local mt = ac.skill['真·冰天雪地']
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
  return (self.owner:get('智力')*70+10011)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {140,2800},
 ['技能伤害加深'] = 60
,
	--介绍
	tip = [[|cffffff00【杀怪加智力】+140*Lv
【技能伤害加深】+60%
【强大的冰盾系统】参考天空的宝藏
【强大的技能伤害】参考天空的宝藏

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，造成3次，每1秒造成一次伤害
【伤害公式】（智力*70+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[btxd.blp]],
	--特效4
	effect4 = [[【伤害公式】（智力*70+10000）*Lv]],
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
