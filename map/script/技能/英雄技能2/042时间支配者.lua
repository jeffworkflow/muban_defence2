local mt = ac.skill['时间支配者']
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
	color = "玄阶",
	--技能类型
	skill_type = "被动,冷却",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加智力'] = {400,8000},
['技能冷却'] = {6.4,14},
	--介绍
	tip = [[

|cffffff00【杀怪加智力】+400*Lv|r
|cffffff00【技能冷却】+（6+0.4*Lv)%|r

]],
	--技能图标
	art = [[xlb.blp]],
}

