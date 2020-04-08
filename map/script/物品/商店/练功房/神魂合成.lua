--物品名称
local mt = ac.skill['神魂合成']
mt{
    --类型
    item_type = "神符",
    art = [[zshxl.blp]],
    --物品技能
    is_skill = true,
    
    content_tip = '',
    auto_fresh_tip = false,
    cool = 1,
    is_order = 1,

    tip = [[
|cffffe799【说明】:|r

消耗 |cffff0000两本神阶功法|r 兑换 |cffdf19d0另一本神阶功法|r
]],
}



function mt:on_add()
    
end

function mt:on_cast_shot()
    local hero = self.owner
    -- hero:add_item('黑色物品合成')
end    
--实际是丢掉
function mt:on_remove()
end