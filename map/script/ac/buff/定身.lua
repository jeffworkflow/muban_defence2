local mt = ac.buff['定身']

mt.cover_type = 1

mt.model = nil
mt.ref = 'origin'
mt.eff = nil
mt.debuff = true
mt.control = 5

function mt:on_add()
	if not self.target:has_restriction '定身' then 
		self.target:add_restriction '定身'
	end
	if self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	if self.target:has_restriction '定身' then 
		self.target:remove_restriction '定身'
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
