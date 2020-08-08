local mt = ac.skill['鸿蒙生死印']
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
	art = [[hmssy.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 2,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['生命上限%'] = 100,
['会心伤害'] = 300,
['全伤加深'] = 150,

v1 = {0.2,0.5},
	--介绍
	tip = [[

|cffcccccc唯一的永生之器，为万灵所觊觎。

|cffffff00+%生命上限%%|r |cffffff00%|r 生命上限
|cffffff00+%会心伤害%|r |cffffff00%|r 会心伤害
|cffffff00+%全伤加深%|r |cffffff00%|r 全伤加深
【强大的永生系统】（死亡后3秒重生）

|cff00bdec【唯一被动-永恒】攻击10% 几率让自己无敌，持续%v1%S|r
]],
	--特效
	effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
	--备注
	effect4 = [[小无敌，唯一]],
	--业务技能代码
	unique_name ='永恒',
	cover = function(self)
		return self.v1
	end
}
mt.event_name = '造成伤害效果'
mt.chance = 10

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    self.value = self.v1
	if not damage:is_common_attack()  then 
		return 
	end 
	hero:add_buff '无敌'{
		time = self.v1
	}
	
end
function mt:on_add()
	local hero = self.owner
	local skl = hero:find_skill('重生',nil,true)
	if not skl then 
		skl = hero:add_skill('重生','隐藏')
	end

	self.skl1 = skl
	if self.skl1 and self.skl1.time >=3 then 
		self.skl1.cnt = 99999999
		self.skl1.time = 3
	end	 
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.skl1 then
        self.skl1:remove()
        self.skl1 = nil
    end
end
