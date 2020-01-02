
local rect = require 'types.rect'
-- 传送 快速达到
-- 练功师
ac.kangfu ={
    ['黄阶练功'] = '黄阶功法怪',
    ['玄阶练功'] = '玄阶功法怪',
    ['地阶练功'] = '地阶功法怪',
    ['天阶练功'] = '天阶功法怪',
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
        local ret = 'lgfbh'..p.id
        local name = key..p.id
        local cep = ac.creep[key]
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
                if not player.kangfu then 
                    player.kangfu = {}
                end    
                player:event '玩家-注册英雄后'(function()
                    local name = key..i
                    local mt = ac.creep[key]{    
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
                            -- local per_cnt = 50
                            -- local max_cnt = 1000
                            local per_cnt = 5
                            local max_cnt = 100
                            p.kangfu[skl_color] = (p.kangfu[skl_color] or 0) +1
                            if p.kangfu[skl_color] % per_cnt == 0 then 
                                p:sendMsg(skl_color..'怪进度 '..p.kangfu[skl_color]..'/1000',5)
                            end    
                            if p.kangfu[skl_color]  == max_cnt then 
                                p:sendMsg('【系统提示】恭喜获得黄阶功法',5)
                                local name = ac.quality_skill[skl_color][math.random(#ac.quality_skill[skl_color])]
                                ac.item.create_skill_item(name,unit:get_point())
                                p.kangfu[skl_color] = 0
                            end    
                        
                        end)
                    end  
                end)  
            end    
        end    
    end)
end    
