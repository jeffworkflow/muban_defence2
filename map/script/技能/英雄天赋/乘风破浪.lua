local mt = ac.skill['乘风破浪']
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
  return (self.owner:get('智力')*5+10000)* self.level
end,
	--属性加成
 ['每秒加木头'] = {1,20},
 ['每秒加魔丸'] = {1,20},
 ['物品获取率'] = 25,
	--介绍
	tip = [[|cffffff00【每秒加木头】+1*Lv
【每秒加魔丸】+1*Lv
【物品获取率】+25%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人（0.3秒）
【伤害公式】（智力*5+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[cfpl.blp]],
	--特效
	effect = [[ShellCharge.mdx]],
	--特效4
	effect4 = [[范围200*1200，
播放特效：ShellCharge.mdx]],
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
