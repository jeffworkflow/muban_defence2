local mt = ac.skill['飞焰']
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
	color = "地阶",
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
  return (self.owner:get('智力')*20+10000)* self.level
end,
	--属性加成
['杀怪加智力'] = {40,800},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+40*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*20+10000）*Lv]],
	--技能图标
	art = [[card2_61.blp]],
	--特效
	effect = [[Abilities\Weapons\PhoenixMissile\Phoenix_Missile_mini.mdl]],
	--特效4
	effect4 = [[参考赤灵传说的飞焰]],--范围
	range = 1500,
	--伤害范围
	area = 75,
	--数量
	num = 20,
	--冷却
	cool = 1,
	--伤害类型
	damage_type = '法术',

}

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local ang = hero:get_point()/target:get_point()

	local speed = 1200
	
	local function shot(u)
		local mover = u
		local mvr = ac.mover.line
		{
			start = hero:get_point(),
			mover =  u,
			source = hero,
			skill = skill,
			speed = 500,
			accel = -500,
			angle = math.random(0,360),
			distance = math.random(100,200),
			min_speed = 10,
			high = 70,
			size = 1,
		}
		function mvr:on_finish()
			local mvr2 = ac.mover.line
			{
				start = u:get_point(),
				mover =  u,
				source = hero,
				skill = skill,
				speed = 500,
				accel = 500,
				angle = ang+math.random(-30,30),
				distance = skill.range,
				hit_area = 70,
				high = 70,
				size = 1,
			}

			function mvr2:on_hit(hit)
				for _,u in ac.selector()
					: in_range(hit:get_point(),skill.area/2)
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
				end
				mvr2:remove()
			end

			local function destroy()
				u.f2_effect:remove()
				u:kill()
			end
			
			function mvr2:on_remove()
				destroy()
			end

			function mvr2:on_finish()
				destroy()
			end
		end
	end
	
	local tm = skill.num
	local timer
	timer = ac.loop(0.05*1000,function()
		local u = ac.player[16]:create_dummy('e001', hero:get_point(), 0)
		u:set_high(0)
		u.f2_effect = u:add_effect('origin', skill.effect)
		shot(u)
		tm = tm -1
		if tm <= 0 then
			timer:remove()
		end
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
            hero:event_notify('单位-触发被动', hero,self)
            --激活cd
            skill:active_cd()
		end
	end)
end

function mt:on_remove()
	if self.trg then
		self.trg:remove()
	end
end
