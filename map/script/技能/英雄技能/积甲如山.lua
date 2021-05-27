local mt = ac.skill['积甲如山']
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
  return (self.owner:get('力量')*10+100000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['攻击加力量'] = {480,9600},
	--介绍
	tip = [[|cffffff00【攻击加力量】+480*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*10+100000）*L
 v]],
	--技能图标
	art = [[yujia.blp]],
	--特效
	effect = [[AZ_[Sepll]LinaSun _T2_Blast.MDX]],
	--特效4
	effect4 = [[参考赤灵的御甲，投射物数量=3]],
	--爆炸半径
    hit_area = 150,
    --连锁数量
    count = 5,
    --模型
    model = [[AZ_[Sepll]LinaSun _T2_Blast.MDX]],
	--伤害类型
	damage_type = '法术',
}

function mt:on_add()
    local hero = self.owner
	local skill = self
	
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local max_damage = self.damage
        local target = damage.target
        ac.effect(target:get_point(),self.model,0,1,'origin'):remove()
        target:damage
        {
            source = hero,
            skill = self,
            damage = max_damage,
            damage_type = skill.damage_type,
        }

        local count = self.count + hero:get '额外连锁数量' - 1

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
            table.insert(group,target)
            ac.effect(target:get_point(),self.model,0,1,'origin'):remove()
            target:damage
            {
                source = hero,
                skill = self,
                damage = max_damage,
                damage_type = skill.damage_type,
            }

            for _, u_t in ac.selector():in_range(target,self.hit_area):is_enemy(hero):is_not(target):ipairs() do
                u_t:damage
                {
                    source = hero,
                    skill = self,
                    damage = max_damage * 0.3,
                    damage_type = skill.damage_type,
                }
            end
        end)

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

