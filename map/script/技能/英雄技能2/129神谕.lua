local mt = ac.skill['神谕']
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
	color = "天阶",
	--技能类型
	skill_type = "主动,无敌",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 25,
	--施法范围
	area = 500,
	--属性加成
['减伤'] = {8.4,16},
	--介绍
	tip = [[

|cffffff00【减伤】+（8+0.4*Lv）%

|cff00bdec【主动施放】让自己无敌（2.5+0.25*Lv）秒

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
	--特效
	effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
	--特效4
	effect4 = [[参考赤灵的神圣护甲，同时只能触发一个，不能叠加]],
    stand_time = {2.75,7.5},
}
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local player = hero:get_owner()
	self.trg = hero:add_buff '无敌' {
		time = self.stand_time
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
