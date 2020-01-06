local mt = ac.skill['震荡波']
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
	color = "黄阶",
	--技能类型
	skill_type = "被动,力量",
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
  return (self.owner:get('力量')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {10,200},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+10*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*5+10000）*Lv
 ]],
	--技能图标
	art = [[zdb.blp]],
	--特效
	effect = [[Abilities\Spells\Orc\Shockwave\ShockwaveMissile.mdl]],
	--特效4
	effect4 = [[参考魔兽自带的震荡波]],
	--范围
	hit_area = 150,
	distance = 900,
	--伤害类型
	damage_type = '法术',
}

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local mvr = ac.mover.line
	{
		source = hero,
		skill = skill,
		model = skill.effect,
		speed = 900,
		angle = hero:get_point()/target:get_point(),
		hit_area = skill.hit_area,
		distance = skill.distance,
		size = 1,
	}
	if mvr then
		function mvr:on_hit(u)
			u:damage
			{
				source = hero,
				target = u,
				skill = skill,
				--damage = 100,
				damage = skill.damage,
				damage_type = skill.damage_type,
			}
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
            hero:event_notify('单位-触发被动', hero,self,damage.target,damage)
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
