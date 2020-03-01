local mt = ac.skill['幽冥术']
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
	skill_type = "主动,全属性",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*4+100000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加全属性'] = {10,200},
['攻击加全属性'] = {10,200},
['每秒加全属性'] = {10,200},
	--介绍
	tip = [[

|cffffff00【杀怪加全属性】+10*Lv
【攻击加全属性】+10*Lv
【每秒加全属性】+10*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】（全属性*4+100000）*Lv*5|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDeathCoil.blp]],
	--特效
    effect = [[Abilities\Spells\Undead\DeathCoil\DeathCoilMissile.mdl]],
    casting_cnt = 1,
	--特效4
	effect4 = [[参考赤灵的死亡脉冲]],
}
mt.on_cast_shot = ac.skill['死亡缠绕'].on_cast_shot
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
