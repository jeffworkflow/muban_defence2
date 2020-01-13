--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['强化石']
mt{
--等久
level = 1,
max_level =9,
--售价
gold = 5000,
--图标
art = [[qianghuashi.blp]],
--类型
item_type = "消耗品",
--模型
specail_model = [[EmeraldCore_blue.mdx]],
model_size = 0.7,
--品质
color = "紫",
--冷却
cool = 0,
--描述
tip = [[ 

|cff00ff00可对装备进行一次强化，最高强化至10级！
]],

--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true,

}

--概率
local rate ={100,100,100,100,80,80,55,55,45}
--强化属性百分比
local strong_attr ={2.5,5,7.5,10,15,20,25,30,35}

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
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红')  and item.level < (item.qh_max_level or 999) then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code[item.color or '白']..'强化 '.. item:get_name() .. '|r  (第' .. item.slot_id .. '格)',
                item = item
            }
            table.insert(list,info)
            
        end
    end 
    if count < 1 then 
        player:sendMsg('|cffffe799【系统消息】|r英雄物品栏没有可强化的装备',4)
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name,true)
        end     
        return 
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'强化装备',list,function (index)
            self.dialog = nil
            local item = list[index].item
            if item then 
                if item.level<10 then 
                    if math.random(10000)/100 <= rate[item.level] then 
                        --改变属性
                        local lni_data = ac.table.ItemData[item.name]
                        if not lni_data then print('没有取到数据') return end 
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
                        player:sendMsg('|cffffe799强化成功:|r '..item.color_name..' |cffffff00+'..item.level -1 ..'|r ')
                    else 
                        player:sendMsg('|cffff0000强化失败:|r '..item.color_name)
                    end    

                    if self._count > 0 then  
                        ac.game:event_notify('触发锻造事件',self,hero,item) --发布事件回调
                        self:on_cast_start()
                        self:add_item_count(-1)
                    end  
                else 
                    player:sendMsg(item.color_name..'|cffffe799【系统消息】|cff00ff00当前物品超过10级，请使用|cffffff00 天谕 |cff00ff00继续升级|r',4)
                    if self._count > 1 then 
                        -- print('数量')
                        self:set_item_count(self._count+1)
                    else
                        --重新添加给英雄
                        unit:add_item(name,true)
                    end  
                end    

            else
                -- print('取消更换技能')
                if self._count > 1 then 
                    -- print('数量')
                    self:set_item_count(self._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name,true)
                end        
            end
            
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end

local function insert_book(hero,name)
    local p = hero.owner
    local skl = hero:find_skill(name,nil,true)
    if not skl  then 
        ac.game:event_notify('技能-插入魔法书',hero,'剑冢',name)
        ac.player.self:sendMsg('系统消息：获得'..name,2)
    end 
end 
local temp = {
    ['锻造学徒'] =50,
    ['锻造师傅'] =100,
    ['锻造匠人'] =200,
    ['锻造宗师'] =300,
    ['鬼斧神工'] =400,
}  
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
        end
    end 
    
    ---处理 触发事件 
    local rand_list = ac.unit_reward['装备升级']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    print('装备升级掉落：',rand_name,_item,_item.name)
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2)
    end  
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        for i=1,tonumber(v) do 
            it = hero:add_item(it_name,true)
        end  
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..it.color_name or it_name..'|r',2)
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
    elseif rand_name == '复制装备' then
        local it = self.owner:add_item(_item.name,true)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..it.color_name or _item.name,2)
    elseif rand_name == '真·复制装备' then
        local it = ac.dummy:add_item(_item.name,true)
        it:upgrade(_item.level-1)
        ac.wait(10,function()
            ac.dummy:remove_item(it)
            self.owner:add_item(it,true)
            tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..it.color_name or _item.name,2)  
        end)
    end   





end)





