local mt = ac.buff['缴械']
mt.cover_type = 0
mt.debuff = true
mt.keep = true

function mt:on_add()
	self.target:add_restriction '缴械'
	if self.model then
		self.eff = self.target:add_effect('chest', self.model)
	end
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:remove_restriction '缴械'
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
