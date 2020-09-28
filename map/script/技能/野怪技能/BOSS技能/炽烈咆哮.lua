local mt = ac.skill['大地崩']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_POINT,
--施法信息
cast_start_time = 0,
cast_channel_time = 0,
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '大地崩',
tip = [[
    大地崩
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--范围
range = 1000,
area = 750,
damage = function(self)
    return self.owner:get('攻击') * 50
end,  

damage_type = '物理',
--冷却
cool = 12}
mt.effect = [[Hero_Sven_N3S_W_Caster.mdx]]

function mt:boss_skill_shot()
    local hero = self.owner
    local target = self.target
    local skill = self
   
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = hero --英雄
	--特效
	hero:add_effect('overhead',skill.effect):remove()

	for i, u in ac.selector()
	: in_range(target,skill.area)
	: is_enemy(hero)
	: ipairs()
	do 
		--技能伤害
		u:damage
		{
			source = hero,
			skill = self,
			damage = skill.damage,
			damage_type = skill.damage_type
		}
		--技能伤害
		u:damage
		{
			source = hero,
			skill = self,
            damage = u:get('生命上限')*0.2,
            real_damage = true,
		}
	end	
end

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    
    -- self.eft = ac.warning_effect_ring
    -- {
    --     point = self.target,
    --     area = self.area,
    --     time = self.cast_channel_time,
    -- }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
    self:active_cd()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
    -- self:active_cd()
end

function mt:on_remove()
end