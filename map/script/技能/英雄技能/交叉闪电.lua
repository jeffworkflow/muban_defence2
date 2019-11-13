local mt = ac.skill['交叉闪电']
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
  return (self.owner:get('敏捷')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['每秒加敏捷'] = {200,4000},
	--介绍
	tip = [[|cffffff00【每秒加敏捷】+200*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*5+10000）*Lv]],
	--技能图标
	art = [[weisuoshandianjian.blp]],
	--特效
	effect = [[FirecrackerArrow.mdx]],
	--特效1
	effect1 = [[AZ_SSCrow_R2.mdx]],
	--特效4
	effect4 = [[参考赤灵的交叉闪电]],
    --投射物数量
    count = 2,
    --图标
    art = [[weisuoshandianjian.blp]],

    --释放几率
    chance = 15,
    cool = 1,

    --交叉闪电数量
    lig_count = {2,3,4,5,6},

    --二段伤害
    ejection_damage = 45,


    --投射物模型
    model = [[FirecrackerArrow.mdx]],
    effect = [[AZ_SSCrow_R2.mdx]],

    title = '交叉闪电',
	damage_type = '法术',
}

--计算高度
local function get_hith(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end

--交叉闪电
local function jiaocha_sd(skill,target,damage)
    local hero = skill.owner

    for _, u in ac.selector():in_range(target,800):is_enemy(hero):random_int(skill.lig_count) do
        local ln = ac.lightning('LN01', hero, u,get_hith(hero),get_hith(u))
        ln:fade(-5)
        u:add_effect('origin',skill.effect):remove()
        u:damage{
            source = hero,
            skill = skill,
            damage = damage * (skill.ejection_damage/100),
            damage_type = skill.damage_type
        }
    end

end


function mt:on_add()
    local hero = self.owner
	local skill = self
	
    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end
        --计算伤害
        local max_damage = self.damage
        local target = damage.target
        
        --投射物数量
        local count = hero:get '额外投射物数量' + 1
        local group = ac.selector():in_range(hero,hero:get '攻击距离'):is_enemy(hero):is_not(target):get()
        if group and #group > 0 then
            while #group > count do
                table.remove(group,#group)
            end
        end
        table.insert(group,target)

        for i,u in ipairs(group) do
            local mvr = ac.mover.target
            {
                source = hero,
                start = hero:get_launch_point(),
                skill = self,
                target = u,
                speed = 1500,
                model = self.model,
                size = 1.3,
            }
            if mvr then
                function mvr:on_finish()
                --交叉闪电
                jiaocha_sd(self.skill,u,max_damage)
                    u:damage
                    {
                        source = hero,
                        damage = max_damage,
                        skill = self.skill,
                        damage_type = skill.damage_type
                    }
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
		self.trg=nil
	end	
end