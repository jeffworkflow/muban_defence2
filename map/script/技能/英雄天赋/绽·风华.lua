local mt = ac.skill['绽·风华']
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
	cool = 12,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*25+10005)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加智力'] = {100,2000},
 ['技暴几率'] = 5,
 ['技暴伤害'] = 50,
 ['技能伤害加深'] = 40,
	--介绍
	tip = [[|cffffff00【杀怪加智力】+100*Lv
【技暴几率】+5%
【技暴伤害】+50%
【技能伤害加深】+40%

|cff00ffff【被动效果】攻击10%几率触发法阵，闪避+50%,触发概率加成+50%,技能冷却+50%，持续8秒，内置CD12秒；法阵生成及消失时都会造成范围技能伤害
【伤害公式】（智力*25+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[dfh.blp]],
	--特效
	effect = [[AZ_CMpink_F_OriginMageP.mdx]],
	--特效4
	effect4 = [[模型再英雄脚下添加，8秒后消失，伤害范围400]],
	kill_int = function(self)
		return self.level * 100
	end,
	skl_crit_rate = 5,
	skl_crit_damage = 50,
	skl_more_damage = 40,
	time = 8,
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	target = hero

	local function start_damage()  
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
	target:add_buff '绽·风华'{
		source = hero,
		skill = skill,
		start_damage = start_damage, --伤害函数
		kill_int = skill.kill_int, --杀怪加智力
		skl_crit_rate = skill.skl_crit_rate, --
		skl_crit_damage = skill.skl_crit_damage, --
		skl_more_damage = skill.skl_more_damage,
		time =skill.time, --持续时间
		model = skill.effect
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

local mt = ac.buff['绽·风华']

mt.cover_type = 1


function mt:on_add()
	self.eff = ac.effect_ex{
		model = self.model,
		point = self.target:get_point()
	}
	self.target:add('杀怪加智力',self.kill_int)
	self.target:add('技暴几率',self.skl_crit_rate)
	self.target:add('技暴伤害',self.skl_crit_damage)
	self.target:add('技能伤害加深',self.skl_more_damage)
	-- self.eff = self.target:add_effect('chest', self.effect)
	if self.start_damage then 
		self:start_damage()
	end	
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:add('杀怪加智力',-self.kill_int)
	self.target:add('技暴几率',-self.skl_crit_rate)
	self.target:add('技暴伤害',-self.skl_crit_damage)
	self.target:add('技能伤害加深',-self.skl_more_damage)
	if self.start_damage then 
		self:start_damage()
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end

