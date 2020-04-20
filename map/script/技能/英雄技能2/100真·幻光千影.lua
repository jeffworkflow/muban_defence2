local mt = ac.skill['真·幻光千影']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "真天阶",
	--技能类型
	skill_type = "被动,智力",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*18+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['杀怪加智力'] = {160,3200},
['攻击加智力'] = {160,3200},
['每秒加智力'] = {160,3200},
	--介绍
	tip = [[

|cffffff00【杀怪加智力】+160*Lv
【攻击加智力】+160*Lv
【每秒加智力】+160*Lv

|cff00bdec【被动效果】对周围敌人造成范围技能伤害
【伤害公式】（智力*45+100000000）*Lv|r

]],
	--技能图标
	art = [[xsx.blp]],
	--特效
	effect = [[gx.mdx]],
	--特效4
	effect4 = [[参考赤灵的X射线]],
	--持续时间
	pulse_time = 0.4,
	--角度
	angle = 20,
	--每次最大数量
	count = 3,
	--X射线距离
	distance = 1600,
	--X射线速度
	speed = 1600,
	--碰撞范围
	hit_area = 100,
}
--X射线
--角度
local function damage_shot(skill,angle)
	local skill = skill
	local hero = skill.owner
	-- print('射线距离',skill.distance,skill.speed,angle)
	--X射线
	local mvr = ac.mover.line
	{
		source = hero,
		distance = skill.distance,
		speed = skill.speed,
		skill = skill,
		angle = angle,
		high = 110,
		model = skill.effect, 
		hit_area = skill.hit_area,
		hit_type = ac.mover.HIT_TYPE_ENEMY,
		size = 1
	}
	if not mvr then 
		return
	end
	function mvr:on_hit(dest)
		dest:damage
		{
			source = skill.owner,
			damage = skill.damage,
			skill = skill,
			missile = skill.mover,
			damage_type = '法术'
		}
	end	
end
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	--在目标区域创建特效
	self.trg = hero:timer(self.pulse_time * 1000,5,function(t)
		local angle = hero:get_facing()
		if t.cnt <=2 then 
			--然后发射3枚射线
			for i = 1,skill.count do
				--计算角度
				local angle = angle + (skill.count / 2 - skill.count - 0.5 + i) * skill.angle
				damage_shot(skill,angle)
			end	
		else
			damage_shot(skill,angle)
		end	
	end)
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
