local mt = ac.skill['藏经阁通行证']
mt{
--等久
level = 0,
--图标
art = [[cjgtxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00魔丸+50000 每秒加魔丸+48|r
|cff00ffff开局赠送8张羊皮纸、2张无字天书
羊皮纸、无字天书掉落概率提高一倍
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['移动速度'] = 150,
['每秒加魔丸'] = 48,
['羊皮纸掉落概率'] = 100,
['无字天书掉落概率'] = 100,
['局内地图等级'] = 1,

add_fire = 50000,
}

function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()

    -- hero = p.hero
    hero:add_rec_ex(self.add_fire)

    local peon = p.peon
    peon:add_item('藏经阁通行证 ')

end



local mt = ac.skill['藏经阁通行证 ']
mt{
--等久
level = 1,
--图标
art = [[cjgtxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff8张羊皮纸、2张无字天书
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
    local it = ac.item.create_item('羊皮纸')
    it:set_item_count(8)
    peon:add_item(it)
    
    local it = ac.item.create_item('无字天书')
    it:set_item_count(2)
    peon:add_item(it)
    -- 藏经阁通行证
end    
