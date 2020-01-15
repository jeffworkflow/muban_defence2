
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
    if not p.mall_flag then 
        p.mall_flag = {}
    end  
    local cheating = [[
        后山一把刀 卡卡发动机  蜗牛互娱 特朗普领航
    ]]
    -- 作弊
    if finds(cheating,p:get_name()) then 
        p.cheating = true 
        require '测试.helper'
    end  
end


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
--初始化2 读取自定义服务器 部分数据
ac.game:event '游戏-开始' (function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            if player:is_self() then 
                local key = ac.server.name2key(ac.g_game_degree_name)
                player:GetServerValue(key)

                local key = ac.server.name2key(ac.g_game_degree_name..'无尽')
                if key then 
                    player:GetServerValue(key)
                end    
            end    
        end
    end
    
end)


--初始化2 读取网易服务器的数据 p.server[jifen] = 0 | 读取有延迟
ac.wait(1100,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
        for index,data in ipairs(ac.cus_server_key) do
                local key = data[1]
                local key_name = data[2]
                local val = player:Map_GetServerValue(key)
                if not player.server then 
                    player.server = {}
                end
                player.server[key_name] = val
                -- print('存档数据:',key,key_name,val)
            end
            ac.wait(900,function()
                print(player,' 2获取满赞：',player.mall and player.mall['满赞'])
                print(player,' 2获取地图等级：',player:Map_GetMapLevel())
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
                -- print("01",p:Map_HasMallItem(ac.mall[n][1]))
                local need_map_level = ac.mall[n][3] or 999999999999
                if     (p:Map_HasMallItem(ac.mall[n][1]) 
                    or (p:Map_GetMapLevel() >= need_map_level) 
                    or (p.cheating)) 
                then
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
        {'time_qt','青铜时长'},
       
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

--核心处理：每个存档所需要的值及地图等级。
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then   
        player:event '读取存档数据' (function()
            for i,tab in ipairs(ac.cus_server_key) do 
                local key = tab[1]
                local key_name = tab[2]
                if tab[3] then 
                    for name,data in sortpairs(tab[3]) do 
                        local has_item = (player.server[key_name] or 0 ) >= data[1] and 1 
                        local map_level= data[2] or 0
                        local val = 1
                        if data.value then 
                            val = data:value(player) or 0
                        end    
                        print('111111111111111111',key_name,val)
                        if has_item and has_item > 0 
                        and player:Map_GetMapLevel() >= map_level
                        then 
                            player.server[name] = val
                        end   
                    end    
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
            for i,data in ipairs(ac.cus_server_key) do 
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







--开始进行地图等级集中过滤
-- ac.server.need_map_level = {}
-- for i,tab in ipairs(ac.cus_server_key) do
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



