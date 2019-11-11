local mt = ac.skill['真·剑气冲霄']
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
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*150+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加全属性'] = {250,5000},
 ['攻击减甲'] = 488,
 ['攻击间隔'] = -0.25,
 ['全伤加深'] = 488
,
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+250*Lv
【攻击减甲】+488
【攻击间隔】-0.25
【全伤加深】+488%
【强大的永生系统】死亡后1秒原地重生，死亡时候对周围500码敌人造成伤害（全属性*75+10000）*Lv

|cff00ffff【被动效果】攻击10%几率造成超大范围技能伤害（伤害公式：全属性*150*Lv+0.5%敌人的最大生命值）

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[jqcx.blp]],
	--特效
	effect = [[Abilities\Spells\Orc\Shockwave\ShockwaveMissile.mdl]],
	--特效1
	effect1 = [[ShockwaveMissile.mdx]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
