local mt = ac.skill['狂雷']
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
title = '狂雷',
tip = [[
	攻击10%触发，每隔0.1秒（一共创建5个），
	在周围1200码随机创建一个直径400码的倒计时0.3秒的预警圈，预警圈消失后，在预警圈位置播放一个特效（模型YX010.mdx），并造成攻击力*50的物理伤害，内置CD12秒
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 1000,
--伤害范围 直径
area = 400,
 --每一个预警圈消失的时间
time = 0.8,
--冷却
cool = 12,
effect = [[YX010.MDX]]
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
function mt:boss_skill_shot()
	local hero = self.owner
	local skill =self
	local target = self.target

	-- local angle = angle or (hero:get_point() / target:get_point())
	--创建特效
	for i, u in ac.selector()
		: in_range(hero,self.area/2) --	起点--	角度--	长度--	宽度
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
	ac.timer(0.2*1000,5,function(t)
		local point = hero:get_point() - {math.random(360),math.random(1200)}
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
				self:boss_skill_shot()
			end
		}
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