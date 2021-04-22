local mt = ac.skill['探宝']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['物品获取率'] = 15,
 ['藏宝图再一次概率'] = 15,
	--介绍

tip = [[ 
|cffffe799物品获取率+15%

|cff00ff00使用藏宝图的时候，10%概率再挖一次

]],
	--技能图标
    art = [[tanbao.blp]],
	passive = true,

}

