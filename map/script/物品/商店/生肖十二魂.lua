local mt = ac.skill['挑战鼠天瞳']
mt.unit_name = '鼠魔'
function mt:on_cast_start()
    local p=self.owner.owner
    local hero =p.hero
    local name = self.name 
    local point = ac.rect.j_rect('shengxiao2'):get_point()
    local ok
    for i=1,6 do 
        local p=ac.player(i)
        if p:is_player() then 
            if p.hero then 
                ok = p.hero:is_in_range(point,2000)
                if ok then 
                    break
                end
            end
        end
    end
    --没有人在挑战才进入
    if not ok then 
        ac.creep[name]:start()
    else
        p:sendMsg('已有人在挑战，请耐心等待',5)
        return true
    end
end



ac.wait(0,function()
    local cj = {
        ['鼠天瞳'] = '鼠灵',
    }
    
    local function save(tab)
        for i=1,6 do 
            local p = ac.player(i)
            if p:is_player() then 
                local index = tab[1]
                local rate = tab.rate
                index = 2^(index-1)
                --没有这个数据
                if not has_flag((p.server['生肖十二魂'] or 0),index) then
                    --概率
                    if math.random(100000)/1000 < rate then
                        local key = ac.server.name2key('生肖十二魂')
                        print('获得生肖十二魂2：',p,index,rate,tab[1],ac.g_game_degree_name)
                        p:Map_AddServerValue(key,index)  
                    end
                end
            end
        end
    end

    local function create_unit(name,where)
        local point = where - {math.random(360),100}
        -- print(point)
        local u = ac.player(12):create_unit(name,point)
        u:add_buff '攻击英雄' {}
        u:add_buff '无敌' {
            time = 2
        }
       
        u:event '单位-死亡'(function(_,unit,killer)
            --激活随机成就
            local list_name = cj[unit:get_name()]
            local list = ac.skill[list_name].skills
            local name = list[math.random(#list)]
            
            local list = ac.server.get_tab('生肖十二魂')[3]
            local tab = list[name]
            if tab then 
                print('生肖十二魂',name)
                save(tab)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000运气爆棚！！！恭喜获得'..name..'！|cff00ff00勋章的属性可在最强魔灵-通关难度奖励-生肖十二魂中查看！',8)
            end
            --传送回练功房
            local p = killer.owner
            if p.hero then 
                local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                p.hero:blink(point,true,false)
            end
            --save()
            -- p:sendMsg('|cffebb608【系统】|r |cff00ff00恭喜击败超级大菠萝',5)
        end)
    
        
    end
    for i,name in ipairs({'挑战鼠天瞳'}) do
        local skl = ac.skill[name]
        local mt = ac.creep[name]{    
            region = 'shengxiao2',
            creeps_datas = skl.unit_name..'*15',
            cool = 1,
            is_random = true,
            create_unit_cool = 0,
            is_leave_region_replace = true,
            is_region_replace = true,
        }
        function mt:on_change_creep(unit,lni_data)
            local crep = self
            --设置搜敌范围
			unit:set_search_range(1000)
			unit:event '单位-死亡'(function(_,unit,killer)
				local player = killer.owner
				local hero = player.hero
                crep.kill_cnt = (crep.kill_cnt or 0) + 1
                -- print('死亡数量',crep.kill_cnt)
				--2000 个数量创建大菠萝
                if crep.kill_cnt == 200 then 
                    local boss = name:sub(7,-1)
                    print('boss 名字',boss,name)
					create_unit(boss,killer:get_point())
				end 
			end)
		end 
    end

end)
-- local region = ac.region.create(ac.rect.j_rect('shengxiao2'))
-- region:event '区域-进入' (function(trg, hero, self)
--     -- print('区域进入',hero:get_name(),hero:get_point(),self.owner,self:get())
--     if region < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
--         local player = hero:get_owner()
--         if player ==  self.owner or  player.id>10 then 
--             if hero:is_hero() then 
--                 if player.current_creep then 
--                     player.current_creep:start()
--                 end    
--             end    
--         else
--             -- print('不可进入3',hero:get_name(),hero:get_point(),self:get()) 
--             hero:blink(ac.map.rects['主城'],true,false,true)
--             player:sendMsg('不可进入')   
--         end  
--     end
-- end)