
local rect = require 'types.rect'


--任务系统
local task_detail = {
    ['血魔'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        --俘虏事件
        local rate = 10
        if math.random(10000/100) < rate then 
            p:create_unit('俘虏·血魔',killer:get_point()-{math.random(360),100})
        end

        if p.flag_tsjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.tsjx_cnt = (p.tsjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.tsjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.tsjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.tsjx_cnt % per_kill_cnt == 0 then 
                hero:add('杀怪加金币',100)
                hero:add('攻击加金币',100)
                hero:add('每秒加金币',100)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000杀怪+100金币，攻击+100金币，每秒+100金币|r',2)
            end

            if p.tsjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('黑心老人',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    local p = killer.owner
                    --俘虏事件
                    local rate = 10
                    if math.random(10000/100) < rate then 
                        p:create_unit('俘虏·黑心老人',killer:get_point()-{math.random(360),100})
                    end
                    p.max_tunshi_cnt = (p.max_tunshi_cnt or 8) + 1  --最大吞噬次数为9次，之前8次。
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000吞噬丹+1 物品吞噬极限+1|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_tsjx = true
            end
        end    

    end, 
}


ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    pcall(task_detail[name],killer,target)
end)    

