local mt = ac.skill['神威']
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
	color = "黄阶",
	--技能类型
	skill_type = "主动,力量",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*4+10000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {5,100},
['攻击加力量'] = {5,100},
['每秒加力量'] = {5,100},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+5*Lv
【攻击加力量】+5*Lv
【每秒加力量】+5*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(力量*4+1w)*Lv*5|r]],
	--技能图标
	art = [[jineng006.blp]],
	--特效
	effect = [[GoblinTech_R.mdx]],
	--特效4
	effect4 = [[参考赤灵的神威]],
}
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner

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
		-- u:add_buff '晕眩'
		-- {
		-- 	source = hero,
		-- 	time = self.time,
		-- }
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
