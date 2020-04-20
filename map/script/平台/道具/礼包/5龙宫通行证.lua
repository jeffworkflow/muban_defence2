local mt = ac.skill['龙宫通行证']
mt{
--等久
level = 0,
--图标
art = [[lgtxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00会心几率+10% 每秒加全属性+8888|r
|cff00ffff开局赠送5张扭蛋券（十连抽）、2张超级扭蛋券（十连抽）
扭蛋券（十连抽）、超级扭蛋券（十连抽）掉落概率提高一倍
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['移动速度'] = 150,
['每秒加全属性'] = 8888,
['会心几率'] = 10,
['扭蛋券（十连抽）掉落概率'] = 100,
['超级扭蛋券（十连抽）掉落概率'] = 100,
-- ['局内地图等级'] = 1,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('龙宫通行证 ')
end

local mt = ac.skill['龙宫通行证 ']
mt{
--等久
level = 1,
--图标
art = [[lgtxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff5张扭蛋券（十连抽）、2张超级扭蛋券（十连抽）
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
    local it = ac.item.create_item('扭蛋券(十连抽)')
    it:set_item_count(5)
    peon:add_item(it)

    local it = ac.item.create_item('超级扭蛋券(十连抽)')
    it:set_item_count(2)
    peon:add_item(it)
end    
