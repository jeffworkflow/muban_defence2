local mt = ac.skill['破坏光线']
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
	skill_type = "主动,智力",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*8+100000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加智力'] = {20,400},
['攻击加智力'] = {20,400},
['每秒加智力'] = {20,400},
	--介绍
	tip = [[

|cffffff00【杀怪加智力】+20*Lv
【攻击加智力】+20*Lv
【每秒加智力】+20*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(智力*8+10w)*Lv*5|r

]],
	--技能图标
	art = [[jineng032.blp]],
	--特效
	effect = [[gx.mdx]],
	--特效4
	effect4 = [[参考赤灵的X射线]],
	--持续时间
	pulse_time = 0.4,
	--角度
	angle = 20,
	--每次最大数量
	count = 3,
	--X射线距离
	distance = 1600,
	--X射线速度
	speed = 1600,
	--碰撞范围
	hit_area = 100,
}
mt.on_cast_shot = ac.skill['X射线'].on_cast_shot
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
