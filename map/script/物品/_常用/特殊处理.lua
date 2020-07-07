--统一去除物品售价提示
for name,data in pairs(ac.table.ItemData) do
    if name ~= '勇气徽章' then
        data.get_sell_tip =''
    end
end    

local function clear_item_bug(u)
    if not u  then  return end
    if not u.item_list then return end
    for i=1,18 do 
        local handle = u.item_list[i] and u.item_list[i].handle
        if not handle then 
            u.item_list[i] = nil 
        end    
    end
end    
--修复卡红装bug
ac.loop(1000,function()
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            clear_item_bug(p.hero)
            clear_item_bug(p.peon)
        end
    end       
end)

--统一给红色装备 非套装的，添加底边文字提醒
ac.game:event '物品-创建' (function (_,item)
    if not item or item.suit_type or not item.color then 
        return 
    end

    if item.color ~= '红' then 
        return 
    end
    
    if item.item_type ~= '装备' then 
        return 
    end
    -- print('|cff00ffff可用强化石、天谕|cffffff00（第二幕-剑冢副本掉落）|cff00ffff强化，顶级红装非常强！',item.name)
    local foot_tip = '|cff00ffff可用强化石、天谕|cffffff00（第二幕-剑冢副本掉落）|cff00ffff强化，顶级红装非常强！'
    item.suit_tip = foot_tip
    item:set_tip(item:get_tip()..'\n'..foot_tip..'\n')    
         
end)
