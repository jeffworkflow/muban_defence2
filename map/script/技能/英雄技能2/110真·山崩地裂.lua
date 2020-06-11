local mt = ac.skill['真·山崩地裂']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 2*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "真天阶",
	--技能类型
	skill_type = "被动,晕眩",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*60+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【被动效果】攻击2%概率对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】（力量*60+100000000）*Lv|r

]],
	--技能图标
	art = [[qhjt.blp]],
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
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	local point = hero:get_point()
	-- hero:add_effect('origin',self.effect):remove()
	ac.effect_ex{
		point = point,
		model=self.effect,
		size = 2
	}:remove()
	for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			time = self.time,
			skill = self,
			source = hero,
			model = self.effect1,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
			damage_type = skill.damage_type
		}
	end	
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
