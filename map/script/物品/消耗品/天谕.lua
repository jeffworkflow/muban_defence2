--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['天谕']
mt{
--等久
level = 1,
max_level =9,
--售价
-- gold = 5000,
--图标
art = [[tianyu.blp]],
--类型
item_type = "消耗品",
--模型
specail_model = [[EmeraldCore.mdx]],
model_size = 1.1,
--品质
-- color = "紫",
--冷却
cool = 0,
--描述
tip = [[ 

|cff00ff00可对|cffffff00高等级装备（10级以上）|cff00ff00进行一次强化，最高强化至15级！

|cffcccccc如果对低等级装备（1-9级）使用，有概率获得多次强化|r]],

--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true,

}
--概率
local rate ={95,85,75,65,60,55,50,45,40,65,55,45,35,25}
--强化属性百分比
local strong_attr ={10,20,30,40,50,65,80,95,115,145,180,220,260,300}

local temp = {
    ['天谕'] = {
        { rand = 65,      name = '1'},
        { rand = 20,      name = '2'},
        { rand = 10,      name = '3'},
        { rand = 5,      name = '5'},
    }
}
local function up_item(item,player)
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
    player:sendMsg('|cffffe799【系统消息】|r|cff00ff00强化成功|r |cffdf19d0(打造熟练度+1，当前打造熟练度 |cffffff00'..player.server['打造熟练度']..' )|r')
    if item.level == item.max_level then 
        player:sendMsg('|cffffe799【系统消息】恭喜强化成功，|cff00ff00当前物品已经到达顶级|r')
    end
    -- 物品升级为 '..item.color_name..'

end    

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
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑')  and item.level < (item.max_level or 999)  then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code['淡黄']..'强化 '..item.color_name  .. '|r ',
                item = item
            }
            table.insert(list,info)
            
        end
    end 
    peon = player.peon
    for i=1,6 do 
        local item = peon:get_slot_item(i)
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红','黑')  and item.level < (item.max_level or 999) then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code['淡黄']..'强化 |cffff0000(宠)|r'..item.color_name  .. '|r ',
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
                if item.level < 10 then 
                    --改变属性
                    local cnt = ac.get_reward_name(temp['天谕'])
                    cnt = tonumber(cnt)
                    cnt = (10 - item.level) > cnt and cnt or (10 - item.level)
                    -- print('提升了等级：',cnt)
                    for i = 1,cnt do
                        up_item(item,player)
                    end    
                elseif item.level < 15 then
                    local rt = rate[item.level]+ player:get('强化成功概率')
                    if math.random(10000)/100 <= rt then 
                        --改变属性
                        up_item(item,player)
                    else 
                        player:sendMsg('|cffffe799【系统消息】|r|cffff0000强化失败|r |cffdf19d0(打造熟练度+1，当前打造熟练度 |cffffff00'..player.server['打造熟练度']..' )|r')
                    end   
                else
                    player:sendMsg('|cffffe799【系统消息】|cff00ff00当前物品已经到达顶级|r')
                    if self._count > 1 then 
                        self:set_item_count(self._count+1)
                    else
                        --重新添加给英雄
                        unit:add_item(name,true)
                    end  
                end    
                if self._count > 0 then  
                    ac.game:event_notify('触发锻造事件',self,hero,item) --发布事件回调
                    self:on_cast_start()
                    self:add_item_count(-1)
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

