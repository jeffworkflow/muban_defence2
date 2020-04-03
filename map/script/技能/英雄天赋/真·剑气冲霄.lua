local mt = ac.skill['真·剑气冲霄']
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
	cool = 1,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*20)* self.level
end,
dead_damage = function(self)
return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*20+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加全属性'] = {500,10000},
 ['攻击减甲'] = 488,
 ['攻击间隔'] = -0.25,
 ['全伤加深'] = 488
,
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+500*Lv
【攻击减甲】+488
【攻击间隔】-0.25
【全伤加深】+488%
【强大的永生系统】

|cff00ffff【被动效果】攻击10%几率造成超大范围技能伤害 
【伤害公式】（全属性*150*Lv+1%敌人的最大生命值）

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[jqcx.blp]],
	--特效
	effect = [[Abilities\Spells\Orc\Shockwave\ShockwaveMissile.mdl]],
	--特效1
	effect1 = [[ShockwaveMissile.mdx]],
}
function mt:on_add()
    local skill = self
	local hero = self.owner
	
	--添加重生技能
	self.skl1 = hero:add_skill('重生','隐藏')
	if self.skl1 then 
		self.skl1.cnt = 99999999
		self.skl1.time = 1
	end	 
	--注册即将死亡伤害事件
	self.trg1=hero:event '单位-即将死亡' (function (_,unit,killer)
		for _, u in ac.selector()
			:in_range(hero,500)
			:is_enemy(hero)
			:ipairs() 
		do
			u:damage{
				source = hero,
				skill = skill,
				damage = skill.dead_damage,
				damage_type = '法术'
			}
		end
    end)

	local function  mvr_damage(data)
		local mvr = ac.mover.line
		{
			source = hero,
			start = data.start,
			skill = skill,
			model =  data.model,
			speed = 5000,
			angle = data.angle,
			hit_area = 250,
			distance = data.distance,
			high = 120,
			size = data.size
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
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = u:get('生命上限') * 0.001,
					real_damage = true,
				}
				
			end

			function mvr:on_remove()
				if timer then
					timer:remove()
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
			--创建特效
			local start_angle = math.random(360)
			for i=1,8 do 
				local angle = start_angle + 360/8*(i-1)
				if i%2 == 1 then 
					local data = {
						angle = angle,
						start = hero:get_point(),
						model = skill.effect,
						distance = 5000,
						size = 1.5,
					}
					mvr_damage(data)
				else 
					ac.wait(0.2*1000,function()
						local data = {
							angle = angle,
							start = hero:get_point(),
							model = skill.effect1,
							distance = 5000,
							size = 1.5,
						}
						mvr_damage(data)
					end)
				end	
			end	

			ac.wait(0.8*1000,function()
				--创建特效
				local start_angle = math.random(360)
				for i=1,8 do 
					local angle = start_angle + 360/8*(i-1)
					local new_point = damage.target:get_point() - {angle,2500}
					if i%2 == 1 then 
						local data = {
							angle = new_point/damage.target:get_point(),
							start = new_point,
							model = skill.effect,
							distance = 5000,
							size = 1.5,
						}
						mvr_damage(data)
					else 
						ac.wait(0.2*1000,function()
							local data = {
								angle = new_point/damage.target:get_point(),
								start = new_point,
								model = skill.effect1,
								distance = 5000,
								size = 1.5,
							}
							mvr_damage(data)
						end)
					end	
				end	
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
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
	end
	if self.skl1 then
		self.skl1:remove()
		self.skl1 = nil
	end	
	
end
