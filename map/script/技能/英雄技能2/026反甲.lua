local mt = ac.skill['反甲']
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
	skill_type = "被动,被攻击",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "受到伤害效果",
	--施法范围
	area = 500,
	--属性加成
['护甲'] = {500,10000},
	--介绍
	tip = [[

|cffffff00【护甲】+500*Lv|r

|cff00bdec【被动效果】被攻击5%几率对敌人造成额外伤害
【伤害公式】（敌人攻击*1%+1W）*Lv

]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNThornShield.blp]],
	damage_rate = 1,
	--特效4
	effect4 = [[参考赤灵的反甲]],
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 
	-- print('测试反甲 攻击倍率',skill.damage_rate)
	damage.source:damage
	{
		source = hero,
		damage = (damage.source:get('攻击')*skill.damage_rate/100+1000000)* self.level,
		-- damage = damage.source:get('攻击'),
		skill = skill
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
