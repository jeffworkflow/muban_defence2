local mt = ac.skill['净灵咒']
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
	skill_type = "主动,晕眩",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*4+10000)* self.level*5
end,
	--施法范围
	area = 500,
	--介绍
	tip = [[

|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】(智力*4+1w)*Lv*5|r

]],
	--技能图标
	art = [[sw.blp]],
	--特效
	effect = [[FrostNova.mdx]],
	--特效4
	effect4 = [[参考赤灵的水舞]],
    --伤害类型
    damage_type = '法术',
    time = 1,
}
function mt:on_cast_shot()
    local skill = self
    local hero = self.owner
    --创建特效
    ac.effect_ex{
        point = hero:get_point(),
        model = skill.effect
    }:remove()
    --计算伤害
    for _,unit in ac.selector()
    : in_range(hero,self.damage_area)
    : is_enemy(hero)
    : ipairs()
    do 
        unit:damage
        {
            source = hero,
            damage = skill.damage,
            skill = skill,
            damage_type = skill.damage_type
        }
        unit:add_buff('晕眩')
        {
            source = hero,
            skll = skill,
            time = self.time
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
