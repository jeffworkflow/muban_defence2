local mt = ac.skill['脸黑']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 5,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['全属性'] = 10000000,
 ['物品获取率'] = -100,
	--介绍
	tip = [[ 
|cffffe799【全属性】+1000万

|cff00ff00【物品获取率】-100%

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNSheep.blp]],
}