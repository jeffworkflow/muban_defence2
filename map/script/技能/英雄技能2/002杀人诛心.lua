local mt = ac.skill['杀人诛心']
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
	skill_type = "被动,收益",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['敏捷'] = {1600000,32000000},
['杀敌数加成'] = {8,160},
	--介绍
	tip = [[

|cffffff00【敏捷】+160W*Lv|r
|cffffff00【杀敌数加成】+4%*Lv|r

]],
	--技能图标
	art = [[shadi1.blp]],
}

