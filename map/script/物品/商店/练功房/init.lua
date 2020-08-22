


require '物品.商店.练功房.练功师'

require '物品.商店.练功房.夭夭'
require '物品.商店.练功房.真·神魂修炼'
require '物品.商店.练功房.神魂合成'
require '物品.商店.练功房.小仙女'
require '物品.商店.练功房.真小仙女'
require '物品.商店.练功房.爱我你就爆了我'
require '物品.商店.练功房.武学功法'
require '物品.商店.练功房.一键修炼'
require '物品.商店.练功房.十连换'

-- require '物品.商店.练功房.魔鬼的交易'
--注册魔兽事件 区域不可其他进入
for i =1 ,6 do 
    local p = ac.player(i)
    if p:is_player() then
        local ret = ac.rect.j_rect('lgfbh'..p.id)
        local region = ac.region.create(ret)
        region.owner = p
        -- p.tt_region = region
        region:event '区域-进入' (function(trg, hero, self)
            -- print('区域进入',hero:get_name(),hero:get_point(),self.owner,self:get())
            if region < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
                local player = hero:get_owner()
                if player ==  self.owner or  player.id>10 then 
                    if hero:is_hero() then 
                        if player.current_creep then 
                            player.current_creep:start()
                        end    
                    end    
                else
                    -- print('不可进入3',hero:get_name(),hero:get_point(),self:get()) 
                    hero:blink(ac.map.rects['主城'],true,false,true)
                    player:sendMsg('不可进入')   
                end   

                --处理第一次进入刷练功师问题。
                if p.flag_lgs then 
                    return 
                end 
                if finds(ac.g_game_degree_name,'深渊冒险') then 
                    return 
                end 
                if hero:is_hero() then 
                    local group = ac.selector()
                                :in_range(hero:get_point(),1500)
                                :allow_god()
                                :add_filter(function(dest) 
                                    return dest:get_name() == '练功师' 
                                end)
                                :get()
                    local seller = group[1]
                    local shop_item = ac.item.shop_item_map['经验怪']
                    local ok = hero:event_dispatch('单位-点击商店物品',seller,hero,shop_item)
                    if ok then 
                        p.flag_lgs = true 
                        --同时创建新人引导
                        ac.effect_ex{
                            model =[[AZ_TX3_2.mdx]],
                            size = 1.5,
                            point = ac.rect.j_rect('lgfnpc'..p.id..'3'):get_point(),
                            time = 30,
                        }
                    end
                end
            end     
        end)    
        -- region:event '区域-离开' (function(trg, hero, self)
        --     print('区域离开',hero:get_name(),self.owner) 
        -- end)    
    end   
end    

            
ac.game:event '玩家-注册英雄' (function(_, player, hero)

    hero:event '单位-死亡' (function(trg,unit,killer)
        if not finds(killer:get_name(),'魔丸','金币','木头怪','功法怪') then 
            return 
        end
        -- print(11111111111111111111111)
        ac.wait((hero.revive_time or 10) * 1000 +10,function()
            -- print('sdfsdf')
            local p = hero:get_owner()
            p.current_creep = nil  
        end)   
    end)

end)    
-- print('ces2222')