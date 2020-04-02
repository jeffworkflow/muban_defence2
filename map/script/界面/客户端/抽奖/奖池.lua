
local mt = ac.skill['谢谢参与']
mt{
    art = [[xiexie.blp]]
}
local mt = ac.skill['挖宝熟练度+100']
mt{
    art = [[xiexie.blp]]
}

--总奖池
local reward = {
    ['神奇的令牌'] =  {	
        {    rand = 15, name = '谢谢参与',},
        {    rand = 5, name = '挖宝熟练度+100' },
        {    rand = 80, name = '随机存档物品',},
    },

}
ac.game:event '选择难度' (function(_,g_game_degree_name)
    --难度系数
    local name = '难'..ac.g_game_degree_attr 
    for i,data in ipairs(reward['神奇的令牌']) do 
        if data.name == '随机存档物品' then 
            data.name = ac.unit_reward[name][1].name
        end
    end
    -- print_r(reward)
end)

local new_ui = ac.ui.client.draw

--神奇的令牌
local mt = ac.skill['神奇的令牌']
mt{
    item_type = '消耗品',
    level = 1,
    tip =[[点击使用 抽取 存档物品]]
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero.owner 
    p.save_coin = (p.save_coin or 0) + 1

    local temp = {}
    for i =1,#new_ui.award_list do 
        local name = ac.get_reward_name(reward['神奇的令牌']) or '空白'
        if finds(name,'级物品') then
            local lv = tonumber(string.sub(name,1,1))
            local color = ac.get_reward_name(ac.unit_reward['存档物品'])
            if not color then 
                return 
            end    
            local rand = math.random(#ac.save_item[lv][color])
            name = ac.save_item[lv][color][rand]
        end
        p.award_list = p.award_list or ac.table_copy(new_ui.award_list)
        p.award_list[i].name = name
    end

    if p:is_self() then 
        new_ui:show()
        new_ui:fresh()
    end
end

--游戏失败 且游戏时长>=15分钟给一个令牌
ac.game:event '游戏-结束' (function(trg,flag)
    if flag then 
        return 
    end
    local time = 60 * 15
    if ac.g_game_time >=time  then 
        for i=1,10 do 
            local p = ac.player(i)
            if p:is_player() then 
                p.hero:add_item('神奇的令牌')
            end
        end
        ac.player.self:sendMsg('虽然游戏失败了，但获得神奇的令牌一枚，请尽快使用。',5)
    end
end)