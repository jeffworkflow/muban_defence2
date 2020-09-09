local mt = ac.skill['魔灵夜泷漩']
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
	skill_type = "被动,智力",
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
  return (self.owner:get('智力')*25+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加智力'] = {500,10000},
['攻击加智力'] = {500,10000},
['每秒加智力'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+500*Lv
【攻击加智力】+500*Lv
【每秒加智力】+500*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人1S
【伤害公式】（智力*25+1亿）*Lv|r
 ]],
	--技能图标
	art = [[donggan.blp]],
	--特效
	effect = [[Effect_az_yin_q3.mdx]],
	--特效4
	effect4 = [[类似火焰呼吸，不过伤害区域是一个长方形，区域大小400*1200]],
	distance = 1000,
	hit_area = 200,
	time =1,
	is_strong = function(self)
		if not self.owner then 
			return 
		end 
		return self.owner:has_item('太初威丸弹弓')
	end,
}
local function start_damage(skill,damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
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


function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	start_damage(skill,damage)
	if self.is_strong then 
		ac.wait(1000,function()
			start_damage(skill,damage)
		end)
	end
end