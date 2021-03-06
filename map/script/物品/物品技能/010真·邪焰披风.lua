local mt = ac.skill['真·邪焰披风']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return self.level+5 end,
    --伤害范围
   damage_area = 400,
	--类型
	item_type = "装备",
	--品质
	color = "黑",
	--图标
	art = [[item\jineng502.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (20000000)* self.level
end,
	--施法范围
	area = 800,
	--属性加成
 ['力量'] = 150000000,
 ['护甲'] = 99999,
 ['减伤'] = 5,
 ['每秒加护甲'] = 25,

v1 = {1,0.5},
	--介绍
	tip = [[

|cffcccccc一团幽蓝色的火焰正在跳动，在它周围，有一个黑色的魅影静静地把它拥抱

|cffffff00+%力量%|r 力量
|cffffff00+%护甲%|r 护甲
|cffffff00+%减伤% |cffffff00%|r 减伤
|cffffff00+%每秒加护甲%|r 每秒加护甲

|cffffe799【唯一被动-献祭】|r
每隔 %v1% 秒能对周围敌人造成 %damage% 点真实伤害
]],
	--特效
	effect = [[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]],
	--备注
	effect4 = [[宠物携带无效

模型放怪物身上

唯一被动-献祭，不叠加，真实伤害

当怪物同时只会受到一个献祭的效果]],
	--业务技能代码
}
mt.on_upgrade = ac.skill['火焰宝珠'].on_upgrade
mt.on_remove = ac.skill['火焰宝珠'].on_remove