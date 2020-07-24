

--每15分钟传送进魔灵争霸
local start_time = 60 * 12
-- start_time = 65
local duration_time = 60 * 2 --持续时间
-- duration_time = 45 
local give_award 

--魔灵争霸倒计时（文字提醒）
local function ss_wldh(time)
    local start_time = time or start_time
    ac.timer_ex 
    {
        time = start_time,
        title = '距离 魔灵争霸 开始： ' ,
        func = function ()
            ac.game.start_wldh()
        end,
    }
    --快到时，进行提醒
    local t_time = 15
    ac.wait( (start_time - t_time)*1000,function() 
        ac.timer(1000,t_time,function(t)
            t_time = t_time -1 
            ac.player.self:sendMsg('|cffebb608【系统】|r魔灵争霸|cffff0000 '..t_time..' |r秒后开始，请做好准备',4)
            if t_time <=0 then 
                t:remove()
            end    
        end)
    end )

    ac.wait( (start_time - 5)*1000,function() 
        for i=1,10 do 
            local p = ac.player(i)
            local hero = p.hero
            local peon = p.peon
            if p:is_player() and hero then 
                --每个玩家添加传送动画（倒计时）
                hero:add_buff '时停'
                {
                    time = 5,
                    text = '秒后进入魔灵争霸',
                    skill = '魔灵争霸',
                    source = hero,
                    xoffset = -205,
                    zoffset = 220,
                    show = true,
                    is_god = true,
                }
                
                --基地加无敌
                ac.main_unit:add_buff '无敌'{
                    time = 5
                }

                ac.wait(5*1000,function()
                    -- print('时停结束，开始进行死亡之环')
                    -- print(hero:get_name())
                    local point = ac.rect.j_rect('moku5'):get_random_point()
                    hero:blink(point,true,false)
                    peon:blink(point,true,false)
                    --锁定镜头
                    local minx, miny, maxx, maxy = ac.rect.j_rect('moku5'):get()
                    p:setCameraBounds(minx, miny-300, maxx, maxy+300+704)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
                    p:setCamera(hero:get_point())
                    
                    --每个玩家添加传送动画（倒计时）
                    hero:add_buff '时停'
                    {
                        time = 5,
                        skill = '魔灵争霸',
                        source = hero,
                        zoffset = 220,
                        show = true,
                    }
                end)
            end
        end        
    end )
    
end    

ac.game.start_wldh = function(time) 
    local duration_time = time or duration_time
    --发布 魔灵争霸-开始 
    ac.game:event_notify('魔灵争霸-开始')
    --魔灵争霸倒计时
    ac.timer_ex 
    {
        time = duration_time,
        title = '距离 魔灵争霸 结束： ' ,
        func = function ()
            ac.game:event_notify('魔灵争霸-结束')
            --魔灵争霸倒计时
            ss_wldh()
        end,
    }
    --快到时，进行提醒
    local t_time = 15
    ac.wait( (duration_time - t_time)*1000,function() 
        ac.timer(1000,t_time,function(t)
            t_time = t_time -1 
            ac.player.self:sendMsg('|cffebb608【系统】|r魔灵争霸|cffff0000 '..t_time..' |r秒后结束',5)
            if t_time <=0 then 
                t:remove()
            end    
        end)
    end )
end

ac.game:event '游戏-开始'(function()
    if ac.g_game_degree_name =='魔灵争霸' then
        ss_wldh()
    end    
end)

ac.game:event '魔灵争霸-开始' (function()
    --给标志
    ac.flag_wldh = true
    --暂停 正常出怪，暂停出怪，
    for i=1,3 do 
        local creep = ac.creep['刷怪'..i]
        creep:PauseTimer(duration_time)
    end  
    --启用如果有暂停出怪处理
    if ac.main_stop_timer then 
        ac.main_stop_timer:PauseTimer()
    end    
    --基地加无敌
    ac.main_unit:add_buff '无敌'{
        time = duration_time + 30
    }
    --玩家敌对
    ac.init_enemy()

    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon
        if p:is_player() and hero then 
            --禁止F2,F3
            local skl = hero:find_skill('F2回城',nil,true)
            if skl then skl:disable() end 
            local skl = hero:find_skill('F3小黑屋',nil,true)
            if skl then skl:disable() end 

        end    
        
    end    
end)


ac.game:event '魔灵争霸-结束' (function()
    ac.flag_wldh = false
    --启用如果有暂停出怪处理，则恢复
    if ac.main_stop_timer then 
        ac.main_stop_timer:ResumeTimer()
    end    
    --玩家联盟
    ac.init_alliance()
    
    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon

        if p:is_player() and hero then 
            --恢复镜头
            local minx, miny, maxx, maxy = ac.map_area:get()
            p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
            hero:blink(ac.map.rects['主城'],true,false) 
            peon:blink(ac.map.rects['主城'],true,false)
            ac.wait(10,function()
                p:setCamera(hero:get_point())
            end)
            
            --恢复F2,F3
            local skl = hero:find_skill('F2回城',nil,true)
            if skl then skl:enable() end 
            local skl = hero:find_skill('F3小黑屋',nil,true)
            if skl then skl:enable() end 

            --恢复护甲
            if hero.had_reduce_defence then 
                hero:add('护甲',hero.had_reduce_defence)
            end    

        end    
    end    

    --给奖励
    give_award()


end)

-----------------------------------------魔灵争霸统计------------------------------------------------------- 
ac.game:event '玩家-注册英雄' (function(_, p, hero)

    hero:event '单位-死亡' (function(_,unit,killer)
        if not killer:is_hero() then 
            return 
        end
        if not ac.flag_wldh then 
            return 
        end
        local p = killer:get_owner()
        p.wldh_jf = (p.wldh_jf or 0 ) + 2
        --保存魔灵争霸积分
        p:Map_AddServerValue('mlzb',2) --网易服务器
        --保存到自定义服务器 暂时先保存值，后面结束时再保存到服务器
        if not p.cus_server3 then 
            p.cus_server3 = {} 
        end 
        p.cus_server3['魔灵争霸'] = (p.cus_server3['魔灵争霸'] or 0) + 2
        --文字提醒
        p:sendMsg('|cffebb608【系统】|r|cff00ff00击杀成功|r |cffdf19d0可存档杀戮值+2',5)
    end) 

end)    
-----------------------------------------发放奖励-------------------------------------------------------
local award_item = {
    [1] = {'红',20},
    [2] = {'金',16},
    [3] = {'蓝',12},
    [4] = {'白',8},
    [5] = {'白',4},
    [6] = {'白',0},
}
function give_award()
    ac.player.self:clearMsg()
    local temp_tab = {}
    for i=1,10 do 
        local p= ac.player(i)
        if p:is_player() then 
            table.insert(temp_tab,{player = p,wldh_jf = (p.wldh_jf or 0)})
        end
        --清空积分
        p.wldh_jf = 0 
    end  
    --排序
    table.sort(temp_tab,function(a,b)
        return a.wldh_jf>b.wldh_jf
    end)
    local tip = '|cffebb608【系统】|r|cffff0000魔灵争霸结束，发放奖励如下|r\n\n'
    --循环给奖励
    for i,data in ipairs(temp_tab) do 
        local ad_it,jifen = table.unpack(award_item[i])
        local hero = data.player.hero 
        local list = ac.quality_item[ad_it]
        local name = list[math.random(#list)]
        local it = hero:add_item(name,true)
        -- print(i,data.player,data.wldh_jf)
        tip = tip..'第'..i..'名 |cff00ffff'..data.player:get_name()..'|r共获得|cffff0000'..(data.wldh_jf+jifen)..'|r杀戮值，奖励'..it.color_name..'|r'..'\n\n'
        local key = 'mlzb'
        --保存积分
        data.player:Map_AddServerValue(key,jifen) --网易服务器
        
        --保存到自定义服务器 暂时先保存值，后面结束时再保存到服务器
        local p = data.player
        if not p.cus_server3 then 
            p.cus_server3 = {} 
        end 
        p.cus_server3['魔灵争霸'] = (p.cus_server3['魔灵争霸'] or 0) + jifen
       --凌晨数据弄为0 
        p:clear_key('today_'..key)
        --今日累计榜
        p:AddServerValue('today_'..key,p.cus_server3['魔灵争霸']) 
        --累计总榜
        p:AddServerValue(key,p.cus_server3['魔灵争霸'])  

        -- p:sendMsg('|cffebb608【系统】|r|cff00ff00本次获得 魔灵争霸 积分: |cffff0000'..p.cus_server3['魔灵争霸'])
        print(p,'魔灵争霸 积分: '..p.cus_server3['魔灵争霸'])
        p.cus_server3['魔灵争霸'] = 0

    end    
    ac.player.self:sendMsg(tip)
    
end    







-----------------------------------------投票相关-------------------------------------------------------
--在线玩家 1  >= 0 开启 存档
-- 2  >= 1 开启 存档
-- 3  >= 1.5 开启 存档
local online_cnt = get_player_count()
local half_online_cnt = online_cnt/2
local use_mall = 0
local click_cnt = 0
local has_check

local function reload_mall()
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            p:event_notify '读取存档数据'
        end
    end
end


local function check_vote()
    if has_check then 
        return 
    end 
    has_check = true
    if use_mall >= half_online_cnt then 
        ac.flag_use_mall = true 
    else
        ac.flag_use_mall = false 
    end 

    if ac.flag_use_mall then 
        ac.player.self:sendMsg('|cffffe799【系统消息】|r投票结束，本局|cff00ff00开启|r商城道具和存档内容')   
    else 
        ac.player.self:sendMsg('|cffffe799【系统消息】|r投票结束，本局|cffff0000禁用|r商城道具和存档内容')  
    end    

    -- 关闭商城道具
    if not ac.flag_use_mall then 
        --重载 商城及存档及地图等级要求
        reload_mall() 

        for i=1,10 do
            local p = ac.player[i]  
            if p:is_player() then 
                if not p.cheating then 
                    for i,data in ipairs(ac.mall) do 
                        local key = data[1]
                        local name = data[2]
                        if p.mall and p.mall[name] then 
                            -- print('关闭商城道具：',name,key,p.mall[name])
                            p.mall[name] = 0
                        end
                    end    
                end    
            end    
        end 
    end  
    
    ac.game:event_notify('投票结束',ac.flag_use_mall) 
end    

ac.game.start_vote = function()
    local list = {
        { name = "是" },
        { name = "否" },
    }
    for i =1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            create_dialog(p,"是否开启商城道具及存档内容？",list,function (index)  
                -- local name = list[index].name
                if index == 1 then 
                    use_mall = use_mall + 1
                    if use_mall >= half_online_cnt then 
                        ac.flag_use_mall = true 
                    end  
                    ac.player.self:sendMsg('|cff00ffff等待其他玩家投票中...|r')      
                else
                    ac.player.self:sendMsg('|cff00ffff等待其他玩家投票中...|r')      
                end  
                --'玩家 '..p:get_name()..' 选择了 |cff00ff00是|r'
                click_cnt = click_cnt + 1 
                if click_cnt >= get_player_count() then 
                    check_vote()
                end    
            end,10)    
        end
    end         
    --时间到，检查选择的结果
    ac.wait(10*1000+10,function(t) 
        check_vote()
    end)
end    



