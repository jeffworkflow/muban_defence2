
local mt = ac.skill['泻药卡']
mt{
--等久
level = 1,
--图标
art = [[zhadan.blp]],
--说明
tip = [[ 
点击投掷进魔界大军的水井中，
50%投掷成功，使敌军拉肚子，暂停进攻60秒
50%投掷失败，被愤怒的敌军抓到，加速进攻60秒
    
]],
--物品类型
item_type = '消耗品',
is_card = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local p = self.owner.owner 
    local hero = p.hero 
    --百分50进攻暂停，百分50直接开始下一波
    if math.random(100000)/1000 < 50 then 
        --下一波
        for i=1,3 do 
            local creep = ac.creep['刷怪'..i]
            if creep.has_started  then 
                creep:next()
            else
                creep:start()
            end		
        end    
    else
        --暂停60秒
        local time = 20
        for i=1,3 do 
            local creep = ac.creep['刷怪'..i]
            creep:PauseTimer(time)
        end
        local remain = 0
        if ac.main_stop_timer then 
            remain = ac.main_stop_timer:GetRemaining() 
            ac.main_stop_timer:remove()
            ac.main_stop_timer = nil
            print('剩余时间',remain)
        end
        --启用另一个计时器 显示停怪恢复倒计时	
        ac.main_stop_timer = ac.timer_ex
        {
            time = time + (remain or 0 ),
            title = '停怪还剩：',
            func = function()
                ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
                ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
                ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
                ac.main_stop_timer = nil
            end,
        }
    end
end

local mt = ac.skill['遗产卡']
mt{
--等久
level = 1,
--图标
art = [[zhadan.blp]],
--说明
tip = [[ 

|cff00ff00当物品栏有此卡时,|cff00ff00下一次玩|cffffff00“杀敌数/木头/魔丸/全属性翻倍”|cff00ff00时，40% 翻八倍，60%概率凉凉|r
]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
}
function mt:on_cast_start()
--     直接给杀敌数100万，木头200万，魔丸500万
-- 但是杀敌数加成，木头加成，魔丸加成，物品获取率，上限固定为0
    local p = self.owner.owner 
    local hero = p.hero 

    hero:add_kill_count(1000000)
    hero:add_wood(2000000)
    hero:add_rec_ex(5000000)

    hero:add('杀敌数加成^',0.0000000001)
    hero:add('木头加成^',0.0000000001)
    hero:add('魔丸加成^',0.0000000001)
    hero:add('物品获取率^',0.0000000001)
end


local mt = ac.skill['一分为二卡']
mt{
--等久
level = 1,
--图标
art = [[zhadan.blp]],
--说明
tip = [[ 
点击选择一个物品，让它一分为二，
50%成功，获得一个新的物品，等级可继承
50%失败，本来的物品也消失
]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
--成功概率
rate = 50,
}
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local p = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {} 

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑')  then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'复制 '..item.color_name  .. '|r '
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
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'复制 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r英雄物品栏没有可复制的装备',4)
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
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'复制装备')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            if math.random(100000)/1000 <= skill.rate then  
                local it = ac.dummy:add_item(item.name,true)
                --升级
                for i=1,(item.level-1) do 
                    ac.up_item(it)
                end
                ac.dummy:remove_item(it)
                skill.owner:add_item(it)
                p:sendMsg('复制'..item.color_name..'成功',5)
            else
                p:sendMsg('复制'..item.color_name..'失败',5)
                --移除物品
                item:item_remove()
                if skill._count > 0 then  
                    skill:on_cast_start()
                    skill:add_item_count(-1)
                end
            end
        else
            -- print('取消更换技能')
            if skill._count > 1 then 
                -- print('数量')
                skill:set_item_count(skill._count+1)
            else
                --重新添加给英雄
                unit:add_item(name,true)
            end        
        end 
    end

end

local mt = ac.skill['功法重置卡']
mt{
--等久
level = 1,
--图标
art = [[zhadan.blp]],
--说明
tip = [[ 
点击选择一本功法书
50%成功，获得一本新的功法
50%失败，本来的功法也消失
]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
--成功概率
rate = 50
}
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local p = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {} 

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.color and finds(item.color,'黄阶','玄阶','地阶','天阶','神阶')  then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'重随 '..item.color_name  .. '|r '
            }
            table.insert(list,info)
        end
    end 
    
    peon = player.peon
    for i=1,6 do 
        local item = peon:get_slot_item(i)
        if item and item.color and finds(item.color,'黄阶','玄阶','地阶','天阶','神阶')  then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'重随 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r英雄物品栏没有可重随的功法',4)
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
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'重随功法')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            if math.random(100000)/1000 <= skill.rate then  
                local color = item.color
                local skl_name = ac.quality_skill[color][math.random(#ac.quality_skill[color])]
                local new_skl = ac.item.add_skill_item(skl_name,skill.owner)
                p:sendMsg('重随'..item.color_name..'成功,获得了新的功法：'..new_skl.color_name..'',5)
                --移除物品
                item:add_item_count(-1)
            else
                p:sendMsg('重随'..item.color_name..'失败',5)
                --移除物品
                item:add_item_count(-1)
                if skill._count > 0 then  
                    skill:on_cast_start()
                    skill:add_item_count(-1)
                end
            end
        else
            -- print('取消更换技能')
            if skill._count > 1 then 
                -- print('数量')
                skill:set_item_count(skill._count+1)
            else
                --重新添加给英雄
                unit:add_item(name,true)
            end        
        end 
    end

end

local mt = ac.skill['基地复活次数卡']
mt{
--等久
level = 1,
--图标
art = [[zhadan.blp]],
--说明
tip = [[ 
    点击使用，让基地复活次数+1
    50%失败，基地复活次数-1，当复活次数不够扣时，扣光该玩家的所有木头、杀敌数、魔丸
]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
rate = 50
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero.owner
    local skill = self
    if math.random(100000)/1000 <=self.rate then    
        ac.wait(0,function()
            hero:add_item('基地重生')
        end)
    else
        local unit = ac.main_unit
        local skl = unit:find_skill('重生')
        if skl and skl.cnt>0 then 
            skl.cnt = skl.cnt - 1
            p:sendMsg('系统，扣除基地一次重生机会',5)
        else
            --扣掉所有的东西
            p:add_wood(-p.wood)
            p:add_kill_count(-p.kill_count)
            p:add_rec_ex(-p.rec_ex)
            p:sendMsg('系统，扣除所有资源',5)
        end 
    end
end