local mt = ac.skill['归梦五行图 ']
mt{
--等久
level = 1,
--图标
art = [[wuxingtu.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff004月23日-5月13日
|cffffe799【活动说明】|r|cff00ff00时值暮春初夏之交，不少怪物已变异为五行怪物，它们身上藏着的“五行图卷”，据说有着不可思议的宝藏。|cffffff00各位少侠快去凑个热闹吧！
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
store_name = '|cffdf19d0归梦五行图|r',
--物品详细介绍的title
content_tip = ''
}
--[[4%	随机金装
4%	随机红装
4%	随机技能书
4%	点金石
4%	恶魔果实
4%	吞噬丹
4%	格里芬
4%	黑暗项链
4%	最强生物心脏
4%	白胡子的大刀
4%	获得可存档成就-归梦五行图，激活巅峰神域-精彩活动里面，最大等级=5级，重复获得可以升级
56%	什么都没有
]]

--奖品
local award_list = { 
    ['五行图卷'] =  {
        { rand = 5, name = '金'},
        { rand = 5, name = '红'},
        { rand = 5, name = '地阶'},
        { rand = 5, name = '天阶'},

        { rand = 5, name = '天谕*5'},
        { rand = 5, name = '天谕*15'},
        { rand = 5, name = '功法连升书*1'},
        { rand = 5, name = '功法连升书*3'},
        { rand = 5, name = '无谓因果*1'},
        { rand = 5, name = '吞噬丹*1'},
        { rand = 5, name = '随机卡片'},
        { rand = 5, name = '神奇的令牌*1'},
        { rand = 5, name = '归梦五行图'},
        { rand = 35, name = '无'},
    },
}

--掉落在地上
local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['五行图卷']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，只见天空中出现了八个大字：|cffffff00盛世嘉年，普天同庆|cff00ff00!',3) 
    elseif  finds(rand_name,'天谕','功法连升书','无谓因果','龙之血珠','吞噬丹','三眼赤痕','火龙气息','天魂融血丹','地魂融血丹','神奇的令牌') then
        local it
        --处理掉落物品相关
        for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
            for i=1,tonumber(v) do 
                it = hero:add_item(k)
            end 
        end
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds('红 金',rand_name) then   
        local list = ac.quality_item[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = hero:add_item(name)
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..(it.color_name or rand_name)..'|r',4)
    elseif  finds('地阶 天阶',rand_name) then   
        local list = ac.quality_skill[rand_name]
        local name = list[math.random(#list)]
        --满时，掉在地上
        local it = ac.item.add_skill_item(name,hero)
        local color = it and it.color 
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000|cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',4)
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffffe799【系统消息】|r |cff00ff00烟花点燃后，一道绚丽的光芒闪过，好像掉落了什么，仔细一看是|cffff0000'..name..'|r',4)
    elseif  rand_name == '归梦五行图' then 
        local hero = p.hero
        local key = ac.server.name2key(rand_name)
        if p:Map_GetServerValue(key) < ac.skill[rand_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --动态插入魔法书
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',rand_name)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00放烟花一时爽，一直放一直爽，惊喜获得|cffff0000【可存档成就】'..rand_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 不断放烟花，使|cffff0000【可存档成就】'..rand_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
            end   
        else   
            --重新来一次
            give_award(hero)
        end    
    end    


end
local rand_rect = {'cbt2','cbt3'}

local mt = ac.skill['五行图卷']
mt{
--等久
level = 1,
--图标
art = [[wuxingtu.blp]],
--说明
tip = [[


|cff00ff00根据提示，到指定地点，挖开即可获得 |cffdf19d0 不可思议的宝藏 |r

|cffcccccc劳动节活动物品|r]],
--品质
-- color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.5,
life_rate = 20,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect = [[Fireworksred.mdx]],
effect2 = [[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]],
--挖图范围
area = 500,
--可能会掉线
effect = function(self)
    local str = ''
    if self.owner:get_owner():is_self() then 
        str='wbdd.mdx'
    end
    return str    
end  
}
function mt:on_add()
    --全图随机刷 正式用
    local name = rand_rect[math.random(#rand_rect)]
    self.random_point =  ac.rect.j_rect(name):get_random_point()
end

function mt:on_cast_start()
    local skill = self
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()

    if self.eff then 
        self.eff:remove()
    end  
    self.eff = ac.effect(self.random_point,self.effect,0,1,'origin')  
    self:add_item_count(1)
    local tx,ty = self.random_point:get()
    local rect = ac.rect.create( tx - self.area/2, ty-self.area/2, tx + self.area/2, ty + self.area/2)
    local region = ac.region.create(rect)
    local point = hero:get_point()

    --点在区域内
    if region < point  then
        if not player.peon_wabao and  ( hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
            player:sendMsg('|cff00ffff宠物不能挖宝|r',3)
            player:sendMsg('|cff00ffff宠物不能挖宝|r',3)
            return true
        end    
        self.eff:remove()
        region:remove()
        self:add_item_count(-1) 
        --改变下一次随机点
        self:on_add() 
        --添加东西给英雄
        give_award(p.hero)
    else
        player:pingMinimap(self.random_point, 3)
    end 
   
end   

--注册新春爆竹 掉落
ac.game:event '单位-死亡' (function (_,unit,killer)
    if  unit.unit_type ~= 'boss' then 
        return
    end    
    local p = killer:get_owner()
    if not p.max_item_fall then 
        p.max_item_fall = {}
    end
    local rate = 10 
    local rand = math.random(10000)/100 
    local max_cnt =15
    if rand < rate and (p.max_item_fall['五行图卷'] or 0) <=20 then 
        p.max_item_fall['五行图卷'] = (p.max_item_fall['五行图卷'] or 0) + 1
        ac.item.create_item('五行图卷',unit:get_point())
    end
end)

