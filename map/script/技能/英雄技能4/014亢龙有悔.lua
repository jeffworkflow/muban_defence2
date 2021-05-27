local mt = ac.skill['亢龙有悔']
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
	color = "神阶",
	--技能类型
	skill_type = "被动，力量",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*30+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加力量'] = {500,10000},
['攻击加力量'] = {500,10000},
['每秒加力量'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+250*Lv
【攻击加力量】+250*Lv
【每秒加力量】+250*Lv

|cff00bdec【被动效果】攻击10%几率对敌人造成范围技能伤害
【伤害公式】（力量*30+1亿)*Lv）|r
 ]],
	--技能图标
	art = [[longyouhui.blp]],
	--特效
	effect = [[JNTX05.MDX]],
	--特效4
	effect4 = [[在目标位置播放特效后，0.1秒后再播放一次]],
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
		point = target:get_point()
	}:remove()

	ac.wait(0.1*1000,function()
		ac.effect_ex{
			model = self.effect,
			point = target:get_point()
		}:remove()
	end)
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = skill.damage ,
			skill = skill,
			damage_type = '法术'
		}	
	end
end
