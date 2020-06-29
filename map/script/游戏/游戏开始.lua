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
        size = 0.7
    }
    reg:event '区域-进入' (function(trg,unit)
        --传送到另一个地方
        unit:blink(target_rect,true,false,true)
    end)


    --难五 添加伏地魔 和斗神
    

end)    
--新人引导
ac.wait(100,function()
    ac.effect_ex{
        model =[[AZ_TX3_2.mdx]],
        size = 1.5,
        point = ac.rect.j_rect('npc1'):get_point(),
        time = 60,
    }
    -- AZ_TX3_2.mdx

end)

