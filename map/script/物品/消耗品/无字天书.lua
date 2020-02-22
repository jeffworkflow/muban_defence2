local mt = ac.skill['无字天书']
mt{
    --等久
    level = 1,
    --图标
    art = [[wuzitianshu.blp]],
    --说明
    tip = [[


无字天书上封印着一股强大的神秘气息|cffdf19d0(点击耗费10000魔丸解开封印)|r
]],
    --物品类型
    item_type = '消耗品',
    rec_ex = 10000,
    --cd
    cool = 0.5,
    --全部玩家发送信息概率
    rate = 0.3,
    --多少秒后地上物品消失
    time_removed = 100,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',

    specail_model = [[ArcaneTome.mdx]],
    model_size = 1.3, 
    
   
}
    
function mt:on_add()
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local p = hero:get_owner()
    local item = self 
    --需要先增加一个，否则消耗品点击则无条件先消耗
    if p.rec_ex >= self.rec_ex then 
        self:add_content()
        hero:add_rec_ex(-self.rec_ex)
    else 
        self:add_item_count(1) 
        p:sendMsg('魔丸不足',2)
    end    
 
end    

function mt:add_content()

    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['无字天书']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    print('无字天书掉落：',rand_name)
    if not rand_name then 
        return true
    end  
    local tran_player = rand_rate < self.rate and ac.player.self or player
    local flag
    local temp_rand_name = rand_name
    --先处理属性相关
    for k,v in string.gsub(temp_rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        --增加人物属性
        -- print(k,v)
        flag = true
        hero:add(k,v)
    end    
    --发送消息
    if flag then 
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开|cff00ff00'..self.name..'|r封印的过程中，一阵醍醐灌顶，获得  |cffff0000'..rand_name..'|r',2)
    end  
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        for i=1,tonumber(v) do 
            it = hero:add_item(k,true)
        end  
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，原来它是 |cffff0000'..it..color_name or it.name..'|r',2)
    end 

    if rand_name == '无' then
        player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，什么事情都没有发生 |cffff0000(看书积分+1，当前看书积分 '..player.server['挖宝积分']..' )|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，原来它是 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif  finds(rand_name,'天阶','地阶','玄阶','黄阶') then
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = ac.item.add_skill_item(name,self.owner)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，原来它是 |cffffff00【技能书】'..(it.color_name or name)..'|r',2)
    elseif  rand_name == '大魔丸' then
        self.owner:add_rec_ex(25000)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，原来它是 |cffff0000'..rand_name..'+25000|r',2) 
    elseif  rand_name == '大木头' then
        self.owner:add_wood(10000)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，原来它是 |cffff0000'..rand_name..'+10000|r',2) 
    elseif finds(rand_name,'七十二绝技') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏经阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 对|cff00ff00'..self.name..'|r进行解密，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+2000万，多重暴击+1，多重暴击几率+2.5%， 全伤加深+25%',6)
        else
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，什么事情都没有发生 |cffff0000(看书积分+1，当前看书积分 '..player.server['挖宝积分']..' )|r',2)
        end   
    elseif rand_name == '鉴宝大师' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 对|cff00ff00'..self.name..'|r进行解密，惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff00001000万全属性，魔丸加成+50%|r',6)
        else
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'|r的封印，什么事情都没有发生 |cffff0000(看书积分+1，当前看书积分 '..player.server['挖宝积分']..' )|r',2)
        end   
    elseif rand_name == '书呆子' then
        if not p.flag_yccj then 
            p.flag_yccj = {} 
        end    
        if p.flag_yccj[rand_name] then 
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.server['挖宝积分']..' )|r',2)
            return 
        end   
        p.flag_yccj[rand_name] = true --一局只能获得一次
        --存档
        local key = ac.server.name2key(rand_name)
        if ac.g_game_degree_attr > p:Map_GetServerValue(key) then 
            p:Map_AddServerValue(key,1)
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',rand_name)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'的封印|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..'|r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'的封印|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..'|r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 解开了|cff00ff00'..self.name..'的封印|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..'|r 属性可在最强魔灵-隐藏成就中查看',6)
            else 
                skl:upgrade(1)  
                p:sendMsg('|cffff0000【可存档成就】'..rand_name..'+1 ',2)  
            end   
        else 
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.server['挖宝积分']..' )|r',2)
        end      
    end   
end

function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    
end
