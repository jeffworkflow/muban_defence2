local mt = ac.skill['九天玄铁']
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
 ['物理伤害加深系数'] = 20,
 ['强化石天谕重复获得概率'] = 10,
	--介绍

tip = [[ 
|cffffe799物理伤害加深系数+20%

|cff00ff00使用强化石/天谕时，10%概率获得一个强化石/天谕
 ]],
	--技能图标
	art = [[xuantiejian.blp]],

}
