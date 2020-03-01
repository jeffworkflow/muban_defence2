local mt = ac.skill['真·万箭穿心']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "真天阶",
	--技能类型
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*80+100000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加敏捷'] = {160,3200},
['攻击加敏捷'] = {160,3200},
['每秒加敏捷'] = {160,3200},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+160*Lv
【攻击加敏捷】+160*Lv
【每秒加敏捷】+160*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*80+100000000）*Lv
 ]],
	--技能图标
	art = [[wanjianqifa.blp]],
	--特效
	effect = [[K_WJQF2.mdx]],
	--特效1
	effect1 = [[anyingzhijing.mdx]],
	--特效4
	effect4 = [[参考赤灵的万箭齐发，投射物数量=7]],
    --数量
    count = 7,
    --投射物碰撞距离
    hit_area = 150,
    --主伤害比
    main_damage = 100,
    --cd
    cool = 1,
    damage_type = '法术'
}

function mt:on_add()
    local skill = self
    local hero = self.owner

    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local target = damage.target
        local max_damage = self.current_damage
        --投射物数量
        local count = hero:get '额外投射物数量' * 2 + self.count 
        --范围
        local hit_area = hero:get '额外范围' + self.hit_area 
       
        local unit_mark = {}
        
        for i = 1,count do 

            local random_time = math.random(1, 400)
		    hero:timer(random_time, 1, function(t)
                local angle = math.random(1, 360)
                local s = target:get_point() - {angle, math.random(1, skill.area)}

                local angle1 = math.random(1, 360)
                local t = s - {angle1, 150}
                -- local p = ac.point(0,0)
                if i == 1 then 
                    s = target:get_point()
                    t = target:get_point()
                end
                -- local u = hero:create_dummy('nabc',p,0)
                local mover = hero:create_dummy('nabc',s, 0)
                --落下箭矢
                local mvr = ac.mover.target
                {
                    source = hero,
                    mover = mover,
                    start = s,
                    target = t,
                    -- angle = angle,
                    speed = 600,
                    turn_speed =720,
                    high = 1500,
                    heigh = 1500,
                    skill = skill,
                    model = skill.effect,
                    size = 1.3
                }
                if mvr then
                    function mvr:on_move()
                        
                        if self.high <= 50 then
                            local eff = ac.effect(self.mover:get_point(),skill.effect1,0,1,'origin')
                            ac.wait(100,function()
                                eff:remove()
                            end)

                            ac.effect(self.mover:get_point(),[[OrbOfCorruption.mdx]],0,1,'origin'):remove()
                            self.mover:remove()
                            self:remove()

                            for i,u in ac.selector()
                            : in_range(self.mover:get_point(),hit_area)
                            : is_enemy(hero)
                            : of_not_building()
                            : ipairs()
                            do
                                u:damage
                                {
                                    source = hero,
                                    damage = max_damage * skill.main_damage / 100,
                                    skill = skill,
                                    missile = self.mover,
                                    damage_type = skill.damage_type
                                }
                            end
                        end

                    end 
                end    
            end   );

        end

    end    

	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
        end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
	
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            self = self:create_cast()
            --当前伤害要在回调前初始化
            self.current_damage = self.damage
            range_attack_start(hero,damage)
            hero:event_notify('单位-触发被动', hero,self,damage.target,damage)
            --激活cd
            skill:active_cd()
        end 
        
        return false
    end)

end



function mt:on_remove()
    local hero = self.owner
    self.trg:remove()
end