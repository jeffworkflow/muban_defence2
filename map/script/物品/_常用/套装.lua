
--需要考虑套装在地上时的文字显示
--套装
local item ={}
item.suit_type = '召唤'

ac.item.suit = {
    --套装名，套装要求类型，符合类型个数及对应加成属性，符合类型个数及对应加成属性
    {'【大天使】','大天使的赠礼','全属性','3 全伤加深+35% 杀怪加全属性+1000','5 全伤加深+35% 杀怪加全属性+1000'},
    {'【吉安娜】','吉安娜的赠礼','智力','3 技暴几率+5% 技暴伤害+200% 杀怪加智力+2000','5 技暴几率+5% 技暴伤害+200% 杀怪加智力+2000' },
    {'【野蛮人】','野蛮人的赠礼','力量','3 暴击几率+5% 暴击伤害+400% 物理伤害加深+150%','5 暴击几率+5% 暴击伤害+400% 物理伤害加深+150%' },
    {'【迅猛龙】','迅猛龙的赠礼','敏捷','3 分裂伤害+50% 攻击间隔-0.1 攻击加全属性+10000','5 分裂伤害+50% 攻击间隔-0.1 攻击加全属性+10000' },
    {'【守护神】','守护神的赠礼','护甲','3 减伤+5% 每秒加护甲+15 减少周围护甲+1000','5 减伤+5% 每秒加护甲+15 减少周围护甲+1000' },
    {'【掠夺者】','掠夺者的赠礼','收益','3 物品获取率+35% 木头加成+35% 杀敌数加成+35% 魔丸加成+35% ','5 物品获取率+35% 木头加成+35% 杀敌数加成+35% 魔丸加成+35% ' },
    {'【食人魔】','食人魔的赠礼','减甲','3 吸血+25% 攻击速度+150% 攻击减甲+250 ','5 吸血+25% 攻击速度+150% 攻击减甲+250 ' },
    {'【牛魔王】','牛魔王的赠礼','暴击','3 会心伤害+200% 物品获取率+100% 多重暴击+1 ','5 会心伤害+200% 物品获取率+100% 多重暴击+1 ' },
}
local function get_suit_count(unit,suit_type)
    local cnt =0 
    for i=1,6 do
        local items = unit:get_slot_item(i)
        if items and items.suit_type == suit_type then
            cnt = cnt + 1
        end
    end
    return cnt 
end    
local function fresh_suit_tip(unit,type,tip)
--刷新单位身上的所有物品说明
    for i =1,6 do 
        -- print(tip)
        local items = unit:get_slot_item(i)
        if items and type == items.suit_type  then
            items:set_tip(items:get_tip()..tip)
            items.suit_tip = tip
        end
    end    
end    

local function unit_add_suit(unit,item)
    if not item.suit_type then 
        return
    end    

    for _, data in ipairs(ac.item.suit) do
        local little_name,name, type,attr1,attr2,attr3,attr4,attr5,attr6 = table.unpack(data)
        local temp_attr ={}
        temp_attr[1] = attr1 
        temp_attr[2] = attr2 
        temp_attr[3] = attr3 
        temp_attr[4] = attr4 
        temp_attr[5] = attr5 
        temp_attr[6] = attr6 

        if type == item.suit_type then 
            local tip = '' 
            local unit_suit_cnt = get_suit_count(unit,item.suit_type) or 0 
            tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
            item.suit_name = name
            for i = 1,6 do
                if temp_attr[i] then 
                    local dest_rate 
                    local t_attr = {} 
                    -- 匹配 召唤物+1   (%S+)%+(%d+%s-)
                    local first_flag = true
                    local active_flag = false
                    local cnt = 0
                    local attr_tip =''
                    for value in temp_attr[i]:gmatch '%S+' do
                        if first_flag  then 
                            -- print(value)
                            first_flag=false
                            cnt = tonumber(value)
                        else
                            -- print(value)
                            attr_tip = attr_tip.. value ..' '
                        end    
                    end

                    --如果满足条件就增加属性
                    if not unit.suit  then 
                        unit.suit ={}
                    end
                    if not unit.suit[name] then 
                        unit.suit[name]={}
                    end
                    if not unit.suit[name][cnt] then 
                        unit.suit[name][cnt]={}
                        unit.suit[name][cnt][1] = false
                        unit.suit[name][cnt][2] = type
                        unit.suit[name][cnt][3] = attr_tip
                    end
                    if unit_suit_cnt >= cnt   then 
                        active_flag = true
                        if not unit.suit[name][cnt][1]  then   
                            for k,v in string.gsub(attr_tip,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
                                --额外增加人物属性
                                --多个物品会额外增加套装属性
                                -- print(k,v)
                                unit:add(k,v)
                            end   
                        end   
                        unit.suit[name][cnt][1] = true
                    end    
                    local extr_tip = cnt == 5 and '|cffFFE799【额外】|r' or ''
                    if active_flag then 
                        tip = tip..'|cff00FF00'..attr_tip..' ('..unit_suit_cnt..'/'..cnt..')|r'..extr_tip..'\n'
                    else
                        tip = tip..'|cffcccccc'..attr_tip..' ('..unit_suit_cnt..'/'..cnt..')|r'..extr_tip..'\n'
                    end    
                    unit.suit[name][cnt][4] = tip  
                end
            end   
            local foot_tip = '|cff00ffff集齐五件后，在|cffffff00套装熔炼NPC|cff00ffff（练功房右边）进行熔炼入体'
            tip = tip ..'\n'..foot_tip..'\n' 
            item.suit_tip = tip
            --刷新单位身上的所有物品说明
            fresh_suit_tip(unit,type,tip)
        end    
    end    

end     

local function unit_remove_suit(unit,item)
    if not unit.suit or not item.suit_type or not item.suit_name  then 
        return
    end    
    local tip = ''
    local item_self_tip = ''
    -- unit.suit[]
    --只需要减属性即可
    local suit_count = get_suit_count(unit,item.suit_type)
    local name = item.suit_name 
   
    tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
    item_self_tip = item_self_tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
    -- print(tip)
    --刷新tip
                 
    for k,v in sortpairs(unit.suit) do 
        for i = 1,6 do 
            if v[i] and v[i][2] == item.suit_type then 
                --如果类型一样且已激活
                if v[i][1]   and suit_count < i then 
                    --减属性
                    for k,v in string.gsub(v[i][3],'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
                        --额外增加人物属性
                        --多个物品会额外增加套装属性
                        unit:add(k,-v)
                    end
                    v[i][1] = false
                end   
                -- print(v[i][1],v[i][3])
                local extr_tip = i == 5 and '|cffFFE799【额外】|r' or ''
                if v[i][1] then 
                    tip = tip..'|cff00FF00'..v[i][3]..'('..suit_count..'/'..i..')|r'..extr_tip..'\n'
                else
                    tip = tip..'|cffcccccc'..v[i][3]..'('..suit_count..'/'..i..')|r'..extr_tip..'\n'
                end    
                item_self_tip = item_self_tip ..'|cffcccccc'..v[i][3]..'('..suit_count..'/'..i..')|r'..extr_tip..'\n'
            end 
        end 
    end 
    -- print(tip)
    local foot_tip = '|cff00ffff集齐五件后，在|cffffff00套装熔炼NPC|cff00ffff（练功房右边）进行熔炼入体'
    tip = tip ..'\n'..foot_tip..'\n'
    item_self_tip = item_self_tip ..'\n'..foot_tip..'\n'
    --先刷新丢地上的物品
    item:set_tip(item:get_tip()..item_self_tip)
    item.suit_tip = tip
    --刷新 套装说明 
    fresh_suit_tip(unit,item.suit_type,tip)

end    


ac.game:event '单位-获得物品后' (function (_,unit,item)
    unit_add_suit(unit,item)
end)

ac.game:event '单位-丢弃物品后' (function (_,unit,item)
    --需要移除属性
    --移除激活标志
    unit_remove_suit(unit,item)
end)

ac.game:event '物品-创建' (function (_,item)
    if not item or not item.suit_type then 
        return 
    end
    
    for _, data in ipairs(ac.item.suit) do
        local little_name,name, type,attr1,attr2,attr3,attr4,attr5,attr6 = table.unpack(data)
        local temp_attr ={}
        temp_attr[1] = attr1 
        temp_attr[2] = attr2 
        temp_attr[3] = attr3 
        temp_attr[4] = attr4 
        temp_attr[5] = attr5 
        temp_attr[6] = attr6 

        if type == item.suit_type then 
            local tip = '' 
            tip = tip ..'|cffFFE799'.. name..' (套装)|r'..'\n'
            item.suit_name = name
            for i = 1,6 do
                if temp_attr[i] then  
                    local first_flag = true
                    local cnt = 0
                    local attr_tip =''
                    for value in temp_attr[i]:gmatch '%S+' do
                        if first_flag  then 
                            first_flag=false
                            cnt = tonumber(value)
                        else
                            attr_tip = attr_tip.. value ..' '
                        end    
                    end  
                    local extr_tip = cnt == 5 and '|cffFFE799【额外】|r' or ''
                    tip = tip..'|cffcccccc'..attr_tip..'('..cnt..')|r'..extr_tip..'\n'
                end
            end    
            -- print(item:get_tip()..tip)
            local foot_tip = '|cff00ffff集齐五件后，在|cffffff00套装熔炼NPC|cff00ffff（练功房右边）进行熔炼入体'
            item.suit_tip = tip
            item:set_tip(item:get_tip()..tip..'\n'..foot_tip..'\n')    
            --更改物品名字
        end    
    end   
         
end)
