
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
                p:setCamera(ac.point(x+(self.x or 0),y+(self.y or 0)))
            end    
        end, 
    } ,
    ['杀敌数兑换'] = {
        real_kill_cnt = 500,
        on_cast_start = function(self)
            local hero = self.owner
            local p = hero:get_owner()
            local player = hero:get_owner()
            hero = p.hero
            
            local shop_item = ac.item.shop_item_map[self.name]
            if not shop_item.player_kill then 
                shop_item.player_kill ={}
            end
            -- print(shop_item.player_buy_cnt[player])
            --改变价格
            if shop_item.player_buy_cnt[player] >20 then
                shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + 50
            else
                shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + self.cre  
            end   
            if player:is_self() then 
                shop_item.real_kill_cnt = shop_item.player_kill[player]
                shop_item:set_tip(shop_item:get_tip())
            end    
            --文字提醒
            p:sendMsg('|cff00ff00兑换 '..self.name..' 成功|r',5)
        end, 
    }   

}


for name,data in pairs(ac.table.ItemData) do 
    if data.category == '商品' then 
        if data.coin == '金币' then 
            data.gold = data.coin_val
        end
        if data.coin == '木头' then 
            data.wood = data.coin_val
        end
        if data.coin == '杀敌数' then 
            data.kill_count = data.coin_val
        end
        if data.coin == '魔丸' then 
            data.rec_ex = data.coin_val
        end

        --商品名称
        local mt = ac.skill[name]
        for key,val in pairs(data) do 
            mt[key] = val
        end    
        for key,val in pairs(shop_item_detail['通用']) do 
            if not mt[key] then 
                mt[key] = val
            end    
            if key == 'store_name' then 
                mt.title = val
            end    
        end
        if data.class and shop_item_detail[data.class] then 
            for key,val in pairs(shop_item_detail[data.class]) do 
                mt[key] = val
            end    
        end    
    end

end    
