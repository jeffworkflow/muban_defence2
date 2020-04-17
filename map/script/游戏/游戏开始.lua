-- 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
ac.game:event '游戏-开始' (function()
    print('游戏开始1')

    --每个玩家初始化金币
    for i=1 ,12 do 
        local p = ac.player(i)
        if p.hero then 

        end    
    end    

    --设置隐藏玩法 五号熔炼石
    local rect = ac.rect.j_rect('ronglian107')
    local reg = ac.region.create(rect)
    local target_rect = ac.rect.j_rect('ronglian101')
    ac.effect_ex{
        model = [[void1.mdx]],
        point = rect:get_point(),
        size = 0.8
    }
    reg:event '区域-进入' (function(trg,unit)
        --传送到另一个地方
        unit:blink(target_rect,true,false,true)
    end)


    --难五 添加伏地魔 和斗神
    if ac.g_game_degree_attr >= 5 then 
        for key,unit in pairs(ac.shop.unit_list) do 
            if unit:get_name() == '新手任务' then 
                unit:add_sell_item('伏地魔',3)
            end	
            if unit:get_name() == '境界突破'  then 
                unit:add_sell_item('境界-斗神',11)
            end	
            if unit:get_name() == '护天神甲'  then 
                unit:add_sell_item('神甲-皇龙阴阳甲',11)
            end	
            if unit:get_name() == '神兵利器'  then 
                unit:add_sell_item('神兵-九幽白蛇剑',11)
            end	
        end	
        --创建 超级异火
        local x,y = ac.rect.j_rect('npc10'):get_point():get()
        local shop = ac.shop.create('超级异火',x,y,270,nil)  
        --创建 超越极限
        local x,y = ac.rect.j_rect('cyjx'):get_point():get()
        local shop = ac.shop.create('超越极限',x,y,270,nil)  
        
        --百鸟朝凤相关
        local time = 8 * 60
        -- local time = 30
        for i=1,8 do 
            ac.wait(i*time*1000,function()
                local u = ac.player(16):create_unit('鸟',ac.rect.j_rect('bncf'..i))
                local angle = ac.rect.j_rect('bncf'..i):get_point() / ac.rect.j_rect('bncf9'):get_point()
                u:add_restriction '无敌'
                u:add_restriction '定身'
                u:set_facing(angle)
            end)
        end    

    end    

end)    


