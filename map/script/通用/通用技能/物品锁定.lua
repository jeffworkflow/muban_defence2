local mt = ac.skill['物品锁定']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	title = function(self)
		return '物品锁定 ('.. self.auto_hecheng..')'
	end,	
	max_level = 1,
	auto_fresh_tip = false,
	
	tip = [[

|cffffff00锁定/解锁|cff00ff00你的物品，锁定后其他玩家将不能拾取你的物品

]],
--|cffcccccc（当前状态： %auto_hecheng%）

	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNBloodKey.blp]],
	
    ignore_cool_save = true, --忽略技能冷却
	--cd
	cool = 1,
	--自动合成
	auto_hecheng= function(self)
		local hero = self.owner
		local p = hero:get_owner()
		local str = p.flag_auto_hecheng and '|cff00ff00解锁|r' or '|cffff0000锁定|r'
		return str
	end,	
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local p = hero:get_owner()
	-- print('标识1：',p.flag_auto_hecheng)
	p.flag_auto_hecheng = not p.flag_auto_hecheng  and true or false
    -- print('标识2：',p.flag_auto_hecheng)
    if p.flag_auto_hecheng then 
        p:set('物品开关',1)
    else
        p:set('物品开关',0)
    end

	self:fresh_title()
	self:fresh_tip()


end

function mt:on_remove()

end
