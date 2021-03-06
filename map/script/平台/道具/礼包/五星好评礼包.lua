local mt = ac.skill['五星好评礼包']
mt{
--等久
level = 0,
--图标
art = [[hplb.blp]],
is_order = 1,
content_tip = '',
is_skill =true ,
--说明
tip = [[

|cffFFE799【领取条件】|r给此图来个|cffff0000五星好评|r

|cffFFE799【礼包奖励】|r|cff00ff00被攻击10%几率获得200点全属性， 暴击伤害+50%， 技暴伤害+25% |r
 ]],
--物品类型
item_type = '神符',
need_map_level = 3,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--购买价格
gold = 0,
award_physical_damage = 50,
award_magic_damage = 25,
chance = 10
}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    -- local map_level = p:Map_GetMapLevel() 
      
    local name = self.name
    if p.mall[name] and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('暴击伤害',self.award_physical_damage)
        hero:add('技暴伤害',self.award_magic_damage)

        --受到 伤害几率 加全属性
        hero:event '受到伤害效果' (function(trg, damage)
            --概率加全属性
            if math.random(100) <= self.chance then 
                hero:add('全属性',200)
            end    
        end)
        p.mall_flag[name] = true
        
        local tip = '|cffebb608【系统】|r|cff00ff00自动激活|cff00ffff 五星好评礼包 |r|cff00ff00 礼包属性可在最强魔灵-礼包中查看'
        p:sendMsg(tip,3)
    else
        p:sendMsg('|cffebb608【系统】|r|cffff0000条件不足或已领取过',2)    
    end   
end
mt.on_add = mt.on_cast_start