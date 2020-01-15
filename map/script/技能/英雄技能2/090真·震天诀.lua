local mt = ac.skill['真·震天诀']
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
	skill_type = "被动,力量",
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
  return (self.owner:get('力量')*64+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {80,1600},
['攻击加力量'] = {80,1600},
['每秒加力量'] = {80,1600},
	--介绍
	tip = [[

|cffffff00【杀怪加力量】+80*Lv
【攻击加力量】+80*Lv
【每秒加力量】+80*Lv

|cff00bdec【被动效果】对周围敌人造成范围技能伤害
【伤害公式】（力量*64+100000000）*Lv|r

]],
	--技能图标
	art = [[qhjineng006.blp]],
	--特效
	effect = [[GoblinTech_R.mdx]],
	--特效4
	effect4 = [[参考赤灵的神威]],
}

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	-- 特效
	ac.effect_ex{
        point = hero:get_point(),
        model = self.effect,
        size =1.25
    }:remove()

	for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = self.damage,
            skill = self,
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
