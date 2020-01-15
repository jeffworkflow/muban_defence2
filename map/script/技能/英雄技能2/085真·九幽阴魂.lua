local mt = ac.skill['真·九幽阴魂']
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
	skill_type = "被动,全属性",
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*32+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['杀怪加全属性'] = {40,800},
['攻击加全属性'] = {40,800},
['每秒加全属性'] = {40,800},
	--介绍
	tip = [[

|cffffff00【杀怪加全属性】+40*Lv
【攻击加全属性】+40*Lv
【每秒加全属性】+40*Lv

|cff00bdec【被动效果】对周围敌人造成范围技能伤害
【伤害公式】（全属性*32+100000000）*Lv|r

]],
	--技能图标
	art = [[qhswmc.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\DeathCoil\DeathCoilMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵的死亡脉冲]],
    casting_cnt = 1,
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	for i, u in ac.selector()
		: in_range(hero,self.area)
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do
		local mvr = ac.mover.target
		{
			source = hero,
			target = u,
			model = skill.effect,
			speed = 600,
			height = 110,
			skill = skill,
		}
		if not mvr then
			return
		end
		function mvr:on_finish()
			u:damage
			{
				source = hero,
				damage = skill.damage ,
				skill = skill,
				damage_type = '法术'
			}	
		end
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
