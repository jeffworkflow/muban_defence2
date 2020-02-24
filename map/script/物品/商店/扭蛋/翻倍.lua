--物品名称
local mt = ac.skill['木头翻倍']
mt{
has_vale = function() 
    return ac.player.self.wood
end ,
--物品类型
item_type = '神符',
content_tip = '',
--商店名词缀
store_affix = '',
--币种
coin = '木头',
--实际概率
rate = function(self)
    return self.owner.owner:get(self.name..'概率') + 55
end 
}

local mt = ac.skill['杀敌数翻倍']
mt{
has_vale = function() 
    return ac.player.self.kill_count
end ,
--物品类型
item_type = '神符',
content_tip = '',
--商店名词缀
store_affix = '',
--币种
coin = '杀敌数',
--实际概率
rate = function(self)
    return self.owner.owner:get(self.name..'概率') + 55
end 
}

local mt = ac.skill['魔丸翻倍']
mt{
has_vale = function() 
    return ac.player.self.rec_ex
end ,
--物品类型
item_type = '神符',
content_tip = '',
--商店名词缀
store_affix = '',
--币种
coin = '杀敌数',
--实际概率
rate = function(self)
    return self.owner.owner:get(self.name..'概率') + 55
end 
}

local mt = ac.skill['魔丸翻倍']
mt{
has_vale = function() 
    return ac.player.self.rec_ex
end ,
--物品类型
item_type = '神符',
content_tip = '',
--商店名词缀
store_affix = '',
--币种
coin = '魔丸',
--实际概率
rate = function(self)
    return self.owner.owner:get(self.name..'概率') + 55
end 
}

local mt = ac.skill['全属性翻倍']
mt{
has_vale = function() 
    local hero = ac.player.self.hero
    local value =0
    if hero then 
        value = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
    end
    return value
end ,
--物品类型
item_type = '神符',
content_tip = '',
--商店名词缀
store_affix = '',
--币种
coin = '全属性', 
--实际概率
rate = function(self)
    return self.owner.owner:get(self.name..'概率') + 55
end 
}
for i,name in ipairs({'木头翻倍','杀敌数翻倍','魔丸翻倍','全属性翻倍'}) do 
    local mt = ac.skill[name]
    function mt:on_cast_start()
        ac.game:event_notify('单位-触发翻倍',self.owner,self)
    end
end

local function add_coin(hero,k,v)
    if k == '木头' then 
        hero:add_wood(v)
    elseif k == '杀敌数' then 
        hero:add_kill_count(v)
    elseif k == '魔丸' then 
        hero:add_rec_ex(v)
    elseif k == '全属性' then 
        local p = hero.owner
        hero = p.hero
        hero:add(k,v)
    end
end

ac.game:event '单位-触发翻倍'(function(_,u,skill)
    local self = skill 
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local coin_val =0
    local min_attr =0
    if self.coin == '木头' then 
        coin_val = p.wood
    elseif self.coin == '杀敌数' then 
        coin_val = p.kill_count
    elseif self.coin == '魔丸' then 
        coin_val = p.rec_ex
    elseif self.coin == '全属性' then 
        coin_val = math.min(p.hero:get('力量'),p.hero:get('敏捷'),p.hero:get('智力'))
        min_attr = 10000
    end
    if coin_val <= 10 or coin_val <= min_attr then 
        p:sendMsg('|cffFFCC00不够资源|r',5)
        return 
    end  

    local rand = math.random(100)
    local rate = self.rate
    print('翻倍概率：',rate)
    local mul = self.coin == '全属性' and 0.1 or 1 --要加的倍数
    local base_mul = self.coin == '全属性' and 0.1 or 1 --要加的倍数
    local bb_it = self.owner:has_item(self.coin..'保本卡') 
    local fb_it = self.owner:has_item(self.coin..'翻倍卡') 
    local zd_it = self.owner:has_item('炸弹卡') 
    local bzd_it = self.owner:has_item('大炸弹卡') 
    --炸弹卡 影响倍数
    if zd_it then 
        mul = mul * 3
        zd_it:add_item_count(-1)
    end    
    --大炸弹卡 影响倍数
    if bzd_it then 
        mul = mul * 7
        bzd_it:add_item_count(-1)
    end   
    --翻倍卡 影响概率
    if fb_it then 
        rate =100 
        fb_it:add_item_count(-1)
    end
    --进行决策
    if rand <= rate then 
        --翻倍： 加对应资源
        add_coin(hero,self.coin,coin_val * mul)
        if mul >=2 then 
            p:sendMsg('|cff00ff00翻 '..(mul+1)..' 倍|r',5)
        else 
            p:sendMsg('|cff00ff00翻倍|r',5)
        end
    else
        --凉凉
        if bb_it then 
            bb_it:add_item_count(-1)
            p:sendMsg('|cffff0000凉凉，但有保本卡，资源没变化|r',5)
        else 
            local return_coin = p:get('返还资源')
            local val = coin_val * base_mul * (100-return_coin)/100
            add_coin(hero,self.coin,-val)
            p:sendMsg('|cffff0000凉凉|r',5)
        end    
    end    
    
    --超级彩蛋触发
    local rate = 7.5
    local hero = p.hero
    if self.coin ~= '全属性' then 
        if coin_val >=30000 then 
            if math.random(10000)/100 <= rate then 
                local skl = hero:find_skill('一代幸运神',nil,true)
                if not skl then 
                    ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','一代幸运神')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 翻倍一时爽，一直翻倍一直爽，|r 获得成就|cffff0000 "一代幸运神" |r，奖励 |cffff00005000万全属性，+100%杀敌数加成，+100%物品获取率，+100%木头加成，+100%魔丸加成|r',6)
                end    
            end
        end  
    end


end)


