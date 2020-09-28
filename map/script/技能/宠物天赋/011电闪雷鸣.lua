local mt = ac.skill['电闪雷鸣']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--作用在人身上
	strong_hero = true,
	passive = true,
	--属性加成
 ['闪避'] = 10,
	--介绍

tip = [[  
|cffffe799闪避+10%
	
|cff00ff00使得英雄可对周围敌人进行闪电攻击
	
]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNChainLightning.blp]],
	effect = [[Abilities\Spells\Orc\LightningBolt\LightningBoltMissile.mdl]],
	damage_area = 500,
	area = 1000,
	--伤害
	damage = function(self)
		local p = self.owner.owner
		local hero = p.hero
		return (hero:get('攻击')*10)
	end,
	damage_type = '法术'

}

--计算高度
local function get_high(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end
function mt:atk_pas_shot(target,num)
	local hero = self.owner
	local p = hero.owner
	hero = p.hero
	local skill =self
	local target = target

	local tm = num+1
	local unit = hero
	local next = target
	local timer
	if not target then return end
	local function shot()
		-- next:add_effect('origin',skill.effect):remove()
		next:damage
		{
			source = hero,
			skill = skill,
			target = next,
			damage = skill.damage,
			damage_type = skill.damage_type,
		}
		local lt = ac.lightning('LN06',unit,next,get_high(unit),get_high(next))
		lt.speed = -3
		-- print(lt,get_high(unit),get_high(next),unit:get_name(),next:get_name())
		local group = {}
		for _,u in ac.selector()
			: in_range(hero,skill.area/2)
			: is_enemy(hero)
			: ipairs()
		do
			if u ~= next then
				table.insert(group,u)
			end
		end
		if #group > 0 then
			unit = next
			next = group[math.random(1,#group)]
		else
			timer:remove()
		end
		tm = tm - 1

		if tm <= 0 then
			timer:remove()
		end
	end
	
	timer = ac.loop(0.3*1000,function()
		shot()
	end)
end

function mt:damage_shot(time)
	local skill = self 
	local hero = self.owner 
	local p = hero.owner
	hero = p.hero
	self.trg = ac.wait(time*1000,function()
		local num = math.random(20)
		local target = ac.selector():in_range(hero,skill.area/2):is_enemy(hero):random()
		self:atk_pas_shot(target,num)
		local next_time = math.random(10)
		-- print(next_time)
		self:damage_shot(next_time)
	end)

end

function mt:on_add()
	local hero =self.owner
	local next_time = math.random(10)
	self:damage_shot(next_time)
end
function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end
end