
local mt = ac.skill['黑暗骰子']
mt{
--等久
level = 1,
--图标
art = [[anheishaizi.blp]],
--说明
tip = [[


我命由天不由我，请小心使用，以免gg

|cffffe799每点摇骰子熟练度|r 奖励 |cff00ff00每秒加攻击+0.2
|cffcccccc（属性|cffff0000永久存档|cffcccccc，上限受地图等级影响）]],
--品质
-- color = '紫',
--物品类型
item_type = '消耗品',
rate =3,
specail_model = [[OrbofDarkness.mdx]],
model_size = 1.15,

--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()

    self:add_content()

end   

function mt:add_content()

    local hero = self.owner
    local player = self.owner:get_owner()
    local p = self.owner:get_owner()
    hero = player.hero 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['黑暗骰子']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    -- print('黑暗骰子奖励掉落：',rand_name)
    if not rand_name then 
        return true
    end  
    ac.game:event_notify('触发黑暗骰子事件',self,self.owner) --发布事件回调
    --摇骰子熟练度
    player:Map_AddServerValue('sldytz',1) --网易服务器
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,奖励 |cffff0000'..rand_name..'|r',2)
    end  
    
    p.flag_hatz = p.flag_hatz or {} 
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        if finds(k,'熔炼石')  then
            if not p.flag_hatz[k] then  
                for i=1,tonumber(v) do 
                    it = self.owner:add_item(k,true)
                end 
                p.flag_hatz[k] = true
                tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cffff0000'..(it.color_name or it.name)..'|r',2)
            else
                print('重新再随机一次',self.name,k)
                self:add_content()
                return
            end
        else
            it = ac.item.create_item(k)
            it:set_item_count((tonumber(v) or 1))
            if it.owner_ship then
                it.owner_ship = p
            end
            it = self.owner:add_item(it,true) 
            tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cffff0000'..(it.color_name or it.name)..'|r',2)
        end
    end 

    if rand_name == '无' then
        player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生 |cffffff00(摇骰子熟练度+1，当前摇骰子熟练度 '..player.server['摇骰子熟练度']..'|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif  finds(rand_name,'天阶','地阶','玄阶','黄阶') then
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = ac.item.add_skill_item(name,self.owner)
        local color = it and it.color 
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',2)
    elseif  rand_name == '魔丸' then
        self.owner:add_rec_ex(10000)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cffff0000'..rand_name..'+10000|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(3500)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,骰子摇身一变,原来是 |cffff0000'..rand_name..'+3500|r',2) 
    elseif finds(rand_name,'一笔巨款') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150w，杀敌数+5000、木头+10000、魔丸+25000',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150w，杀敌数+5000、木头+10000、魔丸+25000',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150w，杀敌数+5000、木头+10000、魔丸+25000',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end   
    elseif finds(rand_name,'玄远之学') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300w，技能冷却+10%， 触发概率加成+10%， 翻倍概率似乎得到了提高',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300w，技能冷却+10%， 触发概率加成+10%， 翻倍概率似乎得到了提高',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300w，技能冷却+10%， 触发概率加成+10%， 翻倍概率似乎得到了提高',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end 

    elseif finds(rand_name,'三冬暖') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600w，免伤几率+10%， 每秒回血+10%， 凉凉时返还5%资源',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600w，免伤几率+10%， 每秒回血+10%， 凉凉时返还5%资源',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600w，免伤几率+10%， 每秒回血+10%， 凉凉时返还5%资源',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end 
    elseif finds(rand_name,'源源不断的本钱') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200w，每秒加杀敌数+10，每秒加木头+50，每秒加魔丸+100，每秒加全属性+10w',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200w，每秒加杀敌数+10，每秒加木头+50，每秒加魔丸+100，每秒加全属性+10w',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200w，每秒加杀敌数+10，每秒加木头+50，每秒加魔丸+100，每秒加全属性+10w',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end 
    elseif finds(rand_name,'骰子王') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff00001800万全属性，杀敌数加成+75%， 木头加成+75%， 物品获取率+75%， 魔丸加成+75%|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff00001800万全属性，杀敌数加成+75%， 木头加成+75%， 物品获取率+75%， 魔丸加成+75%|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff00001800万全属性，杀敌数加成+75%， 木头加成+75%， 物品获取率+75%， 魔丸加成+75%|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end 

    elseif finds(rand_name,'du神') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'罪恶城堡',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+24000000，会心几率+5%， 会心伤害+50%， 多重暴击几率+5%， 多重暴击+1',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+24000000，会心几率+5%， 会心伤害+50%， 多重暴击几率+5%， 多重暴击+1',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+24000000，会心几率+5%， 会心伤害+50%， 多重暴击几率+5%， 多重暴击+1',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去,什么事情都没有发生|r',2)
        end 

    


        --'玄远之学','三冬暖','源不断的本钱'
    -- elseif rand_name == '骰子王' then
    --     local skl = hero:find_skill(rand_name,nil,true)
    --     if not skl  then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
    --         player.is_show_nickname = rand_name
    --         --给全部玩家发送消息
    --         ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000【彩蛋】'..rand_name..' |r 奖励 |cffff00001000万全属性，物品获取率+50%|r',6)
    --     else
    --         player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 将|cff00ff00'..self.name..'|r摇了下去, 什么事情都没有发生 |cffffff00(摇骰子熟练度+1，当前摇骰子熟练度 '..player.server['摇骰子熟练度']..'|r',2)
    --     end    

    elseif rand_name == 'du徒' then
        if not p.flag_yccj then 
            p.flag_yccj = {} 
        end    
        if p.flag_yccj[rand_name] then 
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(摇骰子熟练度+1，当前摇骰子熟练度 '..player.server['摇骰子熟练度']..' )|r',2)
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
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
            else 
                skl:upgrade(1)  
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r将|cff00ff00'..self.name..'|r摇了下去, |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
            end   
        else 
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(摇骰子熟练度+1，当前摇骰子熟练度 '..player.server['摇骰子熟练度']..' )|r',2)
        end   
    end   
end
