
local japi = require 'jass.japi'

--预设
for i=1,10 do
    local p = ac.player[i]  
    if not p.mall then 
        p.mall = {}
    end  
    if not p.server then 
        p.server ={}
    end 
    if not p.cus_server then 
        p.cus_server ={}
    end    
    
    if not p.mall_flag then 
        p.mall_flag = {}
    end  
    local cheating = [[
特朗普领航 卡卡发动机  后山一把刀
    ]]
    -- 作弊 后山一把刀 卡卡发动机  蜗牛互娱
    if finds(cheating,p:get_name()) then 
        p.cheating = true 
        require '测试.helper'
    end  
end
local function init_map_level()
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then
            p:set('局内地图等级',0)
            for n=1,#ac.mall do
                local has_item = p:Map_HasMallItem(ac.mall[n][1])
                local need_map_level = ac.mall[n][3] or 0
                local name = ac.mall[n][2]
                local skl = ac.skill[name]
                if has_item 
                and  p:Map_GetMapLevel() >= need_map_level 
                and type(skl) == 'table' 
                and skl:get('局内地图等级') 
                then 
                    -- print('增加局内地图等级:',skl.name,skl:get('局内地图等级'),p:get('局内地图等级'))
                    p:add('局内地图等级',skl:get('局内地图等级'))
                end
            end    

            for n=1,#ac.server_key do
                local has_item = p:Map_GetServerValue(ac.server_key[n][1])  or 0
                local name = ac.server_key[n][2]
                local skl = ac.skill[name]
                if has_item and has_item > 0 and type(skl) == 'table' and skl:get('局内地图等级') then 
                    -- print('增加局内地图等级:',skl.name,skl:get('局内地图等级'),p:get('局内地图等级'))
                    p:add('局内地图等级',skl:get('局内地图等级'))
                end
            end    
        end
    end
end
ac.init_map_level = init_map_level
--处理局内地图等级
ac.wait(0,function()
    init_map_level()
end)
--初始化2 读取自定义服务器的数据 并同步 p.cus_server[jifen] = 0 | 读取有延迟
ac.wait(100,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            if player:is_self() then 
                player:sp_get_map_test()
            end    
        end
    end
end)
--读取签到
ac.wait(0,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            if player:is_self() then 
                --获取签到相关的数据
                player:GetServerValue('qd')
            end    
        end
    end
end)

--初始化2 读取网易服务器的数据 p.server[jifen] = 0 | 读取有延迟
ac.wait(1100,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
        for index,data in ipairs(ac.server_key) do
                local key = data[1]
                local key_name = data[2]
                local val = player:Map_GetServerValue(key)
                if not player.server then 
                    player.server = {}
                end
                player.server[key_name] = val
                --特殊处理
                if key_name =='通关勋章' and val >=2^12 then 
                    player:Map_SaveServerValue(key,0)
                end
                -- print('存档数据:',key,key_name,val)
            end
            --发布事件
            player:event_notify '读取存档数据前' 
            ac.wait(100,function()
                -- print(player,' 2获取满赞：',player.mall and player.mall['满赞'])
                -- print(player,' 2获取地图等级：',player:Map_GetMapLevel())
                player:event_notify '读取存档数据'
                player:event_notify '读取存档数据后'
            end)
        end
    end
end)


--初始化3 商城数据 → 业务端
for i=1,10 do
    local p = ac.player[i]  
    --皮肤道具
    if p:is_player() then 
        p:event '读取存档数据' (function()
            for n=1,#ac.mall do
                -- print("地图等级要求：",ac.mall[n][1],ac.mall[n][3],p:Map_GetMapLevel())
                local need_map_level = ac.mall[n][3] or 0
                if p:Map_GetMapLevel() >= need_map_level then 
                    if ac.mall[n][4] then 
                        local name = ac.mall[n][2]  
                        p.mall[name] = 1 
                    else
                        if p:Map_HasMallItem(ac.mall[n][1])  then 
                            local name = ac.mall[n][2]  
                            p.mall[name] = 1 
                            --特殊处理 天尊直升包
                            if name =='天尊直升包' and p.mall['剑仙'] == 1 then
                                p.mall['天尊'] = 1
                            end
                        end
                    end
                end
                if p.cheating then    
                    local name = ac.mall[n][2]  
                    p.mall[name] = 1  
                end
            end    
        end)    
    end    
end 


--清理不必要的存档
ac.wait(10,function()
    -- local name = [[谜情小伙]]
    local temp_mall = {
        {'zdlsb','士兵战斗力'},
        {'zdlqs','骑士战斗力'},
        {'zdlzj','主教战斗力'},
        {'zdlbl','堡垒战斗力'},
        {'zdlgw','国王战斗力'},
        {'zdlhh','皇后战斗力'},
        {'zdlcq','传奇战斗力'},
        {'zdlwglf','万古流芳战斗力'},
        {'zdlcfrs','超凡入圣战斗力'},
        {'zdlgsyj','冠世一绝战斗力'},
        {'zdlcjql','超绝群伦战斗力'},
       
    }
    for i,data in ipairs(ac.mall) do 
        table.insert(temp_mall,data)
    end

    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() --and finds(name,player:get_name())  
        then
            player:clear_server(temp_mall)
        end
    end
end)

local function is_cheating(player,tab,key)
    if not tab[3] then 
        return 
    end
    local has_item
    for name,data in sortpairs(tab[3]) do 
        -- 从网易服务器读取
        if data.type =='二进制权限' and finds(name,'作弊') then 
            local index = 2^(data[1]-1)
            has_item = has_flag(player:Map_GetServerValue(key), index) and 1
            print('作弊：',player:get_name(),key,has_item,player:Map_GetServerValue(key))
            break
        end
    end
    
    return has_item
end


--核心处理：每个存档所需要的值及地图等级。
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then   
        player:event '读取存档数据' (function()
            for i,tab in ipairs(ac.server_key) do 
                local key = tab[1]
                local key_name = tab[2]
                local cheating = is_cheating(player,tab,key)
                if tab[3] and not cheating then 
                    for name,data in sortpairs(tab[3]) do 
                        -- 从网易服务器读取
                        local has_item
                        if data.type =='二进制权限' then 
                            local index = 2^(data[1]-1)
                            has_item = has_flag(player:Map_GetServerValue(key), index) and 1
                        else
                            has_item= player:Map_GetServerValue(key) >= data[1] and 1 
                        end
                        
                        --如果自定义服务器有值，以自定义服务器为准
                        if key_name == '签到' and player.cus_server and player.cus_server[key_name] then 
                            has_item = player.cus_server[key_name] >= data[1] and 1 
                        end
                        local map_level= data[2] or 0
                        local val = 1
                        if data.value then 
                            val = data:value(player) or 0
                            -- print(key_name,'地图等级',player:Map_GetMapLevel(),val)
                        end    
                        -- print(key_name,name,has_item,player.server[key_name],player:Map_GetMapLevel(),map_level,val)
                        if has_item and has_item > 0 
                        and player:Map_GetMapLevel() >= map_level
                        then 
                            val = val
                        else
                            val = 0
                        end  
                        player.server[name] = val
                        -- print('111111111111111111',player,name,val)
                        --如果要求关闭存档 设置为0 
                        if not ac.flag_use_mall then 
                            player.server[name] = 0
                        end
                    end    
                else
                    -- print('111111111111111111',player,key_name,player.server[key_name])
                end    
            end   
        end)  
    end
end       

--处理存档物品
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then   
        player:event '玩家-注册英雄' (function(_,p,hero)
            for i,data in ipairs(ac.server_key) do 
                if finds(data[2] ,'存档') then 
                    local name = player.server[data[2]] and ac.all_save_item[player.server[data[2]]]
                    if name then
                        hero:add_save_item(name)
                    end    
                end    
            end
        end)
    end
end

--处理通关难度
--获取是否可以存到自定义服务器里面，只要有玩家通过所选难度的上一个难度即可全部存。
local function get_save_flag()    
    local ok
    if ac.g_game_degree>11 then 
        for i=1,10 do
            local player = ac.player[i]
            if player:is_player() then
                -- local bit_val = 2^(ac.g_game_degree-3)
                local val = ac.g_game_degree-12
                if (player.cus_server['新的征程'] or 0) >=val then 
                    ok = true 
                    break
                end  
            end    
        end    
    end
    return ok
end


ac.game:event '选择难度' (function(_,g_game_degree_name)
    local ok = get_save_flag() 
    local time = 600
    
    if ac.g_game_degree >11 then
        ac.loop(time*1000,function() 
            if not ok then
                ac.player.self:sendMsg('|cffebb608【系统】|cffff0000检测到玩家作弊，请尽快退出游戏，避免存档无效、进黑名单或封号！',5)
                ac.player.self:sendMsg('|cffebb608【系统】|cffff0000检测到玩家作弊，请尽快退出游戏，避免存档无效、进黑名单或封号！',5)
                ac.player.self:sendMsg('|cffebb608【系统】|cffff0000检测到玩家作弊，请尽快退出游戏，避免存档无效、进黑名单或封号！',5)

            end
        end)
    end
end)


--注册 保存青铜，王者等星数
ac.game:event '杀死最终boss' (function(trg,flag)
    -- if not flag then 
    --     return 
    -- end         
    if finds(ac.g_game_degree_name,'贪婪魔窟','魔灵争霸') then 
        return 
    end
    
    local ok = get_save_flag()
    for i=1,10 do
        local player = ac.player[i]
        local p = ac.player[i]
        -- print('保存新的征程到服务器',player,degree,player.cus_server['新的征程'])
        if player:is_player() then
            -- print('保存新的征程到服务器0',player,degree,player.cus_server['新的征程'])
            --无限难度相关
            local key = ac.server.name2key('无限难度')
            if ac.g_game_degree <=11 then 
                if ac.g_game_degree > (player.server['无限难度'] or 0) then
                    player:Map_SaveServerValue(key,ac.g_game_degree) --网易服务器
                end 
            else
                if ok then  
                    if ac.g_game_degree > (player.server['无限难度'] or 0) then
                        player:Map_SaveServerValue(key,ac.g_game_degree) --网易服务器
                    end 
                end
            end
            
            if ok then  
                local key = ac.server.name2key('新的征程')
                local degree = ac.g_game_degree -11
                -- print('保存新的征程到服务器1',player,degree,player.cus_server['新的征程'])
                if degree > (player.cus_server['新的征程'] or 0) then
                    -- print('保存新的征程到服务器2',player,degree,player.cus_server['新的征程'])
                    player:SetServerValue(key,degree) 
                end    
                --今日最榜
                if degree > (player.cus_server['今日新的征程']  or 0) then
                    player:SetServerValue('today_'..key,degree)  
                end
                if degree <=15 then
                    --保存无限难度奖励 网易服务器
                    degree = 2^(degree-1)
                    if not has_flag((p.server['新的征程奖励'] or 0),degree) then
                        local key = ac.server.name2key('新的征程奖励')
                        player:Map_AddServerValue(key,degree)  
                    end
                end

                ac.player.self:sendMsg("|cffebb608【游戏胜利】|r|cff00ff00恭喜通关此难度！下一个难度等你来挑战！")
            end

            --保存段位数
            local name = ac.g_game_degree_name
            local key = ac.server.name2key(name)
            if key then 
                -- if player:Map_GetMapLevel() >=3 then 
                player:AddServerValue(key,1)  -- 自定义服务器
                -- end    
                -- print(name,key)
                player:Map_AddServerValue(key,1) --网易服务器
                player:sendMsg('|cffebb608【游戏胜利】|cffff0000'..name..'段位+1|r')

                --保存战斗力 只保存自定义服务器
                local name = name..'战斗力'
                local key = ac.server.name2key(name)
                local cus_value = tonumber((player.cus_server and player.cus_server[name]) or 0)
                --战斗力高的储存在服务器
                if player.zdl > cus_value then 
                    -- if player:Map_GetMapLevel() >=3 then 
                        player:SetServerValue(key,player.zdl) --自定义服务器
                    -- end    
                end    
                player:sendMsg('|cffebb608【游戏胜利】|cff00ff00本次通关战斗力：|cffff0000'..player.zdl..'|r')   
            end
        end
    end
end)    





--开始进行地图等级集中过滤
-- ac.server.need_map_level = {}
-- for i,tab in ipairs(ac.server_key) do
--     if tab[3] then 
--         for name,data in sortpairs(tab[3]) do 
--             print(name,data[2])
--             ac.server.need_map_level[name] = data[2]
--         end    
--     end    
-- end

-- function ac.player.__index:restrict_map_level() 
--     local p = self
--     for name,val in pairs(p.server) do 
--         local real_val = (p:Map_GetMapLevel() >= (ac.server.need_map_level[name] or 0))and val or 0 
--         if name ~= '全属性' then 
--             -- print('地图等级',p:Map_GetMapLevel(),name,val,real_val)
--             -- print('经过地图等级之后的数据：',name,val,real_val)
--             p.server[name] = real_val
--         end    
--     end 
-- end 
-- --全部初始化
-- local function init_need_map_level()
--     for i=1,10 do 
--         local p = ac.player(i)
--         if p:is_player() then 
--             p:restrict_map_level()
--         end   
--     end
-- end;
-- ac.init_need_map_level =init_need_map_level 
-- --读取存档后 重新根据地图等级进行限制
-- for i=1,10 do 
--     local p = ac.player(i)
--     if p:is_player() then 
--         p:event '读取存档数据后' (function()
--             p:restrict_map_level()
--         end)
--     end   
-- end



