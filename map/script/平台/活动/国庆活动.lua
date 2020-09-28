
local mt = ac.skill['繁光缀天落九州']
mt{
--等久
level = 1,
--图标
art = [[yanhua.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月24日-10月9日
|cffffe799【活动说明】|r|cff00ff00盛世嘉年，普天同庆，三界上下将举行烟花盛典庆贺祖国华诞。
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
store_name = '|cffdf19d0繁光缀天落九州|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['九洲帝王'] =  {
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
        { rand = 15, name = '随机卡片'},
        { rand = 3, name = '神奇的令牌*1'},
        { rand = 10, name = '九洲帝王'},
        
        { rand = 30, name = '无'},
    },
}
--掉落在地上
local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['九洲帝王']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这暑假作业一看就是应付了事的！',3) 
    elseif  finds(rand_name,'天谕','功法连升书','无谓因果','龙之血珠','吞噬丹','三眼赤痕','火龙气息','天魂融血丹','地魂融血丹','神奇的令牌') then
        local it
        --处理掉落物品相关
        for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
            for i=1,tonumber(v) do 
                it = hero:add_item(k)
            end 
        end
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..(it.color_name or rand_name)..'|r',4)
    elseif  finds('地阶 天阶',rand_name) then   
        local list = ac.quality_skill[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.add_skill_item(name,hero)
        local color = it and it.color 
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000|cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',4)
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜迅速地完成了暑假作业！获得奖励|cffff0000'..name..'|r',4)
    elseif  rand_name == '九洲帝王' then 
        local hero = p.hero
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 完美地完成了暑假作业，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断完成暑假作业，使|cffff0000【可存档成就】'..rand_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
            end   
        else   
            --重新来一次
            give_award(hero)
        end    
    end    


end


local mt = ac.skill['七彩烟花']
mt{
--等久
level = 1,
--图标
art = [[yanhua1.blp]],
--说明
tip = [[


|cff00ff00燃放绚丽烟花，庆祖国华诞！

|cffcccccc国庆活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.5,
rate = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect = [[Fireworksred.mdx]]
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local eff = ac.effect(hero:get_point(),self.effect,0,1.5,'overhead',350):remove()
    give_award(hero)

end   



--获得事件
local unit_reward = { 
    ['城堡守卫'] =  {
        { rand = 0.1,     name = '七彩烟花'},
    },
}
ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'城堡守卫') then 
        return
    end    
    local p = killer:get_owner()
    local rand_name = ac.get_reward_name(unit_reward['城堡守卫'])  
    if not rand_name then 
        return 
    end   

    if not p.max_item_fall then 
        p.max_item_fall = {}
    end
    p.max_item_fall[rand_name] = (p.max_item_fall[rand_name] or 0) + 1
    --获得最多次数
    local max_cnt = 20   
    if p.max_item_fall[rand_name] <= max_cnt then 
        ac.item.create_item(rand_name,unit:get_point())
    end    

end)