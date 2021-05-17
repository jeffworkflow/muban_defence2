
local rect = require 'types.rect'
-- 杀敌数兑换
-- 传送 快速达到 兑换
ac.exchange_kill ={
    --商品名（map.table.单位.商店） = 属性名，数值，上限次数，耗费杀敌数，图标,说明
    ['杀敌数加成'] = {'杀敌数加成',5,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%杀敌数加成|r|n'} ,
    ['木头加成'] = {'木头加成',5,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%木头加成|r|n'} ,
    ['物品获取率加成'] = {'物品获取率',5,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%物品获取率|r|n'} ,
    ['魔丸加成'] = {'魔丸加成',5,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%魔丸加成|r|n'} ,
    ['杀怪全属性成长'] = {'杀怪加全属性',25,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+25杀怪加全属性|r|n'} ,
    ['杀怪力量成长'] = {'杀怪加力量',60,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加力量|r|n'} ,
    ['杀怪敏捷成长'] = {'杀怪加敏捷',60,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加敏捷|r|n'} ,
    ['杀怪智力成长'] = {'杀怪加智力',60,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加智力|r|n'} ,
    ['杀怪攻击成长'] = {'杀怪加攻击',100,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+100杀怪加攻击|r|n'} ,
    ['攻击减甲'] = {'攻击减甲',8,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+8攻击减甲|r|n'} ,
    ['每秒加护甲'] = {'每秒加护甲',1,999999,500,[[mingwen9.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+1每秒加护甲|r|n'} ,
    -- ['杀怪护甲成长'] = {'杀怪加护甲',0.1,999999,400,[[sdsdh.blp]],'挑着boss'} ,
}

for key,value in pairs(ac.exchange_kill) do 
    --物品名称
    local mt = ac.skill[key]
    mt{
    --等久
    level = 1,
    is_order = 1,
    --图标
    art = value[5],
    --说明
    tip = value[6],
    --属性名
    attr_name = value[1],
    --属性值
    attr_val = value[2],
    --最大购买次数
    max_buy_cnt = value[3],
    --消耗
    kill_count = value[4],
    --每次增加 20级后，每级+50
    cre = 10,
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    content_tip = '|cffFFE799【说明】：|r',
    store_affix = '兑换 ',
    --物品技能
    is_skill = true,
    real_kill_cnt = 500,
    title = function(self)
        local lv = self.player_buy_cnt and self.player_buy_cnt[ac.player.self] 
        lv = lv and ' Lv'..lv or ''
        return self.name..lv
    end
    -- auto_fresh_tip = true,
    }
  
    if key == '杀敌数加成' then 
        mt.type_id ='EX02'
    end

    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local player = hero:get_owner()
        hero = p.hero
        -- if not p.xnn_current_cnt then 
        --     p.xnn_current_cnt = p.switch_xxn and 10 or 1 
        -- end
        -- local current_time = ac.clock()
        -- p.xnn_last_click_time = p.xnn_last_click_time or 0
        -- local time = current_time - p.xnn_last_click_time
        -- if time > 1 then
        --     -- print('短时间内点了两次',self.name)
        --     --表示鼠标又点了次杀敌数兑换，重新购买商店


        --     return true
        -- end
        -- p.xnn_last_click_time = current_time

        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_kill then 
            shop_item.player_kill ={}
        end
        -- print('改变价格:',shop_item,shop_item.name,player,shop_item.player_buy_cnt[player],shop_item.player_kill[player])
        --改变价格
        local function add_attr()
            if shop_item.player_buy_cnt[player] >19 then
                shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + 50
            else
                shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + self.cre  
            end   
            if player:is_self() then 
                shop_item.real_kill_cnt = shop_item.player_kill[player]
                shop_item:set_tip(shop_item:get_tip())
            end    
            --增加属性
            hero:add(self.attr_name,self.attr_val)

            --文字提醒
            p:sendMsg('|cffebb608【系统】|cff00ff00兑换 '..self.name..' 成功|r',5)
        end

        if not p.switch_xxn then
            add_attr()
        else
            --加属性
            add_attr()
            ac.wait(0,function()
                --模拟9次
                for i=1,9 do 
                    if p.kill_count >= shop_item.player_kill[player] then 
                        --加属性
                        add_attr()
                        --加次数
                        shop_item.player_buy_cnt[player] = shop_item.player_buy_cnt[player] + 1 
                        --扣资源
                        p:add_kill_count(-shop_item.player_kill[player])
                    else
                        p:sendMsg('|cffebb608【系统】|cffff0000杀敌数不足|r',5)
                        break
                    end
                end
            end)
        end
        
    end

end    
