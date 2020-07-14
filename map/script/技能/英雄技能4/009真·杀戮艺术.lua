local mt = ac.skill['真·杀戮艺术']
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
	skill_type = "被动，叠伤",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加敏捷'] = {600,12000},
['攻击加敏捷'] = {600,12000},
['每秒加敏捷'] = {600,12000},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+600*Lv
【攻击加敏捷】+600*Lv
【每秒加敏捷】+600*Lv

|cff00bdec【被动效果】攻击5%几率造成范围技能伤害，并叠加一层持续时间为5秒的“影割”状态
【伤害公式】（敏捷*15*Lv*影割层数）|r]],
	--技能图标
	art = [[shanuyishu.blp]],
	--特效
	effect = [[effect2_az_jingzi_jiansheng01_e1.mdx]],
	--特效4
	effect4 = [[目标位置播放特效，特效朝向：从英雄往敌人的方向，伤害范围100*1200]],
	--被动事件
	event_name = "造成伤害效果",
	damage = function(self)
		return self.owner:get('敏捷')*15* self.level
	end,
	distance = 1200,
	hit_area = 100,
	time =5
}
mt.damage_start = ac.skill['杀戮艺术'].damage_start
mt.on_remove = ac.skill['杀戮艺术'].on_remove
