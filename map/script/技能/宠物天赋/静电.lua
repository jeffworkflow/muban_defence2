local mt = ac.skill['静电']
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
	--流派
	skill_type = "防御",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['护甲%'] = 10,
	--介绍
	tip = [[
|cffffe799【护甲】+10%

|cff00ff00使得主人受到攻击时，5%几率|cffffff00麻痹敌人

]],
	--技能图标
	art = [[pikaqiu.blp]],
	--特效
	effect = [[Abilities\Spells\Orc\Purge\PurgeBuffTarget.mdl]],
	time = 5,
	cool = 1,
}
function mt:on_add()
    local skill = self
	local hero = self.owner
    local p = self.owner.owner
    hero = p.hero
    self.trg = hero:event '受到伤害效果' (function (_,damage)
		if not damage:is_common_attack()  then 
			return 
		end
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end 
        local source = damage.source
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
            --变身不支持单位
            self.buff = source:add_buff '晕眩' {
                skill = self,
                time = self.time,
                model = self.effect
            }
        
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