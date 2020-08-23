local mt = ac.skill['火焰喷射']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 0, 
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '火焰喷射',
tip = [[
参考天外鎏金，施法时间1秒，内置CD16秒，记得播放预警圈，使用长方形的预警圈，范围300*2000，攻击10%几率造成范围物理伤害，并短暂晕眩敌人1S，伤害公式=攻击*100，技能模型T50.mdx；
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 2000,
--伤害范围 直径
area = 800,
--冷却
cool = 11,
effect = [[jn_tf3.mdx]]
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
		: in_sector(hero:get_point(),self.area,angle,120 )
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
end

function mt:on_cast_shot()
    self:boss_skill_shot()
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