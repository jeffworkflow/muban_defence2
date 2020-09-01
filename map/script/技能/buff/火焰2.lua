local mt = ac.buff['火焰2']
mt.ref = 'origin' 
mt.cover_type = 1 
mt.is_damage_on_add = true
mt.cover_max = 1

function mt:on_add()
    self.eff = self.target:add_effect('origin',[[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]])

    if self.is_damage_on_add then  
        self:on_pulse()
    end
    
end

function mt:on_remove()
    -- self.eff:remove()
    if self.eff then 
        self.eff:remove()
        self.eff = nil 
    end
end

function mt:on_pulse()
    for i, u in ac.selector()
        : in_range(self.target,self.skill.area)
        : is_enemy(self.target)
        : of_not_building()
        : ipairs()
    do  
        u:add_effect('overhead', [[Abilities\Spells\NightElf\Immolation\ImmolationDamage.mdx]]):remove()
        u:damage
        {
            source = self.source,
            damage = self.damage ,
            skill = self.skill,
            real_damage = true
        }
    end
end

function mt:on_cover(new)
	return new.damage > self.damage
end