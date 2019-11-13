local mt = ac.skill['疾风血刃']
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
	color = "玄阶",
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
  return (self.owner:get('敏捷')*10+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加敏捷'] = {20,400},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+20*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*10+10000）*Lv]],
	--技能图标
	art = [[jfzr.blp]],
	--特效
	effect = [[effect2_az_jingzi_jiansheng01_e1.mdx]],
	--特效4
	effect4 = [[目标位置播放特效，特效朝向：从英雄往敌人的方向，伤害范围100*1200]],
	len = 1200,
	width = 100
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local angle = hero:get_point()/target:get_point()
	ac.effect_ex{
		point = target:get_point(),
		model = skill.effect,
		angle = angle
	}:remove()  

	for i, u in ac.selector()
	: in_line(target:get_point(), angle, self.len, self.width)
	: is_enemy(hero)
	: ipairs()
	do 
		--技能伤害
		u:damage
		{
			source = hero,
			skill = self,
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
            hero:event_notify('技能-触发被动', self)
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
end

