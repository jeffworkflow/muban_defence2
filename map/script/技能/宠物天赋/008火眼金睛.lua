local mt = ac.skill['火眼金睛']
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
 ['全伤加深系数'] = 10,
 ['攻击距离%'] = 10,
	--介绍

tip = [[ 
|cffffe799全伤加深系数+10%
|cffffe799攻击距离+10%

]],
	--技能图标
	art = [[moshen.blp]],
}
