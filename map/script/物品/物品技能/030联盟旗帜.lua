local mt = ac.skill['联盟旗帜']
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
	color = "金",
	--图标
	art = [[ReplaceableTextures\CommandButtons\BTNHumanCaptureFlag.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
v1 = {5,25},
v2 = {5,25},
v3 = {5,20},
	--介绍
	tip = [[

|cffffe799【唯一被动-专注】|r能给周围友军提供额外 %v1% |cffffe799%|r的生命上限 
|cffffe799【唯一被动-战鼓】|r能给周围友军提供额外 %v2% |cffffe799%|r的攻击
|cffffe799【唯一被动-行军】|r能给周围友军提供额外 %v3% |cffffe799%|r的移动速度
]],
	--业务技能代码
	area = 1000,
}
mt.aura = {'专注','战鼓','行军'}
mt.on_upgrade = ac.skill['风暴狮角'].on_upgrade
mt.on_remove = ac.skill['风暴狮角'].on_remove
