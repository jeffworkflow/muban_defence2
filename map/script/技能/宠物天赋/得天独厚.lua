local mt = ac.skill['得天独厚']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
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
 ['每秒加木头'] = 2,
 ['天选之人概率'] = 50,
	--介绍
	tip = [[ 
|cffffe799每秒加木头+2，
天选之人的事件触发概率提升50%

]],
	--技能图标
	art = [[tianxuan.blp]],
}

