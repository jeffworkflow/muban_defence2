local mt = ac.skill['沧澜破']
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
	skill_type = "主动,降敌护甲",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['减少周围护甲'] = {230,800},
	--介绍
	tip = [[

|cffffff00【减少周围护甲】+（200+30*Lv）

|cff00bdec【唯一效果】使用后降低周围敌人（16+0.7*lv）%护甲，持续8秒|r

]],
	--技能图标
	art = [[azly.blp]],
	--特效4
	effect4 = [[参考赤灵的暗之领域]],
    value = {16.7,30},
    time = 8
}
mt.on_cast_start = ac.skill['暗之领域'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
