

for ix =1 ,6 do 
    local affix 
    if ix == 1 then 
        affix = '一'
    elseif ix == 2 then
        affix = '二' 
    elseif ix == 3 then
        affix = '三'    
    elseif ix == 4 then
        affix = '四'   
    elseif ix == 5 then
        affix = '五'    
    elseif ix == 6 then 
        affix = '六' 
    end          
    local mt = ac.skill[affix..'号熔炼石']
    mt{
        --等久
        level = 0,
        --图标
        art = [[ronglianshi.blp]],
        --说明
        tip = [[%change_tip%]],
        change_tip = [[

|cff00ffff可熔炼出装备的套装属性，但|cffff0000合成材料会消失
                
|cff00ff00【合成材料】5个相同套装的装备|r

|cffcccccc【同一套装属性只能激活一次】|r]],
        --物品类型
        item_type = '消耗品',
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        --物品技能
        is_skill = true,
        --物品详细介绍的title
        skill_cnt = 8,
        content_tip = '|cffffe799使用说明：|r',
    }
        
    function mt:on_add()
        self.first_use =true
        
    end
    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        --宠物也帮忙升级
        -- hero = player.hero
        --优化:优先选择所有者身上的套装进行熔炼，再没有再选择人身上的。
        local item_owner_has_suit 
        if not hero.suit then 
            item_owner_has_suit = false
        else    
            for key,val in sortpairs(hero.suit) do   
                --如果5个集满
                if val[5] and val[5][1] then 
                    item_owner_has_suit = true 
                    break
                end
            end    
        end    
        if not item_owner_has_suit then 
            hero = player.hero
        end    

        if not hero.suit then 
            player:sendMsg('|cffebb608【系统】|r|cffff0000熔炼失败|r |cff00ff00请检查身上是否佩戴 |cff00ffff5个相同套装的装备',2)
            if self.add_item_count then 
                self:add_item_count(1) 
                
            end    
            return true
        end     
        
        local skl = player.hero:find_skill(self.name,nil,true)
        if skl and skl.level >=1 then 
            player:sendMsg('|cffebb608【系统】|r|cffff0000操作失败|r '..self.name..'已被激活，可以在套装系统中查看',2)
            if self.add_item_count then 
                self:add_item_count(1) 
            end    
            return true
        end  
        if not player.hero.flag_suit then 
            player.hero.flag_suit = {}
        end    
        local item = self 
        local flag
        for key,val in sortpairs(hero.suit) do   
            --如果5个集满
            if val[5] and val[5][1] and not player.hero.flag_suit[key] then 
                if not val[5][5] then 
                    flag = val[5][2] 
                    local tip = val[5][4]
                    skl:set('change_tip',tip)
                    skl:fresh_tip()
                    skl:set_level(1)
                    --增加属性5个的 
                    for k,v in string.gsub(val[5][3],'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
                        --额外增加人物属性
                        player.hero:add(k,v)
                    end  
                    for k,v in string.gsub(val[3][3],'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
                        player.hero:add(k,v)
                    end 
                    player:sendMsg('|cffebb608【系统】|r|cff00ff00熔炼成功|r 炼化后的属性可在圣龙气运-熔炼石系统中查看',2)
                    --标记已经熔炼过（不可熔炼两套海贼王）
                    player.hero.flag_suit[key] =true
                    break
                end     
            end    
        end   
        --移除物品
        if flag then
            for i=1,30 do
                local items = hero.item_list and hero.item_list[i]
                if items and items.suit_type == flag then  
                    items:item_remove()
                end    
            end  
        else
            player:sendMsg('|cffebb608【系统】|r|cffff0000熔炼失败|r 合成材料出错或者该套装已被激活',2)
            if self.add_item_count then 
                self:add_item_count(1) 
            end    
            return true    
        end   


    end 


end    

--魔法书
local mt = ac.skill['套装熔炼']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ronglianshi.blp]],
    title = '套装熔炼',
    tip = [[
        
点击查看 |cff00ff00套装熔炼|r，通过 |cffffff00圣龙精魄|r 或|cffffff00熔炼石|r 熔炼装备获得
    ]],
}
mt.skills = {
    -- '烧火棍','赤炎甲',nil,nil,
    nil,nil,nil,nil,
    '一号熔炼石','二号熔炼石','三号熔炼石','四号熔炼石','五号熔炼石','六号熔炼石',
}