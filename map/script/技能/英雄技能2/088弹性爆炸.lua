local mt = ac.skill['弹性爆炸']
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
	color = "地阶",
	--技能类型
	skill_type = "主动,力量",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*15+1000000)* self.level*3
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {120,2400},
['攻击加力量'] = {120,2400},
['每秒加力量'] = {120,2400},
	--介绍
	tip = [[

|cffffff00【杀怪加力量】+120*Lv
【攻击加力量】+120*Lv
【每秒加力量】+120*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(力量*15+100w)*Lv*3|r

]],
	--技能图标
	art = [[jineng006.blp]],
	--特效
	effect = [[GoblinTech_R.mdx]],
	--特效4
	effect4 = [[参考赤灵的神威]],
}

mt.on_cast_shot = ac.skill['神威'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
