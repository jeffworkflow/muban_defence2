local mt = ac.skill['魔鬼金矿']
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
	color = "黑",
	--图标
	art = [[mgjk.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['杀敌数加成'] = 60,
 ['物品获取率'] = 60,
 ['木头加成'] = 60,
 ['魔丸加成'] = 60,
	--介绍
	tip = [[

|cffcccccc金矿被魔鬼占据之后，侍僧才可以从中采集黄金资源。

|cffffff00+%杀敌数加成% |cffffe799%|r 杀敌数加成
|cffffff00+%物品获取率% |cffffe799%|r 物品获取率
|cffffff00+%木头加成% |cffffe799%|r 木头加成
|cffffff00+%魔丸加成% |cffffe799%|r 魔丸加成
 ]],
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
