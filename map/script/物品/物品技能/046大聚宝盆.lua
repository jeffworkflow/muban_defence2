local mt = ac.skill['大聚宝盆']
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
	cool = {300,225},
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['每秒加杀敌数'] = 2,
 ['每秒加木头'] = 50,
 ['每秒加魔丸'] = 100,

v1 = {300,225},
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
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
