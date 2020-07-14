local mt = ac.skill['积分夺宝']
mt{
    --等久
    level = 1,
    --图标
    art = [[jfcj.blp]],
    --说明
    tip = [[|cffffe799【说明】：|r|cff00ff00（当前守家积分%jf%|cff00ff00）
    
|cff00ff00消耗|cffffff00100守家积分|cff00ff00进行夺宝，有几率获得|cffff0000宝物【太初威丸弹弓】
]],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    val = 100,
    jf =function()
        return ac.player.self:get('守家积分')
    end
}

--奖品
local award_list = { 
    ['积分夺宝'] =  {
        { rand = 3, name = '金'},
        { rand = 3, name = '红'},
        { rand = 3, name = '地阶'},
        { rand = 3, name = '天阶'},
        { rand = 3, name = '天谕*1'},
        { rand = 3, name = '天谕*5'},
        { rand = 3, name = '功法连升书*1'},
        { rand = 3, name = '无谓因果*1'},
        { rand = 3, name = '龙之血珠*1'},
        { rand = 3, name = '吞噬丹*1'},
        { rand = 3, name = '三眼赤痕*1'},
        { rand = 3, name = '火龙气息*1'},
        { rand = 3, name = '天魂融血丹*1'},
        { rand = 3, name = '地魂融血丹*1'},
        { rand = 3, name = '神奇的令牌*1'},
        { rand = 10, name = '随机卡片'},
        { rand = 45, name = '太初威丸弹弓*1'},
        
        { rand = 0, name = '无'},
    },
}
--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    local p =hero.owner
    hero = player.hero 
    if p:get('守家积分')>self.val then 
        p:add('守家积分',-self.val)
        self:add_content()
    else
        p:sendMsg('|cffebb608【系统】|r|cffff0000守家积分不足',3)
    end
end

function mt:add_content()
    -- print('使用了命运花')
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['积分夺宝']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    player.achievement = player.achievement or {}
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r|cff00ff00什么宝物都没有',3) 
    elseif finds(rand_name,'天谕','功法连升书','无谓因果','龙之血珠','吞噬丹','三眼赤痕','火龙气息','天魂融血丹','地魂融血丹','神奇的令牌') then
        local it
        --处理掉落物品相关
        for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
            for i=1,tonumber(v) do 
                it = hero:add_item(k,true)
            end 
        end
        p:sendMsg('|cffebb608【系统】|r|cff00ffff守家日当午，汗滴禾下土！|cff00ff00恭喜获得|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ffff守家日当午，汗滴禾下土！|cff00ff00恭喜获得|cffff0000'..(it.color_name or rand_name)..'|r',4)
    elseif  finds('地阶 天阶',rand_name) then   
        local list = ac.quality_skill[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.add_skill_item(name,hero)
        local color = it and it.color 
        p:sendMsg('|cffebb608【系统】|r|cff00ffff守家日当午，汗滴禾下土！|cff00ff00恭喜获得|cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',4)
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ffff守家日当午，汗滴禾下土！|cff00ff00恭喜获得|cffff0000'..name..'|r',4)
    elseif  rand_name == '太初威丸弹弓' then 
        local it = hero:add_item(rand_name)
        p:sendMsg('|cffebb608【系统】|r|cff00ffff守家日当午，汗滴禾下土！|cff00ff00恭喜获得|cffff0000'..it.color_name..'|r',4)
    end    

end



