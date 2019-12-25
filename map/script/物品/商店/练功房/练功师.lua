
local rect = require 'types.rect'
-- 传送 快速达到
-- 练功师
ac.pratice_man ={
    '经验怪','小金币怪','中金币怪','大金币怪','小木头怪','中木头怪','大木头怪','超大木头怪','小魔丸怪','中魔丸怪','大魔丸怪'


    -- ['经验怪'] = {'经验怪',[[ReplaceableTextures\CommandButtons\BTNTomeBrown.blp]],'\n\n|cff00ff00召唤15只经验怪，每只提供500经验|n|r'} ,
    -- ['小金币怪'] = {'小金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'\n\n|cff00ff00召唤15只小金币怪，每只提供1000金币|n|r'} ,
    -- ['中金币怪'] = {'中金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'\n\n|cff00ff00召唤15只中金币怪，每只提供3500金币|n|r'} ,
    -- ['大金币怪'] = {'大金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'\n\n|cff00ff00召唤15只大金币怪，每只提供10000金币|n|r'} ,
    -- ['小木头怪'] = {'小木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'\n\n|cff00ff00召唤15只小木头怪，每只提供2.5木头|n|r'} ,
    -- ['中木头怪'] = {'中木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'\n\n|cff00ff00召唤15只中木头怪，每只提供6木头|n|r'} ,
    -- ['大木头怪'] = {'大木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'\n\n|cff00ff00召唤15只大木头怪，每只提供15木头|n|r'} ,
    -- ['超大木头怪'] = {'超大木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'\n\n|cff00ff00召唤15只超大木头怪，每只提供30木头|n|r'} ,
    -- ['小魔丸怪'] = {'小魔丸怪',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'\n\n|cff00ff00召唤15只小魔丸怪，每只提供12魔丸|n|r'} ,
    -- ['中魔丸怪'] = {'中魔丸怪',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'\n\n|cff00ff00召唤15只中魔丸怪，每只提供40魔丸|n|r'} ,
    -- ['大魔丸怪'] = {'大魔丸怪',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'\n\n|cff00ff00召唤15只大魔丸怪，每只提供100魔丸|n|r'} ,
}

for i,key in ipairs(ac.pratice_man) do 
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
                player:event '玩家-注册英雄后'(function()
                    local name = key..i
                    local mt = ac.creep[key]{    
                        creeps_datas = key..'*'..(10 + player:get('练功房怪')),
                        cool = 0.5,
                        create_unit_cool = 0,
                        first_wait_time = 0.6, --调整切换练功怪首次出现时间
                        is_leave_region_replace = true,
                        is_region_replace = true,
                    }
                    function mt:on_change_creep(unit,lni_data)
                        --设置搜敌范围
                        unit:set_search_range(1000)

                    end  
                end)  
            end    
        end    
    end)
end    
