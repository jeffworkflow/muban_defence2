local mt = ac.skill['魔神降世']
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
  return (self.owner:get('智力')*10+10001)* self.level
end,
	--属性加成
 ['杀怪加力量'] = {40,800},
 ['吸血'] = 10,
 ['攻击距离'] = 100,
 ['物理伤害加深'] = 40,
	--介绍
	tip = [[|cffffff00【杀怪加力量】+40*Lv
【吸血】+10%
【攻击距离】+100
【物理伤害加深】+40%

|cff00ffff【被动效果】攻击10%几率变身魔神，持续8秒，内置CD12秒
【攻击】+50%
【攻击速度】+500%
【分裂伤害】+50%
【减伤】+50%

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[msjs.blp]],
	--特效
	effect = [[LvBuPiFu3.mdx]],
	--特效4
	effect4 = [[吕布 变身模型 LvBuPiFu3.mdx]],
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
