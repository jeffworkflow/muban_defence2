local mt = ac.skill['重生']

mt.title = "重生"
mt.tip = [[
]]
mt.cool = 0
--重生时间
mt.time = 8
mt.cnt = 1
mt.passive = true
mt.effect = [[Abilities\Spells\Orc\Reincarnation\ReincarnationTarget.mdl]]


function mt:on_add()

    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    -- hero:add('生命上限%', -self.value)
    -- hero:add('护甲%', -self.value)
    -- hero:add('攻击%', -self.value)
    -- hero:add('魔抗%', -self.value)

    --重生相关
    self.trg = hero:event '单位-即将死亡' (function (_,unit,killer)
        --武林大会期间，没有重生
        local p = unit.owner
        --渡劫期间，永生无效
        if p.flag_dz then 
            return 
        end
        if ac.g_game_degree_name =='魔灵争霸' and unit:get_name() ~='基地' then 
            return 
        end
        --冷却期间，重生无效
        if self:is_cooling() then 
            return 
        end
        --激活cd
        self:active_cd()

        local point = hero:get_point()
        --额外特效
        if self.effect1 then 
            ac.effect_ex{
                time = self.time,
                model = self.effect1,
                model_size = self.effect1_size,
                point = point
            }
        end    


        local effect = ac.effect(point,self.effect,0,1,'origin')
        --发送红色信号
        if unit:get_name() == '基地' then
            local f1 = ac.player.self:cinematic_filter
            {   
                file = 'xueliangguodi.blp',
                start = {100, 100, 100, 100},
                finish = {100, 100, 100, 0},
                time = 5,
            }
        end    

        if not hero:has_restriction '隐藏' then 
            hero:add_restriction '隐藏'
        end
        if not hero:has_restriction '定身' then 
            hero:add_restriction '定身'
        end
        if not hero:has_restriction '无敌' then 
            hero:add_restriction '无敌'
        end
        if not hero:has_restriction '缴械' then 
            hero:add_restriction '缴械'
        end

        ac.wait(self.time*1000,function ()

            effect:remove()
            if hero:has_restriction '隐藏' then 
                hero:remove_restriction '隐藏'
            end
            
            if hero:has_restriction '无敌' then
                hero:remove_restriction '无敌'
            end
            if hero:has_restriction '定身' then
                if unit:get_name() ~= '基地' then
                    hero:remove_restriction '定身'
                end
            end
            if hero:has_restriction '缴械' then
                if unit:get_name() ~= '基地' then
                    hero:remove_restriction '缴械'
                end
            end

            --用 set,生命加成可能会有问题
            hero:add('生命', hero:get '生命上限')
            
            --重生次数 -1 小于1时 ,无法重生，技能移除
            self.cnt = self.cnt - 1 
            if self.cnt < 1 then 
                self:remove()
            end 
        end)
        -- 中断死亡
        return true 
    
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    -- hero:add('生命上限%', self.value)
    -- hero:add('护甲%', self.value)
    -- hero:add('攻击%', self.value)
    -- hero:add('魔抗%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

