--物品名称
local mt = ac.skill['扭蛋券(十连抽)']
mt{
--等久
level = 1,
--图标
art = [[cjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次|cffffff00扭蛋(十连抽)|cff00ff00的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
specail_model = [[WP4.mdx]],
model_size = 0.8,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['扭蛋券(百连抽)']
mt{
--等久
level = 1,
--图标
art = [[cjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['超级扭蛋券']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}


local mt = ac.skill['超级扭蛋券(十连抽)']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次|cffffff00超级扭蛋(十连抽)|cff00ff00的机会|r
]],
--物品类型
item_type = '消耗品',
specail_model = [[WP3.mdx]],
model_size = 1.3,
--不可点击
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['超级扭蛋券(百连抽)']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}


local function insert_book(hero,name)
    local p = hero.owner
    local skl = hero:find_skill(name,nil,true)
    if not skl  then 
        ac.game:event_notify('技能-插入魔法书',hero,'龙宫',name)
        ac.player.self:sendMsg('系统消息：获得'..name,2)
    end 
end 
local temp = {
    ['欢乐扭蛋'] =50,
    ['扭蛋高手'] =100,
    ['扭蛋天才'] =200,
    ['扭蛋大魔王'] =300,
    ['扭蛋大神'] =400,
}  

ac.game:event '单位-触发抵用券' (function(_,seller,u,__it,__u_raffle)
    if not finds(__u_raffle.name,'扭蛋券') then 
        return 
    end    
    --__it 为神符类，已经被销毁
    local self = __u_raffle
    local hero = u
    local player = u:get_owner()
    hero = player.hero  
    --处理成就
    player:add('扭蛋次数',1)

    for k,v in sortpairs(temp) do 
        if player:get('扭蛋次数') == v then 
            insert_book(hero,k)
        end
    end 
    
    ---处理 触发事件 
    local rand_list = ac.unit_reward['扭蛋券']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    print('扭蛋券奖励：',rand_name)
    if not rand_name then 
        return true
    end  
    local tran_player = rand_rate < 0.3 and ac.player.self or player
    local flag
    local temp_rand_name = rand_name
    --先处理属性相关
    for k,v in string.gsub(temp_rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        flag = true
        hero:add(k,v)
    end    
    --发送消息
    if flag then 
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2)
    end  
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        for i=1,tonumber(v) do 
            it = hero:add_item(k,true)
        end  
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..it.color_name or it.name..'|r',2)
    end

    local skl = u:find_skill(__it.name,nil,true)
    if not skl then 
        skl = u:add_skill(__it.name,'隐藏')
    end    

    if rand_name == '无' then
        player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif rand_name == '多抽一次' then
        local cnt =1 
        for i=1,cnt do 
            skl:on_cast_start()
        end
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..rand_name,2)
    elseif rand_name == '多抽十次' then
        local cnt =10 
        for i=1,cnt do 
            skl:on_cast_start()
        end
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..rand_name,2)
    elseif rand_name == '多抽百次' then
        local cnt =100 
        for i=1,cnt do 
            skl:on_cast_start()
        end
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..rand_name,2)
    end   

end)


