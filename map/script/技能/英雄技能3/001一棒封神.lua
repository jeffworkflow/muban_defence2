local mt = ac.skill['一棒封神']
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
	color = "神阶",
	--技能类型
	skill_type = "被动,力量",
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
  return (self.owner:get('力量')*25+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加力量'] = {500,10000},
['攻击加力量'] = {500,10000},
['每秒加力量'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+500*Lv
【攻击加力量】+500*Lv
【每秒加力量】+500*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人1S
【伤害公式】（力量*25+1亿）*Lv|r
 ]],
	--技能图标
	art = [[yibang.blp]],
	--特效
	effect = [[effect_hero_attack5.mdx]],
	--特效4
	effect4 = [[类似火焰呼吸，不过伤害区域是一个长方形，区域大小400*1200]],
	distance = 1200,
	hit_area = 250,
	time =1
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	local angle = damage.source:get_point() / damage.target:get_point()
	--创建特效
	ac.effect_ex{
		model = self.effect,
		angle = angle,
		point = hero:get_point()
	}:remove()
	for i, u in ac.selector()
		: in_line(hero, angle, self.distance, self.hit_area) --	起点--	角度--	长度--	宽度
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do
		u:add_buff '晕眩' {
			time = self.time
		}
		u:damage
		{
			source = hero,
			damage = skill.damage ,
			skill = skill,
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
