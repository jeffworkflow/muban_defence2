local mt = ac.skill['血色罗纹']
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
   damage_area = 600,
	--技能品阶
	color = "神阶",
	--技能类型
	skill_type = "被动,生命",
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
  return (self.owner:get('生命上限')*12+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加生命上限'] = {2000,40000},
	--介绍
	tip = [[|cffffff00【杀怪加生命上限】+2000*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（生命上限*12+1亿）*Lv|r
 ]],
	--技能图标
	art = [[yeqiu.blp]],
	--特效
	effect = [[AZ_Slark_C.mdx]],
	--特效4
	effect4 = [[目标区域播放特效，伤害范围1000]],
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	--创建特效
	ac.effect_ex{
		model = self.effect,
		size = 3,
		point = target:get_point(),
	}:remove()
	--造成伤害
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do	
		u:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
			damage_type = '法术'
		}	
	end
end