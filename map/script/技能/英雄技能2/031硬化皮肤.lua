local mt = ac.skill['硬化皮肤']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "黄阶",
	--技能类型
	skill_type = "被动,肉",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['护甲'] = {600,12000},
['伤害减少'] = {400000,8000000},
	--介绍
	tip = [[

|cffffff00【护甲】+600*Lv
【伤害减少】+40w*Lv|r

]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNResistantSkin.blp]],
}

