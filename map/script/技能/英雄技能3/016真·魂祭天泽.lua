local mt = ac.skill['真·魂祭天泽']
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
   damage_area = 1000,
	--技能品阶
	color = "真神阶",
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 4,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*48+1000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加全属性'] = {240,4800},
['攻击加全属性'] = {240,4800},
['每秒加全属性'] = {240,4800},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+240*Lv
【攻击加全属性】+240*Lv
【每秒加全属性】+240*Lv

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人2S
【伤害公式】（全属性*48+10亿）*Lv|r
 ]],
	--技能图标
	art = [[hunji.blp]],
	--特效
	effect = [[hero_hs05.mdx]],
	--特效4
	effect4 = [[参考最终BOSS的"伤害守卫"，持续时间4秒，每隔1秒造成一次伤害，晕眩0.5秒]],
	pulse_time = 1,
	time = 4,
	stu_time = 0.5 --晕眩时间
}
mt.damage_start = ac.skill['魂祭天泽'].damage_start
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
