local mt = ac.skill['九渊之怒']
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
	skill_type = "主动,技暴",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['每秒加智力'] = {16000,320000},
	--介绍
	tip = [[

|cffffff00【每秒加智力】+16000*Lv|r

|cff00bdec【主动施放】增加|cffff0000技暴几率+(10+0.75*Lv)% 技暴伤害+(300+20*Lv)%，|r|cff00bdec持续5秒|r

]],
	--技能图标
	art = [[dyyb.blp]],
	--特效4
	effect4 = [[参考赤灵的渡业妖爆]],
    --技暴几率
    skill_rate = function(self)
        return 10 + self.level*0.75
    end,
    --技暴伤害
    skill_damage = function(self)
        return 300 + self.level*20
    end,
    damage_type = '法术',
    time = 5
}
mt.on_cast_start = ac.skill['魔息术'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
