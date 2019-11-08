local mt = ac.skill['真·流光舞术']
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
  return (self.owner:get('敏捷')*30+10006)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {120,2400},
 ['移动速度'] = 200,
 ['吸血'] = 20,
 ['物理伤害加深'] = 160,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+120*Lv
【移动速度】+200
【吸血】+20%
【物理伤害加深】+160%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，每0.2秒造成一次，持续1秒
【伤害公式】（敏捷*30+10000）*Lv+2%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[lgws.blp]],
	--特效
	effect = [[gongjitexiao.mdx]],
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
