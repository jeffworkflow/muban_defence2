local mt = ac.buff['法术']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'origin'
mt.model = [[Abilities\Spells\Human\Brilliance\Brilliance.mdl]]
--技能冷却+50%,触发概率加成+100%，技能伤害加深+500%
function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)
	self.target:add('技能伤害加深', self.value)
	self.target:add('技能冷却', 50)
	self.target:add('触发概率加成', 100)
end

function mt:on_remove()
	self.effect:remove()
	self.target:add('技能伤害加深', - self.value)
	self.target:add('技能冷却', -50)
	self.target:add('触发概率加成', -100)
end

function mt:on_cover(new)
	return new.value > self.value
end
