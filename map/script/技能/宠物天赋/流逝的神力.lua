local mt = ac.skill['流逝的神力']
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
 ['移动速度'] = 50,
 ['全属性'] = 20000000,
 ['每秒加全属性'] = -1000,
 
	--介绍
	tip = [[ 
|cffffe799【智力】+10%

|cff00ff00使得主人触发被动时，10%几率|cffffff00召唤弟弟|cff00ff00出来帮忙打架

]],
	--技能图标
	art = [[chaoren.blp]],
}