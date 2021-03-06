local mt = ac.skill['金色鎏金']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 1, 
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '金色鎏金',
tip = [[
参考天外鎏金，施法时间1秒，内置CD16秒，记得播放预警圈，使用长方形的预警圈，范围300*2000，攻击10%几率造成范围物理伤害，并短暂晕眩敌人1S，伤害公式=攻击*100，技能模型T50.mdx；
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 2000,
--伤害范围 直径
area = 350,
 --每一个预警圈消失的时间
time = 0.35,
--冷却
cool = 16,
stu_time = 1,
effect = [[T50.mdx]]
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_ai()
	local hero = self.owner
	local skill =self
	local target = ac.selector():in_range(hero,self.range):is_enemy(hero):random()
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
	local angle = angle or (hero:get_point() / target:get_point())
	--创建特效
	ac.effect_ex{
		model = self.effect,
		angle = angle,
		point = hero:get_point()
	}:remove()
	for i, u in ac.selector()
		: in_line(hero, angle, self.range + 50, self.area) --	起点--	角度--	长度--	宽度
		: of_not_building()
		: is_enemy(hero)
        : is_not(ac.main_unit)
		: ipairs()
	do
		u:add_buff '晕眩'{
			time =1 
		}
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
	local angle = hero:get_point() / self.target:get_point()
	for i=1,3 do 
		local point 
		if i==1 then 
			point = hero:get_point() - {angle,self.area/2}
		else 
			point = hero:get_point() - {angle,self.area/2 + (i-1)*self.area}
		end
		ac.wait(0.35*(i-1)*1000,function(t)
			ac.warning_effect_ring
			{
				point = point,
				area = self.area,
				time = self.time,
			}
		end)
	end
	ac.wait((self.time + 0.35*2)*1000,function()
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