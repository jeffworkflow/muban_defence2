--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['世界吞噬丹']
mt{
--等久
level = 1,
art =[[sjtsd.blp]],
--冷却
cool = 0,

--描述
tip = [[


可以|cff00ff00吞噬指定装备|r |cffffff00所有玩家|r均可获得吞噬后的装备属性|cffffff00（套装效果无法加成）|r
 ]],
cnt = function(self) 
    local cnt = ac.tunshi_cnt or 0  
    return cnt
end,
max_cnt = 8,

content = function(self) 
    local content = '' 
    --吞噬丹在宠物也可以展示
    if self and self.owner and ac.tunshi then 
        for i,item in ipairs(ac.tunshi) do
            content = content ..'\n'.. item.store_name
        end
    end    
    return content
end,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true

}
local function add_tunshi_skill(hero,item)
    if not hero then 
        return 
    end
    local player = hero.owner
    local skl = ac.game:event_dispatch('技能-插入魔法书',hero,'吞噬神丹',item.name)
    skl.title = item.name
    skl.store_name = item.store_name
    skl.art = item.art
    skl.tip = item:get_tip()
    --改变数值
    for key,val in pairs(item) do  
        local attr = key
        if key:sub(-1, -1) == '%' then
            attr = key:sub(1, -2)
        end
        -- print('吞噬：',key,attr,ac.unit.attribute[attr],_in(attr,ac.player_attr))
        if ac.unit.attribute[attr] or _in(attr,ac.player_attr) then 
            skl[key] = val
        end
    end
    -- print('吞噬物品，物品等级：',item.level)
    if item.level == 1 then 
        ac.game:event_notify('技能-升级',hero,skl)
    end
    skl:set_level(item.level)
    player:sendMsg('|cffebb608【系统】|r|cffffff00吞噬成功|r 吞噬后的属性可以在吞噬神丹系统中查看')
  
end

function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {}
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = 8
    if (ac.tunshi_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('|cffebb608【系统】|r已经吞噬过多物品(最多'..cnt..'个)，无法继续吞噬')
        return 
    end    

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' and _in(item.color,'白','蓝','金','红','黑','神')   then 
            count = count + 1
            local info = {
                tostring(item.handle),'', "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r ',
                -- name = "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r ',
                -- item = item
            }
            table.insert(list,info)
        end
    end 
    
    peon = player.peon
    for i=1,6 do 
        local item = peon:get_slot_item(i)
        if item and item.item_type == '装备' and _in(item.color,'白','蓝','金','红','黑','神')  then 
            count = count + 1
            local info = {
                tostring(item.handle),'', "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
                -- name = "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r |cffdf19d0(宠)|r',
                -- item = item
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r英雄物品栏没有可吞噬的装备',4)
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name)
        end     
        return 
    end 
    local info = {
        '取消 (Esc)','Esc'
    }
    table.insert(list,info)
    table.insert(list,1,'吞噬装备')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            --移除装备，移除一次属性
            item:item_remove()
            for i=1,6 do 
                local player = ac.player(i) 
                if player:is_player() then 
                    local hero = player.hero
                    add_tunshi_skill(hero,item)  
                end
            end
            --吞噬个数 +1
            if not ac.tunshi_cnt then 
                ac.tunshi_cnt =0
            end    
            ac.tunshi_cnt = ac.tunshi_cnt + 1
            --吞噬名
            if not ac.tunshi then 
                ac.tunshi = {}
            end    
            table.insert(ac.tunshi,skl)

        else
            if skill._count > 1 then 
                -- print('数量')
                skill:set_item_count(skill._count+1)
            else
                --重新添加给英雄
                unit:add_item(name)
            end  
        end
                    
    end


end

function mt:on_remove()
end
