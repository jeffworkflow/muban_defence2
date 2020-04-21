--物品名称
local mt = ac.skill['物品合成']
mt{
    --类型
    item_type = "神符",
    art = [[other\hecheng.blp]],
    title = '物品合成',
    content_tip = '',
    cool = 1,

    art = [[other\hecheng.blp]],
    tip = [[

|cffFFE799【使用说明】：|r
将 |cff00ff00四个低品质装备|r 合成 |cffdf19d0一个高品质装备|r
将 |cff00ff00两个红色品质装备|r 合成 |cffdf19d0另一个红色品质装备|r
将 |cff00ff00三本低阶功法|r 合成 |cffdf19d0一本高阶功法|r
将 |cff00ff00两本天阶功法|r 合成 |cffdf19d0另一本天阶功法|n|r

]],

    ignore_cool_save = true, --忽略技能冷却
}



function mt:on_add()
    
end

function mt:on_cast_shot()
    local hero = self.owner
    hero:add_item('装备合成')
    hero:add_item('功法合成')
end    
--实际是丢掉
function mt:on_remove()
end

--物品名称
local mt = ac.skill['装备合成']
mt{
    --类型
    item_type = "神符",
}