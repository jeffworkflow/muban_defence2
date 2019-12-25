local mt = ac.skill['真·圣龙精魄']
mt{
    level = 1 ,
    --颜色
    color = '紫',
    tip = [[
可炼化顶级的烧火棍和赤炎甲

点击使用，如果身上没有顶级的烧火棍和顶级的赤炎甲，【系统提示】请检查烧火棍和赤炎甲是否已经升至顶级，如果有顶级的烧火棍和顶级的赤炎甲，则【系统提示】炼化成功，攻击+XXX；护甲+XXX
每个人限完成一次
    ]],
    --技能图标
    art = [[qiu305.blp]],
}

function mt:on_cast_start()
    local owner = self.owner
    local p = owner:get_owner()
    local sec_owner 
    if owner:is_hero() then 
        sec_owner = p.peon
    else 
        sec_owner = p.hero
    end   
    local hero =p.hero
    
    local first_item1 = owner:has_item('烧火棍') 
    local first_item2 = owner:has_item('赤炎甲') 
    
    local sec_item1 = sec_owner:has_item('烧火棍') 
    local sec_item2 = sec_owner:has_item('赤炎甲') 
    
    if (first_item1 and first_item1.level == first_item1.max_level and
    first_item2 and first_item2.level == first_item2.max_level )
    then 
        owner:has_item(self.name):item_remove()
        first_item1:item_remove()
        first_item2:item_remove()

        local skl = hero:add_skill('烧火棍','隐藏')
        skl:upgrade(skl.max_level)

        local skl = hero:add_skill('赤炎甲','隐藏')
        skl:upgrade(skl.max_level)
        p:sendMsg('炼化成功')
        return
    end
     
    if (sec_item1 and sec_item1.level == sec_item1.max_level and
    sec_item2 and sec_item2.level == sec_item2.max_level )
    then 
        owner:has_item(self.name):item_remove()
        sec_item1:item_remove()
        sec_item2:item_remove()

        local skl = hero:add_skill('烧火棍','隐藏')
        skl:upgrade(skl.max_level)

        local skl = hero:add_skill('赤炎甲','隐藏')
        skl:upgrade(skl.max_level)
        
        p:sendMsg('炼化成功')
    else
        p:sendMsg('【系统提示】请检查烧火棍和赤炎甲是否已经升至顶级，如果有顶级的烧火棍和顶级的赤炎甲')    
    end
end    