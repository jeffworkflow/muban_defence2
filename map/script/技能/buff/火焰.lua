local mt = ac.buff['火焰']
mt.ref = 'origin' 
mt.cover_type = 0 --独占性，只有一个生效
mt.is_damage_on_add = true
-- mt.cover_max = 1
-- mt.cover_global = 1

function mt:on_add()
    --Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl
    --Abilities\Spells\Other\BreathOfFire\BreathOfFireDamage.mdl
    --Abilities\Spells\NightElf\Immolation\ImmolationDamage.mdl

    --Abilities\Spells\Other\ImmolationRed\ImmolationRedDamage.mdx
    self.target:add_effect('overhead', [[Abilities\Spells\Other\ImmolationRed\ImmolationRedDamage.mdx]]):remove()
    if self.is_damage_on_add then  
        self.target:damage
        {
            source = self.source,
            damage = self.damage ,
            skill = self.skill,
            real_damage = true
        }
    end
    
end

function mt:on_remove()
	-- self.eff:remove()
end

function mt:on_pulse()
	self.target:damage
	{
		source = self.source,
		damage = self.damage ,
        skill = self.skill,
        real_damage = true
	}
    
end

function mt:on_cover(new)
	return new.damage > self.damage
end