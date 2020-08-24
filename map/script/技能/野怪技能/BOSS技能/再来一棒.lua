local mt = ac.skill['再来一棒']
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
title = '再来一棒',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 1000,
--伤害范围 直径
area = 600,
 --每一个预警圈消失的时间
time = 0.8,
--冷却
cool = 12,
effect = [[JNTX43.mdx]]
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
function mt:boss_skill_shot(point)
	local hero = self.owner
	local skill =self
	local target = self.target

	-- local angle = angle or (hero:get_point() / target:get_point())
	--创建特效
	for i, u in ac.selector()
		: in_range(point,self.area/2) --	起点--	角度--	长度--	宽度
		: of_not_building()
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
	end
end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	local target = self.target
	-- local target = ac.selector():in_range(hero,self.range):is_enemy(hero):random()
	-- if not target then 
	-- 	ac.wait(0,function()
	-- 		self:set_cd(0)
	-- 	end)
	-- 	return 
	-- end
	local point = target:get_point()
	ac.warning_effect_ring
	{
		point = point,
		area = self.area,
		time = self.time,
		func = function()
			ac.effect_ex{
				model = self.effect,
				size = 2,
				point = point
			}:remove()
			self:boss_skill_shot(point)
		end
	}

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