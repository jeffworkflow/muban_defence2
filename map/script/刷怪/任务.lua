
local rect = require 'types.rect'

local temp_sl = {
    ['二郎'] = 1,
    ['七郎'] = 2,
    ['判官'] = 3,
    ['马面'] = 4,
    ['牛头'] = 5,
    ['夜叉'] = 6,
    ['辟邪'] = 7,
    ['狐仙'] = 8,
    ['龙女'] = 9,
    ['刑天'] = 10,
}
--任务系统
local task_detail = {
    ['血魔'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        --俘虏事件
        local rate = 0.5
        if math.random(10000)/100 < rate and (p.flxm or 0) < 11 then 
            local u = p:create_unit('俘虏·血魔',killer:get_point()-{math.random(360),100})
            p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00触发俘虏事件',2)
            p.flxm = (p.flxm or 0)+ 1
        end

        if p.flag_tsjx then return end
        local per_kill_cnt = 10 --每20只给奖励
        local max_kill_cnt = 50 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.tsjx_cnt = (p.tsjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.tsjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前屠魔进度：|cffff0000'..(p.tsjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.tsjx_cnt % per_kill_cnt == 0 then 
                hero:add('攻击速度',5)
                hero:add('分裂伤害',5)
                hero:add('全属性',200)
                p:sendMsg('|cffFFE799【系统消息】|r完成屠魔任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000全属性+200，分裂伤害+5%，攻击速度+5%|r',2)
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
                    local rate = 2.5
                    if math.random(10000)/100 < rate then 
                        p:create_unit('俘虏·黑心老人',killer:get_point()-{math.random(360),100})
                        p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00触发俘虏事件',2)
                    end
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00剿灭魔教成功，奖励|r |cffff0000【噬血珠】|r',6)
                    hero:add_item('噬血珠',true)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000黑心老人|r已出现，小心他的|cffff0000冰火爪|r',2)
                p.flag_tsjx = true
            end
        end    

    end, 
    
    ['二郎侍卫 七郎侍卫 判官侍卫 马面侍卫 牛头侍卫 夜叉侍卫 辟邪侍卫 狐仙侍卫 龙女侍卫 刑天侍卫'] = 
    function(killer,target)
        local name = target:get_name()
        local skill_name = string.sub(name,1,-2)
        -- if not finds(name,'侍卫') then  return end 
        local p = killer:get_owner()
        local task_name = finds(skill_name,'侍卫') and string.sub(skill_name,1,-7) or skill_name
        -- print(name,skill_name,task_name)
        p.flag_all = p.flag_all or {}
        p.task_cnt = p.task_cnt or {}
        if p.flag_all[name] then return end
        p.flag_all[name] = true 
        p.task_cnt[task_name] = (p.task_cnt[task_name] or 0) + 1

        --加属性
        local hero = p.hero
        local skl = hero:add_skill(skill_name..'1','隐藏')
        if finds(skill_name,'侍卫') then
            p:sendMsg('|cffFFE799【系统消息】|r完成屠魔任务：|cffff0000'..p.task_cnt[task_name].. '|r/4，获得|cffff0000'..skl:get_tip()..'|r',2)
        else    
            p:sendMsg('|cffFFE799【系统消息】|r完成屠魔任务：获得|cffff0000'..skl:get_tip()..'|r',2)
        end
        
        if p.task_cnt[task_name] == 4 then 
            --boss事件
            -- local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
            -- print('shoulei'..temp_sl[task_name]..'6')
            local point = ac.rect.j_rect('shoulei'..temp_sl[task_name]..'6')
            local unit = ac.player(12):create_unit(task_name,point,270)
            unit:add_buff '定身'{
                time = 2
            }
            unit:add_buff '无敌'{
                time = 2
            }
            unit:event '单位-死亡' (function(_,unit,killer) 
                local p = killer.owner
                hero:add_item('狩猎1',true)
            end)    
            p:sendMsg('|cffFFE799【系统消息】|r|cffff0000'..task_name..'|r已出现，小心他的|cffff0000冰火爪|r',2)


        end    

    end, 
}
local mt = ac.skill['二郎侍卫1']{
    ['攻击速度'] =25,
    tip = [[攻击速度+25%]],
}

local mt = ac.skill['七郎侍卫1']{
    ['攻击速度'] =25,
    tip = [[攻击速度+25%]]
}

local mt = ac.skill['二郎1']{
    ['攻击速度'] =25,
    tip = [[攻击速度+25%]],
    fall_item = '狩猎1'
}



ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    local like_name = string.sub(name,1,-2)
    -- print(name,like_name)
    for k,v in pairs(task_detail) do 
        if finds(k,name) or finds(k,like_name) then 
            pcall(task_detail[k],killer,target)
        end
    end  
end)    

