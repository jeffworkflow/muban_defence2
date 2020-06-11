local mt = ac.skill['火焰雨']
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
	color = "玄阶",
	--技能类型
	skill_type = "被动,智力",
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
  return (self.owner:get('智力')*12+100000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加智力'] = {80,1600},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+80*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*20+100000）*Lv
 ]],
	--技能图标
	art = [[card1_9.blp]],
	--特效
	effect = [[Abilities\Spells\Demon\RainOfFire\RainOfFireTarget.mdl]],
	--特效1
	effect1 = [[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵传说的火焰雨]],
	--波次
	tm = 2
}

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local point = target:get_point()
	
	local tm = 0
	local timer

	local function raining()
		for i = 1 , 10 do
			ac.effect_ex
			{
				point = point - {math.random(1,360),math.random(30,skill.area/2)},
				model = skill.effect,
				size = 0.7
			}:remove()
		end
		hero:wait(0.85*1000,function()
			for _,u in ac.selector()
				: in_range(point,skill.area/2)
				: is_enemy(hero)
				: ipairs()
			do
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
				u:add_effect('chest',skill.effect1):remove()
			end
		end)
	end

	raining()
	timer = ac.loop(1*1000,function()
		tm = tm + 1
		if tm == skill.tm then
			timer:remove()
		end
		raining()
	end)
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
