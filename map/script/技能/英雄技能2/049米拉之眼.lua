local mt = ac.skill['米拉之眼']
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
	color = "天阶",
	--技能类型
	skill_type = "被动,触发",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加全属性'] = {320,6400},
['触发概率加成'] = {20.6,32},
	--介绍
	tip = [[

|cffffff00【杀怪加全属性】+320*Lv|r
|cffffff00【触发概率加成】+（20+0.6*Lv)%|r

]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNMagicalSentry.blp]],
}

