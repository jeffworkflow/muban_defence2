local mt = ac.skill['千沟万壑1']
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
title = '千沟万壑1',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*50
end, 
--范围
range = 1000,
--伤害范围 直径
area = 350,
 --每一个预警圈消失的时间
time = 0.35,
--碰撞范围
hit_area = 200,
--特效移动速度
speed = 5000,
--距离
distance =1000,
--冷却
cool = 12,
effect = [[ImpaleMissTarget.mdx]]
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

	local source = hero:get_point()
	local target = target:get_point()
	local mvr = ac.mover.line
	{
		source = hero,
		start = hero,
		angle = angle,
		speed = skill.speed,
		distance = skill.distance,
		skill = skill,
		high = 110,
		model = '', 
		hit_area = skill.hit_area,
		size = 1
	}
	if not mvr then 
		return
	end

	function mvr:on_move()
		--创建特效
		ac.effect_ex{
			point = self.mover:get_point(),
			model = skill.effect
		}:remove()  
	end	
	function mvr:on_hit(dest)
		local u = dest
		u:add_buff '晕眩'
		{
			time = 1,
			skill = skill,
			source = hero,
		}
		
		u:add_buff '高度'
		{
			time = 0.3,
			speed = 1200,
			skill = skill,
			reduction_when_remove = true
		}
		u:damage
		{
			skill = skill,
			source = hero,
			damage = skill.damage
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