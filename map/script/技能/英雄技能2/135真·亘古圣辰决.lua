local mt = ac.skill['真·亘古圣辰决']
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
	color = "真天阶",
	--技能类型
	skill_type = "被动,生命回复",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['生命恢复'] = {8000000,160000000},
	--介绍
	tip = [[

|cffffff00【生命恢复】+800w*Lv|r
        
|cff00bdec【被动效果1】攻击10%几率触发，回复35%的生命值|r

|cff00bdec【被动效果2】唯一技能-内伤：10%几率对周围敌人造成|r|cffffff00生命恢复效果减少50%|r，|cff00bdec持续0.5秒|r

]],
	--技能图标
	art = [[qhsls.blp]],
	--特效
	effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
	--特效1
	effect1 = [[Effect_az_heiseguangzhu.mdx]],
	--特效4
	effect4 = [[参考赤灵的水疗术]],
    --内伤
    area = 500,
    value = -50,
    time = 0.5,

    --补血量
    heal = 35
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	--补血
	hero:heal
	{
		source = hero,
		skill = skill,
		-- string = '水疗术',
		size = 10,
		heal = hero:get('生命上限') * skill.heal/100,
	}	

	ac.effect_ex{
		point = damage.target:get_point(),
		model = self.effect1
	}:remove()

	for _,unit in ac.selector()
	: in_range(damage.target,skill.area)
	: is_enemy(hero)
	: ipairs()
	do 
		unit:add_buff('生命恢复效果')
		{
			value = self.value,
			source = hero,
			time = self.time,
			skill = self,
		}
	end 
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
