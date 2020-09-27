--破损的箱子
ac.wait(30,function()
    for i=1,10 do 
        local rect = ac.rect.j_rect('xiangzi'..i)
        local u = ac.player(16):create_unit('破损的箱子',rect)
        u:add_restriction('魔免')
        u:add_restriction('定身')
        u:event '受到伤害开始'(function(_,damage)
            if not damage:is_common_attack() then 
                return true
            end
        
        end)
        
        u:event '单位-死亡'(function(_,unit,killer)
            local p = killer.owner
            local hero =p.hero
            hero:add('力量%',1)
            hero:add('敏捷%',1)
            hero:add('智力%',1)
            p:sendMsg('|cffebb608【系统】|r|cff00ff00隐藏的箱子被打爆了，恭喜获得|cffff0000 全属性+1%',5)

            --彩蛋
            p.kill_psdxz = (p.kill_psdxz or 0) +1
            if p.kill_psdxz == 5 then 
                --触发 破损的箱子
                local skl = hero:find_skill('破损的箱子',nil,true) 
                if not skl  then 
                    ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','绝对C位')
                    ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 打爆了一堆箱子 获得成就|cffff0000 "绝对C位" |r，奖励 |cffff0000+150w全属性 +35%木头加成 +250减少周围护甲|r',5)
                    ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 打爆了一堆箱子 获得成就|cffff0000 "绝对C位" |r，奖励 |cffff0000+150w全属性 +35%木头加成 +250减少周围护甲|r',5)
                    ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 打爆了一堆箱子 获得成就|cffff0000 "绝对C位" |r，奖励 |cffff0000+150w全属性 +35%木头加成 +250减少周围护甲|r',5)
                end
            end
        end)
    end
end)
--卡牌大师
local cnt = 0
ac.game:event '单位-死亡'(function(_,unit,killer)
    if unit:get_name() ~='城堡守卫' then 
        return 
    end
    local p = killer.owner
    cnt = cnt + 1 
    if cnt == 5000 then 
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00卡牌大师来到了这个世界，在罪恶城堡中可以找到他',5)
        --创建卡牌大师
        local x,y = ac.rect.j_rect('kpds'):get_point():get()
        local shop = ac.shop.create('卡牌大师',x,y,270)
        local it = shop:add_sell_item('免费刷新',9)
        it:on_cast_start()

        _:remove()
    end
end)



--物品名称
local mt = ac.skill['免费刷新']
mt{
--特殊id
type_id = 'EX04',    
--等久
level = 1,
--图标
art = [[BTNJBSX.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cff00ff00免费刷新本批卡片|r
 ]],
--物品类型
item_type = '神符',
is_order = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
shop_count = 0, --初始个数
--冷却
cool = 0,
content_tip = '',
--商店名词缀
-- store_affix = '最终的挑战',
}
local function get_status(tab,name)
    local ok 
    local str = table.concat(tab, ",")
    if not finds(str,name) then 
        ok = true
    end
    return ok
end

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local seller = self.seller
    --随机3个不同名卡片
    local list = {}
    local i = 0 
    while true do 
        local name = ac.all_card[math.random(#ac.all_card)]
        local ok = get_status(list,name)
        if ok then 
            i = i + 1
            table.insert(list,name)
            seller.sell[i] = name
            if i == 3 then 
                break
            end
        end
    end
    seller:fresh()
    --改变tip
    for i=1,3 do 
        local it = seller.sell_item_list[i]
        it.item_type_tip = [[|cff00ff00消耗 |cffff000030个黑暗骰子 |cff00ff00进行兑换

]]
        it:fresh_tip()
    end
end



--多啦A梦
local cnt = 2
ac.game:event '挖图成功'(function(_,hero)
    
    local p = hero.owner
    p.wt_cnt = (p.wt_cnt or 0) + 1
    if p.wt_cnt == 50 and not ac.flag_dlam then 
        ac.flag_dlam = true
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00多啦A梦来到了这个世界，在藏宝阁中可以找到他',5)
        --创建多啦A梦
        local x,y = ac.rect.j_rect('cbt5'):get_point():get()
        local shop = ac.shop.create('多啦A梦',x,y,270)
        local it = shop:add_sell_item('免费刷新2',9)
        it:on_cast_start()
        shop:add_sell_item('兑换超级藏宝图',12)
        
    end
end)
local all_item = {}
ac.wait(100,function()
    local color ={
        '白','蓝','金','红','黑'
    }
    for i,color in ipairs(color) do 
        for i,name in ipairs(ac.quality_item[color]) do 
            table.insert(all_item,name)
        end
    end
    --进行乱序
    table.sort(all_item,function(a,b)
        return a > b
    end)
    -- print_r(all_item)
end)

--物品名称
local mt = ac.skill['免费刷新2']
mt{
--特殊id
type_id = 'EX05',    
title = '免费刷新',
--等久
level = 1,
--图标
art = [[BTNJBSX.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cff00ff00免费刷新本批物品|r
 ]],
--物品类型
item_type = '神符',
is_order = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
shop_count = 0, --初始个数
--冷却
cool = 0,
content_tip = '',
--商店名词缀
-- store_affix = '最终的挑战',
}
local function get_status(tab,name)
    local ok 
    local str = table.concat(tab, ",")
    if not finds(str,name) then 
        ok = true
    end
    return ok
end

local color_cost = {
    ['白'] = 1999,
    ['蓝'] = 9999,
    ['金'] = 49999,
    ['红'] = 249999,
    ['黑'] = 999999,
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local seller = self.seller
    --随机4个不同名卡片
    local list = {}
    local i = 0 
    while true do 
        local name = all_item[math.random(#all_item)]
        local ok = get_status(list,name)
        if ok then 
            i = i + 1
            table.insert(list,name)
            seller.sell[i] = name
            if i == 4 then 
                break
            end
        end
    end
    seller:fresh()
    --改变tip
    for i=1,4 do 
        local it = seller.sell_item_list[i]
        it.wood = color_cost[it.color]
        it.on_selled_remove = true 
        it:fresh_tip()
    end
end


--物品名称
local mt = ac.skill['兑换超级藏宝图']
mt{  
title = '兑换超级藏宝图',
--等久
level = 1,
--图标
art = [[cjcbt.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cff00ff00消耗|cffff000040点当局挖宝积分|cff00ff00，兑换|cffffff00超级藏宝图|cffcccccc（当局挖宝积分：%wt_cnt%|cffcccccc）
 ]],
--物品类型
item_type = '神符',
is_order = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
shop_count = 1, --初始个数
--冷却
cool = 0,
content_tip = '',
wt_cnt = function()
    return ac.player.self.wt_cnt or 0 
end
--商店名词缀
-- store_affix = '最终的挑战',
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero.owner
    p.wt_cnt = p.wt_cnt or 0
    if p.wt_cnt >=40 then 
        --扣积分
        p.wt_cnt = p.wt_cnt - 40 
        --加超级藏宝图
        hero:add_item('超级藏宝图')
    else
        p:sendMsg('藏宝图积分不够',5)
    end

end