--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['强化石']
mt{
--等久
level = 1,
max_level =9,
--售价
-- gold = 5000,
--图标
art = [[qianghuashi.blp]],
--类型
item_type = "消耗品",
--模型
specail_model = [[item_gem_sapphire.mdx]],
-- specail_model = [[Athelas1.mdx]],
model_size = 0.9,
--品质
-- color = "紫",
--冷却
cool = 0,
--描述
tip = [[ 

可对装备进行一次强化，最高强化至10级！|cffdf19d0（强化成功几率和装备等级相关）

|cffffe799每点打造熟练度|r 奖励 |cff00ff00每秒加力量+0.1
|cffcccccc（属性|cffff0000永久存档|cffcccccc，上限受地图等级影响）]],

--物品技能
is_skill = true,
time_removed = 200,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true,

}
local rate ={95,85,75,65,60,55,50,45,40,65,55,45,35,25}
--概率

--强化属性百分比
-- local strong_attr ={2.5,7.5,15,25,37.5,52.5,70,90,115,145,180,220,260,300}

local strong_attr ={10,20,30,40,50,65,80,95,115,145,180,220,260,300}

function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {} 

    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑','神')  and item.level < (item.qh_max_level or 999) then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'强化 '..item.color_name  .. '|r '
            }
            table.insert(list,info)
        end
    end 
    
    peon = player.peon
    for i=1,6 do 
        local item = peon:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑','神')  and item.level < (item.qh_max_level or 999) then 
            count = count + 1
            local info = {
                tostring(item.handle),'',"|cff"..ac.color_code['淡黄']..'强化 '..item.color_name  .. '|r |cffdf19d0(宠)|r'
            }
            table.insert(list,info)
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffebb608【系统】|r英雄物品栏没有可强化的装备',4)
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name)
        end     
        return 
    end 
    local info = {
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'强化装备')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(handle)
        local item = ac.item.item_map[tonumber(handle)]
        if item then 
            if item.level<10 then 
                local rt = rate[item.level]+ player:get('强化成功概率')
                --打造熟练度
                player:Map_AddServerValue('slddz',1) --网易服务器
                if math.random(10000)/100 <= rt then 
                    --改变属性
                    local lni_data = ac.skill[item.name].v1 and ac.skill[item.name] or ac.table.ItemData[item.name] 
                    if not lni_data or type(lni_data) == 'function'  then print('没有取到数据') return end 
                    -- print('打印值：',lni_data,lni_data.name,lni_data['攻击'],ac.table.ItemData['321'] )
                    -- print_r(lni_data)
                    for key in sortpairs(ac.unit.attribute) do
                        if item[key] and lni_data[key]  then 
                            item[key] = lni_data[key] * (1+strong_attr[item.level]/100)
                        end 
                        if item[key..'%'] and lni_data[key..'%']  then 
                            item[key..'%'] = lni_data[key..'%'] * (1+strong_attr[item.level]/100)
                        end 
                    end
                    item.show_level = true
                    item.qh_max_level = 10
                    item.max_level = 15
                    item:upgrade(1)
                    item:set_name(item.name)
                    player:sendMsg('|cffebb608【系统】|r|cff00ff00强化成功|r |cffdf19d0(打造熟练度+1，当前打造熟练度 |cffffff00'..player.server['打造熟练度']..' )|r')

                    if item.level == 10 then 
                        player:sendMsg(item.color_name..'|cffebb608【系统】|cff00ff00当前物品超过10级，请使用|cffffff00 天谕 |cff00ff00继续升级|r',4)  
                    end
                    -- 物品升级为 '..item.color_name..'
                    -- |cffffff00+'..item.level -1 ..'|r 
                else 
                    player:sendMsg('|cffebb608【系统】|r|cffff0000强化失败|r |cffdf19d0(打造熟练度+1，当前打造熟练度 |cffffff00'..player.server['打造熟练度']..' )|r')
                end    
                skill.owner = unit
                ac.game:event_notify('触发锻造事件',skill,hero,item) --发布事件回调
                if skill._count > 0 then  
                    skill:on_cast_start()
                    skill:add_item_count(-1)
                end  
            else 
                player:sendMsg(item.color_name..'|cffebb608【系统】|cff00ff00当前物品超过10级，请使用|cffffff00 天谕 |cff00ff00继续升级|r',4)
                if skill._count > 1 then 
                    -- print('数量')
                    skill:set_item_count(skill._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name)
                end  
            end    

        else
            -- print('取消更换技能')
            if skill._count > 1 then 
                -- print('数量')
                skill:set_item_count(skill._count+1)
            else
                --重新添加给英雄
                unit:add_item(name)
            end        
        end 
    end

end

function mt:on_remove()
end

local function insert_book(hero,name)
    local p = hero.owner
    local player = hero.owner
    local skl = hero:find_skill(name,nil,true) 
    -- if finds(name,'鬼斧神工') then 
    --     if not skl then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',name)
    --         ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00只要功夫深，铁杵磨成针。'..p:get_name()..'获得|cffffff00【彩蛋】'..name..'|cff00ff00 属性可在圣龙气运-彩蛋中查看',2)
    --     end
    -- else
    if finds(name,'剑瞎子') then 
        if not p.flag_yccj then 
            p.flag_yccj = {} 
        end    
        if p.flag_yccj[name] then 
            return 
        end   
        p.flag_yccj[name] = true --一局只能获得一次
        --存档
        local key = ac.server.name2key(name)
        if ac.g_game_degree_attr > p:Map_GetServerValue(key) then 
            p:Map_AddServerValue(key,1)
            local skl = hero:find_skill(name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',name)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极，惊喜获得 |cffff0000【可存档成就】'..name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极，惊喜获得 |cffff0000【可存档成就】'..name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极，惊喜获得 |cffff0000【可存档成就】'..name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
            else 
                skl:upgrade(1)  
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极， |cffff0000【可存档成就】'..name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极， |cffff0000【可存档成就】'..name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r强化装备的水平已登峰造极， |cffff0000【可存档成就】'..name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
            end 
        end   
    else
        if not skl then 
            ac.game:event_notify('技能-插入魔法书',hero,'剑冢',name)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00只要功夫深，铁杵磨成针。|cff00ffff '..p:get_name()..' |cff00ff00获得成就|cffffff00'..name..'|cff00ff00 属性可在圣龙气运-踢馆-剑冢中查看',2)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00只要功夫深，铁杵磨成针。|cff00ffff '..p:get_name()..' |cff00ff00获得成就|cffffff00'..name..'|cff00ff00 属性可在圣龙气运-踢馆-剑冢中查看',2)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00只要功夫深，铁杵磨成针。|cff00ffff '..p:get_name()..' |cff00ff00获得成就|cffffff00'..name..'|cff00ff00 属性可在圣龙气运-踢馆-剑冢中查看',2)
        end
    end
 
end 
local temp = {
    ['锻造学徒'] =20,
    ['锻造师傅'] =45,
    ['锻造匠人'] =75,
    ['锻造宗师'] =110,
    ['鬼斧神工'] =150,
    -- ['鬼斧神工'] =2,
    ['剑瞎子'] =100,
    -- ['剑瞎子'] =2,
    ['天外飞仙'] =245,
}  
local function up_item(item)  
    local lni_data = ac.skill[item.name].v1 and ac.skill[item.name] or ac.table.ItemData[item.name] 
    if not lni_data or type(lni_data) == 'function'  then print('没有取到数据') return end 
    for key in sortpairs(ac.unit.attribute) do
        if item[key] and lni_data[key]  then 
            item[key] = lni_data[key] * (1+strong_attr[item.level]/100)
        end 
        if item[key..'%'] and lni_data[key..'%']  then 
            item[key..'%'] = lni_data[key..'%'] * (1+strong_attr[item.level]/100)
        end 
    end
    item.show_level = true
    item.qh_max_level = 10
    item.max_level = 15
    item:upgrade(1)
    item:set_name(item.name)
end   
ac.up_item = up_item


ac.game:event '触发锻造事件'(function(_,skill,hero,_item)
    local self = skill
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero  
    --处理成就
    player:add('锻造次数',1)

    for k,v in sortpairs(temp) do 
        if player:get('锻造次数') == v then 
            insert_book(hero,k)
            break
        end
    end 
    
    ---处理 触发事件 
    local rand_list = ac.unit_reward['装备升级']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    -- print('装备升级掉落：',rand_name,_item,_item.name)
    if not rand_name then 
        return true
    end  
    local tran_player = rand_rate < 0.3 and ac.player.self or player
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
        tran_player:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，突然发现一个 |cffff0000'..rand_name..'|r',2)
    end  
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        for i=1,tonumber(v) do 
            it = self.owner:add_item(k)
        end  
        ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，突然发现一个 |cffff0000'..(it.color_name or it.name)..'|r',2)
    end

    if rand_name == '无' then
        -- player:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，额外获得 |cffff0000打造熟练度+1，当前打造熟练度 '..player.server['打造熟练度']..'|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，突然发现一个 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif rand_name == '复制装备' then
        local it = self.owner:add_item(_item.name)
        ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，突然发现一个 '..(it.color_name or _item.name),2)
    elseif rand_name == '真·复制装备' then
        local it = ac.dummy:add_item(_item.name)
        --升级
        for i=1,(_item.level-1) do 
            up_item(it)
        end
        ac.dummy:remove_item(it)
        self.owner:add_item(it)
        -- ac.wait(10,function()
            -- local it = self.owner:add_item(_item.name)
            -- for i=1,(_item.level-1) do 
            --     up_item(it)
            -- end
            print('真复制装备：',it.level)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r的时候，突然发现一个 '..(it.color_name or _item.name),2)  
        -- end)
    end   





end)





