local mt = ac.skill['天外飞石']
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
	--伤害
	

	damage = function(self)
		return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*15+10000)* self.level
	  end,

	area = 500,
	--属性加成
	['杀怪加全属性'] = {250,5000},
	['分裂伤害'] = 500,
	['暴击几率'] = 5,
	['暴击伤害'] = 500,
	['技暴几率'] = 5,
	['技暴伤害'] = 250,
	['会心几率'] = 5,
	['会心伤害'] = 125,
	['多重暴击几率'] = 5,
	['多重暴击'] = 1,

	--介绍
	tip = [[|cffffff00【杀怪加全属性】+250*Lv
【分裂伤害】+500%
【暴击几率】+5%
【暴击伤害】+500%
【技暴几率】+5%
【技暴伤害】+250%
【会心几率】+5%
【会心伤害】+125%
【多重暴击几率】+5%
【多重暴击】+1

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】全属性*15*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[xingluo1.blp]],
	--冷却时间
	cool = 3,
	ignore_cool_save = true,
	--延迟1秒轰炸
	delay_time = 2.5,
	--碰撞范围
	area = 500,
	--碰撞范围
	range = 1200,
	--耗蓝
	
	effect = [[AZ_Kaer_D1.mdx]],
	effect2 = [[Hero_EmberSpirit_N4S_C_Cicle.mdx]],
	
	damage_type = '法术'
}

local function damage_shot(skill,target)
    local self = skill
	local hero = self.owner
	--在目标区域创建特效
	--预警圈
    self.eft = ac.warning_effect_ring
    {
        point = target,
        area = self.area,
        time = self.delay_time,
	}

	--圈圈
	-- ac.effect(self.target,self.effect2,0,1.2,'origin'):remove()
	-- ac.timer(0.3*1000,2,function()
	-- 	ac.effect(self.target,self.effect2,0,1.2,'origin'):remove()
	-- end)
	--陨石
	ac.wait(1000,function() 
		local eff1 = ac.effect(target,self.effect,0,1,'origin')

		ac.wait((self.delay_time-1)*1000,function()
			eff1:remove()
			for i, u in ac.selector()
				: in_range(target,self.area)
				: is_enemy(hero)
				: of_not_building()
				: ipairs()
			do
				u:damage
				{
					source = hero,
					damage = skill.damage ,
					skill = skill,
					damage_type =skill.damage_type
				}	
			end 
		end)
	end)	
end


function mt:on_upgrade()
	local hero = self.owner
end

function mt:on_add()
	local hero = self.owner 
    local skill = self

    --注册触发
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
			damage_shot(skill,damage.target:get_point())
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
	
    if self.eft then
        self.eft:remove()
        self.eft = nil
    end      
end
