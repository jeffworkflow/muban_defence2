local mt = ac.skill['锤子重击']
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
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*2+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['攻击加全属性'] = {30,600},
	--介绍
	tip = [[|cffffff00【攻击加全属性】+30*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*2+10000）*Lv]],
	--技能图标
	art = [[sqzc.blp]],
	--特效
	effect = [[Abilities\Spells\Other\BlackArrow\BlackArrowMissile.mdl]],
	--特效1
	effect1 = [[Abilities\Spells\Human\Thunderclap\ThunderClapCaster.mdl]],
	--特效4
	effect4 = [[参考希尔瓦娜斯 山丘的大锤子]],
    --移动距离
    move_distance = 200,
    max_distance = 1000,
    --投射物数量
    count = 1,
    --碰撞范围
    hit_area = 250,
    --主伤害伤害比
    main_damage = 100,
    --主伤害伤害比
    second_damage = 15,
}


function mt:on_add()
    local skill = self
    local hero = self.owner

    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local target = damage.target
        local max_damage = self.damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count

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
				local mvr = ac.mover.line
				{
                    source = hero,
                    model = skill.effect,
                    speed = 1200,
                    angle = hero:get_point()/u:get_point(),
                    distance = skill.max_distance,
                    high = 100,
                    skill = skill,
                    size = 3,
                    hit_area = skill.hit_area,
                    hit_type = ac.mover.HIT_TYPE_ENEMY,
                    per_moved = 0
				}
				if not mvr then
					return
                end
                local hit_unit ={}
                function mvr:on_move()
                    self.per_moved = self.per_moved + self.speed * 0.03
                    -- print(self.per_moved,skill.move_distance)
                    if self.per_moved >= skill.move_distance then
                        self.per_moved = 0

                        ac.effect(self.mover:get_point(),skill.effect1,0,1,'origin'):remove();

                        for i,u in ac.selector()
                            : in_range(self.mover,150)
                            : is_enemy(hero)
                            : of_not_building()
                            : ipairs()
                        do
                            if not hit_unit[u]  then
                                u:damage
                                {
                                    source = hero,
                                    damage = max_damage * skill.second_damage/100,
                                    skill = skill,
                                    missile = self.mover,
                                    damage_type = '法术'
                                }
                                hit_unit[u] = true
                            end
                        end

                    end
                end
                function mvr:on_hit(dest)
                    dest:damage
                    {
                        source = hero,
                        damage = max_damage * skill.main_damage /100,
                        skill = skill,
                        missile = self.mover,
                        damage_type = '法术'
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