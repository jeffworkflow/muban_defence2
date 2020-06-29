local mt = ac.skill['大聚宝盆']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return self.level+5 end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "红",
	--图标
	art = [[jubaopen.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = {315,225},
	-- cool = 5,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['每秒加杀敌数'] = 4,
 ['每秒加木头'] = 50,
 ['每秒加魔丸'] = 100,

v1 = {315,225},
	--介绍
	tip = [[
|cffffff00+%每秒加杀敌数%|r  每秒加杀敌数
|cffffff00+%每秒加木头%|r 每秒加木头
|cffffff00+%每秒加魔丸%|r 每秒加魔丸

|cffffe799【被动-造宝】|r每隔%v1%秒，造出一个随机装备
]],
	--业务技能代码
}
mt.on_upgrade = ac.skill['小聚宝盆'].on_upgrade
mt.on_cast_start = ac.skill['小聚宝盆'].on_cast_start
mt.on_remove = ac.skill['小聚宝盆'].on_remove
