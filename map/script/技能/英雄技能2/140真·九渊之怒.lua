local mt = ac.skill['真·九渊之怒']
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
	skill_type = "被动,技暴",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['每秒加智力'] = {3200,64000},
	--介绍
	tip = [[

|cffffff00【每秒加智力】+3200*Lv|r

|cff00bdec【被动效果】攻击10%几率触发|cffff0000技暴几率+30% 技暴伤害+300%|r，|cff00bdec持续0.75秒|r

]],
	--技能图标
	art = [[qhdyyb.blp]],
	--特效4
	effect4 = [[参考赤灵的渡业妖爆]],
    time = 0.75,
    skill_rate = 30,
    skill_damage = 300
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 

	hero:add_buff('渡业妖爆')
	{
		value = self.skill_rate,
		skill_rate = self.skill_rate,
		skill_damage = self.skill_damage,
		source = hero,
		time = self.time,
		skill = self,
	}
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
