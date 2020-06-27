--破损的箱子
ac.wait(30,function()
    for i=1,10 do 
        local rect = ac.rect.j_rect('xiangzi'..i)
        local u = ac.player(16):create_unit('破损的箱子',rect)
        u:add_restriction('魔免')
        u:add_restriction('定身')
        u:event '受到伤害开始'(function(_,damage)
            if not damage:is_common_attack() then 
                return true
            end
        
        end)
        
        u:event '单位-死亡'(function(_,unit,killer)
            local p = killer.owner
            local hero =p.hero
            hero:add('力量%',1)
            hero:add('敏捷%',1)
            hero:add('智力%',1)
            ac.player.self:sendMsg('系统消息，'..p:get_name()..'打开了 破损的箱子',5)
        end)
    end
end)