local mt = ac.skill['魔煞血陨']
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
	color = "地阶",
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
  return (self.owner:get('智力')*20+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加智力'] = {20,400},
['攻击加智力'] = {20,400},
['每秒加智力'] = {20,400},
	--介绍
	tip = [[|cffffff00【杀怪加智力】+20*Lv
【攻击加智力】+20*Lv
【每秒加智力】+20*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*20+10000）*Lv]],
	--技能图标
	art = [[jifeng.blp]],
	--特效
	effect = [[jifeng.mdx]],
	--特效1
	effect1 = [[AZ_BaoHunJue.mdx]],
	--特效4
	effect4 = [[参考希尔瓦娜斯的季风，额外连锁数量=4]],
	count = 4
}
function mt:on_add()
	local hero = self.owner
	local skill =self
	local function range_attack_start(hero,damage)
		if damage.skill and damage.skill.name == self.name then
			return
		end

		local max_damage = self.damage
		local target = damage.target

		local group_p = ac.selector():in_range(target,200):is_enemy(hero):get()
		
		--如果只有一个单位
		if group_p and #group_p == 1 then
			target:add_effect('origin',skill.effect):remove()
			target:add_effect('origin',skill.effect1):remove()
			target:damage
			{
				source = hero,
				skill = self,
				damage = max_damage * 1.5,
				damage_type = '法术',
			}
		else
			target:add_effect('origin',skill.effect):remove()
			target:damage
			{
				source = hero,
				skill = self,
				damage = max_damage,
				damage_type = '法术',
			}
	
			--对周围单位造成伤害
			for _, m_u in ac.selector():in_range(target,self.area):is_enemy(hero):ipairs() do
				m_u:damage
				{
					source = hero,
					skill = self,
					damage = max_damage * 0.3,
					damage_type = '法术',
				}
				m_u:add_effect('origin',skill.effect1):remove()
			end
	
			local count = self.count 
			--已造成闪电链的单位保存进去
			local group = {}
			table.insert(group,target)
			ac.timer(200,count,function()
				u = ac.selector():in_range(target,700):is_enemy(hero)
				for index, value in ipairs(group) do
					u:is_not(value)
				end
	
				u = u:random()
				if not u then
					return
				end
	
				target = u
				target:add_effect('origin',skill.effect):remove()
				table.insert(group,target)
				target:damage
				{
					source = hero,
					skill = self,
					damage = max_damage,
					damage_type = '法术',
				}
				--对周围单位造成伤害
				for _, m_u in ac.selector():in_range(target,self.area):is_enemy(hero):ipairs() do
					m_u:damage
					{
						source = hero,
						skill = self,
						damage = max_damage * 0.3,
						damage_type = '法术',
					}
					m_u:add_effect('origin',skill.effect1):remove()
				end
			end)
		end
	end

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
			range_attack_start(hero,damage)
			hero:event_notify('单位-触发被动', hero,self)
			--激活cd
			skill:active_cd()
		end 

	end)

end


function mt:on_remove()
	local hero = self.owner
	if self.trg then 
		self.trg:remove()
		self.trg=nil
	end
end