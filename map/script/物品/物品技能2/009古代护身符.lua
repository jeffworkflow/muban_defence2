local mt = ac.skill['古代护身符']
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
	art = [[gdhsf.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['智力%'] = 35,
['技暴伤害'] = 600,
['会心伤害'] = 300,
['技能伤害加深'] = 300,
['全伤加深'] = 100,
['对BOSS额外伤害'] = 50,
	--介绍
	tip = [[

|cffcccccc耶路撒冷发现的一件迷人的小护身符，是人们一直痴迷于抵御传说中的邪恶之眼

|cffffff00+%智力%%|r |cffffff00%|r 智力
|cffffff00+%技暴伤害%|r |cffffff00%|r 技暴伤害
|cffffff00+%会心伤害%|r |cffffff00%|r 会心伤害
|cffffff00+%技能伤害加深%|r |cffffff00%|r 技能伤害加深
|cffffff00+%全伤加深%|r |cffffff00%|r 全伤加深
|cffffff00+%对BOSS额外伤害%|r |cffffff00%|r 对BOSS额外伤害
]],
	--备注
	effect4 = [[强智力]],
	v1 = {1,1},
	--业务技能代码
}
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
