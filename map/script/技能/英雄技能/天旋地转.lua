local mt = ac.skill['天旋地转']
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
  return (self.owner:get('力量')*13+10000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {160,3200},
['攻击加力量'] = {160,3200},
['每秒加力量'] = {160,3200},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+160*Lv
【攻击加力量】+160*Lv
【每秒加力量】+160*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*20+10000000）*Lv
 ]],
	--技能图标
	art = [[huixuanren.blp]],
	--特效
	effect = [[SentinelMissile.mdx]],
	--特效4
	effect4 = [[参考赤灵传说的回旋刃，投射物数量=8]],
    --投射物数量
    count = 8,
    --move_distance
    distance = 500,
    --碰撞范围
    hit_area = 150,
    --停留时长
    stay_time = 0.5,
    --回旋伤害比
    cycle_round_damage = 25,
    damage_type = '法术'

}


function mt:on_add()
    local skill = self
    local hero = self.owner

    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local target = damage.target
        local max_damage = self.damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count 
       
		local unit_mark = {}

		for i,u in ac.selector()
			: in_range(hero,hero:get('攻击距离'))
			: is_enemy(hero)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: set_sort_first(target)
			: ipairs()
     	do
			if i <= 1 then
				local mvr = ac.mover.target
				{
					source = hero,
					target = u,
					model = self.effect,
					speed = 1500,
					skill = skill,
				}
				if not mvr then
					return
                end
                function mvr:on_finish()
                    
                    u:damage
                    {
                        source = hero,
                        damage = max_damage,
                        skill = skill,
                        missile = self.mover,
                        damage_type = skill.damage_type
                    }
                    local angle = u:get_point()  / hero:get_point()
                    for i = 1,count do

                        -- 进行一次创造回旋刃，进行前移，停滞，返回
                        -- 目标 英雄，起始点 第一次投射物命中单位，先反方向移动 500距离，再停留，再折回。
                        local source = u:get_point():copy()
                        local stay_time = skill.stay_time 

                        local angle = angle + (count / 2 - count - 0.5 + i) * 17.5
                        local mvr = ac.mover.target
                        {
                            source = hero,
                            start = source,
                            target = hero,
                            model = skill.effect,
                            angle =  angle,
                            turn_speed = 0,
                            speed = -1000,
							high =120,
                            skill = skill,
                            stay_time = skill.stay_time ,
                            hit_area = skill.hit_area,
                        }
                        if not mvr then
                            return
                        end
                          
                        --每0.03秒运动一次， 一次距离为 500*0.03，每次运动15距离。
                        function mvr:on_move()
                            local p1, p2 = self.mover:get_point(), self.target:get_point()
                            local target_angle = p1 / p2
                            
                            self.speed = self.speed + 20

                            if self.speed >= 0 then
                                --停滞，变换角度
                                if  self.stay_time > 0 then 
                                    self.stay_time = self.stay_time - 0.03 
                                    return
                                end      
                                self.speed = 1500 
                                self.angle = target_angle  
                                --后半段碰击
                                self.second_mover_hit = true
                            end    
                        
                        end   
                        --碰撞到单位的处理
                        local hited = {} 
                        function mvr:on_hit(dest)
                            hited[dest] = {}

                            if hited[dest][1] and hited[dest][2] then
                                return
                            end    

                            if not hited[dest][1] then

                                dest:damage
                                {
                                    source = hero,
                                    damage = max_damage * skill.cycle_round_damage/100,
                                    skill = skill,
                                    missile = self.mover,
                                    damage_type = skill.damage_type
                                }
                                hited[dest][1] =true

                            end

                            --二段伤害，只能在回溯时产生
                            if self.second_mover_hit then 
                                --必须要已造成一段伤害,且二段伤害还没产生时，才进行二段伤害。
                                if  hited[dest][1] and not hited[dest][2] then
                                    dest:damage
                                    {
                                        source = hero,
                                        damage = max_damage * skill.cycle_round_damage/100,
                                        skill = skill,
                                        missile = self.mover,
                                        damage_type = skill.damage_type
                                    }
                                    hited[dest][2] =true
                                end
                            end

                        end    
                    end
					--return true
				end
			end	
		end

    end    

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

            range_attack_start(hero,damage)
            hero:event_notify('单位-触发被动', hero,self,damage.target,damage)
            --激活cd
            skill:active_cd()
        end 

        return false
    end)

end



function mt:on_remove()
    local hero = self.owner
	if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end	
end