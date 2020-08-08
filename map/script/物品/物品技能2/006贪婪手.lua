local mt = ac.skill['贪婪手']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "神",
	--图标
	art = [[dianjinshou.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = {270,180},
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成

 ['杀敌数加成'] = 60,
 ['物品获取率'] = 60,
 ['木头加成'] = 60,
 ['魔丸加成'] = 60,
 ['每秒加杀敌数'] = 20,
 ['每秒加木头'] = 500,
 ['每秒加魔丸'] = 1000,

v1 = {270,180},
	--介绍
	tip = [[

|cffcccccc贪婪是个丑恶的字眼,但它不放过任何一个人。

|cffffff00+%杀敌数加成%|r |cffffff00%|r 杀敌数加成
|cffffff00+%物品获取率%|r |cffffff00%|r 物品获取率
|cffffff00+%木头加成%|r |cffffff00%|r 木头加成
|cffffff00+%魔丸加成%|r |cffffff00%|r 魔丸加成
|cffffff00+%每秒加杀敌数%|r 每秒加杀敌数
|cffffff00+%每秒加木头%|r 每秒加木头
|cffffff00+%每秒加魔丸%|r 每秒加魔丸

|cffffff00【唯一被动-贪婪】|r每隔%v1%秒，造出一个随机红色装备]],
	--备注
	effect4 = [[印钞手的进化版本]],
	--业务技能代码
}
mt.on_upgrade = ac.skill['小聚宝盆'].on_upgrade
mt.on_cast_start = ac.skill['小聚宝盆'].on_cast_start
mt.on_remove = ac.skill['小聚宝盆'].on_remove
