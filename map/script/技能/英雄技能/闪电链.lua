local mt = ac.skill['闪电链']
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
	skill_type = "被动,敏捷",
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
  return (self.owner:get('敏捷')*5+10000)* self.level
end,
	--施法范围
	area = 1000,
	--属性加成
['杀怪加敏捷'] = {10,200},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+10*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*5+10000）*Lv
 ]],
	--技能图标
	art = [[card1_2.blp]],
	--特效
	effect = [[Abilities\Weapons\Bolt\BoltImpact.mdl]],
	--特效4
	effect4 = [[参考赤灵的闪电链]],
	--弹射次数
	time = 15,
	--伤害类型
	damage_type = '法术',
}

--计算高度
local function get_high(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end
function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target

	local tm = skill.time+1
	local unit = hero
	local next = target
	local timer

	local function shot()
		next:add_effect('origin',skill.effect):remove()
		next:damage
		{
			source = hero,
			skill = skill,
			target = next,
			damage = skill.damage,
			damage_type = skill.damage_type,
		}
		--hero:add_buff '闪电链-特效'
		--{
		--	skill = skill,
		--	unit1 = unit,
		--	unit2 = next,
		--	time = 1,
		--}
		local lt = ac.lightning('LN06',unit,next,get_high(unit),get_high(next))
		--local lt = ac.lightning('FFAC',unit,next,50,50)
		lt.speed = -3
		
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
