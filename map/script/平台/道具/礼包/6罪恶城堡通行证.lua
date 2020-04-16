local mt = ac.skill['罪恶城堡通行证']
mt{
--等久
level = 0,
--图标
art = [[xbxfx.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00移速+200 每秒加全属性888|r
|cff00ffff开局赠送5张藏宝图
藏宝图掉落概率提高一倍
可自动寻宝（点击藏宝图试试）|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['移动速度'] = 150,
['每秒加木头'] = 38,
['藏宝图掉落概率'] = 100,
['局内地图等级'] = 10,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('罪恶城堡通行证 ')
end

local mt = ac.skill['罪恶城堡通行证 ']
mt{
--等久
level = 1,
--图标
art = [[szdlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[
|cffFFE799【领取条件】|r商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加1000金币，杀怪+1000金币，攻击+1000金币
开局赠送一本黄阶功法书（四选一），发放英雄背包|r
]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
passive = true
} 

function mt:on_cast_start()
    local hero = self.owner
    local items = self
    local p = hero:get_owner()
    local peon = p.peon
    local it = ac.item.create_item('黑暗骰子')
    it:set_item_count(5)
    peon:add_item(it)

end    
