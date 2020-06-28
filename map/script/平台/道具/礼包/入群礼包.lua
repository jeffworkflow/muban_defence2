local mt = ac.skill['入群礼包']
mt{
--等久
level = 0,
--图标
art = [[qhlb.blp]],
is_order = 1,
is_skill =true ,
content_tip = '',
--说明
tip = [[

|cffFFE799【领取条件】|r进入官方交流群|cffff0000(群号288678028)|r 获得隐藏密码

|cffFFE799【礼包奖励】|r|cff00ff00全属性+10000，初始杀敌数+250|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
qq_qum = [[good魔灵]],
award_all_attr = 10000,
award_kill_cnt = 250,
}

function mt:on_cast_start()
    local p = self.owner:get_owner()
    p:sendMsg('|cffebb608【系统】|r|cffff0000已领取或条件不足')
end


function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    --添加给英雄
    hero:add('全属性',self.award_all_attr)
    hero:add_kill_count(self.award_kill_cnt)
    local tip = '|cffebb608【系统】|r恭喜 |cff00ffff'..p:get_name()..'|r 获得|cffff0000入群礼包|r |cffFFE799【礼包奖励】|r|cff00ff00全属性+10000，杀敌数+500|r'
    ac.player.self:sendMsg(tip,3)
   
end



ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
    local p = player
    --输入 群号给奖励
    if string.lower(str) == mt.qq_qum then
        if not player.is_qq_qum  then 
           local skl = hero:find_skill('入群礼包',nil,true)
           skl:set_level(1)
           player.is_qq_qum = true
        end    
    end
end)    