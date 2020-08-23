local mt = ac.skill['七夕-喜鹊翎毛']
mt{
--等久
level = 1,
--图标
art = [[xique.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff008月20日-8月31日
|cffffe799【活动说明】|r|cff00ff00金风玉露一相逢，便胜却人间无数。年年岁岁架鹊桥，牛郎织女偷相会。少侠既然也是有心之人，还请帮忙收集|cffffff00喜鹊翎毛|r|cffcccccc（种树掉落）
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
-- store_name = '|cffdf19d0挑战 |r',
--物品详细介绍的title
content_tip = ''
}

local mt = ac.skill['兑换-天谕']
mt{
--等久
level = 1,
store_name = '兑换-天谕',
--图标
art = [[tianyu.blp]],
--说明
tip = [[

消耗 |cffff0000三根喜鹊翎毛|r 兑换 |cff00ff00天谕|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 3,
max_cnt = 99999,
}   

local mt = ac.skill['兑换-吞噬丹']
mt{
--等久
level = 1,
store_name = '兑换-吞噬丹',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

消耗 |cffff0000十根喜鹊翎毛|r 兑换 |cff00ff00吞噬丹|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 10,
max_cnt = 99999,
}  
local mt = ac.skill['兑换-三眼赤痕']
mt{
--等久
level = 1,
store_name = '兑换-三眼赤痕',
--图标
art = [[sanyanchihe.blp]],
--说明
tip = [[

消耗 |cffff0000五根喜鹊翎毛|r 兑换 |cff00ff00三眼赤痕|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-火龙气息']
mt{
--等久
level = 1,
store_name = '兑换-火龙气息',
--图标
art = [[longqixi.blp]],
--说明
tip = [[

消耗 |cffff0000五根喜鹊翎毛|r 兑换 |cff00ff00火龙气息|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-天魂融血丹']
mt{
--等久
level = 1,
store_name = '兑换-天魂融血丹',
--图标
art = [[tianhundan.blp]],
--说明
tip = [[

消耗 |cffff0000五根喜鹊翎毛|r 兑换 |cff00ff00天魂融血丹|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-地魂融血丹']
mt{
--等久
level = 1,
store_name = '兑换-地魂融血丹',
--图标
art = [[dihundan.blp]],
--说明
tip = [[

消耗 |cffff0000五根喜鹊翎毛|r 兑换 |cff00ff00地魂融血丹|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-功法连升书']
mt{
--等久
level = 1,
store_name = '兑换-功法连升书',
--图标
art = [[gongfashengji.blp]],
--说明
tip = [[

消耗 |cffff0000五根喜鹊翎毛|r 兑换 |cff00ff00功法连升书|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-缘定三生']
mt{
--等久
level = 1,
store_name = '兑换-缘定三生',
--图标
art = [[ydss.blp]],
--说明
tip = [[

消耗 |cffff0000三十根喜鹊翎毛|r 兑换 |cff00ff00可存档成就-缘定三生|r

|cffFFE799【成就属性】：|r
|cff00ff00+20W |cff00ff00全属性|r
|cff00ff00+20  |cff00ff00攻击减甲|r
|cff00ff00+2   |cff00ff00每秒加护甲|r
|cff00ff00+1%  |cff00ff00技能伤害加深系数|r

|cffcccccc【要求地图等级>5】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 30,
max_cnt = 99999,
}  



for i,name in ipairs({'兑换-火龙气息','兑换-天魂融血丹','兑换-地魂融血丹','兑换-功法连升书','兑换-天谕','兑换-吞噬丹','兑换-三眼赤痕','兑换-缘定三生'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    

        local real_name = string.gsub(self.name,'兑换%-','')

        --先扣当前消费者的勋章数，不足的话扣除单位下的另一个人的勋章
        local first_item = self.owner:has_item('喜鹊翎毛','all')
        local unit = (self.owner == hero and p.peon or hero )
        local second_item = unit:has_item('喜鹊翎毛','all')

        local has_cnt = (first_item and first_item._count or 0) + (second_item and  second_item._count or 0 )

        if real_name == '缘定三生' then 
            local hero = p.hero
            local key = ac.server.name2key(real_name)
            if p:Map_GetServerValue(key) >= ac.skill[real_name].max_level  then 
                p:sendMsg('已满级',5)
                return 
            end
        end
        --处理兑换
        if has_cnt >= self.need_xqym  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --扣除物品
                if first_item  then
                    if first_item._count>= self.need_xqym then 
                        first_item:add_item_count(-self.need_xqym)
                    else
                        local dis_cnt = self.need_xqym - first_item._count
                        first_item:add_item_count(-self._count)
                        second_item:add_item_count(-dis_cnt)
                    end    
                else
                    second_item:add_item_count(-self.need_xqym)
                end 
                --给物品
                if real_name == '缘定三生' then 
                    local hero = p.hero
                    local key = ac.server.name2key(real_name)
                    if p:Map_GetServerValue(key) < ac.skill[real_name].max_level  then 
                        --激活成就（存档） 
                        p:Map_AddServerValue(key,1) --网易服务器
                        --动态插入魔法书
                        local skl = hero:find_skill(real_name,nil,true) 
                        if not skl  then 
                            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
                            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断食用美味的西瓜，惊喜获得|cffff0000【可存档成就】'..real_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
                        else
                            skl:upgrade(1)
                            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断食用美味的西瓜，使|cffff0000【可存档成就】'..real_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
                        end 
                    end    
                else    
                    self.owner:add_item(real_name) 
                end    

                p.max_cnt[real_name] = (p.max_cnt[real_name] or 0) + 1
                p:sendMsg('|cffff0000兑换'..real_name..'成功|r')   
            else
                p:sendMsg('本局已达兑换上限')    
            end    
        else
            p:sendMsg('|cffebb608【系统】|r|cff00ff00材料不足|r')    
        end    
    end    
end    


local mt = ac.skill['露水']
mt{
--等久
level = 1,
--图标
art = [[lushui.blp]],
--说明
tip = [[

|cff00ff00传说七夕节时的露水是牛郎织女相会时的眼泪,如抹在眼上和手上,可使人眼明手快。|cffffff00使用后增加1%敏捷 ，10%攻速，-0.01攻击间隔|r

|cffcccccc七夕活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 1,
['敏捷%'] = 1,
['攻击速度'] = 10,
['攻击间隔'] = -0.01,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['喜鹊翎毛']
mt{
--等久
level = 1,
--图标
art = [[xique.blp]],
--说明
tip = [[

|cff00ff00可前往活动使者处（基地右上角）兑换奖励

|cffcccccc七夕活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}




--注册掉落事件
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_owner().id < 11 then 
        return
    end    
    if not finds(unit:get_name(),'百花宫宫女') then 
        return 
    end    
    local p = killer:get_owner()
    if not p.max_cnt then 
        p.max_cnt = {}
    end    
    local rate = 0.4
    local max_cnt = 50
    local name ='露水'
    -- local max_cnt = 5 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        --掉落
        if (p.max_cnt[name] or 0 ) < max_cnt then 
            ac.item.create_item(name,unit:get_point())
            p.max_cnt[name] = (p.max_cnt[name] or 0) + 1
        end    
    end  
    
end)
--注册挖图回调
ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero:get_owner()
    if not p.max_cnt then 
        p.max_cnt = {}
    end  

    local rate = 10
    local max_cnt = 30
    local name ='喜鹊翎毛'
    -- local rate = 10 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        if (p.max_cnt[name] or 0 ) < max_cnt then 
            hero:add_item(name)
            p.max_cnt[name] = (p.max_cnt[name] or 0) + 1
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|r 种树过程中，惊喜获得 |cffff0000喜鹊翎毛|r',6) 
        end    
    end  

end)
-- player:event_notify('挖图成功',hero)
