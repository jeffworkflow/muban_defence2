local mt = ac.skill['死亡尖叫']
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
   damage_area = 800,
	--技能品阶
	color = "神阶",
	--技能类型
	skill_type = "被动，智力",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*25+100000000)* self.level
end,
	--被动事件
	event_name = "造成伤害效果",
	--属性加成
['杀怪加智力'] = {500,10000},
['攻击加智力'] = {500,10000},
['每秒加智力'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+500*Lv
【攻击加智力】+500*Lv
【每秒加智力】+500*Lv

|cff00bdec【被动效果】攻击10%几率对敌人造成范围技能伤害，并提升周围友军200%的技暴伤害（可叠加），持续5秒
【伤害公式】（智力*25+1亿)*Lv）|r]],
	--技能图标
	art = [[siwnagjianjiao.blp]],
	--特效
	effect = [[203.mdx]],
	--特效4
	effect4 = [[类似天尊天赋，以英雄为中心，发射五个冲击波（特效1），最大距离800码。

技暴伤害的范围 半径800码]],

	--被动事件
	event_name = "造成伤害效果",
	damage = function(self)
		return (self.owner:get('智力')*25+100000000)* self.level
	end,
	val = 200,
	time =5
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	--创建特效
	for i=1,5 do 
		local angle = (i-1)*360/5
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			model =  skill.effect,
			speed = 1200,
			angle = angle,
			distance = skill.damage_area,
			high = 120,
			size =1
		}
		--创建特效
		-- ac.effect_ex{
		-- 	model = self.effect,
		-- 	angle = angle,
		-- 	point = hero:get_point()
		-- }:remove()
	end

	--造成伤害
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: of_not_building()
		-- : is_enemy(hero) --测试
		: ipairs()
	do
		--敌人造成伤害 友军加buff
		if u:is_enemy(hero) then 
			u:damage
			{
				source = hero,
				damage = skill.damage ,
				skill = skill,
				damage_type = '法术'
			}	
		else
			u:add_buff '死亡尖叫' {
				time = self.time,
				val = self.val
			}
		end
	end
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

local mt = ac.buff['死亡尖叫']
mt.cover_type = 1 --共享型 
mt.cover_max = 5  

function mt:on_add()
	self.target:add('技暴伤害',self.val)
	-- self:add_stack
end

function mt:on_remove() 
	self.target:add('技暴伤害',-self.val)
	-- self.target:add('额外受到伤害',-self.val)
end