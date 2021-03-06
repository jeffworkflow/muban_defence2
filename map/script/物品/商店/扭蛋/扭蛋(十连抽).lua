local mt = ac.skill['扭蛋(十连抽)']

mt{
    --等久
    level = 1,
    --图标
    art = [[cjnd.blp]],
    --说明
    tip = [[|cffffe799【说明】：|r
    
|cff00ff00扭扭更健康，虽然50%几率是空蛋|r
]],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    --售价
    wood = 680,
    --兑换材料
    raffle = '扭蛋券(十连抽)*1',
    --物品技能
    is_skill = true,
    --全部玩家发送信息概率
    rate = 1,
    --商店名词缀
    store_affix = '',
}

--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    for i=1,10 do 
        self:add_content()
    end    
end

function mt:add_content()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['扭蛋']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end  
    local flag
    local temp_rand_name = rand_name
    --先处理属性相关
    for k,v in string.gsub(temp_rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        --增加人物属性
        -- print(k,v)
        flag = true
        hero:add(k,v)
    end  
    local tran_player = rand_rate < self.rate and ac.player.self or player
    --发送消息
    if flag then 
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    end    
    
    --再处理特殊的 
    if rand_name == '空蛋' then
        player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
    elseif finds(rand_name,'强化石','天谕') then
        -- self.owner:add_item(rand_name)
        local it = add_item(self.owner,rand_name)
        if tran_player then 
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
        end
    elseif rand_name == '红色小水滴' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋1',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+500w，护甲+5000，吸血+10%，攻击回血+50W|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif rand_name == '黄金罗盘' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            --给藏宝图10张，挖宝熟练度100点
            for i=1,10 do
                local it = add_item(self.owner,'藏宝图')
            end    
            -- player:AddServerValue('wbjf',100) 自定义服务器
            player:Map_AddServerValue('sldwb',100) --网易服务器
            --自动寻宝
            hero.wabao_auto = true 

            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋1',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000藏宝图10张，挖宝熟练度100点，特殊技能：自动寻宝（点击藏宝图试试）|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end  
    elseif rand_name == '发光的草药' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋1',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+500W，种树熟练度100点，特殊技能：自动种树（点击神奇的种子试试）|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end  
    elseif rand_name == '奇美拉的头颅' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋1',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+500w，分裂伤害+50%，攻击速度+50%|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif rand_name == '倒霉蛋' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000时来运转!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得成就 |cffff0000"'..rand_name..'" |r，奖励 |cffff0000木头+16888，魔丸+16888，杀敌数+16888|r',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000时来运转!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得成就 |cffff0000"'..rand_name..'" |r，奖励 |cffff0000木头+16888，魔丸+16888，杀敌数+16888|r',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000时来运转!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得成就 |cffff0000"'..rand_name..'" |r，奖励 |cffff0000木头+16888，魔丸+16888，杀敌数+16888|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local rand_list = ac.unit_reward['商店随机物品']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.quality_item[rand_name] 
        local name = list[math.random(#list)]
        --满时，掉在地上
        -- self.owner:add_item(name)
        local it = add_item(self.owner,name)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif  rand_name == '随机技能' then
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        -- local it = ac.item.add_skill_item(name,self.owner)
        local it = add_item(self.owner,name,true)
        local color = it and it.color 
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',2)
    elseif  finds(rand_name,'技能升级书') then
        local it = add_item(self.owner,rand_name)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif finds(rand_name,'熔炼石') then
        player.flag = player.flag or {}
        if player.flag[rand_name] then 
            self:add_content() --已挖到再随机一次
            return
        end
        player.flag[rand_name] = true
        -- self.owner:add_item(rand_name)
        local it = add_item(self.owner,rand_name)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif rand_name == '吞噬丹' then
        -- self.owner:add_item(rand_name)
        local it = add_item(self.owner,rand_name)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif  rand_name == '宠物经验书(小)' then
        -- self.owner:add_item(rand_name)
        local it = add_item(self.owner,rand_name)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif finds(rand_name,'神兵','神甲') then
        local rand_list = ac.magic_item[rand_name]
        --添加给英雄
        local name = rand_list[math.random(1,5)]
        local skl = hero:find_skill(name,nil,true)
        --已激活，再扭一次
        if skl and skl.level >= 1 then 
            
            self:add_content()
        else 
            local it = add_item(self.owner,name)
            tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..name..'|r',2) 
        end     
    elseif  rand_name == '魔丸' then
        self.owner:add_rec_ex(500)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r 获得了 |cffff0000'..rand_name..'+500|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(68)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r 获得了 |cffff0000'..rand_name..'+68|r',2) 
    elseif  rand_name == '矮人的火枪' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋1',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000时来运转!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得成就 |cffff0000"'..rand_name..'" |r，奖励 |cffff0000+500w全属性 +50攻击距离 +35攻击减甲|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    end

end

function mt:on_remove()
   
end
