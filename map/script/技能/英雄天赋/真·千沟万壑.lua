local mt = ac.skill['真·千沟万壑']
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
	color = "真天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*10+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['攻击力%'] = 50,
 ['护甲'] = 5000,
 ['伤害减少'] = 500000,
	--介绍
	tip = [[|cffffff00【攻击力】+50%
【护甲】+5000
【伤害减少】+500000

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人
【伤害公式】（力量*10+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[qgwh.blp]],
	--特效
	effect = [[ImpaleHitTarget.mdx]],
	--特效1
	effect1 = [[ImpaleMissTarget.mdx]],
	--特效4
	effect4 = [[0.5秒后再触发一次]],
	time = 0.5 ,
	--碰撞范围
	hit_area = 200,
	--特效移动速度
	speed = 5000,
	--距离
	distance =1000,
}


function mt:atk_pas_shot(target)
	local skill = self
	local hero = self.owner
	local source = hero:get_point()
	local target = target:get_point()
	local angle = source / target
	local mvr = ac.mover.line
	{
		source = hero,
		start = hero,
		angle = angle,
		speed = skill.speed,
		distance = skill.distance,
		skill = skill,
		high = 110,
		model = '', 
		hit_area = skill.hit_area,
		size = 1
	}
	if not mvr then 
		return
	end

	function mvr:on_move()
		--创建特效
		ac.effect_ex{
			point = self.mover:get_point(),
			model = skill.effect1
		}:remove()  
	end	
	function mvr:on_hit(dest)
		local u = dest
		u:add_effect('origin',skill.effect):remove()
		u:add_buff '晕眩'
		{
			time = skill.time,
			skill = skill,
			source = hero,
		}
		
		u:add_buff '高度'
		{
			time = 0.3,
			speed = 1200,
			skill = skill,
			reduction_when_remove = true
		}
		u:damage
		{
			skill = skill,
			source = hero,
			damage = skill.damage,
			damage_type = '法术'
		}	
	end	
	
end	

function mt:on_add()
    local skill = self
    local hero = self.owner
    
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			self:atk_pas_shot(damage.target)
			--0.5秒后再触发一次
			ac.wait(500,function()
				self:atk_pas_shot(damage.target)
			end)
            --激活cd
            skill:active_cd()
        end
    end)

end   

function mt:on_remove()
	local hero = self.owner
	if self.trg then
		self.trg:remove()
		self.trg = nil
	end
end
