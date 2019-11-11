local mt = ac.skill['真·极刃风暴']
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
  return (self.owner:get('力量')*10+10007)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加力量'] = {50,1000},
 ['护甲%'] = 10,
 ['每秒回血'] = 10,
 ['物理伤害加深'] = 50,
	--介绍
	tip = [[|cffffff00【杀怪加力量】+50*Lv
【物理伤害加深】+50%
【每秒回血】+10%
【护甲】+10%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*10+10000）*Lv+1.2%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[jrfb.blp]],
	--特效
	effect = [[tx208.mdx]],
	--特效4
	effect4 = [[0.5秒后再触发一次]],
	value = 1.2,--最大生命值
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()

	ac.effect_ex{
		point = target:get_point(),
		model = skill.effect,
	}:remove()  

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
			damage_type = '法术'
		}
		--真伤（最大生命值）
		u:damage
		{
			source = hero,
			skill = self,
			damage = u:get('生命上限') * self.value /100,
			real_damage = true
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
			--0.5秒后再触发一次
			ac.wait(500,function()
				self:atk_pas_shot(damage.target)
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
end