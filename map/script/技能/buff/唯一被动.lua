local mt = ac.buff['专注']
mt.effect = nil
mt.cover_type = 0 --独占性，只有一个生效
mt.attr = '生命上限%'
-- mt.ref = 'overhead'
-- mt.model = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]]
local mt = ac.buff['战鼓']
mt.effect = nil
mt.cover_type = 0 --独占性，只有一个生效
mt.attr = '攻击%'

local mt = ac.buff['行军']
mt.effect = nil
mt.cover_type = 0 --独占性，只有一个生效
mt.attr = '移动速度%'

local mt = ac.buff['战甲']
mt.effect = nil
mt.cover_type = 0 --独占性，只有一个生效
mt.attr = '护甲%'

local mt = ac.buff['意志']
mt.effect = nil
mt.cover_type = 0 --独占性，只有一个生效
mt.attr = '全属性%'
for i,name in ipairs({'专注','战鼓','行军','战甲','意志'}) do 
	local mt = ac.buff[name]
	function mt:on_add()
		-- self.effect = self.target:add_effect(self.ref, self.model)

		self.target:add(self.attr, self.value)
	end

	function mt:on_remove()
		-- self.effect:remove()
		self.target:add(self.attr, -self.value)
	end

	function mt:on_cover(new)
		return new.value > self.value
	end
end