local mt = ac.skill['号令之旗']
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
	art = [[item\jineng406.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
v1 = {5,15},
v2 = {5,15},
v3 = {5,15},
v4 = {5,15},
	--介绍
	tip = [[|cffffff00【唯一被动-专注】|r能给周围友军提供额外%v1% %的生命上限 
|cffffff00【唯一被动-战鼓】|r能给周围友军提供额外%v2% %的攻击
|cffffff00【唯一被动-行军】|r能给周围友军提供额外%v3% %的移动速度
|cffffff00【唯一被动-战甲】|r能给周围友军提供额外%v4% %的护甲]],
	--业务技能代码
	area = 1000,
}
mt.aura = {'专注','战鼓','行军','战甲'}
mt.on_upgrade = ac.skill['风暴狮角'].on_upgrade
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
