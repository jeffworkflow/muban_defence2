
local mt = ac.skill['众人拾柴火焰高']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[zuoyeben.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff007月20日-8月12日
|cffffe799【活动说明】|r|cff00ff00炎炎夏日，火似骄阳。暑期来临，魔神班主任担心大家荒废学业，往|cff00ffff藏经阁|cff00ff00投放了一些|cffffff00【暑假作业本】|cff00ff00，热爱学习的少侠赶紧去寻找吧！
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0众人拾柴火焰高|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['火把积分'] =  {
        { rand = 3, name = '金'},
        { rand = 3, name = '红'},
        { rand = 3, name = '地阶'},
        { rand = 3, name = '天阶'},
        { rand = 3, name = '天谕*1'},
        { rand = 3, name = '天谕*5'},
        { rand = 3, name = '功法连升书*1'},
        { rand = 3, name = '无谓因果*1'},
        { rand = 3, name = '龙之血珠*1'},
        { rand = 3, name = '吞噬丹*1'},
        { rand = 3, name = '三眼赤痕*1'},
        { rand = 3, name = '火龙气息*1'},
        { rand = 3, name = '天魂融血丹*1'},
        { rand = 3, name = '地魂融血丹*1'},
        { rand = 15, name = '随机卡片'},
        { rand = 3, name = '神奇的令牌*1'},
        
        { rand = 30, name = '无'},
    },
}


local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['火把积分']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    local key = ac.server.name2key('火把积分')
    --加火把积分
    p:Map_AddServerValue(key,1)

    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这暑假作业一看就是应付了事的！',3) 
    elseif  finds(rand_name,'天谕','功法连升书','无谓因果','龙之血珠','吞噬丹','三眼赤痕','火龙气息','天魂融血丹','地魂融血丹','神奇的令牌') then
        local it
        --处理掉落物品相关
        for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
            for i=1,tonumber(v) do 
                it = hero:add_item(k)
            end 
        end
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..(it.color_name or rand_name)..'|r',4)
    elseif  finds('地阶 天阶',rand_name) then   
        local list = ac.quality_skill[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.add_skill_item(name,hero)
        local color = it and it.color 
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000|cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',4)
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..name..'|r',4)
    end    


end

local mt = ac.skill['火把']
mt{
--等久
level = 1,
--图标
art = [[zuoyeben.blp]],
is_order = 1,
--说明
tip = [[ 
|cffffe799【使用说明】|r

|cff00ff00击杀100个怪物，即可完成作业
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
store_affix = '',
no_use = true,
store_name = '|cffdf19d0火把|r',
item_type = '消耗品',
--物品详细介绍的title
content_tip = ''
}



ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'血魔') then 
        return
    end    
    local p = killer:get_owner()
    if not p.max_fall_cnt then 
        p.max_fall_cnt = {}
    end
    local rand_name = '血魔123'
    p.max_fall_cnt[rand_name] = (p.max_fall_cnt[rand_name] or 0)
    --获得最多次数
    local max_fall_cnt = 16   
    local rate = 0.12
    if math.random(100000)/1000 <= rate and p.max_fall_cnt[rand_name] < max_fall_cnt then 
        --当前个数+1
        p.max_fall_cnt[rand_name] = (p.max_fall_cnt[rand_name] or 0) +1

        --给种子
        local it = ac.item.create_item('火把',unit:get_point())
        -- it.owner_ship = p
        -- p:sendMsg('恭喜掉落了 西瓜种子',5)
    end    
end)


--处理区域触发
local minx, miny, maxx, maxy = ac.rect.j_rect('npc15'):get()
local rect = ac.rect.create(minx-250, miny-250, maxx+250, maxy+250)
local reg = ac.region.create(rect)

reg:event '区域-进入' (function(trg,unit)
    local p = unit:get_owner()
    if p.id>=11 then 
        return 
    end
    if not p.server then 
        return 
    end  
    local it = unit:has_item('火把')
    if it then 
        p.hb_cnt = (p.hb_cnt or 0 ) + 1
        if p.hb_cnt <= 15 then 
            give_award(unit)
            it:add_item_count(-1)
        end
    end
end)


ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 6 
    local rate = 55
    local time = 10
    ac.loop(time*1000,function()
        local online_cnt = get_player_count()
        local cnt = math.floor(online_cnt/3) + 1 

        for i= 1, cnt do 
            local point = ac.map.rects['藏宝区']:get_random_point()
            local unit = ac.player(16):create_unit('游荡的虫子',point)

            unit:add_buff '随机逃跑' {}
            ac.nick_name('有人唠嗑不',unit,250)
            unit:event '受到伤害开始'(function(_,damage)
                local u = damage.source 
                local rate =10 
                if u:has_item('火把') then 
                    if math.random(100000)/1000<=rate then 
                        unit:kill(u)
                    end
                end
                return true
            end)
            unit:event '单位-死亡'(function(_,unit,killer)
                local p = killer:get_owner()
                if p.id >= 11 then 
                    return 
                end    
                local player = killer:get_owner()
                local hero = p.hero
                give_award(hero)
                -- local save_name = '火把积分'
                -- -- print(self.rate)
                -- if math.random(100) <= rate then 
                --     local key = ac.server.name2key(save_name)
                --     --激活成就（存档） 
                --     p:Map_AddServerValue(key,1) --网易服务器
                --     p:sendMsg('|cffebb608【系统】|r |cffff0000火把积分+1',6) 
                -- else
                --     p:sendMsg('|cffebb608【系统】|r阁下人品略低 |cffff0000超度失败',6) 
                -- end     
            end)
        end    
    end)

end)
