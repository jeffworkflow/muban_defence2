local mt = ac.skill['印钞手']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return self.level+5 end,
    --伤害范围
   damage_area = 175,
	--类型
	item_type = "装备",
	--套装
	-- suit_type = "收益",
	--品质
	color = "金",
	--图标
	art = [[item\dianjin.blp]],
	--售价
	gold = 1000,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = {90,30},
	--忽略技能冷却
	ignore_cool_save = true,
	--施法范围
	area = {175,475},
	--介绍
	tip = [[
	
|cffffe799【点金术】|r能立即杀死|cffffe799指定范围内|r的非BOSS类的单位，并获得|cffffe79920倍的赏金*物品等级|r
 ]],
	--备注
	effect4 = [[主动使用，施法距离=1000]],
	--业务技能代码
	--目标类型
	target_type = ac.skill.TARGET_TYPE_POINT,
	value = function(self)
		return self.level*20
	end,
	range = 1000
}
function mt:on_cast_start()
	local hero = self.owner
	local p = hero.owner
	local target = self.target

	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_type('boss')
		: ipairs()
	do
		-- u.gold= u.gold and u.gold * self.value
		-- u.wood= u.wood and u.wood * self.value
		-- u.rec_ex= u.rec_ex and  u.rec_ex * self.value
		if u.gold then 
			hero:addGold(u.gold * (self.value-1))
		end
		if u.wood then 
			hero:add_wood(u.wood * (self.value-1))
			-- print('增加了木头',u.wood * (self.value-1))
		end
		if u.rec_ex then 
			hero:add_rec_ex(u.rec_ex * (self.value-1))
		end
		u:kill(hero) --无法激活cd，需要手动激活
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
