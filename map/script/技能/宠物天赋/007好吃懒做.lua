local mt = ac.skill['好吃懒做']
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
 ['生命上限%'] = 100,
 ['移动速度'] = -50,
 ['攻击速度'] = -50,
 ['扭蛋券再一次概率'] = 10,
	--介绍

tip = [[ 
|cffffe799生命上限+100%
|cffffe799移动速度-50
|cffffe799攻击速度-50%

|cff00ff00使用扭蛋/超级扭蛋券（十连抽）时，10%概率再使用一次

]],
	--技能图标
	art = [[zxj.blp]],
}
