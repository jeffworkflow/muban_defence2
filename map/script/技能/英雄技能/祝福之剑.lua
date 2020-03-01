local mt = ac.skill['祝福之剑']
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
	skill_type = "被动,全属性",
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*4+100000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加全属性'] = {10,200},
['攻击加全属性'] = {10,200},
['每秒加全属性'] = {10,200},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+10*Lv
【攻击加全属性】+10*Lv
【每秒加全属性】+10*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*4+100000）*Lv
 ]],
	--技能图标
	art = [[ltzj.blp]],
	--特效
	effect = [[leitingzhijian.mdx]],
	--特效1
	effect1 = [[AZ_CocoChristmas_D_Impact.mdx]],
	--特效4
	effect4 = [[参考赤灵雷霆之剑，投射物数量=4]],

    --爆炸范围
    boom_area = 200,
    --投射物数量
    count = 4,
    damage_type = '法术'
}
function mt:on_add()
    local hero = self.owner
    local skill = self

    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local target = damage.target
        local max_damage = self.current_damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count - 1
       
		local unit_mark = {}

		for i,u in ac.selector()
			: in_range(hero,hero:get('攻击距离'))
			: is_enemy(hero)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: set_sort_first(target)
			: ipairs()
     	do
			if i <= count then
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
                    ac.effect(u:get_point(),skill.effect1,0,3,'origin'):remove()
					for _,target in ac.selector()
						: in_range(u,skill.boom_area)
						: is_enemy(hero)
						: of_not_building()
						: ipairs()
					do 
                        if not unit_mark[target] then 
                            -- print(target,target.handle)
							-- if target == u then --命中中心的敌人额外伤害，并允许触发额外辅助
                            target:damage
                            {
                                source = hero,
                                damage = max_damage,
                                skill = skill,
                                missile = self.mover,
                                damage_type = skill.damage_type
                            }
                            -- end
							unit_mark[target] = true
				    	end
			     	end
					--return true
				end
			end	
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
		self.trg=nil
	end
end