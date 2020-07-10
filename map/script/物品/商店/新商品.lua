
local rect = require 'types.rect'
--简单逻辑：
-- 杀敌数兑换、传送、翻倍、基地商品、异火升级、融合等

--复杂逻辑：
-- 扭蛋、魔鬼的交易、练功师

--简单的逻辑，统一这边处理
--复杂逻辑可以通过 ac.table.ItemData data.class =='' 去做一个for循环的逻辑处理
local shop_item_detail = {
    ['通用'] = { --传送
        on_cast_finish = function(self)
            -- print('施法完成:',self.rect,self.x,self.y)
            local hero = self.owner
            local p = hero:get_owner()
            if self.rect then 
                local rect = ac.rect.j_rect(self.rect)
                hero = p.hero
                hero:blink(rect,true,false)
                --镜头偏移
                local x,y=hero:get_point():get()
                -- print(1111,self.y)
                p:setCamera(ac.point(x+(self.x or 0),y+(self.y or 0)))
            end    
        end, 
    } ,
    -- ['杀敌数兑换'] = {
    --     on_cast_start = function(self)
    --         local hero = self.owner
    --         local p = hero:get_owner()
    --         local player = hero:get_owner()
    --         hero = p.hero
            
    --         local shop_item = ac.item.shop_item_map[self.name]
    --         if not shop_item.player_kill then 
    --             shop_item.player_kill ={}
    --         end
    --         -- print(shop_item.player_buy_cnt[player])
    --         --改变价格
    --         if shop_item.player_buy_cnt[player] >20 then
    --             shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + 50
    --         else
    --             shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + self.cre  
    --         end   
    --         if player:is_self() then 
    --             shop_item.real_kill_cnt = shop_item.player_kill[player]
    --             shop_item:set_tip(shop_item:get_tip())
    --         end    
    --         --文字提醒
    --         p:sendMsg('|cff00ff00兑换 '..self.name..' 成功|r',5)
    --     end, 
    -- }   

}


for name,data in pairs(ac.table.ItemData) do 
    if data.category == '商品' then 
        if data.coin == '金币' and data.coin_val ~= 0 then 
            data.gold = data.coin_val
        end
        if data.coin == '木头' and data.coin_val ~= 0  then 
            data.wood = data.coin_val
        end
        if data.coin == '杀敌数' and data.coin_val ~= 0  then 
            data.kill_count = data.coin_val
        end
        if data.coin == '魔丸' and data.coin_val ~= 0  then 
            data.rec_ex = data.coin_val
        end

        --商品名称
        local mt = ac.skill[name]
        for key,val in pairs(data) do 
            mt[key] = val
            if key == 'store_name' then 
                mt.title = val
            end  
        end    
        for key,val in pairs(shop_item_detail['通用']) do 
            if not mt[key] then 
                mt[key] = val
            end      
        end
        if data.class and shop_item_detail[data.class] then 
            for key,val in pairs(shop_item_detail[data.class]) do 
                mt[key] = val
            end    
        end    
    end
end    

--特殊商品处理
local mt = ac.skill['至凶之物']
function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    p.flag_slqy = true
    if p.flag_tsjx then return end 
    p.revive_point = ac.rect.j_rect('zxzw'):get_point()
end

local mt = ac.skill['兑换-神奇的令牌']
mt{
    store_name = '神奇的令牌',
    all_attr = 500000000,
    item_type = '神符',
    art = [[lingpai.blp]],
    tip=[[
|cffffe799【说明】

|cff00ff00消耗 |cffff00005亿全属性 |cff00ff00兑换 |cff00ffff一个神奇的令牌
|cffcccccc（可用于幸运转盘中抽取各种稀有存档道具）
  
|cffcccccc每局兑换上限受游戏难度影响]]
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero 
    local min_allattr = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
    p.dh_sqlp = p.dh_sqlp or 0 

    if p.dh_sqlp >= (2 + ac.g_game_degree_attr) then 
        p:sendMsg('|cffebb608【系统】|cff00ff00本局已达兑换上限',5)
        return 
    end
    if min_allattr > self.all_attr then 
        p.dh_sqlp = p.dh_sqlp + 1
        hero:add_item('神奇的令牌')
        hero:add('全属性',-self.all_attr)
        p:sendMsg('|cffebb608【系统】|cff00ff00恭喜兑换成功',5)
    else
        p:sendMsg('|cffebb608【系统】|cffff0000兑换条件不足',5)
    end
end

ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪1' then
        return
    end    
    if index == 10 then 
        --可能异步
        for handle,shop in pairs(ac.shop.unit_list) do 
            if shop.name == '庄周' then 
                shop:add_sell_item('兑换-神奇的令牌',9)
            end
        end
    end

end)
