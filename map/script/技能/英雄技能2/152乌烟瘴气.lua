local mt = ac.skill['乌烟瘴气']
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
	skill_type = "主动,降敌命中",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['闪避'] = {6.2,10},
	--介绍
	tip = [[

|cffffff00【闪避】+（6+0.2*Lv）%

|cff00bdec【唯一效果】使用后周围敌人攻击有20%几率丢失，持续5秒|r

]],
	--技能图标
	art = [[mzly.blp]],
	--特效4
	effect4 = [[参考赤灵的迷之领域]],
    value = 20,
    time = 5
}
mt.on_cast_start = ac.skill['含沙射影'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
