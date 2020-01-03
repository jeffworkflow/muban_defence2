
--进入游戏后3秒开始刷怪
ac.wait(1200,function()
    --循环创建难度
    local function t_create_dialog(p,title,lists,page,f)
        local page =page or 1
        local min_index = (page-1)*10+1
        local max_index = (page-1)*10+10
        local list={}
        for i=min_index,max_index do 
            if lists[i] then 
                table.insert(list,lists[i])
            end    
        end   
        if #list == 10 and max_index<#lists then
            table.insert(list,{ name = "下一页" })
        end    

        create_dialog(p,title,list,function (index)  
            --11的倍数
            local next_page = page + 1
            if index == 11 then 
                t_create_dialog(p,title,lists,next_page,f)
            else
                f(index,page)
            end    
        end)    
    end    

    local function create_choose_dialog()
        local player = get_first_player()
        local list = {
            { name = "士兵" },
            { name = "骑士" },
            { name = "主教" },
            { name = "堡垒" },
            { name = "国王" },
            { name = "皇后" },
            { name = "传奇" },
            { name = "万古流芳" },
            { name = "超凡入圣" },
            { name = "冠世一绝" },
            { name = "超绝群伦" },
        }
        
        ac.g_game_degree_list = {} 
        for i = #list ,1 ,-1 do 
            local name = list[i].name  
            table.insert(ac.g_game_degree_list,name)  
        end  
        local list3 = {}
        local _,bit = math.frexp((player.cus_server['无限难度'] or 0))
        print(player.cus_server['无限难度'],_,bit)
        local max_degree = bit + 1
        for i=1,max_degree do 
            if list[i] then 
                table.insert(list3,list[i] )
            end    
        end    
        ac.player.self:sendMsg("正在选择 |cffffff00难度|r")
        if player then 
            t_create_dialog(player,"选择难度",list3,1,function (index,page)  
                ac.g_game_degree = index + (page-1) * 10
                ac.g_game_degree_attr = index + (page-1) * 10
                ac.g_game_degree_name = '无限BOSS-'..list3[ac.g_game_degree].name  
                --创建预设英雄
                ac.choose_hero()
                --游戏-开始
                ac.wait(30*1000,function()
                    ac.game:event_notify('游戏-开始')
                end)
                ac.player.self:sendMsg("选择了 |cffffff00"..list3[ac.g_game_degree].name.."|r")
                ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree)
            end)
        end 
    end  
    create_choose_dialog()  

    --每3秒提醒玩家主机在选择难度
    ac.loop(3*1000,function(t)
        if ac.g_game_degree then 
            t:remove()
        else
            ac.player.self:sendMsg("等待主机选择模式、难度")
        end
    end)
    ac.game:event '游戏-开始' (function()
        --游戏开始后 刷怪时间
        local time = 180
        if global_test then 
            time = 20
        end    
        BJDebugMsg(time .. "秒后开始第1波怪物进攻",10)
        ac.timer_ex 
        {
            time = time,
            title = "距离第1波怪物进攻",
            func = function ()
                --开始刷怪
                print('开始刷兵啦')
                for i=1 ,3 do 
                    local creep = ac.creep['刷怪'..i] 
                    creep:start()
                    -- creep:attack_hero() 
                end 
            end,
        }
    end)
 
end);