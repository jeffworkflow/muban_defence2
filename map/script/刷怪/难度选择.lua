
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
    --普通难度选择
    local function common_degree(player,list) 
        t_create_dialog(player,"选择难度",list,1,function (index,page)  
            ac.g_game_degree = index + (page-1) * 10
            ac.g_game_degree_attr = index + (page-1) * 10
            ac.g_game_degree_name = list[ac.g_game_degree].name  
            --创建预设英雄
            ac.choose_hero()
            --游戏-开始
            ac.wait(30*1000,function()
                ac.game:event_notify('游戏-开始')
            end)
            ac.player.self:sendMsg("选择了 |cffffff00"..list[ac.g_game_degree].name.."|r")
            ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree_attr)
            
            print("选择了 |cffffff00"..list[ac.g_game_degree].name.."|r")

            if ac.g_game_degree_attr >= 12 then
                ac.player.self:sendMsg("|cffebb608【新的征程】|r|cff00ff00无限难度，当前难度通关后，即可开启下一个征程的挑战！")
                ac.player.self:sendMsg("|cffebb608【新的征程】|r|cff00ff00每往前通关|cffffff00五个难度|cff00ff00，可激活一个强大的可存档成就，成就属性可在最强魔灵-新的征程中查看")
                ac.player.self:sendMsg("|cffebb608【新的征程】|r|cff00ff00按 |cffffff00F6 |cff00ff00可查看，新的征程 通关排行榜")
            end
        end)
    end

    --贪婪魔窟选择
    local function cave_degree(player,list) 
        t_create_dialog(player,"选择难度",list,1,function (index,page)  
            ac.g_game_degree = index + (page-1) * 10
            ac.g_game_degree_attr = list[ac.g_game_degree].attr
            ac.g_game_degree_name = '贪婪魔窟-'..list[ac.g_game_degree].name  
            --创建预设英雄
            ac.choose_hero()
            --游戏-开始
            ac.wait(30*1000,function()
                ac.game:event_notify('游戏-开始')
            end)
            ac.player.self:sendMsg("选择了 |cffffff00"..ac.g_game_degree_name.."|r")
            ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree_attr)

            ac.player.self:sendMsg("|cffebb608【开启条件】|r|cff00ff00通关堡垒/万古流芳/超绝群伦后开启！|cff00ffff（对应贪婪魔窟的普通/噩梦/地狱模式）")
            ac.player.self:sendMsg("|cffebb608【模式介绍】|r|cff00ff00通关后可进入|cffffff00贪婪魔窟|cff00ff00，获取大量的|cffff0000可存档装备！")

            
            print("选择了 |cffffff00"..ac.g_game_degree_name.."|r")
        end)
    end

    --魔灵争霸选择
    local function moling_degree(player,list) 
        ac.g_game_degree = 2
        ac.g_game_degree_name = list.name
        ac.g_game_degree_attr = list.attr
        --发起投票
        ac.game.start_vote()
        ac.game:event '投票结束'(function(_,flag)
            --创建预设英雄
            ac.choose_hero()
            --游戏-开始
            ac.wait(30*1000,function()
                ac.game:event_notify('游戏-开始')
            end)
            ac.player.self:sendMsg("选择了 |cffffff00"..ac.g_game_degree_name.."|r")
            ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree_attr)

            ac.player.self:sendMsg("|cffebb608【开启条件】|r|cff00ff00通关士兵后开启！")
            ac.player.self:sendMsg("|cffebb608【模式介绍】|r|cff00ff00每间隔12分钟，玩家会开始PK，胜利者将获得丰厚的奖励！")
        end)
    end

    local function create_choose_dialog()
        local player = get_first_player()
        if not player then 
            return
        end
        ac.player.self:sendMsg("正在选择 |cffffff00难度|r")

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
        local list3 = {}
        local show_list = {}
        local bit = player.server['无限难度'] or 0
        -- print(player.server['无限难度'],bit)
        local max_degree = bit + 1
        for i=1,max_degree do 
            if list[i] then 
                table.insert(list3,list[i] )
            else
                local name = '新的征程('..formatNumber(i-11)..')'
                table.insert(list3,{name = name} )
            end    
        end    
        ac.g_game_degree_list = {} 
        for i = #list3 ,1 ,-1 do 
            local name = list3[i].name  
            table.insert(ac.g_game_degree_list,name)  
        end  

        --根据无限难度 开发对应模式
        local list4 = {}
        if bit >= 1 then 
            table.insert(show_list,{name = '段位挑战'})
            table.insert(show_list,{name = '魔灵争霸',attr = 1})
        end
        if bit >= 4 then 
            table.insert(show_list,{name = '贪婪魔窟'})
            table.insert(list4,{name = '普通',attr = 5}) 
        end
        if bit >= 8 then 
            table.insert(list4,{name = '噩梦',attr = 9}) 
        end
        if bit >= 11 then 
            table.insert(list4,{name = '地狱',attr = 12}) 
        end
        
        for i = #list4 ,1 ,-1 do 
            local name = list4[i].name  
            table.insert(ac.g_game_degree_list,'贪婪魔窟-'..name)  
        end  

        if #show_list >0 then 
            t_create_dialog(player,"选择难度",show_list,1,function (index,page)  
                if index == 1 then 
                    common_degree(player,list3) 
                elseif index == 2 then 
                    moling_degree(player,show_list[2])
                else
                    cave_degree(player,list4) 
                end
            end)
        else 
            common_degree(player,list3) 
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
        -- if global_test then 
        --     time = 20
        -- end    
        ac.player.self:sendMsg("|cffebb608【系统】|cff00ff00"..time .. "秒后，怪物开始第1波进攻",10)
        ac.timer_ex 
        {
            time = time,
            title = "距离第1波怪物进攻",
            func = function ()
                --开始刷怪
                print('开始刷兵啦')
                for i=1 ,3 do 
                    local creep = ac.creep['刷怪'..i] 
                    if type(creep) == 'table' then 
                        creep:start()
                        creep:attack_hero() 
                    end
                    -- creep:attack_hero() 
                end 
            end,
        }
    end)
 
end);