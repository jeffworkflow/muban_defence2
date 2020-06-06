local mt = ac.skill['剑冢通行证']
mt{
--等久
level = 0,
--图标
art = [[jztxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00每秒加木头18|r
|cff00ffff开局赠送5个强化石，2个天谕
强化石、天谕掉落概率提高一倍
|cffffff00随机物品一个（纯随机，运气好直接红装）
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['移动速度'] = 150,
['每秒加木头'] = 18,
['强化石掉落概率'] = 100,
['天谕掉落概率'] = 100,
['局内地图等级'] = 1,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('剑冢通行证 ')
end

local mt = ac.skill['剑冢通行证 ']
mt{
--等久
level = 1,
--图标
art = [[jztxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff5个强化石，2个天谕
|cffffff001个随机物品（纯随机，运气好直接红装）
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
    local it = ac.item.create_item('强化石')
    it:set_item_count(5)
    peon:add_item(it)

    local it = ac.item.create_item('天谕')
    it:set_item_count(2)
    peon:add_item(it)

    local name = ac.all_item[math.random(#ac.all_item)]
    peon:add_item(name)
end    
