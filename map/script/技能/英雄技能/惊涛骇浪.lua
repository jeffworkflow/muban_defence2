local mt = ac.skill['惊涛骇浪']
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
  return (self.owner:get('力量')*20+1000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['每秒加力量'] = {800,16000},
	--介绍
	tip = [[|cffffff00【每秒加力量】+800*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*20+1000000）*Lv
 ]],
	--技能图标
	art = [[3.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\FreezingBreath\FreezingBreathMissile.mdl]],
	--特效1
	effect1 = [[Abilities\Spells\Other\CrushingWave\CrushingWaveDamage.mdl]],
	--特效4
	effect4 = [[参考赤灵传说的巨浪]],
	--范围
	distance = 1500,
	hit_area = 125,
	--概率%
	cool = 1,
	--弹道数量
	num = 1,
	damage_type = '法术'
}

mt.model = [[Abilities\Spells\Undead\FreezingBreath\FreezingBreathMissile.mdl]]
mt.effect_data = {
	['chest'] = [[Abilities\Spells\Other\CrushingWave\CrushingWaveDamage.mdl]],
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
			model =  skill.model,
			speed = 600,
			angle = hero:get_point()/target:get_point() + 360/num * i,
			hit_area = skill.hit_area,
			distance = skill.distance,
			high = 120,
			size = 3,
		}
		if mvr then
			--timer = ac.loop(0.3*1000,function()
			--	ac.effect( mvr.mover:get_point(), skill.model, mvr.mover:get_facing(), 2 ):remove()
			--end)
			function mvr:on_hit(u)
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
				--添加效果
				for key,value in sortpairs(skill.effect_data) do 
					u:add_effect(key,value):remove()
				end	
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

