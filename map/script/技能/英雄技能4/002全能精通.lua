local mt = ac.skill['全能精通']
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
	color = "半魔阶",
	--技能类型
	skill_type = "被动,本能",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['攻击%'] = {0.65,13},
['护甲%'] = {0.65,13},
['生命上限%'] = {0.65,13},
	--介绍
	tip = [[|cffffff00【攻击】+0.65%*Lv
|cffffff00【护甲】+0.65%*Lv
|cffffff00【生命上限】+0.65%*Lv

|cff00bdec【被动效果】杀怪0.1%几率获得0.65%永久攻击、护甲、生命上限
（已获得has_val%攻击）
（已获得has_val%护甲）
（已获得has_val%生命上限）]],
	--技能图标
	art = [[bnzj.blp]],
	--特效
	effect = [[Shock Blast Yellow.mdx]],
	--特效4
	effect4 = [[模型大小=0.2，触发时，从敌人身上创建特效吸收到英雄身上]],
	--被动事件
	event_name = "单位-杀死单位",
	attr_name1 = '攻击%',
	attr_name2 = '护甲%',
	attr_name3 = '生命上限%',
	value = 0.1,
	has_val = function(self)
		return self.spell_stack * self.value
	end,
}
mt.damage_start = ac.skill['全属性精通'].damage_start
mt.on_remove = ac.skill['全属性精通'].on_remove
