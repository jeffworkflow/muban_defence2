
local mt = ac.skill['泻药卡']
mt{
--等久
level = 1,
--图标
art = [[xieyaoka.blp]],
--说明
tip = [[ 

|cff00ff00点击将泻药投进魔界大军的水井中，可让他们拉肚子|cffffff00（如果正在停怪，请勿使用该卡片，否则不生效）
    
|cffcccccc投药有风险，行动需谨慎！]],
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
    if math.random(100000)/1000 < 30 then 
        --下一波
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00使用泻药卡时，被敌军抓包，愤怒的魔界大军直接|cffff0000开启了下一波的进攻！',5)
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00使用泻药卡时，被敌军抓包，愤怒的魔界大军直接|cffff0000开启了下一波的进攻！',5)
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00使用泻药卡时，被敌军抓包，愤怒的魔界大军直接|cffff0000开启了下一波的进攻！',5)
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
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00将泻药投进了魔界大军的水井中，魔军上下不断拉肚子，|cffff0000暂停进攻90秒！',5)
        local time = 90
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
            title = '泻药的药效还剩：',
            func = function()
                ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000药效已过！停怪结束！请注意进攻怪来袭|r')
                ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000药效已过！停怪结束！请注意进攻怪来袭|r')
                ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000药效已过！停怪结束！请注意进攻怪来袭|r')
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
art = [[yichan.blp]],
--说明
tip = [[ 
 
|cff00ff00点击进行遗产签订，直接获得|cffffff00杀敌数+25万，木头+50万，魔丸+125万|cff00ff00，但|cffff0000所有资源加成锁定为0!

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

    hero:add_kill_count(250000)
    hero:add_wood(500000)
    hero:add_rec_ex(1250000)

    hero:add('杀敌数加成^',0.0000000001)
    hero:add('木头加成^',0.0000000001)
    hero:add('魔丸加成^',0.0000000001)
    hero:add('物品获取率^',0.0000000001)

    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00签订了二爷留下来的遗产！获得|cffffff00杀敌数+25万，木头+50万，魔丸+125万|cff00ff00，但|cffff0000所有资源加成锁定为0!|cffff0000所有资源加成锁定为0!|cffff0000所有资源加成锁定为0!',5)
end



local mt = ac.skill['一分为二卡']
mt{
--等久
level = 1,
--图标
art = [[fuzhika.blp]],
--说明
tip = [[ 

|cff00ff00点击选择一个物品，让它一分为二

|cffcccccc小心物品会裂开！]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
--成功概率
rate = 60,
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
        if item and item.item_type == '装备' and _in(item.color,'白','蓝','金','红','黑','神')  then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'选择 '..item.color_name  .. '|r '
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
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'选择 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r|cffff0000没有可选择的物品',4)
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
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'选择要一分为二的物品')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            if math.random(100000)/1000 <= skill.rate then  
                local it = ac.dummy:add_item(item.name)
                --升级
                for i=1,(item.level-1) do 
                    ac.up_item(it)
                end
                ac.dummy:remove_item(it)
                unit:add_item(it)
                p:sendMsg('|cffebb608【系统】|r|cff00ff00一分为二成功，恭喜获得了两个'..item.color_name..' ',5)
            else
                p:sendMsg('|cffebb608【系统】|r|cffff0000一分为二失败，'..item.color_name..'|cffff0000裂开了',5)
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
                unit:add_item(name)
            end        
        end 
    end

end

local mt = ac.skill['功法重置卡']
mt{
--等久
level = 1,
--图标
art = [[gongfachongzhi.blp]],
--说明
tip = [[ 

|cff00ff00选择一本功法，置换成另一本同品阶的功法

|cffcccccc小心功法会消失！]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
--成功概率
rate = 60
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
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'选择 '..item.color_name  .. '|r '
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
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'选择 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r|cffff0000没有可选择的功法',4)
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
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'选择要重置的功法')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            if math.random(100000)/1000 <= skill.rate then  
                local color = item.color
                local skl_name = ac.quality_skill[color][math.random(#ac.quality_skill[color])]
                local new_skl = ac.item.add_skill_item(skl_name,unit)
                p:sendMsg('|cffebb608【系统】|r'..item.color_name..'|cff00ff00重置成功,获得'..new_skl.color_name..'',5)
                --移除物品
                item:add_item_count(-1)
            else
                p:sendMsg('|cffebb608【系统】|r|cffff0000重置失败，'..item.color_name..'|cffff0000消失了',5)
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
                unit:add_item(name)
            end        
        end 
    end

end

local mt = ac.skill['基地复活次数卡']
mt{
--等久
level = 1,
--图标
art = [[fuhuocishu.blp]],
--说明
tip = [[ 

|cff00ff0050%基地复活次数+1
|cffff000050%基地复活次数-1

|cffcccccc小心倾家荡产！]],
--物品类型
item_type = '消耗品',
is_card = true,
--独自拥有
owner_ship = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
rate = 60
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
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00使用了基地复活次数卡，造成了基地|cffff0000复活次数-1',5)
        else
            --扣掉所有的东西
            p:add_wood(-p.wood)
            p:add_kill_count(-p.kill_count)
            p:add_rec_ex(-p.rec_ex)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00由于基地复活次数已为0，不够该卡片扣除。|cff00ffff'..p:get_name()..'|cff00ff00的杀敌数、木头、魔丸|cffff0000全部归零|cff00ff00，希望心态不要崩！',5)
        end 
    end
end