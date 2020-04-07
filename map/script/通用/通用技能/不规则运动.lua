local mt = ac.skill['不规则运动']
mt{
    --等级
    level = 1,
	tip = [[
		|cff11ccff被动：|r
		攻击时%chance%%触发火球术，对%area%周围造成%damage%伤害。
    ]],
	art = [[llzj.blp]],
	--概率触发多重锤
	chance = 100, --90表示百分90%
	--model
	model = [[Athelas Yellow.mdx]],
	--弹道速度
	speed = 1000,
	--范围
	area = 350,	
	--伤害
	damage = 30,
	--自由碰撞时的碰撞半径
    hit_area = 100,
    passive = true
}
function mt:on_add()
	local skill = self
	local function range_attack_start(hero, damage)
		if damage.skill and damage.skill.name == self.name then
			return
		end
		local target = damage.target
		local damage = skill.damage
		local unit_mark = {}
		print('触发不规则运动：')
		for i=1,5 do
			local turn_speed 
			turn_speed = math.random(1,20)*18
			local angle = target:get_point() / hero:get_point() +math.random(-90,90)
			local height = math.random(200,400)
			local mvr = ac.mover.target
			{
				source = hero,
				target = target,
				model = self.model,
				speed = 600,
				height = height,
				--反方向
				angle =   angle ,
				turn_speed = turn_speed,
				skill = skill,
				damage = damage,
				hit_area = skill.hit_area,
				stay_time = 0.3 ,
				on_move_count = 0,
                move_high = 0,
                size =0.3
			}
			if not mvr then
				return
			end
			function mvr:on_move()
				--local rand_speed = math.random(-100,100)
				if self.turn_speed >=0 then 
					self.turn_speed = self.turn_speed + 10
				else 	
					self.turn_speed = self.turn_speed - 10 
				end
				-- print(self.height_c,self.height)
				if self.height_c +10 >= self.height then
				    self.speed = self.speed +50
				end
				-- self.on_move_count = self.on_move_count +1
			end
			function mvr:on_hit()
				target:damage
				{
					source = hero,
					damage = damage,
					skill = skill,
					missile = self.mover,
					damage_type = '法术',
					allow_other_skill = true
				}
				--return true
			end
				
		end
		hero.range_attack_start = self.oldfunc
    end
    
	local hero = self.owner
	self.oldfunc = hero.range_attack_start
	self.event = hero:event '单位-攻击出手' (function(trg, data)
		if math.random(1,100) > self.chance then
			return
		end
		hero.range_attack_start = range_attack_start
	end)


end

function mt:on_remove()
	self.event:remove();
end






