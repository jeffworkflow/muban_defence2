local mt = ac.skill['探宝']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
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
 ['藏宝图再一次概率'] = 100,
	--介绍

tip = [[ 
|cffffe799移动速度+50
|cff00ff00击杀进攻怪可以获得双倍的守家积分

]],
	--技能图标
    art = [[shadiao.blp]],
	passive = true,

}

