
local mt = ac.skill['谢谢参与']
mt{
    art = [[xiexie.blp]],
    -- tip = [[谢谢参与]]
}
local mt = ac.skill['挖宝熟练度+100']
mt{
    art = [[chanzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['看书熟练度+100']
mt{
    art = [[fadajing.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['打造熟练度+100']
mt{
    art = [[suijiwupin.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['种树熟练度+100']
mt{
    art = [[zhongzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['白嫖熟练度+100']
mt{
    art = [[niudantiancai.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['摇骰子熟练度+100']
mt{
    art = [[anheishaizi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['挖宝熟练度+2000']
mt{
    art = [[chanzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['看书熟练度+2000']
mt{
    art = [[fadajing.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['打造熟练度+2000']
mt{
    art = [[suijiwupin.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['种树熟练度+2000']
mt{
    art = [[zhongzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['白嫖熟练度+2000']
mt{
    art = [[niudantiancai.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['摇骰子熟练度+2000']
mt{
    art = [[anheishaizi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['挖宝熟练度+5000']
mt{
    art = [[chanzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['看书熟练度+5000']
mt{
    art = [[fadajing.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['打造熟练度+5000']
mt{
    art = [[suijiwupin.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['种树熟练度+5000']
mt{
    art = [[zhongzi.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['白嫖熟练度+5000']
mt{
    art = [[niudantiancai.blp]],
    -- tip = [[xiexie.blp]]
}

local mt = ac.skill['摇骰子熟练度+5000']
mt{
    art = [[anheishaizi.blp]],
    -- tip = [[xiexie.blp]]
}

--总奖池
local reward = {
    ['神奇的令牌'] =  {	
        {    rand = 19.2, name = '谢谢参与',},

        {    rand = 4, name = '挖宝熟练度+100' },
        {    rand = 4, name = '看书熟练度+100',},
        {    rand = 4, name = '打造熟练度+100',},
        {    rand = 4, name = '种树熟练度+100',},
        {    rand = 4, name = '白嫖熟练度+100',},
        {    rand = 4, name = '摇骰子熟练度+100',},

        {    rand = 0.5, name = '挖宝熟练度+2000' },
        {    rand = 0.5, name = '看书熟练度+2000',},
        {    rand = 0.5, name = '打造熟练度+2000',},
        {    rand = 0.5, name = '种树熟练度+2000',},
        {    rand = 0.5, name = '白嫖熟练度+2000',},
        {    rand = 0.5, name = '摇骰子熟练度+2000',},

        {    rand = 0.3, name = '挖宝熟练度+5000' },
        {    rand = 0.3, name = '看书熟练度+5000',},
        {    rand = 0.3, name = '打造熟练度+5000',},
        {    rand = 0.3, name = '种树熟练度+5000',},
        {    rand = 0.3, name = '白嫖熟练度+5000',},
        {    rand = 0.3, name = '摇骰子熟练度+5000',},

        {    rand = 30, name = '随机存档物品',},

        {    rand = 1, name = '我是大魔头',},
        {    rand = 1, name = '黄金矿工',},
        {    rand = 1, name = '书呆子',},
        {    rand = 1, name = '剑瞎子',},
        {    rand = 1, name = '采蘑菇的小姑娘',},
        {    rand = 1, name = '扭蛋人生',},
        {    rand = 1, name = 'du徒',},
        {    rand = 1, name = '强悍之人',},
        {    rand = 1, name = '血牛',},
        {    rand = 1, name = '一出门就被秒',},
        {    rand = 1, name = '绝世魔剑',},
        {    rand = 1, name = '绝世神剑',},

        {    rand = 1, name = '番天印',},
        {    rand = 1, name = '战舰之舵',},
        {    rand = 1, name = '量天尺',},
        {    rand = 1, name = '虚空王座',},
        {    rand = 1, name = '天眼',},
        {    rand = 1, name = '血羽之心',},
        {    rand = 1, name = '天神之息',},
        {    rand = 1, name = '灭世者',},
        {    rand = 1, name = '宇宙之心',},
        {    rand = 1, name = '太初锁灵鼓',},
        

    },

}

local new_ui = ac.ui.client.draw

local function fresh_item(p)
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
        new_ui:fresh()
    end
end
ac.game:event '选择难度' (function(_,g_game_degree_name)
    --难度系数
    local name = '难'..ac.g_game_degree_attr 
    for i,data in ipairs(reward['神奇的令牌']) do 
        if data.name == '随机存档物品' then 
            data.name = ac.unit_reward[name][1].name
        end
    end
    --刷新奖池
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            fresh_item(p)
        end
    end
    -- print_r(reward)
end)
--神奇的令牌
local mt = ac.skill['神奇的令牌']
mt{
    item_type = '消耗品',
    art = [[lingpai.blp]],
    content_tip = '|cffffe799使用说明：|r',
    level = 1,
    tip =[[


|cff00ff00传说可以打开幸运宝库的令牌，可用于幸运转盘中抽取|cffff0000各种稀有存档道具
                ]]
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero.owner 
    if p.flag_cj then 
        p:sendMsg('|cffffe799【系统提示】|cff00ff00请勿打开幸运转盘',5)
        if p:is_self() then 
            new_ui:show()
        end
        self:add_item_count(1)
        return 
    end
    p.flag_cj = true
    p.save_coin = (p.save_coin or 0) + 1

    fresh_item(p)

    if p:is_self() then 
        new_ui:show()
    end
end
