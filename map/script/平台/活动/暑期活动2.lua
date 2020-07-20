
local mt = ac.skill['穿山越海书风物']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[duanwu.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff006月25日-7月1日
|cffffe799【活动说明】|r|cff00ff00仲夏端午，烹鹜角黍。|cff00ffff侠士们如果获得了包粽子的材料，记得来此处进行制作，获得|cffffff00 意外的奖励
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
store_name = '|cffdf19d0穿山越海书风物|r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['真正的学霸'] =  {
        { rand = 4, name = '金'},
        { rand = 4, name = '红'},
        { rand = 4, name = '地阶'},
        { rand = 4, name = '天阶'},
        { rand = 4, name = '天谕*1'},
        { rand = 4, name = '天谕*5'},
        { rand = 4, name = '功法连升书*1'},
        { rand = 4, name = '无谓因果*1'},
        { rand = 4, name = '龙之血珠*1'},
        { rand = 4, name = '吞噬丹*1'},
        { rand = 4, name = '三眼赤痕*1'},
        { rand = 4, name = '火龙气息*1'},
        { rand = 4, name = '天魂融血丹*1'},
        { rand = 4, name = '地魂融血丹*1'},
        { rand = 4, name = '随机卡片'},
        { rand = 4, name = '神奇的令牌*1'},
        { rand = 40, name = '真正的学霸'},
        
        { rand = 32, name = '无'},
    },
}


local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['真正的学霸']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r |cff00ffff美味的粽子|cff00ff00果真名不虚传阿',3) 
    elseif  finds(rand_name,'天谕','功法连升书','无谓因果','龙之血珠','吞噬丹','三眼赤痕','火龙气息','天魂融血丹','地魂融血丹','神奇的令牌') then
        local it
        --处理掉落物品相关
        for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
            for i=1,tonumber(v) do 
                it = hero:add_item(k,true)
            end 
        end
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..(it.color_name or rand_name)..'|r',4)
    elseif  finds('地阶 天阶',rand_name) then   
        local list = ac.quality_skill[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.add_skill_item(name,hero)
        local color = it and it.color 
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',4)
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..name..'|r',4)
    elseif  rand_name == '真正的学霸' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断食用美味的粽子，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断食用美味的粽子，使|cffff0000【可存档成就】'..rand_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
            end   
        else   
            --重新来一次
            give_award(hero)
        end    
    end    


end

local mt = ac.skill['暑假作业本']
mt{
--等久
level = 1,
--图标
art = [[mljpz.blp]],
is_order = 1,
--说明
tip = [[ 
|cffffe799【制作说明】|r

|cff00ff00消耗 |cffff0000【粽叶】+【糯米】+【棕馅】 |cff00ff00制作 |cffffff00【美味的粽子】
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
store_affix = '',
store_name = '|cffdf19d0暑假作业本|r',
kill_cnt = 100,
--物品详细介绍的title
content_tip = ''
}

ac.game:event '单位-杀死单位' (function(trg, killer, target)
    local name = '暑假作业本'
    local p = killer:get_owner()
    --召唤物杀死也继承
    local hero = p.hero
    local owner
    if hero then 
        local item 
        local h_item = hero:has_item(name) 
        local p_item = p.peon:has_item(name)
        if p_item then 
            item = p_item
            owner = p.peon 
        end
        if h_item then 
            item = h_item
            owner = hero 
        end
        if not item then 
            return 
        end

        if item._count < item.kill_cnt then 
            item:add_item_count(1)
        else 
            --给红装 删物品
            item:item_remove()

            give_award(owner)
        end   
    end    
end)


local mt = ac.skill['遍尝三界清凉果']
mt{
--等久
level = 1,
--图标
art = [[mljpz.blp]],
is_order = 1,
--说明
tip = [[ 
|cffffe799【制作说明】|r

|cff00ff00消耗 |cffff0000【粽叶】+【糯米】+【棕馅】 |cff00ff00制作 |cffffff00【美味的粽子】
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
store_name = '|cffdf19d0遍尝三界清凉果|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['西瓜种子']
mt{
--等久
level = 1,
--图标
art = [[zhongzi.blp]],
--说明
tip = [[


在地上，埋下西瓜种子，数千年后可获得果实

|cffffe799每点种树熟练度|r 奖励 |cff00ff00每秒加护甲+0.003
|cffcccccc（属性|cffff0000永久存档|cffcccccc，上限受地图等级影响）]],
--品质
color = '紫',
owner_ship = true,
--物品类型
item_type = '消耗品',
specail_model = [[xigua.mdx]],
model_size = 2,
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
--施法距离
range = 200,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
-- pulse = 0.5,
cool = 0.5,
pulse = 1,
}


local function create_u(skl,hero,point)
    local p = hero.owner
    local u = ac.player(11):create_unit('西瓜',point)
    u:set('生命上限',10)
    u:add_restriction('无敌')
    u:add_restriction('定身')
    u:add_restriction('缴械')
    --动画
    local time = 5
    u:add_buff '缩放' {
        time = time,
        origin_size = 0.1,
        target_size = 1.5,
    }
    ac.wait((time+1)*1000,function()
        --创建蟠桃
        local it = ac.item.create_item('西瓜',u:get_point())
        it.owner_ship = p
        --移除桃树
        u:remove()
    
    end)
end
function mt:on_cast_start(next_point)
    local hero = self.owner 
    if not hero then 
        return 
    end 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local point = next_point or self.target 

    -- print('创建了一颗神奇的种子',hero,next_point,self.target)
    create_u(self,hero,point)
    
end   

local mt = ac.skill['西瓜']
mt{
--等久
level = 1,
--图标
art = [[bsdqw.blp]],
--说明
tip = [[
|cffcccccc国庆活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '神符',
specail_model = [[xigua.mdx]],
--Objects\InventoryItems\CrystalShard\CrystalShard.mdl
model_size = 2,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()

    self:add_content()

end   


--奖品
local award_list = { 
    ['魔灵麒麟瓜'] =  {
        {    rand = 5, name = '多重暴击+1',},
        {    rand = 5, name = '暴击伤害+800%',},
        {    rand = 5, name = '技暴伤害+400%',},
        {    rand = 5, name = '会心伤害+200%',},
        {    rand = 5, name = '物理伤害加深+400%',},
        {    rand = 5, name = '技能伤害加深+200%',},
        {    rand = 5, name = '全伤加深+100%',},
        {    rand = 5, name = '对BOSS额外伤害+100%',},
        {    rand = 5, name = '减伤+5%',},
        {    rand = 5, name = '免伤几率+5%',},
        {    rand = 5, name = '闪避+5%',},
        {    rand = 5, name = '每秒回血+5%',},

        {    rand = 70, name = '魔灵麒麟瓜',},

        {    rand = 30, name = '无',},
    },
}

function mt:add_content() 
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['魔灵麒麟瓜']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    if not rand_name then 
        return true
    end
     --处理属性相关
    for k,v in string.gsub(rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        --增加人物属性
        -- print(k,v)
        p.hero:add(k,v)
        ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断食用美味的粽子，惊喜获得|cffff0000'..rand_name..'|r',6) 
    end  

    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r |cff00ffff美味的粽子|cff00ff00果真名不虚传阿',3) 
    elseif  rand_name == '魔灵麒麟瓜' then 
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断食用美味的粽子，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断食用美味的粽子，使|cffff0000【可存档成就】'..rand_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
            end   
        else   
            --重新来一次
            give_award(hero)
        end    
    end    


end



--额外获得
ac.game:event '触发羊皮无字事件'(function(trg,skill,hero)
    local p = hero.owner
    local rate = 5 
    local max_cnt = 15
    if math.random(100000)/1000 <= rate and  (p.max_sqzyb_cnt or 0) < max_cnt then 
        hero:add_item('暑假作业本')
        p.max_sqzyb_cnt = (p.max_sqzyb_cnt or 0) +1
        p:sendMsg('恭喜获得 暑假作业本',5)
    end
end)


ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(unit:get_name(),'百花宫宫女') then 
        return
    end    
    local p = killer:get_owner()
    if not p.max_fall_cnt then 
        p.max_fall_cnt = {}
    end
    local rand_name = '百花宫宫女'
    p.max_fall_cnt[rand_name] = (p.max_fall_cnt[rand_name] or 0)
    --获得最多次数
    local max_fall_cnt = 10   
    local rate = 10
    if math.random(100000)/1000 <= rate and p.max_fall_cnt[rand_name] < max_fall_cnt then 
        --当前个数+1
        p.max_fall_cnt[rand_name] = (p.max_fall_cnt[rand_name] or 0) +1

        --给种子
        local it = ac.item.create_item('西瓜种子',unit:get_point())
        it.owner_ship = p
        p:sendMsg('恭喜掉落了 西瓜种子',5)
    end    
end)
