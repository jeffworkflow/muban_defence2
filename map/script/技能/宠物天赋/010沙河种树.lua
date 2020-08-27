local mt = ac.skill['沙河种树']
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
	--作用在人身上
	strong_hero = true,
	passive = true,
	--属性加成
 ['物理伤害加深系数'] = 10,
 ['一颗神奇的种子再一次概率'] = 10,
	--介绍

tip = [[ 
|cffffe799强化成功概率+2%

|cff00ff00可对物品重铸，获得另外一个相同品质的物品

]],
	--技能图标
	art = [[ronglu.blp]],
}
