local mt = ac.skill['真·冰天雪地']
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
	cool = 1,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加智力'] = {280,5600},
 ['技能伤害加深'] = 200,
 ['智力%'] = 50,
 ['触发概率加成'] = 50,
 ['技能冷却'] = 25,

	--介绍
	tip = [[|cffffff00【杀怪加智力】+280*Lv
【智力】+50%
【触发概率加成】+50%
【技能冷却】+25%
【技能伤害加深】+200%
【强大的冰盾系统】

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*70+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[btxd.blp]],
   --持续时间
	time =3, 
	--生成护盾时间
	pulse_time = 8,
    --晕眩时间
	yun_time = 0.1,
    --护甲
    defence_rate = 300,
    --碎片数量
    de_count = 24,
	--范围
    hit_area = 600,
    --护盾抵消伤害
	shield = function(self,hero)
        return hero:get '攻击' * 1 + hero:get '智力' * 3
	end,
    --晕眩伤害
    yun_damage = function(self,hero)
        return hero:get '攻击' * 1 + hero:get '智力' * 3
    end,
	--暴风雪特效
	effect = [[Abilities\Spells\Human\Blizzard\BlizzardTarget.mdx]],
	-- 亚瑟王没有中心附着点
}

--创建暴风雪
local function tornado(skill,target,area,damage)
    local hero = skill.owner
    for i=1,skill.de_count do
        local angle = math.random(1, 360)
        local p = target - {angle, math.random(1, area)}
        --创建暴风雪特效
        local eff = ac.effect(p,skill.effect,0,1,'origin'):remove()
    end

    ac.wait(700,function()
		for _, u in ac.selector():in_range(target,area):is_enemy(hero):ipairs() do
			--被动2
			if u:find_buff('晕眩') then
				damage = damage + skill.yun_damage
			end	

			u:add_buff '晕眩'
			{
				source =hero,
                skill = skill,
                time = skill.yun_time,
			}

            u:damage{
                source = hero,
                skill = skill,
                damage = damage,
                damage_type = '法术'
			}
			
        end
    end)
end

local function add_shield(skill)
	local hero = skill.owner
	if not hero:find_buff('寒冰护盾') then 
		hero:add_buff '寒冰护盾'
		{
			life = skill.shield,
			skill = skill,
		}
	end	

end

function mt:atk_pas_shot(target)
    local hero = self.owner
	local max_damage = self.damage
	local area = self.hit_area
	local target = target:get_point()
	--先执行一次，后没0.7秒执行一次
	tornado(self,target,area,max_damage)
	self.trg = hero:timer(0.7 * 1000,self.time /0.7, function()
		--执行一次
		tornado(self,target,area,max_damage)
		
	end)
	--增加护甲处理
	hero:add_buff('冰天雪地-护甲')
	{
		defence_rate = self.defence_rate,
		skill = self,
		time = self.time,
	}
	--马上加寒冰护盾
	add_shield(self)
end	

function mt:on_add()
	local hero = self.owner
	local skill = self
	if self.owner.owner.id>10 then return end 
	--被动1 增加护盾
	add_shield(self)
	-- print(hero,hero.owner,hero:is_dummy())
	self.trg1 = hero:event '单位-复活'(function()
		--被动1 增加护盾
		add_shield(self)
	end)
	
	
	self.trg2 = hero:event '造成伤害效果' (function(_,damage)
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
	if self.trg2 then 
		self.trg2:remove()
		self.trg2 = nil 
	end	
end
