local mt = ac.skill['真·圣龙精魄']
mt{
    level = 1 ,
    --颜色
    color = '紫',
    item_type ='消耗品',
    tip = [[ 
|cff00ff00可熔炼顶级的烧火棍和赤炎甲
 ]],
    --技能图标
    art = [[jingpo.blp]],
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
    first_item2 and first_item2.level == first_item2.max_level ) and not p.flag_sljp
    then 
        -- owner:has_item(self.name):item_remove()
        first_item1:item_remove()
        first_item2:item_remove()

        local skl = hero:find_skill('烧火棍',nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'套装熔炼','烧火棍')
            local skl = hero:find_skill('烧火棍',nil,true) 
            skl:upgrade(skl.max_level)
        end    

        local skl = hero:find_skill('赤炎甲',nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'套装熔炼','赤炎甲')
            local skl = hero:find_skill('赤炎甲',nil,true) 
            skl:upgrade(skl.max_level)
        end    
        p.flag_sljp = true
        p:sendMsg('|cffffe799【系统提示】|r|cff00ff00恭喜熔炼成功，炼化后的属性可在圣龙气运-套装熔炼中查看',5)
        return
    end
     
    if (sec_item1 and sec_item1.level == sec_item1.max_level and
    sec_item2 and sec_item2.level == sec_item2.max_level ) and not p.flag_sljp
    then 
        -- owner:has_item(self.name):item_remove()
        sec_item1:item_remove()
        sec_item2:item_remove()

        local skl = hero:find_skill('烧火棍',nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'套装熔炼','烧火棍')
            local skl = hero:find_skill('烧火棍',nil,true) 
            skl:upgrade(skl.max_level)
        end    

        local skl = hero:find_skill('赤炎甲',nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'套装熔炼','赤炎甲')
            local skl = hero:find_skill('赤炎甲',nil,true) 
            skl:upgrade(skl.max_level)
        end 
        
        p.flag_sljp = true
        p:sendMsg('|cffffe799【系统提示】|r|cff00ff00恭喜熔炼成功，炼化后的属性可在圣龙气运-套装熔炼中查看',5)
    else
        self:add_item_count(1)
        p:sendMsg('|cffffe799【系统提示】|r|cff00ff00请检查烧火棍和赤炎甲是否已经升至|cffffff00顶级',5)    
    end
end    