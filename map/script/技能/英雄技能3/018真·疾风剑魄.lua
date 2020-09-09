local mt = ac.skill['真·疾风剑魄']
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
   damage_area = 400,
	--技能品阶
	color = "真神阶",
	--技能类型
	skill_type = "被动,攻击",
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
  return (self.owner:get('攻击')*12+1000000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加攻击'] = {1200,24000},
['每秒加攻击'] = {1200,24000},
	--介绍
	tip = [[|cffffff00【杀怪加攻击】+1200*Lv
【每秒加攻击】+1200*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（攻击*12+10亿）*Lv|r
 ]],
	--技能图标
	art = [[wubeici.blp]],
	--特效
	effect = [[Piercing Thrust.mdx]],
	--特效4
	effect4 = [[如上图，造成2次伤害，播放两次]],
	is_strong = function(self)
		if not self.owner then 
			return 
		end 
		return self.owner:has_item('三少爷的剑')
	end,
}
local function start_damage(skill,target)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	hero:timer(400,2,function()
		--创建特效
		for i=1,6 do 
			local angle = i * 360/6
			local center = target:get_point()
			local poi = center - {angle,self.damage_area -100}
			-- ac.point_effect(poi,{model = [[units\naga\NagaMyrmidon\NagaMyrmidon.mdx]],angle = angle+180,animation = 'Attack-1'}):remove()
			ac.effect_ex{
				model = self.effect,
				angle = angle + 180,
				point = poi,
				size = 2
			}:remove()
		end
		ac.wait(200,function()
			--造成伤害
			for i, u in ac.selector()
				: in_range(target,self.damage_area)
				: of_not_building()
				: is_enemy(hero)
				: ipairs()
			do	
				local mul = 2
				if target:get_point() * u:get_point() >self.damage_area/2 then 
					mul = 1 
				end 
				u:damage
				{
					source = hero,
					damage = skill.damage * mul,
					skill = skill,
					damage_type = '法术'
				}	
			end
		end)
	end) 
end
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end
	start_damage(skill,target)
	if self.is_strong then 
		ac.wait(200,function()
			start_damage(skill,target)
		end)
	end 
	
end