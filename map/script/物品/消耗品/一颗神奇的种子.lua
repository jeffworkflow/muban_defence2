
local mt = ac.skill['一颗神奇的种子']
mt{
--等久
level = 1,
--图标
art = [[zhongzi.blp]],
--说明
tip = [[


在地上，埋下一颗神奇的种子，数千年后可获得果实

|cffffe799每点种树熟练度|r 奖励 |cff00ff00每秒加护甲+0.003
|cffcccccc（属性|cffff0000永久存档|cffcccccc，上限受地图等级影响）]],
--品质
color = '紫',
owner_ship = true,
--物品类型
item_type = '消耗品',
specail_model = [[Objects\InventoryItems\CrystalShard\CrystalShard.mdl]],
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
--施法距离
range = 200,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
-- pulse = 0.5,
cool = 0.5,
pulse = 1,
auto_plant = function(self)
    local owner = self.owner
    local p = owner.owner
    local hero = p.hero
    return p.auto_plant
    -- return true
end
}


local function create_u(skl,hero,point)
    local p = hero.owner
    local u = ac.player(11):create_unit('一颗神奇的种子',point)
    u:set('生命上限',10)
    u:add_restriction('无敌')
    u:add_restriction('定身')
    u:add_restriction('缴械')
    --动画
    local time = 5
    u:add_buff '缩放' {
        time = time,
        origin_size = 0.1,
        target_size = 1.5,
    }
    ac.wait((time+1)*1000,function()
        --创建蟠桃
        local it = ac.item.create_item('一颗神奇的树',u:get_point())
        it.owner_ship = p
        --自动收获
        if skl.auto_plant then 
            hero:add_item(it)
        end
        --移除桃树
        u:remove()
    
    end)
end
function mt:on_cast_start(next_point)
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local point = next_point or self.target 

    -- print('创建了一颗神奇的种子',hero,next_point,self.target)
    create_u(self,hero,point)
    if self.auto_plant then 
        if self:get_item_count() > 1 then 
            hero.auto_plant_timer = ac.wait(self.pulse*1000,function(t)
                hero.auto_plant_timer = nil
                local next_point = hero:get_point() -{math.random(360),100}
                self:on_cast_start(next_point)
                self:add_item_count(-1)
            end)
            
        end
    end
end   
--注册事件
ac.game:event '单位-发布指令' (function(self, hero, order, target, player_order)
    if order == '' then
        return
    end
    if hero.auto_plant_timer then 
        print('自动种树停止：',hero, order, target, player_order)
        hero.auto_plant_timer:remove()
        hero.auto_plant_timer = nil  
    end
end)

local mt = ac.skill['一颗神奇的树']
mt{
--等久
level = 1,
--图标
art = [[bsdqw.blp]],
--说明
tip = [[
|cffcccccc国庆活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '神符',
specail_model = [[Objects\InventoryItems\Shimmerweed\Shimmerweed.mdl]],
--Objects\InventoryItems\CrystalShard\CrystalShard.mdl
model_size = 1.5,
rate =3,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
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
    local rand_list = ac.unit_reward['一颗神奇的种子']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    -- print('一颗神奇的种子掉落：',rand_name)
    if not rand_name then 
        return true
    end  
    
    ac.game:event_notify('触发一颗神奇的种子事件',self,self.owner) --发布事件回调
    --种树熟练度
    player:Map_AddServerValue('sldzs',1) --网易服务器
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cffff0000'..rand_name..'|r',2)
    end  
    p.flag_yksqdzz = p.flag_yksqdzz or {} 
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        if finds(k,'熔炼石')  then
            if not p.flag_yksqdzz[k] then  
                for i=1,tonumber(v) do 
                    it = self.owner:add_item(k,true)
                end 
                p.flag_yksqdzz[k] = true
                tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cffff0000'..(it.color_name or it.name)..'|r',2)
            else
                print('重新再随机一次',self.name,k)
                self:add_content()
                return
            end
        else
            for i=1,tonumber(v) do 
                it = self.owner:add_item(k,true)
            end 
            tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cffff0000'..(it.color_name or it.name)..'|r',2)
        end
    end 

    if rand_name == '无' then
        player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(种树熟练度+1，当前种树熟练度 '..player.server['种树熟练度']..' )|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif  finds(rand_name,'天阶','地阶','玄阶','黄阶') then
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = ac.item.add_skill_item(name,self.owner)
        local color = it and it.color 
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',2)
    elseif  rand_name == '魔丸' then
        self.owner:add_rec_ex(10000)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cffff0000'..rand_name..'+10000|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(3500)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 掉落了 |cffff0000'..rand_name..'+3500|r',2) 
        --'果实累累','辛勤的园丁','冷月葬花魂','蚂蚁森林'
    elseif finds(rand_name,'我爱养花种树') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150W，每秒加木头+10，木头加成+25%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150W，每秒加木头+10，木头加成+25%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+150W，每秒加木头+10，木头加成+25%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   
    elseif finds(rand_name,'果实累累') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300W，+5W魔丸，每秒加魔丸+25，魔丸加成+25%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300W，+5W魔丸，每秒加魔丸+25，魔丸加成+25%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+300W，+5W魔丸，每秒加魔丸+25，魔丸加成+25%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   
    elseif finds(rand_name,'辛勤的园丁') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600W，攻击速度+100%， 分裂伤害+100%，攻击减甲+100，减少周围护甲+1000',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600W，攻击速度+100%， 分裂伤害+100%，攻击减甲+100，减少周围护甲+1000',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+600W，攻击速度+100%， 分裂伤害+100%，攻击减甲+100，减少周围护甲+1000',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   
    elseif finds(rand_name,'冷月葬花魂') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200W，攻击距离+100，技暴几率+5% ，技暴伤害+100% ，攻击间隔-0.05',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200W，攻击距离+100，技暴几率+5% ，技暴伤害+100% ，攻击间隔-0.05',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1200W，攻击距离+100，技暴几率+5% ，技暴伤害+100% ，攻击间隔-0.05',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   
    elseif finds(rand_name,'蚂蚁森林') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff0000全属性+2400W，全属性+10%， 全伤加深+100%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff0000全属性+2400W，全属性+10%， 全伤加深+100%',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff0000全属性+2400W，全属性+10%， 全伤加深+100%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   
    elseif finds(rand_name,'园艺大师') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'百花宫',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff00001800万全属性，每秒回血+5%， 闪避+5%， 免伤几率+5%， 减伤+5%|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff00001800万全属性，每秒回血+5%， 闪避+5%， 免伤几率+5%， 减伤+5%|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r奖励 |cffff00001800万全属性，每秒回血+5%， 闪避+5%， 免伤几率+5%， 减伤+5%|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 )|r',2)
        end   

    -- elseif rand_name == '园艺大师' then
    --     local skl = hero:find_skill(rand_name,nil,true)
    --     if not skl  then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
    --         player.is_show_nickname = rand_name
    --         --给全部玩家发送消息
    --         ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff00001000万全属性，杀敌数加成+50%|r',6)
    --     else
    --         player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 砍掉了|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(种树熟练度+1，当前种树熟练度 '..player.server['种树熟练度']..' )|r',2)
    --     end 
    elseif rand_name == '采蘑菇的小姑娘' then
        if not p.flag_yccj then 
            p.flag_yccj = {} 
        end    
        if p.flag_yccj[rand_name] then 
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(种树熟练度+1，当前种树熟练度 '..player.server['种树熟练度']..' )|r',2)
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
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r 惊喜获得|cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r 惊喜获得|cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r 惊喜获得|cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
            else 
                skl:upgrade(1)  
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r砍掉了|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
            end   
        else 
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(种树熟练度+1，当前种树熟练度 '..player.server['种树熟练度']..' )|r',2)
        end      
    end   
end
