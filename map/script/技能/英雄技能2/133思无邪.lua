local mt = ac.skill['思无邪']
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
	skill_type = "主动,生命回复",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['生命恢复'] = {2000000,40000000},
	--介绍
	tip = [[

|cffffff00【生命恢复】+200w*Lv|r
        
|cff00bdec【主动施放1】回复(35+1*Lv)%生命值 并每秒回复|r|cffffff006%的生命值|r |cff00bdec持续5秒|r

|cff00bdec【主动施放2】唯一技能-内伤：对周围敌人造成|r|cffffff00生命恢复效果减少(24+0.8*Lv)%|r，|cff00bdec持续5秒|r

]],
	--技能图标
	art = [[sls.blp]],
	--特效
	effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
	--特效1
	effect1 = [[Effect_az_heiseguangzhu.mdx]],
	--特效4
	effect4 = [[参考赤灵的水疗术]],
    --内伤
    area = 500,--范围
    value = {-24.8,-40},--减少生命恢复效果值
    --治疗量
    heal = {36,55},
    stu_heal = 6,
    time = 5
}
mt.on_cast_start = ac.skill['黄庭经'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end
