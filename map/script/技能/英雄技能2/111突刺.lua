local mt = ac.skill['突刺']
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
	color = "黄阶",
	--技能类型
	skill_type = "主动,晕眩",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*5+10000)* self.level*3
end,
	--介绍
	tip = [[

|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】(敏捷*5+1w)*Lv*3|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNImpale.blp]],
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
	time = 1 ,
	--碰撞范围
	hit_area = 200,
	--特效移动速度
	speed = 5000,
}
function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

	local function start_damage()
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
	--先释放一次，再释放4次
	start_damage()
	-- if self.casting_cnt >1 then 
	-- 	hero:timer(0.5*1000,self.casting_cnt-1,function(t)
	-- 		start_damage()
	-- 	end)
	-- end	

	
end	
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
