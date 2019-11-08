local mt = ac.skill['真·天外飞弹']
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
	color = "天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*60+10010)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {120,2400},
 ['攻击减甲'] = 50,
 ['攻击速度'] = 50,
 ['多重射'] = 2
,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+120*Lv
【攻击速度】+50%
【攻击减甲】+50
【多重射】+2

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，造成2次，每1秒造成一次伤害
【伤害公式】（敏捷*60+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[zhfd.blp]],
	--特效
	effect = [[calldown_4.mdx]],
	--特效1
	effect1 = [[calldown_flydown.mdx]],
	--特效2
	effect2 = [[calldown_flyup.mdx]],
	--特效4
	effect4 = [[【伤害公式】（敏捷*60+10000）*Lv]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
