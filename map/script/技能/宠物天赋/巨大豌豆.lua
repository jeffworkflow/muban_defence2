local mt = ac.skill['巨大豌豆']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
   --伤害
    damage = function(self)
        local p = self.owner.owner
        local hero = p.hero
        return (hero:get('智力')*5)
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
 ['攻击速度'] = 50,
	--介绍
	tip = [[|cff00ff00使得主人攻击时，5%几率吐出|cffffff00巨大豌豆]],--使得主人攻击时，有5%几率吐出一颗巨大豌豆，伤害：智力*5，范围500，内置CD1秒
	--技能图标
	art = [[wandou.blp]],
	--特效
    effect = [[Boomnl.mdx]],
    cool = 1,
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
			local angle = damage.source:get_point() / damage.target:get_point()
			--创建特效
            ac.effect_ex
            {
                point = damage.target:get_point(),
                model = skill.effect,
            }:remove()

			--计算伤害
			for _,unit in ac.selector()
			: in_range(damage.target:get_point(),self.damage_area)
			: is_enemy(hero)
			: ipairs()
			do 
				unit:damage
				{
					source = hero,
					damage = skill.damage,
					skill = skill,
					damage_type = '法术'
				}
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
