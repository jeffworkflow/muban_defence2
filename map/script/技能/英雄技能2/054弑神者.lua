local mt = ac.skill['弑神者']
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
	skill_type = "被动,技暴",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['攻击加智力'] = {480,9600},
['技暴几率'] = {8.4,16},
['技暴伤害'] = {8,160},
	--介绍
	tip = [[

|cffffff00【攻击加智力】+480*Lv|r
|cffffff00【技暴几率】+（8+0.4*Lv)%
【技暴伤害】+8%*Lv|r

]],
	--技能图标
	art = [[jibao.blp]],
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
