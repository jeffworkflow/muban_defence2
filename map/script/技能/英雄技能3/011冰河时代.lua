local mt = ac.skill['冰河时代']
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
   damage_area = 1000,
	--技能品阶
	color = "神阶",
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
  return (self.owner:get('智力')*96+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加智力'] = {240,4800},
['攻击加智力'] = {240,4800},
['每秒加智力'] = {240,4800},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+240*Lv
【攻击加智力】+240*Lv
【每秒加智力】+240*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*96*Lv+1%敌人的最大生命值）|r]],
	--技能图标
	art = [[binghe.blp]],
	--特效
	effect = [[IX26.mdx]],
	--特效4
	effect4 = [[目标区域播放特效，伤害范围1000]],
	life_rate = 1,
}
mt.damage_start = ac.skill['暴殄天物'].damage_start
