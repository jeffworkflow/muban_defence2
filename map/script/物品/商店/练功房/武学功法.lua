
local rect = require 'types.rect'
-- 传送 快速达到
-- 练功师
ac.kangfu ={
    ['黄阶练功'] = '黄阶功法怪',
    ['玄阶练功'] = '玄阶功法怪',
    ['地阶练功'] = '地阶功法怪',
    ['天阶练功'] = '天阶功法怪',
}
local temp_reward = {
    ['功法掉落'] = {
        { rand = 0.1,      name = '功法升级书'},
        { rand = 0.02,      name = '功法连升书'}
    }
}


for key,u_name in pairs(ac.kangfu) do 
    --物品名称
    local mt = ac.skill[key]
    mt{
    --等久
    level = 1,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local ret = 'lgfnpc'..p.id..'8'
        local name = key..p.id
        local cep = ac.creep[name]
        cep:set_region(ret)
        cep.owner = p
        -- ac.wait(1000,function() 
        cep:start()
        -- end)
        
    end

    ac.wait(10,function()
        for i = 1,10 do 
            local player = ac.player(i)
            if player:is_player() then 
                local skl_color = string.sub( key,1,6 )
                -- print('功法测试',skl_color)
                if not player.kangfu then 
                    player.kangfu = {}
                end  
                if not player.kangfu_cnt then 
                    player.kangfu_cnt = {}
                end      
                player:event '玩家-注册英雄后'(function()
                    local name = key..i
                    local mt = ac.creep[name]{    
                        creeps_datas = u_name..'*'..(10 + player:get('练功房怪')),
                        cool = 0.5,
                        create_unit_cool = 0,
                        first_wait_time = 0.6, --调整切换练功怪首次出现时间
                        is_leave_region_replace = true,
                        is_region_replace = true,
                    }
                    function mt:on_next()
                        self.creeps_datas = u_name..'*'..(10 + player:get('练功房怪'))
                        self:set_creeps_datas()
                    end    
                    function mt:on_change_creep(unit,lni_data)
                        --设置搜敌范围
                        unit:set_search_range(1000)
                        unit:event '单位-死亡'(function(_,unit,killer)
                            local p = killer.owner
                            local hero = p.hero
                            local per_cnt = 25
                            if not skl_color  then 
                                print('功法测试2',skl_color,unit,killer)
                            end
                            local max_cnt = math.min((p.kangfu_cnt[skl_color] or 1)*50,500)
                            p.kangfu[skl_color] = (p.kangfu[skl_color] or 0) +1

                            if p.kangfu[skl_color] % per_cnt == 0 then 
                                p:sendMsg('|cffffe799【系统消息】|r|cff00ff00当前击杀|cffffff00'..skl_color..'功法怪|cff00ff00进度 |cffffff00'..p.kangfu[skl_color]..'/'..max_cnt,5)
                            end    
                            if p.kangfu[skl_color]  == max_cnt then 
                                p:sendMsg('|cffffe799【系统消息】|r |cff'..ac.color_code[skl_color]..skl_color..'功法 |cff00ff00掉落在练功房的地板上,请尽快拾取',5)
                                local name = ac.quality_skill[skl_color][math.random(#ac.quality_skill[skl_color])]
                                -- ac.item.create_skill_item(name,unit:get_point())
                                --掉落运动 
                                ac.fall_move(name,unit:get_point(),ac.skill_model[ ac.skill[name].color or '黄阶' ],true,p)
                                p.kangfu[skl_color] = 0
                                --完成次数
                                p.kangfu_cnt[skl_color] = (p.kangfu_cnt[skl_color] or 1) +1
                            end    
                            --额外掉落 有0.05%概率掉落功法升级书，0.01%概率掉落功法连升书
                            local item_name = ac.get_reward_name(temp_reward['功法掉落'])
                            if item_name then 
                                ac.fall_move(item_name,unit:get_point())
                                -- p:sendMsg('恭喜掉落 '..item_name,5)
                            end
                        end)
                    end  
                end)  
            end    
        end    
    end)
end    
