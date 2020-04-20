local mt = ac.skill['真·鬼舞枯藤']
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*18+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【被动效果】对周围敌人造成范围技能伤害，并晕眩0.2S
【伤害公式】（全属性*18+100000000）*Lv|r

]],
	--技能图标
	art = [[qhcr.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
	--特效4
	effect4 = [[参考赤灵的缠绕]],
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
    time =0.2,
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	--在目标区域创建特效
	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			time = self.time,
			skill = self,
			source = hero,
			ref ='origin',
			model = self.effect,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
			damage_type = '法术'
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
