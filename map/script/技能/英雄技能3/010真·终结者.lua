local mt = ac.skill['真·终结者']
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
	color = "真神阶",
	--技能类型
	skill_type = "被动,敏捷",
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
  return (self.owner:get('敏捷')*60+1000000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加敏捷'] = {480,9600},
['攻击加敏捷'] = {480,9600},
['每秒加敏捷'] = {480,9600},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+480*Lv
【攻击加敏捷】+480*Lv
【每秒加敏捷】+480*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*60*Lv+1%敌人的最大生命值）|r
 ]],
	--技能图标
	art = [[heianxuanwo.blp]],
	--特效
	effect = [[effect_z_uberdarkwave.mdx]],
	--特效4
	effect4 = [[目标区域播放特效，伤害范围1000]],
	life_rate = 1,
}
mt.damage_start = ac.skill['暴殄天物'].damage_start