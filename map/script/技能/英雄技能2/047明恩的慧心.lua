local mt = ac.skill['明恩的慧心']
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
	color = "玄阶",
	--技能类型
	skill_type = "被动,触发",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加全属性'] = {160,3200},
['触发概率加成'] = {10.2,14},
	--介绍
	tip = [[

|cffffff00【杀怪加全属性】+160*Lv|r
|cffffff00【触发概率加成】+（10+0.2*Lv)%|r

]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNMagicalSentry.blp]],
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
