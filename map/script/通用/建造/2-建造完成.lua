local ui = require 'ui.server.util'

local event = {
    on_build = function (x,y)
        local player = ui.player
        local hero = player:get_hero()
        local skill = hero:find_skill('移动','英雄')
        if skill then
            skill.area = skill.data.area
            skill:fresh()
        end

        hero:event_notify('单位-准备建造完成',hero,x,y)
        --hero.build_item = nil
    end,

    on_end = function ()
        local player = ui.player
        local hero = player:get_hero()
        local skill = hero:find_skill('移动','英雄')
        skill.area = skill.data.area
        skill:fresh()
        hero:event_notify('单位-取消建造',hero)
        --hero.build_item = nil
    end
}

ac.game:event '物品-施法开始' (function (_,hero,item)
    print('进入物品施法开始1')
    local name = item.build
    if name == nil or hero.is_build then
        return
    end
    local player = hero:get_owner()

    local count = 0 
    for build in player:each_build() do 
        count = count + 1
    end 

    if count >= 10 then 
        player:sendMsg('最多只能同时召唤10个英雄，请回收其他英雄后再召唤吧。')
        return 
    end 

    hero.build_item = item

    hero:event_notify('单位-准备建造',hero,name)
end)


ac.game:event '单位-准备建造完成' (function (_,hero,x,y)
    local item = hero.build_item
    if item == nil then
        return
    end

    item.target = ac.point(x,y)

    hero:issue_order('move',item.target)
end)


ac.game:event '单位-发布指令' (function(self, hero, order, target, player_order)
    local player = hero:get_owner()
    local item = hero.build_item
    if item == nil then
        return
    end

    if hero.use_item_timer then
        if target == nil or item.target == nil or target.type ~= 'point' then 
            hero.use_item_timer:remove()
            hero.use_item_timer = nil
    
            hero.build_item = nil
            item.target = nil 
            if player:is_self() then 
                ac.clear_selector()
            end 
            
            return
        end 
    end


    hero.use_item_timer = ac.loop(100,function ()
        if item.target and item.target * hero:get_point() < item.skill.range then

            item.skill:_call_event 'on_build_finish'
            item.target = nil

            hero.use_item_timer:remove()
            hero.use_item_timer = nil

            hero.build_item = nil

            hero:issue_order('stop')
            if player:is_self() then 
                ac.clear_selector()
            end 
        end
    end)


end)

ui.register_event('build',event)