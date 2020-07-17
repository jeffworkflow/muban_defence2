local mt = ac.skill['随机神符']

mt{
--必填
is_skill = true,
--等级
level = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
tip = [[
随机神符出现啦，赶紧去寻找。
]],
--cd
cool = 0,
--模型
_model = [[Objects\InventoryItems\runicobject\runicobject.mdl]],
--物品
item_type = '神符'
}

--创建
function mt:on_create()
    local hero = self.owner
    local region = ac.rect.j_rect('moku5')
    local point = ac.rect.j_rect('moku5'):get_random_point()
    -- print(self.item)
    -- if self.item then 
    --     self.item:item_remove() 
    -- end    
    -- self.item = 
    ac.item.create_item(self.name,point)
end	

--奖品
local award_list = { 
    ['随机神符'] =  {
        {    rand = 10, name = '无敌' },
        {    rand = 10, name = '治疗',},
        {    rand = 10, name = '暴击',},
        {    rand = 10, name = '攻击',},
        {    rand = 10, name = '法术',},
        {    rand = 10, name = '减甲',},
        {    rand = 10, name = '中毒',},
        {    rand = 10, name = '沉默',},
        {    rand = 10, name = '定身',},
        {    rand = 10, name = '迟缓',},
    },
}
--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    if hero.unit_type == '宠物' or hero.unit_type == '召唤物' then 
        player:sendMsg('|cff00ffff宠物不能拾取|r',10)
        player:sendMsg('|cff00ffff宠物不能拾取|r',10)
        return true
    end    
    -- print('使用了命运花')
    local rand_list = award_list['随机神符']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end   

    if rand_name == '无' then
    elseif  rand_name == '无敌' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0拥有无敌状态|r |cff00ff00持续5秒|r',6)
        hero:add_buff '无敌' {
            time = 5
        }
    elseif  rand_name == '治疗' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0每秒回血+100%|r |cff00ff00持续8秒|r',6)
        -- hero:heal
		-- {
		-- 	source = hero,
		-- 	skill = self,
		-- 	size = 10,
		-- 	heal = hero:get('生命上限'),
        -- }
        hero:add_buff '属性_每秒回血'{
            time = 8,
            value = 100,
        }
        
    elseif  rand_name == '暴击' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0暴击/技暴/会心/多重暴击几率翻倍|r |cff00ff00持续8秒|r',6)
        hero:add_buff '暴击'{
            time = 8,
            skill = self,
            source = hero,
            mul = 1,
        }
    elseif  rand_name == '攻击' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0攻击+10亿，物理伤害加深+500%，攻击距离+1000 |r |cff00ff00持续8秒|r',6)
        hero:add_buff '攻击'{
            time = 8,
            skill = self,
            source = hero,
            value = 1000000000, 
            wl_val = 500, 
            attack_distance = 1000, 
        }
    elseif  rand_name == '法术' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0技能冷却+50%，触发概率加成+100%，技能伤害加深+500%|r |cff00ff00持续8秒|r',6)
        hero:add_buff '法术'{
            time = 8,
            skill = self,
            source = hero,
            model =[[Abilities\Spells\Human\Brilliance\Brilliance.mdl]],
            ref = 'origin',
            value = 500, 
        }
    elseif  rand_name == '减甲' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0攻击减甲+500，减少周围护甲+5000|r |cff00ff00持续8秒|r',6)
        hero:add_buff '减甲神符'{
            time = 8,
            skill = self,
            source = hero,
            value = 5000, 
        }
    elseif  rand_name == '中毒' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0生命-99%|r',6)
        hero:damage{
            source = hero,
            damage = hero:get('生命')*0.99,
            skill = self,
            real_damage = true
        }
    elseif  rand_name == '沉默' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0被沉默了|r |cff00ff00持续5秒|r',6)
        hero:add_buff '沉默'{
            time = 5,
            skill = self,
            source = hero
        }
    elseif  rand_name == '定身' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0被定身了|r |cff00ff00持续5秒|r',6)
        hero:add_buff '定身'{
            time = 5,
            skill = self,
            model =[[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
            ref = 'origin',
            source = hero
        }
        hero:add_buff '缴械'{
            time =5
        }
    elseif  rand_name == '迟缓' then
        ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..player:get_name()..'|r 捡到'..rand_name..'神符, |cffdf19d0攻击速度-250%，移动速度-50%|r |cff00ff00持续5秒|r',6)
        hero:add_buff '迟缓'{
            time = 5,
        }
    end

end

function mt:on_remove()
    -- print('进行移除')
    if self.item then 
        -- self.item:item_remove()
        self.item = nil
    end     
end



-- ac.game:event '游戏-回合开始'(function(trg,index, creep) 
--     if creep.name ~= '刷怪' then
--         return
--     end    
--     -- print('回合开始2')
-- end)

local looper 
local time = 15
ac.game:event '魔灵争霸-开始' (function()

    --回合开始时，创建命运花
    if not looper then 
        looper = ac.loop(time*1000,function() 
            mt:on_create()
        end) 
    end    



end)    
ac.game:event '魔灵争霸-结束' (function()
    if looper then 
        looper:remove()
        looper = nil
    end    
end)    