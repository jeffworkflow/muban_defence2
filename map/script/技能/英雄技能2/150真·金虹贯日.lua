local mt = ac.skill['真·金虹贯日']
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
	skill_type = "被动,会心",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['每秒加敏捷'] = {20000,400000},
	--介绍
	tip = [[

|cffffff00【每秒加敏捷】+20000*Lv|r

|cff00bdec【被动效果】攻击10%几率触发 |cffff0000会心几率+15% 会心伤害+300%|r，|cff00bdec持续0.5秒|r

]],
	--技能图标
	art = [[qhhonglianbao.blp]],
	--特效4
	effect4 = [[参考赤灵的狂龙爆]],
    time = 0.5,
    crit_rate = 15,
    crit_damage = 150
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 

	hero:add_buff('会心一击')
	{
		value = self.crit_rate,
		crit_rate = self.crit_rate,
		crit_damage = self.crit_damage,
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