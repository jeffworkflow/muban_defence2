local mt = ac.skill['旋风刀舞']
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
	color = "玄阶",
	--技能类型
	skill_type = "主动,敏捷",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*10+100000)* self.level*3
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加敏捷'] = {20,400},
['攻击加敏捷'] = {20,400},
['每秒加敏捷'] = {20,400},
	--介绍
	tip = [[

|cffffff00【杀怪加敏捷】+20*Lv
【攻击加敏捷】+20*Lv
【每秒加敏捷】+20*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(敏捷*10+10w)*Lv*3|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFanOfKnives.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\FanOfKnives\FanOfKnivesMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵的刀刃旋风]],
}
mt.on_cast_shot = ac.skill['刀刃旋风'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
