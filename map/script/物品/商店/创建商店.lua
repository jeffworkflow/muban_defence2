
--一开始就创建商店 需要有玩家在视野内 漂浮文字的高度才能显示出来
local function init_shop()
    local temp_tab = {}
    --创建 npc(商店)
    for key,val in pairs(ac.table.UnitData) do 
        if val.category =='商店' then
            ac.table.UnitData[key].name = key
            table.insert(temp_tab,ac.table.UnitData[key])
        end    
    end
    --排序
    table.sort(temp_tab,function(a,b)
        return a.id < b.id
    end)
    for i,data in ipairs(temp_tab) do
        --优化创建商店
        ac.wait(i*300,function()
            local where = data.where
            local name = data.name
            local face = data.face or 270
            if where then  
                for ix,str in ipairs(where) do 
                    ac.wait(i*300 + ix*200,function()
                        local id
                        local player
                        if finds(name,'夭夭','小仙女')  then
                           id = tonumber(string.sub(str,7,7))
                           player = id and ac.player(id)
                        end
                        --超级异火商店 难5才创建
                        if not finds(name,'超级异火','超越极限') then
                            local x,y = ac.rect.j_rect(str):get_point():get()
                            local shop = ac.shop.create(name,x,y,face,nil,player)  
                            -- print(shop:get_name(),name,x,y)
                        end    
                    end)  
                end    
            end
        end)
    end 
end
init_shop()
ac.max_sendmsg = 0
ac.loop(100,function()
    ac.max_sendmsg = 0
end)
ac.game:event '单位-创建商店'(function(trg,shop)
    local name = shop:get_name()
    if name == '基地' then
        shop:remove_restriction '无敌'
        -- shop:set('生命上限',5000000000000)
        -- shop:set('护甲',10000000000000)
        shop:set('生命上限',500000)
        shop:set('护甲',100)
        local function send_msg()
            --红屏提醒
            if shop:get '生命' / shop:get '生命上限' < 0.30  then
                local f1 = ac.player.self:cinematic_filter
                {   
                    file = 'xueliangguodi.blp',
                    start = {100, 100, 100, 100},
                    finish = {100, 100, 100, 0},
                    time = 5,
                }
            end
        end  
        ac.send_msg = send_msg  
        shop:event '受到伤害结束'(function(trg,damage)
            local source = damage.source
            local target = damage.target
            if ac.max_sendmsg <= 10 then 
                ac.player.self:sendMsg('|cffff0000基地受到伤害，剩余血量：'.. string.format('%.f%%',target:get('生命')/target:get('生命上限')*100),1)
                ac.player.self:sendMsg('|cffff0000基地受到伤害，剩余血量：'.. string.format('%.f%%',target:get('生命')/target:get('生命上限')*100),1)
                ac.player.self:sendMsg('|cffff0000基地受到伤害，剩余血量：'.. string.format('%.f%%',target:get('生命')/target:get('生命上限')*100),1)
                ac.max_sendmsg = ac.max_sendmsg + 3
            end
            send_msg()
        end)
    end    
    
    if name == '游戏说明' then
        shop:remove_restriction '无敌'
        shop:set('生命上限',999999999999)
        shop:set('生命恢复',999999999999)
        shop:set('护甲',999999999999)
        shop:set('魔抗',999999999999)
    end   
    
    if name == '夭夭' then
        --注册区域事件
        local x,y = shop:get_point():get()
        local minx,miny,maxx,maxy = x-32,y-32,x+32,y+32
        -- local rct =  ac.rect.j_rect(str)
        local rct = ac.rect.create(minx,miny,maxx,maxy)
        local region = ac.region.create(rct)
        region:event '区域-离开' (function(trg, hero)
            if hero:get_name() ~= '夭夭' then
                return
            end
            hero:blink(rct)
            hero:set_facing(face)
        end)    
    end 

end)
 




