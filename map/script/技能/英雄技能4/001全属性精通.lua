local mt = ac.skill['全属性精通']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 1*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "半魔阶",
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['力量%'] = {0.65,13},
['敏捷%'] = {0.65,13},
['智力%'] = {0.65,13},
	--介绍
	tip = [[|cffffff00【全属性】+0.65%*Lv

|cff00bdec【被动效果】杀怪1%几率 获得0.065%全属性|cffff0000（已获得 %has_val% |cffff0000%）
 ]],
	--技能图标
	art = [[qsxzj.blp]],
	--特效
	effect = [[Shock Blast Yellow.mdx]],
	--特效4
	effect4 = [[模型大小=0.2，触发时，从敌人身上创建特效吸收到英雄身上]],
	--被动事件
	event_name = "单位-杀死单位",
	attr_name1 = '力量%',
	attr_name2 = '敏捷%',
	attr_name3 = '智力%',
	value = 0.065,
	has_val = function(self)
		return self.spell_stack * self.value
	end,
}
function mt:damage_start(source,target)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = target
	

	local turn_speed = math.random(1,20)*18
	local angle = hero:get_point() / target:get_point()  +math.random(-90,90)
	local height = math.random(200,400)
	local mvr = ac.mover.target
	{
		start = target:get_point(),
		target = hero,
		model = self.effect,
		speed = 600,
		height = height,
		--反方向
		angle =   angle ,
		turn_speed = turn_speed,
		skill = skill,
		size =0.2
	}
	if not mvr then
		return
	end
	function mvr:on_move()
		if self.turn_speed >=0 then 
			self.turn_speed = self.turn_speed + 10
		else 	
			self.turn_speed = self.turn_speed - 10 
		end
	end
	function mvr:on_finish()
		hero:add(skill.attr_name1,skill.value)
		hero:add(skill.attr_name2,skill.value)
		hero:add(skill.attr_name3,skill.value)
		if skill.attr_name4 then 
			hero:add(skill.attr_name4,skill.value)
		end
		if skill.attr_name5 then 
			hero:add(skill.attr_name5,skill.value)
		end
		if skill.attr_name6 then 
			hero:add(skill.attr_name6,skill.value)
		end

		skill:add_stack(1) --记录已获得的敏捷%永久加成
	end
end
function mt:on_remove()
	local hero = self.owner
	local skill = self
	local p = hero:get_owner()
	--移除时，扣除属性
	-- print('移除属性时的值',skill.has_val,)
	hero:add(skill.attr_name1,-skill.spell_stack*skill.value)
	hero:add(skill.attr_name2,-skill.spell_stack*skill.value)
	hero:add(skill.attr_name3,-skill.spell_stack*skill.value)

	if skill.attr_name4 then 
		hero:add(skill.attr_name4,-skill.spell_stack*skill.value)
	end
	if skill.attr_name5 then 
		hero:add(skill.attr_name5,-skill.spell_stack*skill.value)
	end
	if skill.attr_name6 then 
		hero:add(skill.attr_name6,-skill.spell_stack*skill.value)
	end
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end