
--进入最终boss阶段，boss苏醒，打败boss进入无尽
ac.game:event '游戏-最终boss' (function(trg) 
    if ac.final_boss then 
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 最终boss已出现|r，请大家共同前往击杀',3)
        return 
    end    
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
            --游戏结束
            print('最终boss死亡，游戏胜利',boss)
            ac.game:event_notify('游戏-结束',true)
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
    end) ; 
    
end);    
