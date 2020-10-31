
local mt = ac.skill['祭祀-有趣的灵魂']
mt{
--等久
level = 1,
--图标
art = [[zyj.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月3日-9月7日
|cffffe799【活动说明】|r
|cff00ff001.这几天举办祭祀活动，以慰在基地游玩的众家鬼魂，并祈求大家全年的平安顺利。|cff00ff00还请少侠帮忙|cffff0000贡献一些食物|r

|cff00ff002.好看的皮囊千篇一律，有趣的灵魂万里挑一。|cff00ffff基地经常出现一些有趣的灵魂。|cff00ff00还请少侠帮忙|cffff0000击败并超度它们|r
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
store_name = '|cffdf19d0有趣的灵魂|r',
--物品详细介绍的title
content_tip = ''
}


local mt = ac.skill['白嫖的快乐']
mt{
--等久
level = 1,
--图标
art = [[zyj.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月3日-9月7日
|cffffe799【活动说明】|r
|cff00ff001.这几天举办祭祀活动，以慰在基地游玩的众家鬼魂，并祈求大家全年的平安顺利。|cff00ff00还请少侠帮忙|cffff0000贡献一些食物|r

|cff00ff002.好看的皮囊千篇一律，有趣的灵魂万里挑一。|cff00ffff基地经常出现一些有趣的灵魂。|cff00ff00还请少侠帮忙|cffff0000击败并超度它们|r
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
store_name = '|cffdf19d0白嫖的快乐|r',
--物品详细介绍的title
content_tip = ''
}
--初始化设置所有人都拥有黑科技礼包
for i=1,10 do 
    local p = ac.player(i)
    if p:is_player() then 
        p.mall = p.mall or {}
        p.mall['黑科技礼包'] = 1
    end 
end



local mt = ac.skill['祭祀-三眼赤痕']
mt{
--等久
level = 1,
store_name = '祭祀-三眼赤痕',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[

贡献 |cffff0000一个完美的鸡翅|r 奖励 |cff00ff00三眼赤痕|r

|cffcccccc最大贡献次数=10次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '羊皮纸*2',
max_cnt = 2,
}   

local mt = ac.skill['祭祀-火龙气息']
mt{
--等久
level = 1,
store_name = '祭祀-火龙气息',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

贡献 |cffff0000五个完美的鸡腿|r 奖励 |cff00ff00火龙气息|r

|cffcccccc最大贡献次数=2次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '羊皮纸*2',
max_cnt = 2,
}   
local mt = ac.skill['祭祀-天魂融血丹']
mt{
--等久
level = 1,
store_name = '祭祀-天魂融血丹',
--图标
art = [[guoshi.blp]],
--说明
tip = [[

贡献 |cffff0000十个完美的鸡头|r 奖励 |cff00ff00天魂融血丹|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '羊皮纸*2',
max_cnt = 2,
}  
local mt = ac.skill['祭祀-地魂融血丹']
mt{
--等久
level = 1,
store_name = '祭祀-地魂融血丹',
--图标
art = [[gelifen.blp]],
--说明
tip = [[

贡献 |cffff0000两个无字天书|r 奖励 |cff00ff00地魂融血丹|r

|cffdf19d0地魂融血丹|cff00ffff+功法连升书+天谕+吞噬丹=天魂融血丹（食用后可以获得惊人能力！)|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '羊皮纸*2',
max_cnt = 2,
}  

local mt = ac.skill['祭祀-功法连升书']
mt{
--等久
level = 1,
store_name = '祭祀-功法连升书',
--图标
art = [[heianxianglian.blp]],
--说明
tip = [[

贡献 |cffff0000两个无字天书|r 奖励 |cff00ff00功法连升书|r

|cff00ffff地魂融血丹+|cffdf19d0功法连升书|cff00ffff+天谕+吞噬丹=天魂融血丹（食用后可以获得惊人能力！)|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '无字天书*2',
max_cnt = 5,
}  

local mt = ac.skill['祭祀-天谕']
mt{
--等久
level = 1,
store_name = '祭祀-天谕',
--图标
art = [[zqswxz.blp]],
--说明
tip = [[

贡献 |cffff0000两个无字天书|r 奖励 |cff00ff00天谕|r

|cff00ffff地魂融血丹+功法连升书+|cffdf19d0天谕|cff00ffff+吞噬丹=天魂融血丹（食用后可以获得惊人能力！)|r

|cffcccccc最大贡献次数=1次|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '强化石*3',
max_cnt = 10,
}  

local mt = ac.skill['祭祀-吞噬丹']
mt{
--等久
level = 1,
store_name = '祭祀-吞噬丹',
--图标
art = [[]],
--说明
tip = [[]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【祭祀说明】：|r\n',
--物品技能
is_skill = true,
need_material = '藏宝图*5',
max_cnt = 2,
}  


for i,name in ipairs({'祭祀-地魂融血丹','祭祀-功法连升书','祭祀-天谕','祭祀-吞噬丹','祭祀-三眼赤痕','祭祀-火龙气息','祭祀-天魂融血丹'}) do
    local mt = ac.skill[name]
    -- mt.art = ac.skill[string.gsub(name,'祭祀%-','')].art
    -- mt.tip = ac.skill[string.gsub(name,'祭祀%-','')]:get_tip()
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    

        local real_name = string.gsub(self.name,'祭祀%-','')
        local _, _, it_name, cnt = string.find(self.need_material,"(%S+)%*(%d+)")
        cnt = tonumber(cnt)
        local has_cnt = 0
        local has_item = self.owner:has_item(it_name)
        if has_item then 
            has_cnt = has_item:get_item_count()
        end    
        --处理兑换
        if has_cnt >= cnt  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --扣除材料
                has_item:add_item_count(-cnt)
                self.owner:add_item(real_name) 
                p.max_cnt[real_name] = (p.max_cnt[real_name] or 0) + 1
                p:sendMsg('|cffff0000兑换'..real_name..'成功|r')   
            else
                p:sendMsg('本局已达兑换上限')    
            end    
        else 
            p:sendMsg('|cffebb608【系统】|r|cffff0000材料不够')    
        end    
    end    
end    


ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 6 
    local rate = 55
    local time = 10
    ac.loop(time*1000,function()
        local online_cnt = get_player_count()
        local cnt = math.floor(online_cnt/3) + 1 

        for i= 1, cnt do 
            local point = ac.map.rects['藏宝区']:get_random_point()
            local unit = ac.player(16):create_unit('有趣的灵魂',point)

            unit:add_buff '随机逃跑' {}
            ac.nick_name('有人唠嗑不',unit,250)

            unit:event '单位-死亡'(function(_,unit,killer)
                local p = killer:get_owner()
                if p.id >= 11 then 
                    return 
                end    
                local player = killer:get_owner()
                local hero = p.hero
                local save_name = '有趣的灵魂'
                -- print(self.rate)
                if math.random(100) <= rate then 
                    local key = ac.server.name2key(save_name)
                    --激活成就（存档） 
                    p:Map_AddServerValue(key,1) --网易服务器
                    --动态插入魔法书
                    local skl = hero:find_skill(save_name,nil,true) 
                    if not skl  then 
                        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','有趣的灵魂')
                        ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 超度了一个灵魂，获得|cffff0000【可存档成就】'..save_name..'|r，成就属性可在“最强魔灵-精彩活动”中查看',6) 
                    else
                        --有魔法书的情况下，升级
                        skl:upgrade(1)
                        p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6) 
                    end   
                else
                    p:sendMsg('|cffebb608【系统】|r阁下人品略低 |cffff0000超度失败',6) 
                end     
            end)
        end    
    end)

end)
