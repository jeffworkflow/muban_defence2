local mt = ac.skill['爆珠']
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
 ['攻击间隔'] = -0.1,
 ['噬魂珠翻倍'] = 100,
	--介绍

tip = [[ 
	|cffffe799攻击间隔-0.1
	
	|cff00ff00至凶之物的【噬血珠】属性翻倍
	
	当拥有这个技能时，【噬血珠】【噬魂珠】的所有属性都翻倍

]],
	--技能图标
	art = [[sxs.blp]],
}