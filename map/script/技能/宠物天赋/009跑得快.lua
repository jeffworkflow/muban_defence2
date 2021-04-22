local mt = ac.skill['跑得快']
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
	--作用在人身上
	strong_hero = true,
	passive = true,
	--属性加成
 ['移动速度'] = 500,
	--介绍

tip = [[ 
|cffffe799移动速度+500

]],
	--技能图标
	art = [[blm.blp]],
}
