local mt = ac.skill['金色莲花']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 0.8, 
cast_shot_time = 0,
cast_finish_time = 0.0,

--施法动作
cast_animation = 'spell',
cast_animation_speed = 1,

--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '死亡之指',
tip = [[
	施法时间0.8秒，记得播放预警圈，内置CD11秒，半径500，攻击10%几率造成范围物理伤害，伤害公式=攻击*100，技能模型，101.mdx
]],

damage = function(self)
    return self.owner:get('攻击')*100
end,  
--冷却
cool = 11,
-- cool = 6,
area = 500,
effect = [[101.mdx]]
-- time = 5
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_ai()
	local hero = self.owner
	local skill =self
	local target = ac.selector():in_range(hero,self.area):is_enemy(hero):random()
	if not target then 
		return false
	end
	local point = target:get_point():copy()
	self:set('target',point)
	return true
end

function mt:boss_skill_shot(angle)
	local hero = self.owner
	local skill =self
	local target = self.target

	-- print('造成伤害',self.name)
	ac.effect_ex{
		model = self.effect,
		point = target:get_point(),
		size = 1,
	}:remove()
	local angle = angle or (hero:get_point() / target:get_point())
	for _,u in ac.selector()
        : in_range(target,skill.area)
        : is_enemy(hero)
        : is_not(ac.main_unit)
        : ipairs()
	do
		-- print(u,skill.damage)
		u:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
		}	
	end
end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	
	local target = self.target
	--预警圈
	ac.warning_effect_circle
	{
		point = target:get_point(),
		area = self.area,
		time = self.cast_channel_time,
	}
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
	end

end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end
	
    if self.timer then
        self.timer:remove()
        self.timer = nil
	end
end



