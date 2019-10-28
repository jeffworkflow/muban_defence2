local mt = ac.skill['提升星级']


function mt:on_cast_finish()
    local build = self.owner
    local player = build:get_owner()

    local hero = player:get_hero()

    if build:get_star_level() >= 5 then
        player:sendMsg('星级已经升满了')
        return
    end

    if build:can_upgrade() then
        player:sendMsg('升星失败,等级还没达到')
        return
    end

    local price = self.upgrade_gold
    if price == nil then
        return
    end

    local gold = player:getGold()
    if gold < price then
        player:sendMsg('升星失败,钱不够')
        return
    end

    local item_map = {}

    for build in player:each_build() do
        local list = build:find_item()
        for index,item in ipairs(list) do
            if item.build then
                item_map[item.build] = item
            else
                item_map[item:get_name()] = item
            end
        end
    end

    local list = hero:find_item()
    for index,item in ipairs(list) do
        if item.build then
            item_map[item.build] = item
        else
            item_map[item:get_name()] = item
        end
    end


    local item = item_map[build:get_name():gsub('（皮肤）','')]
    if item == nil then
        if build:get_rank_level() <= 2 then
            item = item_map['普通升星石'] or item_map['高级升星石']
        else
            item = item_map['高级升星石']
        end
    end

    if item == nil then
        player:sendMsg('升星失败,缺少所需材料')
        return
    end

    player:sendMsg('升星成功')

    build:add_star_level(1)

    player:addGold(-price)

    item:remove()
end


function mt:on_upgrade()
    local build = self.owner 
    local player = build:get_owner()
 
    local num = self:get_level() - 1
    if num > 0 then 
        build:add('基础力量',10 * num)
        build:add('基础敏捷',10 * num)
        build:add('基础智力',10 * num)
    
        build:add('魔法上限',20)


    end 

end 