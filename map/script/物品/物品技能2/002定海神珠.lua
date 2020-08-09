local mt = ac.skill['定海神珠']
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
	color = "黑",
	--图标
	art = [[dhsz.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['智力%'] = 10,
 ['技暴几率'] = 10,
 ['技暴伤害'] = 400,
 ['技能伤害加深'] = 200,

v1 = {0.5,7.5},
	--介绍
	tip = [[

|cffcccccc散发五色毫光，威力巨大犹如四海之力

|cffffff00+%智力%%|r |cffffff00%|r 智力
|cffffff00+%技暴几率%|r |cffffff00%|r 技暴几率
|cffffff00+%技暴伤害%|r |cffffff00%|r 技暴伤害
|cffffff00+%技能伤害加深%|r |cffffff00%|r 技能伤害加深

|cff00ffff【唯一被动-冷却】|r|cffffff00+%v1%|r |cffffff00%|r 技能冷却（无视技能冷却上限）
]],
	attr = '技能冷却极限',
	attr2 = '技能冷却',
}
function mt:on_upgrade()
	local hero = self.owner 
	if self.bff then 
		self.bff:remove()
	end
	self.bff = hero:add_buff('属性_'..self.attr) {
		value= self.v1,
		cover_type = 0, --独占
	}

	if self.bff2 then 
		self.bff2:remove()
	end
	self.bff2 = hero:add_buff('属性_'..self.attr2) {
		value= self.v1,
		cover_type = 0, --独占
	}
end

function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.bff then
        self.bff:remove()
        self.bff = nil
    end
    if self.bff2 then
        self.bff2:remove()
        self.bff2 = nil
    end
end
