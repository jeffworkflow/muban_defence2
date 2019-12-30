local mt = ac.skill['召唤弟弟']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 100*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
   --伤害
    damage = function(self)
        local p = self.owner.owner
        local hero = p.hero
        return (hero:get('智力')*1)
    end,
	--流派
	skill_type = "技能触发类",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['智力%'] = 10,
	--介绍
	tip = [[
|cffffe799【智力】+10%

|cff00ff00使得主人触发被动时，10%几率|cffffff00召唤弟弟|cff00ff00出来帮忙打架

]],
	--技能图标
	art = [[xuerenxiongdi.blp]],
	--特效
    effect = [[SnowmanBuff.mdx]],
    --冷却
    cool = 1.5,
    --伤害间隔
    pulse_time = 0.2,
    --持续时间
    time = 1.5
}
function mt:on_add()
    local skill = self
    local p = self.owner.owner
    local hero = p.hero
    -- local 
    self.trg = hero:event '单位-触发被动'(function(_,skl,target)
        --技能是否正在CD
        if skill:is_cooling() then
			return 
		end 
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			--创建特效
            ac.effect_ex
            {
                point = target:get_point(),
                model = skill.effect,
                time = skill.time,
                size = 2,
            }
            local point = target:get_point()
            hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
                for i, u in ac.selector()
                : in_range(point,skill.damage_area)
                : is_enemy(hero)
                : ipairs()
                do 
                    u:damage
                    {
                        source = hero,
                        skill = self,
                        damage = skill.damage,
                    }
                end	
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


