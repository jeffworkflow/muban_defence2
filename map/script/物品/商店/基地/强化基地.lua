
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['强化基地']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNStoneArchitecture.blp]],

--说明
tip = [[
 

提升基地 |cff00ff00100%护甲|r 和 |cff00ff00100%生命上限|r
 ]],

--物品类型
item_type = '神符',
--售价
wood = 8888,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--全属性
award_all_attr = 268888,
--护甲%
defence = 100,
--生命上限%
life = 100,
content_tip = '|cffFFE799【使用说明】：|r',
--物品技能
is_skill = true,
cnt = function(self)
    return ac.main_unit.wtf_cnt or 0
end
}

function mt:on_cast_start()
    local unit = self.seller
    if (unit.wtf_cnt or 0) >=100 then 
        player:sendMsg('|cff00ff00强化次数已达上限|r',5)
        return true
    end 

    unit:add('生命上限%',self.life)
    unit:add('护甲%',self.defence)
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:add('全属性',self.award_all_attr)
    player:sendMsg('|cffFFE799【系统消息】|r|cff00ffff'..player:get_name()..'|r 强化了基地 奖励|cff00ff00268888全属性|r',2)
    unit:add_restriction '免死'
    --增加 免伤次数
    unit.wtf_cnt = (unit.wtf_cnt or 0) + 1
    --注册事件
    if not unit.wtf_trg then 
        unit.wtf_trg = unit:event '受到伤害前效果' (function(trg, damage)
            print(unit.wtf_cnt)
            if unit.wtf_cnt >0 then 
                if not unit.bmfy_flg then 
                    unit:add('免伤几率',100)
                    unit:add('免伤几率极限',100)
                    unit.bmfy_flg = true
                end    
                unit.wtf_cnt = unit.wtf_cnt -1
            else
                unit:add('免伤几率',-100)
                unit:add('免伤几率极限',-100)
                unit.bmfy_flg = false
            end    
        end)    
    end
    --概率得 五道杠少年
    local rate = 1
    -- local rate = 80 --测试用
    if math.random(1,10000)/100 < rate then 
        local skl = hero:find_skill('五道杠少年',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','五道杠少年')
            player.is_show_nickname = '五道杠少年'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 保家爱国 精神可嘉 |r 获得成就|cffff0000 "五道杠少年" |r，奖励 |cffff0000+1000w全属性 +5杀怪加木头 +35%木头加成|r',6)
            -- ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000吸血+10%，攻击回血+50W|r',6)
        end
    end    
end
