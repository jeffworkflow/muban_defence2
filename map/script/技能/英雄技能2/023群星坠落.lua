local mt = ac.skill['群星坠落']
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
	skill_type = "被动,被攻击",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*6+500000)* self.level
end,
	--被动事件
	event_name = "受到伤害效果",
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【被动效果】被攻击5%几率造成范围技能伤害
【伤害公式】(全属性*6+50w)*Lv

]],
	--技能图标
	art = [[xingluo.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\Starfall\StarfallTarget.mdl]],
	--特效4
	effect4 = [[参考赤灵的群星陨落]],
}
mt.damage_start = ac.skill['星落'].damage_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
