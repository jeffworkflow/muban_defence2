local mt = ac.skill['般若波罗蜜']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['技能伤害加深系数'] = 10,
	--介绍

tip = [[ 
|cffffe799技能伤害加深系数+10%

|cff00ff00可对功法进行改写，获得另外一个相同品质的功法

]],
	--技能图标
	art = [[txs.blp]],
	cool = 150,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_UNIT,

    --目标允许
	target_data = '物品',
	range = 50,
}

function mt:on_cast_start()
    local unit = self.owner
	local it = self.target
	local p = unit:get_owner()
	local hero = unit

	local color = it.color 
	if not color or not ac.quality_skill[color] or not finds(color,'阶') then 
		p:sendMsg('不可操作',5)
		-- ac.wait(0,function()
        --     self:set_cd(0)
		-- end)
		return 
	end

	local name = ac.quality_skill[color][math.random(#ac.quality_skill[color])]
	print('重铸',name)
	--移除处理
	if it.item_type =='消耗品' then 
		it:add_item_count(-1)
	else
		it:item_remove()
	end
	hero:add_item(name)
	self:active_cd()
end

