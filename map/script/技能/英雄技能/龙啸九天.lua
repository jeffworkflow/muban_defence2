local mt = ac.skill['龙啸九天']
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
	color = "天阶",
	--技能类型
	skill_type = "被动,全属性",
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*16+10000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加全属性'] = {40,800},
	--介绍
	tip = [[|cffffff00【攻击加全属性】+40*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*16+10000000）*Lv
 ]],
	--技能图标
	art = [[longxiaojiutian.blp]],
	--特效
	effect = [[0007788 (2).mdx]],
	--特效4
	effect4 = [[类似希尔瓦娜斯的巨浪，移动距离1200]],
	--范围
	distance = 1200,
	hit_area = 125,
	--概率%
	cool = 1,
	--弹道数量
	num = 1,
	damage_type = '法术'
}

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local timer
	
	local num = skill.num

	for i = 1, num do
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			model =  skill.effect,
			speed = 1000,
			angle = hero:get_point()/target:get_point() + 360/num * i,
			hit_area = skill.hit_area,
			distance = skill.distance,
			high = 120,
			size = 0.9,
		}
		if mvr then
			function mvr:on_hit(u)
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
			end

			function mvr:on_remove()
				if timer then
					timer:remove()
				end
			end
		end
	end
end

function mt:on_add()
	local hero = self.owner
	local skill = self
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
	
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end

		local rand = math.random(1,100)
		if rand <= self.chance then 
			skill:atk_pas_shot(damage)
            hero:event_notify('单位-触发被动', hero,self)
            --激活cd
            skill:active_cd()
		end
	end)
end

function mt:on_remove()
	if self.trg then
		self.trg:remove()
		self.trg = nil
	end
end

