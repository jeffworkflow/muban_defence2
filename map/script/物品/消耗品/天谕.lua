--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['天谕']
mt{
--等久
level = 1,
max_level =9,
--售价
gold = 5000,
--图标
art = [[item\shou204.blp]],
--类型
item_type = "消耗品",
--模型
specail_model = [[EarthCrystal.mdx]],
--品质
color = "紫",
--冷却
cool = 0,
--描述
tip = [[ 

|cff00ff00点击可对指定物品进行一次强化！

|cffcccccc每个物品最多强化10次，无法强化黑色品质物品|r]],

--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
auto_fresh_tip = true,

}

--概率
local rate ={100,100,100,100,80,80,55,55,45,60,55,50,40,30}
--强化属性百分比
local strong_attr ={2.5,5,7.5,10,15,20,25,30,35,40,45,50,55,60}
local temp = {
    ['天谕'] = {
        { rand = 65,      name = '1'},
        { rand = 20,      name = '2'},
        { rand = 10,      name = '3'},
        { rand = 5,      name = '5'},
    }
}
local function up_item(item,player)
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
        if item and item.item_type == '装备' and finds(item.color,'白','蓝','金','红')  and item.level < (item.max_level or 999)  then 
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
                if item.level < 10 then 
                    --改变属性
                    local cnt = ac.get_reward_name(temp['天谕'])
                    cnt = tonumber(cnt)
                    cnt = (10 - item.level) > cnt and cnt or (10 - item.level)
                    -- print('提升了等级：',cnt)
                    for i = 1,cnt do
                        up_item(item,player)
                    end    
                else 
                    if math.random(10000)/100 <= rate[item.level] then 
                        --改变属性
                        up_item(item,player)
                    else 
                        player:sendMsg('|cffff0000强化失败:|r '..item.color_name)
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

