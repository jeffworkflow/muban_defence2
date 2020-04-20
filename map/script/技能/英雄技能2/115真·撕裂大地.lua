local mt = ac.skill['真·撕裂大地']
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
	skill_type = "被动,晕眩",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*45+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【被动效果】攻击10%几率对周围敌人造成范围技能伤害，并晕眩0.2S
【伤害公式】（敏捷*45+100000000）*Lv|r

]],
	--技能图标
	art = [[qhcc.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\Impale\ImpaleHitTarget.mdx]],
	--特效1
	effect1 = [[Abilities\Spells\Undead\Impale\ImpaleMissTarget.mdx]],
	--特效4
	effect4 = [[参考赤灵的穿刺]],
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
	--持续时间
	time = 0.2 ,
	--碰撞范围
	hit_area = 200,
	--特效移动速度
	speed = 5000,
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	local source = hero:get_point()
	local target = self.target:get_point()
	local angle = source / target
	local mvr = ac.mover.line
	{
		source = hero,
		start = hero,
		angle = angle,
		speed = skill.speed,
		distance = skill.range,
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
		-- print('移动中创建特效',skill.effect1)
		ac.effect_ex{
			point = self.mover:get_point(),
			model =skill.effect1,
		}:remove()
	end	
	function mvr:on_hit(dest)
		local u = dest
		ac.effect_ex{
			point = u:get_point(),
			model =skill.effect,
		}:remove()

		u:add_buff '晕眩'
		{
			time = skill.time,
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
			damage = skill.damage,
			damage_type = '法术'
		}
	end	
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
