local mt = ac.skill['天马流星拳']
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
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
		return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*12.5+10000)* self.level
	  end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加全属性'] = {275,5500},
['攻击加全属性'] = {275,5500},
['每秒加全属性'] = {275,5500},
['攻击减甲'] = 488,
['每秒加护甲'] = 68,
['全伤加深'] = 350,
['攻击速度'] = 888,
['攻击间隔'] = -0.1,
['攻击间隔极限'] = -0.1,
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+275*Lv
【攻击减甲】+488
【每秒加护甲】+68
【全伤加深】+350%
【攻击间隔】-0.1（无视攻击间隔极限）
【极致的攻击速度】

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*12.5*Lv+2%敌人的最大生命值）

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[tmlxq.blp]],
	--特效
	effect = [[Kaiserbreath.mdx]],
	--特效4
	effect4 = [[类似火焰呼吸，不过伤害区域是一个长方形，区域大小400*1200]],
	distance = 1500,
	hit_area = 350,
	life_rate =2
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	local angle = damage.source:get_point() / damage.target:get_point()
	--创建特效
	ac.effect_ex{
		model = self.effect,
		angle = angle,
		point = hero:get_point()
	}:remove()
	for i, u in ac.selector()
		: in_line(hero, angle, self.distance, self.hit_area) --	起点--	角度--	长度--	宽度
		: of_not_building()
		: is_enemy(hero)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			damage = skill.damage ,
			skill = skill,
			damage_type = '法术'
		}	
		--最大生命值伤害
		u:damage
		{
			source = hero,
			damage = u:get('生命上限')*skill.life_rate/100 ,
			skill = skill,
			real_damage = true,
		}	
	end
end