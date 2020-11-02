local mt = ac.skill['战争践踏2']
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
title = '战争践踏2',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 800,
--伤害范围 直径
area = 800,
 --每一个预警圈消失的时间
time = 0.7,
--晕眩
stun_time =2,
max_life_rate = 25,
--冷却
cool = 12,
effect = [[Abilities\Spells\Human\ThunderClap\ThunderclapCaster.mdx]]
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_ai()
	local hero = self.owner
	local skill =self
	local target = ac.selector():in_range(hero,self.range):is_enemy(hero):random()
	if not target then 
		return false
	end
	self:set('target',target)
	return true
end
function mt:boss_skill_shot(old_point)
    local skill = self
    local hero = self.owner

    local point = old_point
	-- hero:add_effect('origin',self.effect):remove()
	ac.effect_ex{
		point = point,
		model=self.effect,
		size = 2
	}:remove()
	for i, u in ac.selector()
		: in_range(old_point,self.area/2)
		: is_enemy(hero)
		: of_not_building()
        : is_not(ac.main_unit)
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			time = self.stun_time,
			skill = self,
			source = hero,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
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
    -- self:active_cd()
end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end