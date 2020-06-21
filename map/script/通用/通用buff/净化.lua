local mt = ac.buff['净化']

mt.cover_type = 0
mt.pulse = 0.1
mt.model = [[]]
mt.ref = 'overhead'

function mt:on_add()
	if not self.eff and self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
	self:on_pulse()
end

function mt:on_pulse()
	for buff in self.target:each_buff() do
		if buff.debuff then
			buff:remove()
		end
	end
end

function mt:on_remove(new)
	if self.eff then
		self.eff:remove()
		self.eff = nil
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end