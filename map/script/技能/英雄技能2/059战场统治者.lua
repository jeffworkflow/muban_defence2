local mt = ac.skill['战场统治者']
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
	color = "天阶",
	--技能类型
	skill_type = "被动,暴击",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['攻击加力量'] = {2400,48000},
['暴击几率'] = {8.4,16},
['暴击伤害'] = {32,640},
	--介绍
	tip = [[

|cffffff00【攻击加力量】+2400*Lv|r
|cffffff00【暴击几率】+（8+0.4*Lv)%
【暴击伤害】+32%*Lv|r

]],
	--技能图标
	art = [[baoji.blp]],
}

