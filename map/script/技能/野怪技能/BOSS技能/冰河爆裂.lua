local mt = ac.skill['冰河爆裂']
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
title = '冰河爆裂',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*300
end, 
--范围
range = 1000,
--伤害范围 直径
area = 300,
time = 0.275,
--冷却
cool = 12,
effect = [[Abilities\Spells\Undead\FrostNova\FrostNovaTarget.mdl]]
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
function mt:boss_skill_shot(angle)
	local hero = self.owner
	local skill =self
	local target = self.target

	local angle = angle or (hero:get_point() / target:get_point())
	for i, u in ac.selector()
		: in_line(hero, angle, self.range + 50, self.area) --	起点--	角度--	长度--	宽度
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
		}	
		u:add_buff '晕眩' {
			time = 2
		}
	end
end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	local target = self.target

	local angle = hero:get_point() / self.target:get_point()
	local temp_point = {}
	for i=1,3 do 
		local point 
		if i==1 then 
			point = hero:get_point() - {angle,self.area/2}
		else 
			point = hero:get_point() - {angle,self.area/2 + (i-1)*self.area}
		end
		table.insert(temp_point,point)
		ac.wait(0.275*(i-1)*1000,function(t)
			ac.warning_effect_ring
			{
				point = point,
				area = self.area,
				time = self.time,
			}
		end)
	end
	ac.wait((self.time + 0.275*2)*1000,function()
		for i,point in ipairs(temp_point) do 
			--创建特效
			ac.effect_ex{
				model = self.effect,
				angle = angle,
				point = point,
				size = 4,
			}:remove()
		end
		self:boss_skill_shot(angle)
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