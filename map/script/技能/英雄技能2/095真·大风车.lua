local mt = ac.skill['真·大风车']
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
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*45+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['杀怪加敏捷'] = {160,3200},
['攻击加敏捷'] = {160,3200},
['每秒加敏捷'] = {160,3200},
	--介绍
	tip = [[

|cffffff00【杀怪加敏捷】+160*Lv
【攻击加敏捷】+160*Lv
【每秒加敏捷】+160*Lv

|cff00bdec【被动效果】对周围敌人造成范围技能伤害
【伤害公式】（敏捷*45+100000000）*Lv|r

]],
	--技能图标
	art = [[qhdrxf.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\FanOfKnives\FanOfKnivesMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵的刀刃旋风]],
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	local angle_base = 0
	local num = 3
	for i = 1, num do
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			start = hero:get_point(),
			model =  skill.effect,
			speed = 800,
			angle = angle_base + 360/num * i,
			distance = skill.area  ,
			size = 2,
			height = 120
		}
		if not mvr then
			return
		end
	end	

	for i, u in ac.selector()
	: in_range(hero,self.area)
	: is_enemy(hero)
	: of_not_building()
	: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = skill.damage ,
			skill = skill,
			damage_type ='法术'
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
