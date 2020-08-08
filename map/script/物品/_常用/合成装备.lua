--按照装备品阶 筛选出 lni 装备。
--quality_item={'白' = {'新手剑','新手戒指'},'蓝' = {..}}
local quality_item ={}
local all_item ={}
local equipment ={}
local consumable_item ={}

local save_item ={}
local all_save_item ={}

for name,data in pairs(ac.table.ItemData) do 
    local color = data.color 
    if color and data.category ~= '存档' then 
        local list = quality_item[color] or {}
        quality_item[color] = list 
        table.insert(list,name)
        if finds(color,'白','蓝','金','红') then 
            table.insert(all_item,name)
        end   
        
        if finds(color,'白','蓝','金','红','黑','神') then 
            if data.item_type =='装备' then
                table.insert(equipment,name)
            end    
            if data.item_type =='消耗品' then
                table.insert(consumable_item,name)
            end      
        end
    end 

    if color and data.category == '存档' then 
        if not save_item[data.lv] then 
            save_item[data.lv] = {}
        end    
        if not save_item[data.lv][color] then 
            save_item[data.lv][color]  = {}
        end
        table.insert(save_item[data.lv][color],name)

        if all_save_item[tonumber(data.s_id)] then 
            print('重复存档物品id',data.s_id,data.name)
        else    
            all_save_item[tonumber(data.s_id)] = name
        end    
        
    end    
end 
ac.wait(10,function()   

    --将 品质技能 插入到 品质物品表里
    for color,data in pairs(ac.quality_skill) do
        quality_item[color] = data 
    end   
    --排序
    for color,list in pairs(quality_item) do 
        table.sort(list,function (a,b)
            return a < b
        end)
    end 
    table.sort(all_item,function (strA,strB)
        return strA<strB
    end)

    --排序
    for lv,data in pairs(save_item) do 
        for color,list in pairs(data) do 
            table.sort(list,function (a,b)
                return a < b
            end)
        end    
    end 
    --全局
    ac.quality_item = quality_item
    ac.all_item = all_item
    ac.equipment = equipment
    ac.consumable_item = consumable_item
    ac.save_item = save_item
    ac.all_save_item = all_save_item
    
    
    -- print_r(ac.quality_item['神'])
    -- print_r(ac.save_item)
    -- print_r(ac.all_save_item)
end)




local streng_item_list = {
   
    -- {'新手剑+1','新手剑*1 新手石*1'},
    -- {'新手剑+2','新手剑+1*1 新手石*1'},
    -- -- {'灵宝剑','新手剑+2*1 新手甲*1 新手戒指*1'},
    -- {'灵宝剑','新手剑+2*1 新手剑+2*1 新手剑+2*1'},
    -- {'新手剑+1','生命药水*5 新手石*1'},
    -- {'新手剑+2','生命药水*5 魔法药水*5'},
    --合成品质 ^10 表示10%几率合成
    {'蓝^100','白*1 白*1 白*1 白*1 装备合成*1'},
    {'金^100','蓝*1 蓝*1 蓝*1 蓝*1 装备合成*1'},
    {'红^100','金*1 金*1 金*1 金*1 装备合成*1'},
    {'红^100','红*1 红*1  装备合成*1'},
    {'黑^100','黑*1 黑*1  魔神的合成*1'},
    
    
    {'玄阶^100','黄阶*1 黄阶*1 黄阶*1 功法合成*1'},
    {'地阶^100','玄阶*1 玄阶*1 玄阶*1 功法合成*1'},
    {'天阶^100','地阶*1 地阶*1 地阶*1 功法合成*1'},
    {'天阶^100','天阶*1 天阶*1 功法合成*1'},

    {'神阶^100','神阶*1 神阶*1  神魂合成*1'},

    {'真·圣龙精魄^100','圣龙精魄碎片一*1 圣龙精魄碎片二*1'},
    {'龙之血珠^100','三眼赤痕*1 火龙气息*1'},
    {'无谓因果^100','地魂融血丹*1 天魂融血丹*1'},
    
    -- {'大乘佛法^100','彩虹天堂*1 火焰雨*1 功法合成*1'},
    -- {'青','青*1 青*1 青*1 技能融合*1'},
    {'全能精通','攻击专精*1 护甲专精*1 生命专精*1'},
    {'恶魔之力','全属性精通*1 全能精通*1'},
    {'全属性精通','力量专精*1 敏捷专精*1 智力专精*1'},
}
ac.streng_item_list = streng_item_list
local check_hecheng = {
    '装备合成','神魂合成',
    '功法合成','魔神的合成',
    '圣龙精魄碎片一','圣龙精魄碎片二','三眼赤痕','火龙气息','地魂融血丹','天魂融血丹',
    '全能精通','攻击专精','护甲专精','生命专精',
    '全属性精通','力量专精','敏捷专精','智力专精',
    '恶魔之力',
}
for i,name in ipairs(check_hecheng) do 
    local mt = ac.skill[name]
    mt.check_hecheng = true
end

local function streng_item(alltable,unit,it)

    local u = unit
    local p = unit:get_owner()


    local hebing 
    local trg_it = it 
    --将当前即将获得的物品放入到表里
    --强化石的石头返回数量有点问题，需要调整下。
    local function new_item_table() 

        local unit_item_list = {}
        for i = 1,6 do

            local item = u:get_slot_item(i)

            if  item then 
                local temp_item = {}
                temp_item.name = item.name
                temp_item.value = item:get_item_count()
                temp_item.is_finded = false 

                if  item.name == trg_it.name and trg_it.item_type == '消耗品' then
                    temp_item.value = temp_item.value + trg_it:get_item_count()
                    hebing =true
                end    

                table.insert(unit_item_list,temp_item)
                --处理品质装备 消耗品不能合
                local temp_item = {}
                temp_item.name = item.color 
                temp_item.item_name = item.name
                temp_item.value = item:get_item_count()
                temp_item.is_finded = false 
                table.insert(unit_item_list,temp_item)

            end   
        end    

        if not hebing then
            local temp_item = {}
            temp_item.name = trg_it.name
            temp_item.value = trg_it:get_item_count()
            temp_item.is_finded = false 

            table.insert(unit_item_list,temp_item)
            --处理品质装备
            local temp_item = {}
            temp_item.name = trg_it.color 
            temp_item.item_name = trg_it.name
            temp_item.value = trg_it:get_item_count()
            temp_item.is_finded = false 
            table.insert(unit_item_list,temp_item)
        end     
        return unit_item_list
    end    

    --string ,返回的是 该装备数量,is_finded true 找已经找过的，false 找没有找过的
    local function find_item (table,it_name,is_finded)  

        local stack 
        -- print(table[i]['is_finded'])
        for i=1,#table do
            if table[i]['name'] == it_name and table[i]['is_finded'] == is_finded  then 
                stack = table[i]['value']
                table[i]['is_finded'] = true 
                if table[i].item_name then 
                    find_item(table,table[i].item_name,false)
                end    
                break
            end    
        end   
        return stack
    end  
    local function print_item (table)  
        local pt = ''
        for i=1,#table do
            if table[i]['name'] and table[i]['name'] ~='白' then
                pt = pt ..table[i]['name']  ..table[i]['value'] .. ','
            end    
        end
        print(pt)
    end    

    for _, data in ipairs(alltable) do
        local dest_str, source_str = table.unpack(data)
        local dest_rate 
        for k,v in dest_str:gmatch '(%S+)%^(%d+%s-)' do
            dest_str = k
            dest_rate = v
        end    

        local source_names = {}
        local max_cnt = 0
        for k,v in source_str:gmatch '(%S+)%*(%d+%s-)' do
            local temp_array = {} 
            temp_array[k]=v
            table.insert(source_names,temp_array)
            max_cnt = max_cnt +1
        end
        local is_streng_suc =false 
        local i = 0
   
        local is_block_trg_item
        local unit_item_list = new_item_table()   

        for ti=1,max_cnt do 
            -- print(source_names[ti])   
            for k,v in sortpairs(source_names[ti]) do
                local stack = find_item(unit_item_list,k,false)
                if not stack then
                    is_streng_suc =false 
                    -- print('合成失败，没有',k)    
                    break
                end    
                
                if stack == 0 or stack == 1 then
                    stack = 1
                end    
                -- print(k,stack,v)

                if stack >= tonumber(v) then
                    -- print('合成条件数',i,max_cnt)
                    i = i + 1 
                    if  i == max_cnt then
                        is_streng_suc = true
                    end    
                end
            end    
        end 
        -- 如果合成成功，移除材料，添加新物品
        -- 合成一次就退出，移除材料的同时，要阻止获得材料。
        -- 物品合成有问题，要先全部删掉，
        if is_streng_suc then 
            -- print('合成'..dest_str..'成功')
            -- print_item(unit_item_list)
            local del_item ={} 
            for ti=1,max_cnt do 
                for k,v in sortpairs(source_names[ti]) do
                    local u_it = u:has_item(k) 
                    
                    --不是即将获得的物品，就删掉单位身上的
                    if u_it then 
                        table.insert(del_item,u_it)
                        -- u:remove_item(u_it) modify by jeff 20190305
                        u_it:item_remove()
                    else   
                        if k == trg_it.name or k == trg_it.color  then 
                            
                            table.insert(del_item,trg_it)
                            if trg_it.handle then  
                                --删除即将获得物品
                                trg_it:item_remove() 
                                --不获得即将获得的物品 
                                is_block_trg_item = true
                            end    
                        end     
                    end    

                    if (trg_it and (trg_it.name ==k ) and trg_it.item_type =='消耗品') or (u_it and (u_it.name == k )  and  u_it.item_type =='消耗品') then
                        if trg_it.handle then 
                            table.insert(del_item,trg_it)
                            --删除即将获得物品
                            trg_it:item_remove() 
                            --不获得即将获得的物品 
                            is_block_trg_item = true
                        end    
                        --如果即将获得的物品时消耗品，先删除单位身上的物品
                        if u_it and u_it.item_type =='消耗品' then 
                            --需要再重新找一遍，看这个物品是否被删了。
                            local u_it = u:has_item(k)
                            if u_it then
                                table.insert(del_item,u_it)
                                -- u:remove_item(u_it) modify by jeff 20190305
                                u_it:item_remove()
                            end     
                        end   
                        
                        --处理消耗品材料 创建新的物品，并设置物品数量为 总数量-合成需要的数量
                        --等待0.10秒，等全部物品都删了后，再添加
                        ac.wait(0,function()
                            -- print(111,k)
                            local stack = find_item(unit_item_list,k,true)
                            if stack -  tonumber(v) > 0 then
                                local new_it 
                                if ac.table.ItemData[k] then 
                                    new_it = ac.item.create_item(k)
                                else
                                    new_it = ac.item.create_skill_item(k)
                                end  
                                new_it:set_item_count( stack -  tonumber(v))
                                print('添加材料',u.owner,u,k)
                                u:add_item(new_it,true)  
                            end  
                        end)

                    end   
                    local name
                    if (trg_it and trg_it.color == k and trg_it.item_type =='消耗品') then 
                        name = trg_it.name 
                    end

                    if (u_it and u_it.color ==k and u_it.item_type =='消耗品') then 
                        name = u_it.name 
                    end    

                    if name then
                        --处理消耗品材料 创建新的物品，并设置物品数量为 总数量-合成需要的数量
                        ac.wait(0,function()
                            local stack = find_item(unit_item_list,name,true)
                            -- print_item(unit_item_list)
                            if stack -  tonumber(v) > 0 then 
                                local new_it 
                                if ac.table.ItemData[name] then 
                                    new_it = ac.item.create_item(name)
                                else
                                    new_it = ac.item.create_skill_item(name)
                                end  
                                new_it:set_item_count( stack -  tonumber(v))
                                print('添加材料2',u.owner,u,name)
                                u:add_item(new_it,true)  
                            end  
                        end)
                    end    
                end
            end
            -- 品质装备的 取物品名字
            -- 品质技能
            if not ac.table.ItemData[dest_str] then 
                -- print('类型',type(ac.skill[dest_str])) --ac.skill['蓝'] 是个table
                if not ac.skill[dest_str].skill_type then 
                    dest_str = quality_item[dest_str][math.random(1,#quality_item[dest_str])]
                end
                local max_strong_rate = 0 
                local temp_rate 
                --处理同名装备提升合成成功概率
                for x=1,#del_item do
                    temp_rate = 0
                    for y=1,#del_item do
                        if x ~= y and del_item[x].name == del_item[y].name  then
                            temp_rate = temp_rate+1
                            if max_strong_rate<=temp_rate then
                                max_strong_rate = temp_rate
                            end 
                        end
                    end    
                end    
                if dest_rate then 
                    dest_rate = dest_rate + dest_rate * max_strong_rate
                end 
                print('提升概率：',dest_str,max_strong_rate,dest_rate)
            end    
            

            -- ac.game:event_dispatch('物品-合成成功前', dest_str,source_names,del_item) 
            -- print('最终概率',dest_rate)
            local color = '白'
            local data = ac.table.ItemData[dest_str] --正常物品
            if data then 
                color = ac.color_code[data.color or '白'] 
            else 
                --技能
                local skill_color = ac.skill[dest_str].color
                color = ac.color_code[skill_color] 
            end    

            --倒霉 人的合成概率100%
            if dest_rate and p.unlucky then 
                dest_rate = 100
            end    
            if math.random(1,100) <= (tonumber(dest_rate) or 100) then 
                p:sendMsg('|cff00ff00合成|r |cff'..color..dest_str..' |r|cff00ff00成功|r',5)
                local new_item  
                if ac.table.ItemData[dest_str] then 
                    new_item = u:add_item(dest_str,true)  
                else
                    new_item = ac.item.add_skill_item(dest_str,u)
                end  
                print('添加合成物品3',u.owner,u,dest_str)
                -- 新物品 ， 材料列表 k = 材料名 ，v =数量
                -- 回调时 需要等 合成物品成功，程序继续进行
                ac.game:event_dispatch('物品-合成成功',p,new_item,source_names,source_str) 
            else
                p:sendMsg('|cffff0000合成|r |cff'..color..dest_str..'|r |cffff0000失败|r',5)
                ac.game:event_dispatch('物品-合成失败',p,dest_str,source_names,source_str) 
            end    
              
            return is_block_trg_item 
        end    

    end    
    return is_block_trg_item
end    

ac.game:event '单位-合成装备' (function(trg, unit, it)

    --特殊处理 
    local ok = true
    if finds(it.name,'星星之火碎片','陨落心炎碎片','三千焱炎火碎片','虚无吞炎碎片','陀舍古帝碎片','无尽火域碎片') then 
        local has_item = unit:has_item(it.name) 
        local count = has_item and has_item:get_item_count() or 0
        count = count + it:get_item_count()
        if count>=100 then 
            ok = true 
        else
            ok = false
        end 
    end
    local is_block_trg_item
    if ok then  
        is_block_trg_item = streng_item(streng_item_list,unit,it)
    end
    return is_block_trg_item

    --ac.game:event_dispatch('物品-合成成功',new_item,source_names)  
    
    
end)



ac.game:event '物品-合成成功' (function(trg, player,new_item, source_names,source_str) 
    if not new_item then 
        return
    end    
    local name = new_item:get_name()
    print('物品合成成功：',player,new_item.name,source_names,source_str)
    return true 
end)



-- ac.game:event '物品-合成失败' (function(trg,player,new_item, source_names) 
--     -- print('合成失败')
--     --概率
--     local rate = 5
--     -- 概率小于等于5 且 没有倒霉人，设置为倒霉人
--     if math.random(1,100)<=rate and not ac.unlucky  then 
--         ac.unlucky = player
--         player.unlucky = true
--         player.is_show_nickname = '(衰人)'
--         local hero = player.hero
--         hero:add('力量',10000)
--         hero:add('敏捷',10000)
--         hero:add('智力',10000)
--         --设置数据统计面板显示 (在数据统计2 里面已设置好)
--         --多面板
--         ac.game.multiboard.player_init(player,player.hero)
--         --给全部玩家发送消息
--         ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff合成装备失败|r,获得唯一称号|cffff0000"衰人" |r，称号效果：|cffff0000合成装备100%成功，全属性+10000.|r',10)
--         ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r 经常|cff00ffff合成装备失败|r,获得唯一称号|cffff0000"衰人" |r，称号效果：|cffff0000合成装备100%成功，全属性+10000.|r',10)


--     end    
-- end)

