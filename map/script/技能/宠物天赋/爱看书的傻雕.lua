local mt = ac.skill['爱看书的傻雕']
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
 ['移动速度'] = 50,
 ['羊皮无字再一次概率'] = 10,
	--介绍

tip = [[ 
|cffffe799移动速度+50

|cff00ff00使用羊皮纸、无字天书时候，10%概率再解密一次

]],
	--技能图标
    art = [[shadiao.blp]],
    passive = true,

}





