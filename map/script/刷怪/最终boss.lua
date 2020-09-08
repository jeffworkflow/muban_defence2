
--进入最终boss阶段，boss苏醒，打败boss进入无尽
ac.game:event '游戏-最终boss' (function(trg) 
    if ac.final_boss then 
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00最终boss已经到来，请大家共同前往击杀！|cffff0000击杀限时15分钟！',6)
        return 
    end    
    --击杀最终BOSS倒计时
    local time = 15*60
    --测试 
    -- time = 25
    local timer = ac.timer_ex{
        time = time,
        title = '击杀最终BOSS倒计时： ' ,
        func = function ()
            ac.game:event_notify('游戏-结束')
            ac.final_boss:remove()
        end,
    }
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00最终boss已经到来，请大家共同前往击杀！|cffff0000击杀限时15分钟！',6)
    --快到时，进行提醒
    local t_time = 15
    local wait_timer = ac.wait( (time - t_time)*1000,function() 
        ac.final_boss_timer = ac.timer(1000,t_time,function(t)
                t_time = t_time -1 
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00请尽快击杀最终BOSS，|cffff0000 '..t_time..' |r|cff00ff00秒后游戏失败')
                if t_time <=0 then 
                    t:remove()
                end    
        end)
    end )

    local point = ac.map.rects['进攻点']:get_point()
    local boss = ac.player.com[2]:create_unit(ac.attack_boss[#ac.attack_boss],point)
    
    boss:add_buff '攻击英雄' {}
    boss:add_skill('净化','英雄')
    boss:add_skill('大地崩','英雄')
    boss:add_skill('伤害守卫','英雄')
    boss:add_skill('boss光子灵枪','英雄')

    boss:add_skill('屠戮_黑夜降临','隐藏')
    boss:add_skill('屠戮_神魂一击','隐藏')
    boss:add_skill('屠戮_屠戮盛宴','隐藏')

    boss:add_skill('超级分身','英雄')
    if ac.g_game_degree_attr>=3 then 
        boss:add_skill('死亡之指','英雄')
    end
    

    boss:add('减伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
    boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
    
    -- if ac.creep['刷怪1'] then 
    --     table.insert(ac.creep['刷怪1'].group,boss)
    -- end    
    ac.final_boss = boss
    --注册事件
    boss:event '单位-死亡'(function(_,unit,killer) 
        ac.final_boss = nil
        ac.final_boss_death = true
        if timer then 
            timer:remove()
            timer = nil
        end
        if wait_timer then 
            wait_timer:remove()
            wait_timer = nil
        end
        if ac.final_boss_timer then 
            ac.final_boss_timer:remove()
            ac.final_boss_timer = nil
        end
        
        if ac.main_unit then
            ac.main_unit:add_restriction('无敌')
        end
        if ac.g_game_degree_attr >= 100000 then 
            --无尽开始
            ac.game:event_notify('游戏-无尽开始')
        elseif finds(ac.g_game_degree_name,'贪婪魔窟') then
            --贪婪魔窟
            ac.game:event_notify('游戏-贪婪魔窟开始')
        else
            -- --游戏结束 有几率触发赛季任务
            local rate = 35 + ac.g_game_degree_attr * 2
            -- rate = 100
            if math.random(100000)/1000<=rate then 
                ac.game:event_notify('赛季任务')
            else
                print('最终boss死亡，游戏胜利',boss)
                ac.game:event_notify('游戏-结束',true)
            end
        end    

        --隐藏成就 
        for i=1,10 do 
            local p = ac.player(i)
            local hero = p.hero
            if p:is_player() then 
                --强悍之人 没有死亡半次
                if not p.cnt_death or p.cnt_death == 0 then 
                    ac.active_yccj(p,'强悍之人')
                end
                --血牛 
                if hero:get('生命上限')>= 5000000000 * ac.g_game_degree_attr then 
                    ac.active_yccj(p,'血牛')
                end
                --一出门就被秒
                if p.cnt_death and p.cnt_death >= 35 then 
                    ac.active_yccj(p,'一出门就被秒')
                end
            end
        end
        
        --创建庄周
        local x,y = ac.rect.j_rect('moku1'):get_point():get()
        local shop = ac.shop.create('庄周',x,y,270,nil) 
        shop:add_sell_item('兑换-神奇的令牌',9)

        --杀死最终boss
        ac.game:event_notify('杀死最终boss')
    end) ; 
    
end);    
