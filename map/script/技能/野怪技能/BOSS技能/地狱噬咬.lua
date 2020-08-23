local mt = ac.skill['地狱噬咬']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 0.5, 
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '地狱噬咬',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--伤害范围 直径
area = 650,
max_life_rate = 25,
time = 0.95,
--冷却
cool = 12,
effect = [[effect3_dazui01.mdx]]  
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

function mt:boss_skill_shot(old_point)
	local hero = self.owner
	local skill =self
	local target = old_point or self.target
	ac.effect_ex{
		model = self.effect,
		point = target:get_point(),
		size = 1.8,
	}:remove()
	for _,u in ac.selector()
		: in_range(target,self.area/2)
		: is_enemy(hero)
        : is_not(ac.main_unit)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
		}	
		u:damage
		{
			source = hero,
			damage = u:get('生命上限')*skill.max_life_rate/100,
			skill = skill,
			real_damage =true
		}
	end
end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	local target = self.target
	
	--预警圈
	ac.warning_effect_ring
	{
		point = target:get_point(),
		area = self.area,
		time = self.time,
	}
	local x,y = target:get_point():get()
	local old_point = ac.point(x,y)
	ac.wait(self.time*1000,function()
		self:boss_skill_shot(old_point)
	end)
end

function mt:on_cast_shot()
    -- self:boss_skill_shot()
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
end

