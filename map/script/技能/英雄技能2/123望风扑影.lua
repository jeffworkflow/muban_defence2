local mt = ac.skill['望风扑影']
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
	color = "地阶",
	--技能类型
	skill_type = "主动,无敌",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 25,
	--施法范围
	area = 500,
	--属性加成
['免伤几率'] = {7.3,13},
	--介绍
	tip = [[

|cffffff00【免伤几率】+（7+0.3*Lv）%

|cff00bdec【主动施放】使用技能后，接下来(5+0.2*Lv)次伤害必定免伤

]],
	--技能图标
	art = [[bmfy.blp]],
	--特效4
	effect4 = [[参考赤灵的不灭佛隐，同时只能触发一个，不能叠加]],
    value = {5.2,9},
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    -- self.damage_cnt = 0
    self.trg = hero:add_buff('不灭佛隐')
    {
        value = self.value,
        source = hero,
        skill = self,
        effect = self.effect,
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
