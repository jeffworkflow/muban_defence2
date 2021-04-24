 
--物品名称
local mt = ac.skill['召唤团队BOSS【肉山】']
mt{
title = '召唤团队BOSS【肉山】',
--等久
level = 1,
--图标
art = [[jinbiguai1.blp]],
--说明
tip = [[|cffFFE799难度：|cff00ff00低
|cffFFE799奖励：|cffffff00大量金币
|cffFFE799简介：|cff00ff00难度低，建议优先挑战|cffcccccc（10个怪物）
 ]],
is_order = 1,
--特殊id 带cd EX06
cool = function(self)
    local p = self.owner.owner
    return 10 * (1-p:get('挑战商店cd减少百分比')/100)
end,
init_cd = 4,
ignore_cool_save = true,
unit_name ='肉山',
unit_cool = 0.5,
unit_num = 1
}

local mt = ac.skill['召唤团队BOSS【梦魇】']
mt{
title = '召唤团队BOSS【梦魇】',
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNEnt.blp]],
--说明
tip = [[|cffFFE799难度：|cff00ff00中
|cffFFE799奖励：|cffffff00大量木头
|cffFFE799简介：|cff00ff00建议早点挑战|cffcccccc（3个怪物）
 ]],
is_order = 1,
--特殊id 带cd
cool = function(self)
    local p = self.owner.owner
    return 10 * (1-p:get('挑战商店cd减少百分比')/100)
end,
init_cd = 120,
ignore_cool_save = true,
unit_name ='梦魇',
unit_cool = 1,
unit_num = 1
}

local mt = ac.skill['召唤团队BOSS【戈登的激情】']
mt{
title = '召唤团队BOSS【戈登的激情】',
--等久
level = 1,
--图标
art = [[long.blp]],
--说明
tip = [[|cffFFE799难度：|cff00ffff高
|cffFFE799奖励：|cffffff001个随机装备和1个随机丹药|cffcccccc（随挑战次数增加数量）
|cffFFE799简介：|cff00ff00为周围怪物提供护甲光环|cffcccccc（1个怪物）
 ]],
is_order = 1,
--特殊id 带cd
cool = function(self)
    local p = self.owner.owner
    return 240 * (1-p:get('挑战商店cd减少百分比')/100)
end,
init_cd = 180,
ignore_cool_save = true,
unit_name ='戈登的激情',
unit_cool = 1,
unit_num = 1
}

local mt = ac.skill['召唤团队BOSS【火焰领主】']
mt{
title = '召唤团队BOSS【火焰领主】',
--等久
level = 1,
--图标
art = [[hyzw.blp]],
--说明
tip = [[|cffFFE799难度：|cffff0000非常高
|cffFFE799奖励：|cffffff00吞噬丹
|cffFFE799简介：|cff00ff00为周围怪物提供加速光环和回血光环|cffcccccc（1个怪物）
 ]],
is_order = 1,
ignore_cool_save = true,
init_cd = 300,
cool = function(self)
    local p = self.owner.owner
    -- print('减少',p,240 * (1-p:get('挑战商店cd减少百分比')/100))
    return 300 * (1-p:get('挑战商店cd减少百分比')/100)
end,
--特殊id 带cd
unit_name ='火焰领主',
unit_cool = 1,
unit_num = 1
}
local mt = ac.skill['召唤团队BOSS【毁灭者】']
mt{
title = '召唤团队BOSS【毁灭者】',
--等久
level = 1,
--图标
art = [[hyzw.blp]],
--说明
tip = [[|cffFFE799难度：|cffff0000非常高
|cffFFE799奖励：|cffffff00吞噬丹
|cffFFE799简介：|cff00ff00为周围怪物提供加速光环和回血光环|cffcccccc（1个怪物）
 ]],
is_order = 1,
ignore_cool_save = true,
init_cd = 300,
cool = function(self)
    local p = self.owner.owner
    -- print('减少',p,240 * (1-p:get('挑战商店cd减少百分比')/100))
    return 300 * (1-p:get('挑战商店cd减少百分比')/100)
end,
--特殊id 带cd
unit_name ='毁灭者',
unit_cool = 1,
unit_num = 1
}


for i,name in ipairs({'召唤团队BOSS【肉山】','召唤团队BOSS【梦魇】','召唤团队BOSS【戈登的激情】','召唤团队BOSS【火焰领主】','召唤团队BOSS【毁灭者】'}) do 

    -- local ay =ac.skill[name..'1']
    -- ay{
    --     title = ac.skill[name].title,
    --     art = ac.skill[name].art,
    --     tip = ac.skill[name].tip,
    --     is_order = 1,
    --     ignore_cool_save = true,
    --     init_cd = ac.skill[name].init_cd,
    -- }
    -- function ay:on_add()
    --     local hero = self.owner
    --     local p = hero:get_owner()
    --     print('chushihuacd',self.init_cd,ac.skill[name].art)
    --     ac.wait(0,function()
    --         self:active_cd()
    --         self:set_cd(self.init_cd)
    --     end)
    --     ac.wait(self.init_cd*1000,function()
    --         self:remove()
    --         hero:add_sell_item(name,i)
    --     end)
    -- end
    local data =ac.skill[name]
    -- data.type_id = 'EX0'..(5+i)
    -- data.item_type ='神符'
    function data:on_add()
        local hero = self.owner
        local p = hero:get_owner()
        ac.wait(0,function()
            self:active_cd()
            self:set_cd(self.init_cd)
        end)
    end
    function data:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local ret = 'lgfbh'..p.id
        local name = name
        local cep = ac.creep[name]
        if cep.has_started then 
            cep:next()
        else
            cep:start()
        end
        for i=1,6 do 
            local p = ac.player(i)
            if p:is_player() and p.sjboss_shop then 
                local skl = p.sjboss_shop:find_skill(name,nil,true)
                self:active_cd()
            end
        end
    end

    --刷怪相关
    local key = name
    ac.wait(10,function()
        print('注册刷怪：',data.unit_name,name)
        -- local point = ac.map.rects['进攻点']:get_point()
        local mt = ac.creep[name]{    
            region = 'jg1',
            creeps_datas = (data.unit_name or '')..'*'..(data.unit_num or 10),
            create_unit_cool = data.unit_cool or 0.5,
            first_wait_time = 0.6, --调整切换练功怪首次出现时间
            max_index = data.max_index or 9999,
            creep_player = ac.player(12),
            auto_next = false, --不允许自动下一波
        }
        function mt:on_start()
        end
        -- function mt:on_next()
        --     self.creeps_datas = key..'*'..(10 + player:get('练功房怪'))
        --     self:set_creeps_datas()
        -- end    
        function mt:on_change_creep(unit,lni_data)
            unit:set('生命上限',unit:get('生命上限')*1.5^(self.index-1))
            unit:set('护甲',unit:get('护甲')*1.5^(self.index-1))
            unit:set('攻击',unit:get('攻击')*1.5^(self.index-1))
            --设置搜敌范围
            unit:set_search_range(1000)
            unit:add_buff '攻击英雄' {}

            unit:event '单位-死亡'(function(_,unit,killer)
                local player = killer.owner
                local p =player

                for i=1,6 do 
                    local p = ac.player(i)
                    if p:is_player() then 
                        local hero = p.hero
                        --每个玩家获得奖励2500杀敌数，每个玩家获得杀敌数加成+50%，物品获取率+50%
                        if unit:get_name() == '肉山' then 
                            hero:add_kill_count(2500)
                            hero:add('杀敌数加成',50)
                            hero:add('物品获取率',50)
                        end
                        --每个玩家获得奖励1万木头，5万魔丸，每个玩家获得木头获取率+50%，魔丸获取率+50%，
                        if unit:get_name() == '梦魇' then 
                            hero:add_wood(10000)
                            hero:add_rec_ex(50000)
                            hero:add('木头加成',50)
                            hero:add('魔丸获取率',50)
                        end

                        --每个玩家获得奖励10个天谕或3本功法连升书；
                        if unit:get_name() == '戈登的激情' then 
                            if math.random(100)<=50 then 
                                local it =ac.item.create_item('天谕',hero:get_point())
                                it:set_item_count(10)
                                hero:add_item(it)
                            else
                                local it =ac.item.create_item('功法连升书',hero:get_point())
                                it:set_item_count(3)
                                hero:add_item(it)
                            end
                        end

                        --每个玩家获得奖励一个吞噬丹或一个无谓因果
                        if unit:get_name() == '火焰领主' then 
                            if math.random(100)<=50 then 
                                hero:add_item('吞噬丹')
                            else
                                hero:add_item('无谓因果')
                            end
                        end
                        --每个玩家获得奖励一个吞噬丹或一个无谓因果
                        if unit:get_name() == '毁灭者' then 
                            if math.random(100)<=50 then 
                                local name = ac.quality_item['黑'][math.random(#ac.quality_item['黑'])]
                                hero:add_item(name)
                            else
                                local name = ac.quality_skill['神阶'][math.random(#ac.quality_skill['神阶'])]
                                ac.item.add_skill_item(name,hero)
                            end
                        end
                    end
                end


            end)
        end  
    end)

end
local slots = {9,10,11,12,5,6,7,8,1,2,3,4}

ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪1' then
        return
    end    
    if  index ~= 11 then 
        return 
    end

    ac.player.self:sendMsg('【系统】世界任务开启，在基地左边的NPC世界BOSS中查看！',5)
    --支线·破碎箱子
    local x,y = ac.rect.j_rect('npc3'):get_point():get()
    for i=1,6 do 
        local player = ac.player(i) 
        if player:is_player() then 
            local shop = ac.shop.create('世界BOSS',x,y,270,nil,player)
            for i,name in ipairs({'召唤团队BOSS【肉山】','召唤团队BOSS【梦魇】','召唤团队BOSS【戈登的激情】','召唤团队BOSS【火焰领主】','召唤团队BOSS【毁灭者】'}) do 
                shop:set_high(10000)
                player.sjboss_shop = shop
                --初始化技能
                shop:add_skill(name,'英雄',slots[i])
    
                if player:is_self() then
                    shop:set_high(0)
                end
            end
            

        end
    end
    
    ac.player.self:pingMinimap(ac.point(x,y),5,255,0,0)
    ac.player.self:pingMinimap(ac.point(x,y),5,255,0,0)
    ac.player.self:pingMinimap(ac.point(x,y),5,255,0,0)

end)
