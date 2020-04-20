local mt = ac.skill['三千归尘']
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
	skill_type = "主动,晕眩",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*20+1000000)* self.level*3
end,
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】(智力*20+100w)*Lv*3|r

]],
	--技能图标
	art = [[sw.blp]],
	--特效
	effect = [[FrostNova.mdx]],
	--特效4
	effect4 = [[参考赤灵的水舞]],
    --伤害类型
    damage_type = '法术',
    time = 1,
}
mt.on_cast_shot = ac.skill['净灵咒'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
