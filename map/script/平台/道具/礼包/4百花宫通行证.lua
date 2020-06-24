local mt = ac.skill['百花宫通行证']
mt{
--等久
level = 0,
--图标
art = [[bhgtxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00攻击距离+200 每秒加护甲+20|r
|cff00ffff开局赠送10个一颗神奇的种子
一颗神奇的种子掉落概率提高一倍
|cffffff00可自动种树（点击种子试试）
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['移动速度'] = 150,
['攻击距离'] = 200,
['每秒加护甲'] = 20,
['一颗神奇的种子掉落概率'] = 100,
['局内地图等级'] = 1,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('百花宫通行证 ')
    --开启自动种树
    p.auto_plant = true
end

local mt = ac.skill['百花宫通行证 ']
mt{
--等久
level = 1,
--图标
art = [[bhgtxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff10个一颗神奇的种子
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
    local it = ac.item.create_item('一颗神奇的种子')
    it:set_item_count(10)
    peon:add_item(it)
    

end    
