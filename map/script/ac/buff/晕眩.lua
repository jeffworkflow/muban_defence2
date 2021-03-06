local mt = ac.buff['晕眩']

mt.cover_type = 1
mt.cover_max = 1

mt.control = 10
mt.debuff = true
mt.model = [[Abilities\Spells\Human\Thunderclap\ThunderclapTarget.mdl]]
mt.ref = 'overhead'

function mt:on_add()
	if not self.eff and self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
	self.target:add_restriction '晕眩'
	self.target:cast_stop()
	local time = self.time * (1 - self.target:get('韧性')/100)
	self:set_remaining(time)
end

function mt:on_remove(new)
	if self.eff then
		self.eff:remove()
		self.eff = nil
	end
	self.target:remove_restriction '晕眩'
end
