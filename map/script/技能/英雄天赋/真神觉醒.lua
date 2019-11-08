local mt = ac.skill['真神觉醒']
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
  return (self.owner:get('敏捷')*40+10012)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {160,3200},
 ['移动速度'] = 200,
 ['物理伤害加深'] = 200
,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+160*Lv
【移动速度】+200
【物理伤害加深】+200%
【强大的永生系统】死亡后2秒原地重生，死亡时候对周围500码敌人造成伤害，（敏捷*40+10000）*Lv

|cff00ffff【被动效果】攻击10%几率造成多次突袭伤害，造成5次，每0.1秒造成一次伤害并晕眩0.1秒，500范围内随机一个敌人（可以是同一个敌人），如果没有敌人就暂停
【伤害公式】（敏捷*40+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[zsjx.blp]],
	--特效4
	effect4 = [[人在球里冲锋，Valiant Charge Royal.mdx

死亡原地创建，重生后消失，Mx_yetiliujing.mdx]],
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
