local ui            = require 'ui.client.util'
local json = require 'util.json'
local player = require 'ac.player'

local config = {
    map_name = '魔灵降世',
    url = 'www.91mtp.com/api/maptest' , --类似官方对战平台的服务器存档
    url2 = 'www.91mtp.com/api/mapdb' --统一存储过程入口
}
ac.server_config = config

--读取 map_test 单个并同步
function player.__index:GetServerValue(KEY,f)
    -- if not ac.flag_map or ac.flag_map  < 1 then 
    --     return 
    -- end
    if not self:is_self() and self.id < 11 then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url

    local post = 'get=' .. json.encode({
        map_name = map_name,
        player_name = player_name,
        key = KEY,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval)  

        if not finds(retval,'http','https','') or not finds(retval,'error_code')then 
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                --发起同步请求
                ac.wait(0,function()
                    local info = {
                        type = 'cus_server',
                        func_name = 'on_get',
                        params = {
                            [1] = KEY,
                            [2] = tonumber(tbl[1] and tbl[1].value),
                            [3] = tbl[1] and tbl[1].update_time,
                        }
                    }
                    ui.send_message(info)
                end)   
                local data = {key = KEY, val = tonumber(tbl[1] and tbl[1].value)} 
                f(true,data)
            end    
        else 
            f(false)
            print('数据读取失败',post)
            -- ac.wait(10,function()print(retval)end)
        end
    end)
end

local function sync_t(temp_tab)
    local temp = {}
    local per = 20
    local current = 0 
    local max = 0
    local i = 1
    for k,v in pairs(temp_tab) do 
        max = max +1
    end
    print('总个数：',max,#temp_tab)
    if max == 0 then 
        temp['读取成功'] = true
        local tab_str = ui.encode(temp)
        ac.wait(0,function()
            --发起同步请求
            local info = {
                type = 'cus_server',
                func_name = 'read_key_from_server',
                params = {
                    [1] = tab_str,
                    [2] = 1,
                }
            }
            ui.send_message(info)
        end)
        return
    end
    ac.player.self.sync_t ={}
    local t_max = 0
    for k,v in sortpairs(temp_tab) do 
        current = current + 1
        temp[k] = v 
        if current >= per * i or current == max then 
            if current == max  then 
                temp['读取成功'] = true
            end    
            -- print(t_max)    
            -- local tab_str = ui.encode(temp)
            table.insert(ac.player.self.sync_t,temp)
            i = i + 1
            temp = {}
        end    
    end    

    if ac.player.self.sync_t[1] then 
        --发起同步请求
        ac.wait(0,function(t)
            
            local tab_str = ui.encode(ac.player.self.sync_t[1])
            local info = {
                type = 'cus_server',
                func_name = 'read_key_from_server',
                params = {
                    [1] = tab_str,
                    [2] = 1,
                }
            }
            ui.send_message(info)
        end)
    end
    ac.timer(700,500,function(t)
        -- print_r(ac.player.self.sync_t)
        --取同步列表中，未同步成功的数据
        local sync_tab
        local sync_index
        if ac.player.self.sync_t then 
            for i,data in ipairs(ac.player.self.sync_t) do 
                if not data.is_succ then 
                    sync_tab = data
                    sync_index = i
                    break
                end
            end
        end
        if sync_tab then 
            --发起同步请求
            local info = {
                type = 'cus_server',
                func_name = 'read_key_from_server',
                params = {
                    [1] = ui.encode(sync_tab),
                    [2] = sync_index,
                }
            }
            ui.send_message(info)
        else
            print('移除了异步循环：',ac.player.self)
            ac.player.self.sync_t = nil
            t:remove()
        end
    end)


end
--读取 map_test 多个个并同步
function player.__index:sp_get_map_test(f)
    -- if not ac.flag_map or ac.flag_map < 1 then 
    --     return 
    -- end
    if (not self:is_self() and self.id < 11) or self.flag_read_server then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_map_test',
        para1 = map_name,
        para2 = player_name,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval) 
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            if retval and #retval<1000 then 
                -- print(json.is_json(retval),#retval,retval)
            else 
                print('超出长度')    
            end   
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                local temp_tab = {}
                if tbl.data[1] then 
                    for i,data in ipairs(tbl.data[1]) do 
                        temp_tab[data.key] = data.value
                    
                        --处理排行榜数据 无限难度、挖宝、看书、打造、种树、白嫖、摇骰子
                        if finds(data.key,'today_') then
                            local new_key = data.key..'rank'
                            local new_key_name = ac.server.key2name(data.key)..'排名'
                            temp_tab[new_key] = data.rank
                        end    

                    end    
                end    
                sync_t(temp_tab)
            end  
        else
            log.debug('读取出错',retval)
        end            
    end)
end    
local ui = require 'ui.server.util'
--处理同步请求
local event = {
    onoff = function (val)
        local player = ui.player 
        ac.flag_map = val
        -- print('同步后的数据',ac.flag_map)
    end,
    map_level = function (val)
        local player = ui.player 
        player.cl_map_level = val
        player.mall = player.mall or {}
        player.mall['赤灵地图等级'] = val
        print('获取赤灵地图等级：',val)
        if val >= 7 then 
            player.mall['赤灵限定'] = 1
        end
        -- print('同步后的数据',ac.flag_map)
    end,

    
    on_get = function (key,val,update_time)
        local player = ui.player 
        local p = ui.player 
        if not player.cus_server then 
            player.cus_server = {}
        end    
        local name = ac.server.key2name(key)
        player.cus_server[name] = tonumber(val) or 0 
        -- print('自定义服务器读取完后同步的数据',key,name,val)
        if key =='jifen' then 
            player.jifen = tonumber(val) or 0 
        end   
        if key =='qd' then 
            player.qd_time = update_time and string2time(update_time) or 0
            player.cus_server['签到']= math.min(p:Map_GetMapLevel()*20,(p.cus_server['签到'] or 0),100)
        end   
        if key =='exp' then 
            local exp = tonumber(val) or 0 
            -- print(player,name,'1获取地图经验',exp)
            player:Map_SaveServerValue('level',math.floor(math.sqrt(exp/3600)+1)) --当前地图等级=开方（经验值/3600）+1
        end    
        --影响 网易数据
        -- player:event_notify('读取存档数据')   
    end,
    --从自定义服务器读取数据
    read_key_from_server = function (tab_str,sync_index)
        local player = ui.player 
        if not player.cus_server then 
            player.cus_server = {}
        end    
        if not player.mall then 
            player.mall = {}
        end    
        local ok 
        local data = ui.decode(tab_str) 
        for key,val in pairs(data) do 
            if key == '读取成功' then 
                ok = true 
            else    
                local name = ac.server.key2name(key)
                name = name or key
                player.cus_server[name] = tonumber(val)
                player.mall[name] = tonumber(val)

                if finds(key ,'rank') and val>=1 and val<=10 then
                    player.cus_server['风骚'] = 1
                    player.mall['风骚'] = 1

                    player.cus_server['江山代有才人出'] = 1
                    player.mall['江山代有才人出'] = 1
                    print('同步后的数据：',key,val,player:get_name(),'风骚',player.cus_server['风骚'])
                    print('同步后的数据：',key,val,player:get_name(),'江山代有才人出',player.cus_server['江山代有才人出'])
                end
                if key =='jifen' then 
                    player.jifen =  tonumber(val)
                end  
                if key =='vip'  then 
                    for i,data in ipairs(ac.mall) do 
                        --禁止给地图等级送的英雄
                        if not data[4] and data[1]~='XBDFX' then 
                            player.mall[data[2]] = tonumber(val)
                        end    
                    end    
                end 
                print('同步后的数据：',player:get_name(),name,player.cus_server[name])
                -- print('同步后的数据：',player,key,name,player.cus_server[name]) 
            end    
            -- print('同步后的数据：',player,key,name,player.cus_server[name]) 
        end    
        if ok and not player.flag_read_server then 
            --进行初始化
            for i,data in ipairs(ac.server_key) do 
                player.cus_server[data[2]] = player.cus_server[data[2]] or 0
            end 
            player.flag_read_server = true
            print(player,'又发布了一次读档回调')
            player:event_notify '读取存档数据' 
            player:sendMsg('|cff00ff00读取成功|r')
        end  
        --移除循环  
        if player:is_self() then 
            if player.sync_t and sync_index then
                print('同步里删除异步的数据：')
                player.sync_t[sync_index].is_succ = true
            end
        end
    end,
}
ui.register_event('cus_server',event)

--保存到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:SetServerValue(key,value,f)
    if not self:is_self() and self.id < 11 then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    local key_name,is_mall = ac.server.key2name(key)
    local value = tostring(value) 

    local post = 'exec=' .. json.encode({
        sp_name = 'sp_save_map_test',
        para1 = map_name,
        para2 = player_name,
        para3 = key,
        para4 = key_name,
        para5 = value,
        para6 = is_mall or 0,
    })
    local f = f or function (retval)  end
    -- print(url,post)
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                if tbl and tbl.code == 0 then 
                    f(tbl)
                else
                    -- print(self:get_name(),post,'保存失败')
                end         
            else
                -- print('返回值非json格式:',self:get_name(),post,'保存失败')
                -- print_r(retval)
            end    
        else
            -- print('返回值非json格式:',self:get_name(),post,'保存失败')
            print('服务器返回数据异常1:',post)
            -- print_r(retval)
        end    
    end)

    --保存本局数据
    if not self.cus_server then 
        self.cus_server ={}
    end    
    local key_name = ac.server.key2name(key)
    self.cus_server[key_name] = tonumber(value)
end

--增加数据到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:AddServerValue(key,value,re_read,f)
    if not self:is_self() and self.id < 11 then 
        return 
    end    
    if not self.cus_server then 
        self.cus_server ={}
    end    
    if re_read then 
        self:GetServerValue(key,function(ok,data)
            if ok then 
                local key_name = ac.server.key2name(data.key)
                self.cus_server[key_name] = data.val or 0
                --保存
                local key_name = ac.server.key2name(key)
                -- print(22,key_name,data.key,data.val)
                -- print(key_name,self.cus_server[key_name])
                self.cus_server[key_name] = (self.cus_server[key_name] or 0 ) + tonumber(value)
                self:SetServerValue(key,self.cus_server[key_name])
            end
        end)
    else
        --保存
        local key_name = ac.server.key2name(key)
        -- print(key_name,self.cus_server[key_name])
        if not self.cus_server[key_name] then 
            print('读取存档不成功，中断保存！')
            self:sendMsg('读取存档不成功，中断保存！',5)
            return 
        end    
        -- print(331,key_name,key,self.cus_server[key_name],tonumber(value))
        self.cus_server[key_name] = (self.cus_server[key_name] or 0 ) + tonumber(value)
        -- print(332,key_name,key,self.cus_server[key_name],tonumber(value))
        self:SetServerValue(key,self.cus_server[key_name])
    end
end

-- 清理凌晨今日数据
function player.__index:clear_key(key)
    self.flag_save = self.flag_save or {}
    if not key then 
        print('没有传入key')
        return 
    end
    if not finds(key,'today_') then 
        key = 'today_'..key
    end
    local str = os.date("%Y-%m-%d 00:00:00", os.time())
    local ox = string2time(str)
    if os.time() - ox  < 240 and not self.flag_save[key] then 
        self.flag_save[key] = true 
        local name = ac.server.key2name(key)
        self.cus_server[name] = 0
        -- print('保存服务器：',t_name,p.cus_server[t_name],p.cus_server3[name])
    end
end

local ui = require 'ui.client.util'
--读取 赤灵传说 地图等级
function player.__index:sp_get_player()
    if not self:is_self() and self.id < 11 then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = '赤灵传说'
    local url = config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_player',
        para1 = map_name,
        para2 = player_name
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local tbl = json.decode(retval)
            -- print(type(tbl.code),tbl.code,tbl.code == '0',tbl.code == 0)
            if tbl and tbl.data[1] and tbl.data[1][1] then 
                local map_level = tbl.data[1][1].level
                ac.wait(10,function()
                    local info = {
                        type = 'cus_server',
                        func_name = 'map_level',
                        params = {
                            [1] = tonumber(map_level),
                        }
                    }
                    ui.send_message(info)
                end)   
                f(tbl)
            else
                -- print(self:get_name(),post,'上传失败')
            end    
        end    
    end)
end

--保存玩家名 记录审核人员
function player.__index:sp_save_player()
    if not self:is_self() and self.id < 11 then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local map_level = math.max(japi.DzAPI_Map_GetMapLevel(self.handle),1)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_save_player',
        para1 = map_name,
        para2 = player_name,
        para3 = map_level
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,f)
end

for i=1,10 do
    local p = ac.player(i)
    if p:is_player() then 
        --读取赤灵地图等级数据
        p:sp_get_player()

        --保存玩家名和本图地图等级
        p:sp_save_player()

        --保存地图等级
        -- local map_level = math.max(japi.DzAPI_Map_GetMapLevel(p.handle),1)
        -- p:SetServerValue('level',map_level)
        
    end
end       

function player.__index:sp_get_map_flag(f)
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_map_flag'
    })
    local f = f or function (retval)  end 
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local tbl = json.decode(retval)
            -- print(type(tbl.code),tbl.code,tbl.code == '0',tbl.code == 0)
            if tbl and tbl.code == 0 then 
                local flag_map = tbl.data[1][1].flag
                ac.wait(10,function()
                    local info = {
                        type = 'cus_server',
                        func_name = 'onoff',
                        params = {
                            [1] = tonumber(flag_map),
                        }
                    }
                    ui.send_message(info)
                end)   
                f(tbl)
            else
                -- print(self:get_name(),post,'上传失败')
            end    
        end    
    end)
end
-- ac.flag_map = 0
--读取配置
ac.player(1):sp_get_map_flag()

--每3秒读服务器数据
ac.timer(5*1000,60,function(t)
    local ok =true
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            if not p.flag_read_server then 
                p:sp_get_map_test()
                ok = false 
            end
        end   
    end    
    if ok then 
        print('移除读档循环')
        t:remove()
    end    
end)


--[[
===========自定义服务器 基本功能 ===================
1.进游戏时，往 map_player 插入玩家数据 ，存在更新时间，不存在插入
2.copy 一份服务器存档的数据到 map_test 里面，一样时存在即更新，不存在插入
3.copy 一份商城道具也再服务器存档里面，
4.读取业务端数据 例如排行榜，显示。
5.保存业务端数据到服务器。

=========== 黑名单 map_black_list ===================
目标： war3客户端 读取 黑名单数据，封掉游戏（使游戏结束）
过程：
1.黑名单表
2.插入到黑名单表的条件。 sp_black_list
   a.触发器 一次性积分增加50W,视为作弊. 更改加密保存服务器积分函数,
   b.关键字管理。 
3.游戏内，每5分钟查询一次,查到作弊时,清空所有 网易服务器存档 数据,使掉线.
4.是否考虑地图等级因素,需要考虑,但在客户端执行比较合适,地图等级3级才能参与或是保存服务器的一些数据.
5.每5分钟操作:
  a.同步一次网易服务器积分 到 自定义服务器 触发器可以自动插入到黑名单表
  b.检查黑名单表,如果在表内,使其掉线.
]]






