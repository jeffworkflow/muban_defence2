local mt = ac.skill['疯狂乱抓']
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
	--流派
	skill_type = "攻速",
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
	tip = [[ 
|cffffe799【攻击速度】+50%

|cff00ff00使得主人攻击时，5%几率触发|cffffff00疯狂乱抓

]],
	--技能图标
	art = [[miaomiao.blp]],
	--特效
    effect = [[MaulCasterBase.mdx]],
    cool = 1,
}

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
                size = 3,
            }:remove()

            --计算伤害
            hero:timer(0.1*1000,4,function()
                damage.target:damage
                {
                    source = hero,
                    damage = damage.current_damage,
                    skill = skill,
                    real_damage = true,
                    physicals_crit_flag=damage.physicals_crit_flag,
                    spells_crit_flag=damage.spells_crit_flag,
                    heart_crit_flag=damage.heart_crit_flag,
                   
                }
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
end
