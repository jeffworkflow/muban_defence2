local mt = ac.skill['魂祭天泽']
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
   damage_area = 1000,
	--技能品阶
	color = "神阶",
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 4,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*10+1000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加全属性'] = {120,2400},
['攻击加全属性'] = {120,2400},
['每秒加全属性'] = {120,200},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+120*Lv
【攻击加全属性】+120*Lv
【每秒加全属性】+120*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人2S
【伤害公式】（全属性*12+1亿）*Lv|r
 ]],
	--技能图标
	art = [[hunji.blp]],
	--特效
	effect = [[hero_hs05.mdx]],
	--特效4
	effect4 = [[参考最终BOSS的"伤害守卫"，持续时间4秒，每隔1秒造成一次伤害，晕眩0.5秒]],
	pulse_time = 1,
	time = 4,
	stu_time = 0.5 --晕眩时间

}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 

	self.eff = ac.effect(target:get_point(),skill.effect,270,1.5,'origin')
	-- self.eff2 = ac.effect(target:get_point(),skill.effect1,270,0.8,'origin') 
	--计时器
	self.trg = hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
		for i, u in ac.selector()
        : in_range(target,skill.damage_area)
        : is_enemy(hero)
        : ipairs()
		do 
			u:damage
			{
				source = hero,
				damage = skill.damage ,
				skill = skill,
				damage_type = '法术'
			}	
			--附加 晕眩效果
			u:add_buff '晕眩' {
				time = skill.stu_time
			}
		end
	end)
	function self.trg:on_timeout()
		if skill.eff then
			skill.eff:remove()
			skill.eff = nil
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
