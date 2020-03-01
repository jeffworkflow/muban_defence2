local mt = ac.skill['绿野之矛']
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
	skill_type = "被动,智力",
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
  return (self.owner:get('智力')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['攻击加智力'] = {120,2400},
	--介绍
	tip = [[|cffffff00【攻击加智力】+120*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*5+10000）*Lv
 ]],
	--技能图标
	art = [[lvyezhimao.blp]],
	--特效
	effect = [[lvyezhimao.MDX]],
	--特效1
	effect1 = [[Abilities\Spells\NightElf\Rejuvenation\RejuvenationTarget.mdx]],
	--特效4
	effect4 = [[参考希尔瓦娜斯 绿野之矛]],
	count = 6,
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()

	local unit_mark = {}

	for i,u in ac.selector()
		: in_range(hero,hero:get('攻击距离'))
		: is_enemy(hero)
		: of_not_building()
		: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
		: set_sort_first(target)
		: ipairs()
	 do
		if i <= self.count then
			local mvr = ac.mover.target
			{
				source = hero,
				target = u,
				model = self.effect,
				speed = 1500,
				skill = skill,
			}
			if not mvr then
				return
			end
			
			function mvr:on_finish()
				-- u:add_effect('chest',skill.effect1):remove()
				u:damage
				{
					source = hero,
					damage = max_damage,
					skill = skill,
					missile = self.mover,
					damage_type = '法术'
				}
			end
		end	
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
end


