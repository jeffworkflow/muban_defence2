local mt = ac.skill['真·乙木仙遁']
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
	skill_type = "被动,无敌",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 7.5,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['免伤几率'] = {10.5,20},
	--介绍
	tip = [[|cffffff00【免伤几率】+（10+0.5*Lv）%

|cff00bdec【被动效果】攻击10%几率触发，接下来5次伤害必定免伤]],
	--技能图标
	art = [[qhbmfy.blp]],
	--特效4
	effect4 = [[参考赤灵的不灭佛隐，同时只能触发一个，不能叠加]],
    value = 5,
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
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
