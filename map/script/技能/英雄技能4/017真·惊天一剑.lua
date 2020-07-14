local mt = ac.skill['真·惊天一剑']
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
	color = "真神阶",
	--技能类型
	skill_type = "被动，敏捷",
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
  return (self.owner:get('敏捷')*35+1000000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加敏捷'] = {600,12000},
['攻击加敏捷'] = {600,12000},
['每秒加敏捷'] = {600,12000},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+300*Lv
【攻击加敏捷】+300*Lv
【每秒加敏捷】+300*Lv

|cff00bdec【被动效果】攻击10%几率对敌人造成范围技能伤害
【伤害公式】（敏捷*35+10亿)*Lv）|r
 ]],
	--技能图标
	art = [[pobingzhijian.blp]],
	--特效
	effect = [[A091.mdx]],
	--特效4
	effect4 = [[在目标位置播放特效]],
}
mt.damage_start = ac.skill['惊天一剑'].damage_start
mt.on_remove = ac.skill['惊天一剑'].on_remove
