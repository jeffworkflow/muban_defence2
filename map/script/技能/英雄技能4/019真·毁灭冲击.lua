local mt = ac.skill['真·毁灭冲击']
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
	skill_type = "被动，智力",
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
  return (self.owner:get('智力')*35+1000000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加智力'] = {600,12000},
['攻击加智力'] = {600,12000},
['每秒加智力'] = {600,12000},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+300*Lv
【攻击加智力】+300*Lv
【每秒加智力】+300*Lv

|cff00bdec【被动效果】攻击10%几率对敌人造成范围技能伤害
【伤害公式】（智力*35+10亿)*Lv）|r
 ]],
	--技能图标
	art = [[huimiechongji.blp]],
	--特效
	effect = [[EXshexian-black.mdx]],
	--特效4
	effect4 = [[类似火焰呼吸，不过伤害区域是一个长方形，区域大小400*1200]],
	distance = 1500,
	hit_area = 300,
	time =1
}
mt.damage_start = ac.skill['毁灭冲击'].damage_start
mt.on_remove = ac.skill['毁灭冲击'].on_remove
