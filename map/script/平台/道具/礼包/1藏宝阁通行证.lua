local mt = ac.skill['藏宝阁通行证']
mt{
--等久
level = 0,
--图标
art = [[cbgtxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00移速+175 每秒加木头+18|r
|cff00ffff开局赠送10张藏宝图
藏宝图掉落概率提高一倍
|cffffff00可自动寻宝（点击藏宝图试试）
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['移动速度'] = 175,
['每秒加木头'] = 18,
['藏宝图掉落概率'] = 100,
['局内地图等级'] = 1,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('藏宝阁通行证 ')
    --自动挖宝
    hero.wabao_auto = true
end

local mt = ac.skill['藏宝阁通行证 ']
mt{
--等久
level = 1,
--图标
art = [[cbgtxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff10张藏宝图
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
    local it = ac.item.create_item('藏宝图')
    it:set_item_count(10)
    peon:add_item(it)
    -- 藏经阁通行证
end    
