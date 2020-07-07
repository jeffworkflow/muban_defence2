local mt = ac.buff['缴械']
mt.cover_type = 0
mt.debuff = true
mt.keep = true

function mt:on_add()
	if not self.target:has_restriction '缴械' then
		self.target:add_restriction '缴械'
	end
	if self.model then
		self.eff = self.target:add_effect('chest', self.model)
	end
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	if self.target:has_restriction '缴械' then
		self.target:remove_restriction '缴械'
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
