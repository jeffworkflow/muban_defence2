local mt = ac.skill['敏捷专精']
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
	color = "黄阶",
	--技能类型
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['敏捷%'] = {1,20},
	--介绍
	tip = [[|cffffff00【敏捷】+1%*Lv

|cff00bdec【被动效果】杀怪1% 几率获得 0.1% 永久敏捷|cffff0000（已获得 %has_val% |cffff0000% 敏捷）
 ]],
	--技能图标
	art = [[mjzj.blp]],
	--特效
	effect = [[Shock Blast Green.mdx]],
	--特效4
	effect4 = [[触发时，从敌人身上创建特效吸收到英雄身上]],
	--被动事件
	event_name = "单位-杀死单位",
	attr_name = '敏捷%',
	value = 0.1,
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
		size =0.3
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
		hero:add(skill.attr_name,skill.value)
		skill:add_stack(1) --记录已获得的敏捷%永久加成
	end
end
function mt:on_remove()
	local hero = self.owner
	local skill = self
	local p = hero:get_owner()
	--移除时，扣除属性
	-- print('移除属性时的值',skill.has_val,)
	hero:add(skill.attr_name,-skill.spell_stack*skill.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
