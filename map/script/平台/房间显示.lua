   

local function set_fj_data(player) 
    local temp = {}
    local yxj =  ac.g_game_degree_list
    for key,value in pairs(player.server) do
        for i,name in ipairs(yxj) do
            if key == name then
                if value > 0 then 
                    table.insert(temp,{key = key,value = value,index = i})
                end    
            end    
        end    
    end    
    --根据星数排序
    table.sort(temp,function (a,b)
        local flag   
        if a.index < b.index then 
            flag = true 
        end                  

		return flag
	end) 
    -- print(temp[1].key..temp[1].value..'星')
    -- for index,data in ipairs(temp) do 
    --     print(index,data.key,data.value,key_yxj)
    -- end    

    --段位
    player:Map_Stat_SetStat('DW',temp[1].key..temp[1].value..'段')
    --战斗力
    player:Map_Stat_SetStat('ZDL',(player.cus_server[temp[1].key..'战斗力'] or 0))
    --装备总评分
    player:Map_Stat_SetStat('ZBZPF',(player.pf or 0))

end    

--设置房间显示数据
ac.game:event '游戏-结束' (function(trg,flag)
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --设置房间数据
            set_fj_data(player)
        end
    end
end) 

--设置房间显示数据
ac.game:event '游戏-无尽开始'(function(trg) 
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --设置房间数据
            set_fj_data(player)
        end
    end
end)    
