local mt = ac.skill['鬼舞枯藤']
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
	skill_type = "主动,晕眩",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*16+10000000)* self.level*5
end,
	--施法范围
	area = 500,
	--介绍
	tip = [[|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】（全属性*16+10000000）*Lv*5|r]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNEntanglingRoots.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
	--特效4
	effect4 = [[参考赤灵的缠绕]],
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
    time =1,
}
mt.on_cast_shot = ac.skill['捆绑'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
