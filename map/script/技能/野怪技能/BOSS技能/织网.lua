local mt = ac.skill['织网']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 2, 
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '织网',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

damage = function(self)
    return self.owner:get('攻击')*100
end, 
--伤害范围 直径
area = 1000,
time = 2,
time2 = 20,
--冷却
cool = 12,
effect = [[Abilities\Spells\Undead\Web\WebTarget.mdl]]  --太小了，模型不对
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_ai()
	local hero = self.owner
	local skill =self
	local target = ac.selector():in_range(hero,self.area):is_enemy(hero):random()
	if not target then 
		return false
	end
	self:set('target',target)
	return true
end

function mt:boss_skill_shot(old_point)
	local hero = self.owner
	local skill =self
	local target = old_point or self.target
	ac.effect_ex{
		model = self.effect,
		point = target:get_point(),
		size = 5,
		time = self.time2
	}
	if not self.timer then 
		self.timer = ac.timer(1000,self.time2,function (t)
			for _,unit in ac.selector()
				: in_range(target,self.area/2)
				: ipairs()
			do 
				unit:add_buff(self.name)
				{
					value = 1,
					time = 1,
					source = hero,
					skill = self,
					-- effect = self.effect,
				}
			end 
			if t.count<= 0 then 
				t:remove()
				self.timer = nil
			end
		end)
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
	
    if self.timer then
        self.timer:remove()
        self.timer = nil
	end
end


local mt = ac.buff['织网']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.pulse = 1
mt.cover_type = 1
mt.cover_max = 1
mt.effect = [[]]
-- mt.keep = true

function mt:on_add()
	local target = self.target
	local source = self.source
	self.eff = target:add_effect('origin',self.effect)
	-- print('添加buff',target,source)
	if target == source then 
		target:add('攻击%',35)
		target:add('攻击间隔',-0.4)
		target:add('移动速度',450)
	else
		target:add('移动速度%',-40)
		target:add('攻击丢失',40)
	end
end

function mt:on_remove()
	local target = self.target
	local source = self.source
	if self.eff then self.eff:remove() end
	
	if target == source then 
		target:add('攻击%',-35)
		target:add('攻击间隔',0.4)
		target:add('移动速度',-450)
	else
		target:add('移动速度%',40)
		target:add('攻击丢失',-40)
	end
end
function mt:on_cover(new)
	return new.value > self.value
end





