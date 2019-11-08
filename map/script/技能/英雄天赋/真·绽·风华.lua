local mt = ac.skill['真·绽·风华']
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
  return (self.owner:get('智力')*25+10005)* self.level
end,
	--属性加成
 ['杀怪加智力'] = {100,2000},
 ['技暴几率'] = 5,
 ['技暴伤害'] = 50,
 ['技能伤害加深'] = 40,
	--介绍
	tip = [[|cffffff00【杀怪加智力】+100*Lv
【技暴几率】+5%
【技暴伤害】+50%
【技能伤害加深】+40%

|cff00ffff【被动效果】攻击10%几率触发法阵，闪避+50%,触发概率加成+50%,技能冷却+50%，持续8秒，内置CD12秒；法阵生成及消失时都会造成范围技能伤害
【伤害公式】（智力*25+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[dfh.blp]],
	--特效
	effect = [[AZ_CMpink_F_OriginMageP.mdx]],
	--特效4
	effect4 = [[持续时间13秒]],
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
