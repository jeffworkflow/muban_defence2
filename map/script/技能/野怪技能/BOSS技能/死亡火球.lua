local mt = ac.skill['死亡火球']
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
title = '死亡火球',
tip = [[
参考天外鎏金，施法时间1秒，内置CD16秒，记得播放预警圈，使用长方形的预警圈，范围300*2000，攻击10%几率造成范围物理伤害，并短暂晕眩敌人1S，伤害公式=攻击*100，技能模型T50.mdx；
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 2000,
distance = 1000,
--冷却
cool = 21,
effect = [[Abilities\Weapons\FireBallMissile\FireBallMissile.md]]
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
	
	for i=1,10 do 
		local angle = (i-1)*36
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			model =  skill.effect,
			speed = 800,
			angle = angle,
			hit_area = 200,
			distance = skill.distance,
			high = 120,
			size = 2,
			on_hit = function(self,u)
				if u ~= ac.main_unit then 
					--技能伤害
					u:damage
					{
						source = hero,
						skill = skill,
						damage = skill.damage,
						-- damage_type = '法术'
					}
				end
			end	
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