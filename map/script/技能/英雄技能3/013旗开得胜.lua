local mt = ac.skill['旗开得胜']
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*8+1000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加全属性'] = {250,5000},
['攻击加全属性'] = {250,5000},
['每秒加全属性'] = {250,5000},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+250*Lv
【攻击加全属性】+250*Lv
【每秒加全属性】+250*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*10*Lv+2%敌人的最大生命值）|r
 ]],
	--技能图标
	art = [[qikai.blp]],
	--特效
	effect = [[AZ_LCDark_D_Flag.mdx]],
	--特效4
	effect4 = [[参考最终BOSS的"伤害守卫"，持续时间4秒，每隔1秒造成一次伤害]],
	pulse_time = 1,
	time = 4,
	life_rate = 0.5

}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 

	skill.eff = ac.effect(target:get_point(),skill.effect,270,1.5,'origin')
	-- self.eff2 = ac.effect(target:get_point(),skill.effect1,270,0.8,'origin') 
	--计时器
	skill.trg = hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
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
			--附加 1%真伤
			u:damage
			{
				source = hero,
				damage = u:get('生命上限') * (skill.life_rate /100) ,
				skill = skill,
				real_damage = true
			}	
		end	

	end)
	function skill.trg:on_timeout()
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
