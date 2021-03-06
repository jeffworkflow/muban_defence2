local mt = ac.skill['万毒之王']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 5*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
   --伤害
    damage = function(self)
        local p = self.owner.owner
        local hero = p.hero
        return (hero:get('智力')*50)
    end,
	--流派
	skill_type = "范围攻击",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['攻击减甲'] = 35,

	--介绍
	tip = [[ 
|cffffe799【攻击减甲】+35

|cff00ff00使得主人攻击时，5%几率对敌人造成大量伤害并|cffffff00减少 1%的最大生命值

]],--使得主人攻击时，有5%几率吐出一颗巨大豌豆，伤害：智力*5，范围500，内置CD1秒
	--技能图标
	art = [[sanyanlaozu.blp]],
	--特效
    effect = [[Abilities\Weapons\ChimaeraAcidMissile\ChimaeraAcidMissile.mdl]],
	cool = 2,
	--最大生命百分比伤害
    value = 1,
}
--
function mt:on_add()
    local skill = self
    local p = self.owner.owner
    local hero = p.hero 

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
			--创建特效
			--计算伤害
			for _,unit in ac.selector()
			: in_range(damage.target:get_point(),self.damage_area)
			: is_enemy(hero)
			: ipairs()
			do 
				if _ <= 10 then
					local mvr = ac.mover.target
					{
						source = hero,
						target = unit,
						model = skill.effect,
						speed = 1000,
						height = 110,
						skill = skill,
						on_finish = function(self)
							unit:damage
							{
								source = hero,
								damage = skill.damage,
								skill = skill,
								damage_type = '法术'
							}
							--真伤（最大生命值）
							unit:damage
							{
								source = hero,
								skill = skill,
								damage = unit:get('生命上限') * skill.value /100,
								real_damage = true
							}
						end
					}
				end
			end
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
end
