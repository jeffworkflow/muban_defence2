local mt = ac.skill['真·幽冥船']
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
	skill_type = "被动,力量",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*25+100000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {640,12800},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+640*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*25+100000000）*Lv
 ]],
	--技能图标
	art = [[youlingchuan.blp]],
	--特效
	effect = [[AZ_Coco(2)_T1_Ship.MDX]],
	--特效1
	effect1 = [[AZ_Coco(2)_T2_Gather.mdx]],
	--特效4
	effect4 = [[类似船长的大招，目标位置播放水流特效，从英雄身后500码创建一辆船，移动到目标位置

船特效AZ_Coco(2)_T1_Ship.MDX
水流特效AZ_Coco(2)_T2_Gather.mdx]],
}

function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	--水流特效
	self.eff = ac.effect_ex{
		point = target:get_point(),
		model = skill.effect1
	}
	--移动撞击
	local mvr = ac.mover.target
	{
		source = hero,
		skill = skill,
		model =  skill.effect,
		speed = 1200,
		start = hero:get_point() - {hero:get_point()/target:get_point(),-500}, --身后500码
		target = target:get_point(),
		high = 120,
		size = 1,
		on_finish = function(self,u)
			--技能伤害
			u:damage
			{
				source = hero,
				skill = skill,
				damage = skill.damage,
				damage_type = '法术'
			}
		end	,
		on_finish = function(self)
			if self.eff then 
				self.eff:remove()
				self.eff = nil
			end
            --技能伤害
			for i, u in ac.selector()
			: in_range(target,skill.area)
			: is_enemy(hero)
			: ipairs()
			do 
				--技能伤害
				u:damage
				{
					source = hero,
					skill = skill,
					damage = skill.damage,
					damage_type = '法术'
				}
			end	
		end	
	}

    
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
            hero:event_notify('单位-触发被动', hero,self,damage.target,damage)
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
	if self.eff then 
		self.eff:remove()
		self.eff = nil
	end
end


