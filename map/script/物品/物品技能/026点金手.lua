local mt = ac.skill['点金手']
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
	--套装
	-- suit_type = "收益",
	--品质
	color = "白",
	--图标
	art = [[item\dianjin.blp]],
	--售价
	gold = 1000,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = {62,2},
	--忽略技能冷却
	ignore_cool_save = true,
	--介绍
	tip = [[

|cffffe799【点金术】|r能立即杀死非BOSS类的单位，并获得|cffffe79925倍的赏金*物品等级|r
 ]],
	--备注
	effect4 = [[主动使用，施法距离=1000]],
	
	--目标类型
	target_type = ac.skill.TARGET_TYPE_UNIT,
	value = function(self)
		return self.level*25
	end,
	range = 1000
}
function mt:on_cast_start()
	local hero = self.owner
	local p = hero.owner
	local unit = self.target
	-- print('单位类型：',unit.is_type('boss'),unit.unit_type)
	if not unit:is_type('boss')   then 
		unit.gold= unit.gold and unit.gold * self.value
		unit.wood= unit.wood and unit.wood * self.value
		unit.rec_ex= unit.rec_ex and  unit.rec_ex * self.value
		unit:kill(hero) --无法激活cd，需要手动激活
	else
		p:sendMsg('不可对boss使用',5)
	end
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
