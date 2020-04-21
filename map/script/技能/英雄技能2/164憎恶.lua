local mt = ac.skill['憎恶']
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
	skill_type = "主动,钩子",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*30+10000000)* self.level*3
end,
	--属性加成
['杀怪加力量'] = {80,1600},
['攻击加力量'] = {80,1600},
['每秒加力量'] = {80,1600},
	--介绍
	tip = [[

|cffffff00【杀怪加力量】+80*Lv
【攻击加力量】+80*Lv
【每秒加力量】+80*Lv

|cff00bdec【主动施放】向指定方向投出钩子，将敌人钩回身边
【伤害公式】(力量*30+1000w)*Lv*3|r

]],
	--技能图标
	art = [[zengwu.blp]],
	--特效
	effect = [[SentinelMissile.mdx]],
	--特效1
	effect1 = [[Abilities\Weapons\WardenMissile\WardenMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵的憎恶]],
    --技能目标
    target_type = ac.skill.TARGET_TYPE_POINT,
    --施法距离
    range =  1200,
    --投射物碰撞距离
    hit_area = 150,
    speed = 1200,
    --cd
    cool = 15,
    damage_type = '法术',
    --减速事件
    reduce_time = 3,
    move_speed_rate = 20
}
mt.on_cast_start = ac.skill['肉钩'].on_cast_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
