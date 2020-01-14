local mt = ac.skill['山崩地裂']
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
  return (self.owner:get('力量')*32+10000000)* self.level*5
end,
	--施法范围
	area = 500,
	--介绍
	tip = [[|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】(力量*32+1000w)*Lv*5|r]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNWarStomp.blp]],
	--特效
	effect = [[Abilities\Spells\Human\ThunderClap\ThunderclapCaster.mdx]],
	--特效1
	effect1 = [[Abilities\Spells\Human\ThunderClap\ThunderclapTarget.mdx]],
	--特效4
	effect4 = [[参考赤灵的践踏]],
	--持续时间
	time = 1 ,
	damage_type ='法术'
}
mt.on_cast_shot = ac.skill['踩地板'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
