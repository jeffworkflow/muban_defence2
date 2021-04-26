
local add_next_skill
local add_skill_by_lv 

local devil_deal = {}
local ix = 0
--获得事件
local unit_reward = { 
    ['随机装备1'] =  { { rand = 70,name = '蓝'}, { rand = 25,name = '金'}, { rand = 5,name = '红'},},
    ['随机装备2'] =  { { rand = 60,name = '蓝'}, { rand = 35,name = '金'}, { rand = 5,name = '红'},},
    ['随机装备3'] =  { { rand = 50,name = '蓝'}, { rand = 45,name = '金'}, { rand = 5,name = '红'},},
    ['随机装备4'] =  { { rand = 40,name = '蓝'}, { rand = 55,name = '金'}, { rand = 5,name = '红'},},
    ['随机装备5'] =  { { rand = 30,name = '蓝'}, { rand = 65,name = '金'}, { rand = 5,name = '红'},},
    ['随机装备6'] =  { { rand = 20,name = '蓝'}, { rand = 70,name = '金'}, { rand = 10,name = '红'},},
    ['随机装备7'] =  { { rand = 10,name = '蓝'}, { rand = 70,name = '金'}, { rand = 20,name = '红'},},
    ['随机装备8'] =  { { rand = 0,name = '蓝'}, { rand = 70,name = '金'}, { rand = 25,name = '红'}, { rand = 5,name = '黑'}},
    ['随机装备9'] =  { { rand = 0,name = '蓝'}, { rand = 60,name = '金'}, { rand = 35,name = '红'}, { rand = 5,name = '黑'}},
    ['随机装备10'] =  { { rand = 0,name = '蓝'}, { rand = 50,name = '金'}, { rand = 45,name = '红'}, { rand = 5,name = '黑'}},
    ['随机装备11'] =  { { rand = 0,name = '蓝'}, { rand = 40,name = '金'}, { rand = 55,name = '红'}, { rand = 5,name = '黑'}},
    ['随机装备12'] =  { { rand = 0,name = '蓝'}, { rand = 30,name = '金'}, { rand = 65,name = '红'}, { rand = 5,name = '黑'}},
    ['随机装备13'] =  { { rand = 0,name = '蓝'}, { rand = 20,name = '金'}, { rand = 70,name = '红'}, { rand = 10,name = '黑'}},
    ['随机装备14'] =  { { rand = 0,name = '蓝'}, { rand = 10,name = '金'}, { rand = 70,name = '红'}, { rand = 20,name = '黑'}},
    ['随机装备15'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 70,name = '红'}, { rand = 25,name = '黑'}, { rand = 5,name = '神'}},
    ['随机装备16'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 60,name = '红'}, { rand = 35,name = '黑'}, { rand = 5,name = '神'}},
    ['随机装备17'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 50,name = '红'}, { rand = 45,name = '黑'}, { rand = 5,name = '神'}},
    ['随机装备18'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 40,name = '红'}, { rand = 55,name = '黑'}, { rand = 5,name = '神'}},
    ['随机装备19'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 30,name = '红'}, { rand = 65,name = '黑'}, { rand = 5,name = '神'}},
    ['随机装备20'] =  { { rand = 0,name = '蓝'}, { rand = 0,name = '金'}, { rand = 20,name = '红'}, { rand = 70,name = '黑'}, { rand = 10,name = '神'}},

}
 
for page=1,2 do 
    devil_deal[page] = {}
    for i=1,10 do 
        ix = ix + 1
        local name = '挑战铁匠BOSS'..ix
        table.insert(devil_deal[page],name)
        local mt = ac.skill[name]
        mt{
            level = 0,
            is_order = 1,
            art = [[posuixiangzi.blp]],
            effect2 = [[Void Teleport Target.mdx]],
            tip = '|n|cffFFE799【任务要求】|r|cff00ff00点击前往击败|cffffff00铁匠BOSS|r|n|n|cffFFE799【任务奖励】|r|cff00ff00随机装备（发放至练功房）|r|n|n',
            page = page,
            ix = i,
            award_name = '随机装备'..ix
            -- title = 
        }
        function mt:on_cast_start()
            local skill = self
            local seller = self.owner
            local p = seller.owner 
            local hero = p.hero
            if p.flag_tzps then 
                p:sendMsg('已经有人在挑战',5)
                return 
            end
            --传送
            p.flag_tzps = true
            local blink_rect = ac.rect.j_rect('tiejiang1')
            hero:blink(blink_rect,true,false,true)
            --创建升级怪 
            local rect = ac.rect.j_rect('tiejiang11')
            local point = rect:get_point()
            ac.wait(150,function()
                ac.effect_ex{
                    model = self.effect2,
                    size = 3,
                    point = point
                }:remove()
            
            end)
            ac.wait(500,function()
                ac.effect_ex{
                    model = self.effect2,
                    size = 3,
                    point = point
                }:remove()
            
            end)
            local u  
            local u_name = string.gsub(self.name,'挑战','')
            local trg_t = ac.wait(1*1000,function(t)
                u = ac.player(12):create_unit(u_name,point)
                u:event '单位-死亡'(function(_,unit,killer)
                    p.flag_tzps = false 
                    
                    --传送回练功房
                    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                    if finds(ac.g_game_degree_name,'深渊冒险') then 
                        point = ac.rect.j_rect('zxzw1'):get_point()
                    end
                    hero:blink(point,true,false,true)

                    --加下个等级
                    add_next_skill(skill,seller,hero)

                    --给奖励
                    local rand_name = ac.get_reward_name(unit_reward[skill.award_name])  
                    if not rand_name then 
                        return 
                    end  
                    local list = ac.quality_item[rand_name]
                    local name = list[math.random(#list)]
                    --满时，掉在地上
                    ac.fall_move{
                        name = name,
                        source = unit:get_point(),
                        target = ac.rect.j_rect('lgfnpc'..p.id..'9'):get_point(),
                        owner = p,
                    }
                    -- local it = hero:add_item(name)
                    p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得|cffff0000'..(get_color_name(name))..'|r|cff00ff00,已发放至练功房',4)
                    

                end)
            end)

            --创建区域离开事件
            local reg = ac.map.regions['tiejiang2']
            reg:event '区域-离开'(function(trg,unit)
                if hero ~= unit then 
                    return 
                end  
                if u and u:is_alive() then 
                    u:remove()
                end
                if trg_t then 
                    trg_t:remove()
                    trg_t = nil 
                end
                p.flag_tzps = false 
                --删除自己的
                trg:remove()  
            end)
        end
        
    end

end

add_next_skill = function (skill,seller,hero)
    local self = skill
    seller:remove_skill(self.name)
    local skl_name = ''
    if self.ix == 10 then 
        add_skill_by_lv(seller,self.page+1)
    else
        skl_name = devil_deal[self.page][self.ix+1] --下一个技能名
    end   
    -- 激活下商店下一个属性 
    local skl = seller:find_skill(skl_name,'英雄',true)
    if skl then 
        skl:set_level(1)
    end    
end  
add_skill_by_lv = function(shop,lv,flag)
    if not devil_deal[lv] then 
        return 
    end    
    for num,name in ipairs(devil_deal[lv]) do    
        flag = flag and 300*num  
        ac.wait(flag or 0,function()
            if num <= 4 then 
                -- print(value[1])
                shop:add_skill(name,'英雄',num + 8 )
            elseif num <= 8 then 
                shop:add_skill(name,'英雄',num)
            else
                shop:add_skill(name,'英雄',num - 8)
            end   
            -- shop:add_skill(name,'英雄')
            if num ==1 then 
                local skl = shop:find_skill(name,'英雄',true)
                skl:set_level(1)
            end 
        end)
    end   
end   
ac.game:event '任务-圣龙气运'(function(self,p)
    if ac.flag_zxpsxz then 
        return 
    end
    ac.flag_zxpsxz = true

    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff支线-破碎箱子|r|cff00ff00任务开启，请前往|cffffff00基地左边|cff00ff00找NPC查看！',5)
    --支线·破碎箱子
    local x,y = ac.rect.j_rect('npc4'):get_point():get()
    for i=1,6 do 
        local player = ac.player(i) 
        if player:is_player() then 
            local shop = ac.shop.create('支线·破碎箱子',x,y,270,nil,player)
            shop:set_high(10000)
            player.item_shop = shop
            --初始化技能
            add_skill_by_lv(shop,1,true)

            if player:is_self() then
                shop:set_high(0)
            end
        end
    end
    
    ac.player.self:pingMinimap(ac.point(x,y),5,255,0,0)

end)
