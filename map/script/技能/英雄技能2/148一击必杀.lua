local mt = ac.skill['一击必杀']
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
	skill_type = "主动,会心",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['每秒加敏捷'] = {3200,64000},
	--介绍
	tip = [[

|cffffff00【每秒加敏捷】+3200*Lv|r

|cff00bdec【主动施放】增加|cffff0000会心几率+(6+0.4*Lv)% 会心伤害+(60+4*Lv)%|r，|cff00bdec持续3秒|r

]],
	--技能图标
	art = [[honglianbao.blp]],
	--特效4
	effect4 = [[参考赤灵的狂龙爆]],
    --技暴几率
    crit_rate = function(self) 
        return 6 + self.level * 0.4
    end ,
    --技暴伤害
    crit_damage = function(self) 
        return 60 + self.level * 4
    end ,
    damage_type = '法术',
    time = 3
}
mt.on_cast_start = ac.skill['会心一击'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
