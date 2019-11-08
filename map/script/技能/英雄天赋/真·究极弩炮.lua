local mt = ac.skill['真·究极弩炮']
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
  return (self.owner:get('敏捷')*20+10004)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {80,1600},
 ['物理伤害加深'] = 80,
 ['攻击距离'] = 200,
 ['攻击速度'] = 50,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+80*Lv
【攻击速度】+50%
【攻击距离】+200
【物理伤害加深】+80%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*20+10000）*Lv+1.5%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[jjnp.blp]],
	--特效
	effect = [[AZ_AurelVlaicu_C4.MDX]],
	--特效4
	effect4 = [[0.5秒后再触发一次]],
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
