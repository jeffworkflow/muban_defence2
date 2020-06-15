--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['吞噬丹']
mt{
--等久
level = 1,

--冷却
cool = 0,

--描述
tip = [[


可以|cff00ff00吞噬装备|r 永久增加对应的属性|cffffff00（套装效果无法加成）|r

|cff00ffff已吞噬|r %cnt%|cffffff00 / %max_cnt%|r |cff00ffff个：|r %content%]],
cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.tunshi_cnt or 0 
    end    
    return cnt
end,
max_cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player:get('吞噬丹使用上限')+8
    end    
    return cnt
end,

content = function(self) 
    local content = '' 
    --吞噬丹在宠物也可以展示
    if self and self.owner  then 
        local hero = self.owner
        local player = hero:get_owner()
        if player.tunshi then 
            for i,item in ipairs(player.tunshi) do
                content = content ..'\n'.. item.store_name
            end
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

function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {}
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = player:get('吞噬丹使用上限')+8 
    if (player.tunshi_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('|cffffe799【系统消息】|r已经吞噬过多物品(最多'..cnt..'个)，无法继续吞噬')
        return 
    end    

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑')   then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r ',
                item = item
            }
            table.insert(list,info)
        end
    end 
    
    peon = player.peon
    for i=1,6 do 
        local item = peon:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑')  then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code['淡黄']..'吞噬 '..item.color_name  .. '|r |cffdf19d0(宠)|r',
                item = item
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffffe799【系统消息】|r英雄物品栏没有可吞噬的装备',4)
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name,true)
        end     
        return 
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'吞噬装备',list,function (index)
            local item = list[index].item
            if item then 
                --移除装备，移除一次属性
                item:item_remove()
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
                --吞噬个数 +1
                if not player.tunshi_cnt then 
                    player.tunshi_cnt =0
                end    
                player.tunshi_cnt = player.tunshi_cnt + 1
                player:sendMsg('|cffffe799【系统消息】|r|cffffff00吞噬成功|r 吞噬后的属性可以在吞噬神丹系统中查看')
                --吞噬名
                if not player.tunshi then 
                    player.tunshi = {}
                end    
                table.insert(player.tunshi,skl)

                --触发超级彩蛋
                if player.tunshi_cnt  == 8 then 
                    ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','大胃王')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断吞噬物品|r 惊喜获得技能|cffff0000 "大胃王" |r |cff00ff00攻击10%几率造成范围全属性*250的技能伤害|r',6)
                end    
                    

            else
                -- print('取消更换技能')
                if self._count > 1 then 
                    -- print('数量')
                    self:set_item_count(self._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name,true)
                end        
            end
            
            self.dialog = nil
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end


local mt = ac.skill['吞噬神丹']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[icon\tunshi.blp]],
    title = '吞噬神丹',
    tip = [[
查看 吞噬神丹
    ]],
}
mt.skills ={}
