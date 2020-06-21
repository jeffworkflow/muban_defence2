local ui = require 'ui.client.util'
local new_ui = class.panel:builder
{
    x = 1800,--假的
    y = 378,--假的
    w = 120,
    h = 120,
    is_show = false,
    name = '天选之人', 

    normal_image = '',
    --按钮传送
    bt = {
        w = 84,
        h = 84,
        type = 'button',
        normal_image = 'image\\控制台\\jingong.tga',

        remain_time = {
            type = 'text',
            y = 54,
            font_size = 15,
            align = 'center',
            color = 0xffff0000,
            text = '10:00'
        }
    },
    
    on_button_clicked = function (self)
        local info = {
            type = 'txzr',
            func_name = 'cs',
            params = {
                [1] = 1,
            }
        }
        ui.send_message(info)
    end,

    on_button_mouse_enter = function (self)
        local p = ac.player.self
        if p.current_task then 
            local title = p.current_task.name
            local tip = p.current_task.tip
            self:tooltip('|cffffe799'..title..'|r',tip,-1,300,94)
        end
    end,
    fresh_name = function(self)
        --处理 在线奖励 
        local total_time = 600 
        -- local total_time = 30 
        if self.timer then 
            self.timer:remove()
            self.timer = nil
        end

        self.timer = ac.loop(1000,function(t)
            total_time = total_time - 1
            local str = os.date("!%H:%M:%S", total_time)
            self.bt.remain_time:set_text(str)
            --时间到，没有完成，要清理任务。
            if total_time == 0  then
                --发起同步
                local info = {
                    type = 'txzr',
                    func_name = 'clear',
                    params = {
                        [1] = 1,
                    }
                }
                ui.send_message(info)

                self.timer = nil
                self:hide()
                t:remove()
            end
        end)
    end,   
    fresh = function(self,title)
        local p = ac.player.self
        -- print('刷新ui1')
        if p.current_task then 
            -- print('刷新ui2',p.current_task.art)
            self.bt:set_normal_image(p.current_task.art)
            self:fresh_name()
        end
    end,
    clear = function(self)
        if self.timer then 
            self.timer:remove()
            self.timer = nil
        end
        self:hide()
    end
}

local function clear_task(p,tab)      
    p.current_task = tab
    p.task = p.task or {}
    --清空之前任务统计使用的数据
    for name,v in pairs(p.task) do 
        p.task[name] = 0
    end
end

local ui = require 'ui.server.util'
--处理同步请求
local event = {
    clear = function (val)
        local player = ui.player 
        clear_task(player)
        player:sendMsg('很遗憾，本次任务没完成，期待下一次奖励',5)
    end,
    
    cs = function (val)
        local player = ui.player 
        local p = ui.player 
        if not p.current_task then 
            return
        end
        local list = {
            { name = "是" },
            { name = "否" },
        }
        local task_detail = p.current_task.tip 
        local title = task_detail..'\n'.."是否传送到目的地？"
        create_dialog(p,title,list,function (index)  
            --是 传送
            if index == 1 then   
                local hero = p.hero 
                local ret_handle = p.current_task.rect
                local blink_rect = ac.rect.j_rect(ret_handle)
                hero:blink(blink_rect,true,false,true)
            end  
        end) 
    end
}
ui.register_event('txzr',event)

--业务：完成圣龙气运后触发 ac.game:event_notify('任务-圣龙气运',p) 
--奖品
local award_list = { 
    ['天选之人'] =  {
        { rand = 16.6, name = '超强装备'},
        { rand = 16.6, name = '超强功法'},
        { rand = 16.6, name = '超强石头'},
        { rand = 16.6, name = '超强伤害'},
        { rand = 16.6, name = '超强属性'},
        { rand = 16.6, name = '超强卡片'},
    },

    ['超强装备'] ={
        name = '超强装备',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '藏宝图',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张藏宝图

【任务奖励】随机红色装备一个
               
        ]],
        --奖励
        award = function(self,p,hero)
            local list = ac.quality_item['红']
            local name = list[math.random(#list)]
            local it = hero:add_item(name)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了'..(it.color_name or name),5)
        end,
    },

    ['超强功法'] ={
        name = '超强功法',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '羊皮无字',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张羊皮纸

【任务奖励】随机天阶功法一个
               
        ]],
        --奖励
        award = function(self,p,hero)
            local list = ac.quality_skill['天阶']
            --添加给购买者
            local name = list[math.random(#list)]
            local it = ac.item.add_skill_item(name,hero)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了'..(it.color_name or name),5)
        end, 
    },
    ['超强石头'] ={
        name = '超强石头',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '超强石头',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张羊皮纸

【任务奖励】随机天阶功法一个
               
        ]],
        --奖励
        award = function(self,p,hero)
            local it = ac.item.create_item('天谕',hero:get_point())
            it:set_item_count(8)
            hero:add_item(it)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了'..(it.color_name or name),5)
        end, 
    },
    ['超强伤害'] ={
        name = '超强伤害',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '超强伤害',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张羊皮纸

【任务奖励】随机天阶功法一个
               
        ]],
        --奖励 全伤加深50%
        award = function(self,p,hero)
            local hero = p.hero
            hero:add('全伤加深',50)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了全伤加深',5)
        end, 
    },
    ['超强属性'] ={
        name = '超强属性',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '超强属性',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张羊皮纸

【任务奖励】随机天阶功法一个
               
        ]],
        --奖励 全属性加5%
        award = function(self,p,hero)
            local hero = p.hero
            hero:add('力量%',5)
            hero:add('敏捷%',5)
            hero:add('智力%',5)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了 全属性加5%',5)
        end, 
    },
    ['超强卡片'] ={
        name = '超强卡片',
        rect = 'cbg1',
        art = 'cqzb.blp',
        need = '超强卡片',
        need_cnt = 30,
        tip = [[
【任务条件】
获得并使用30张羊皮纸

【任务奖励】随机天阶功法一个
               
        ]],
        --奖励
        award = function(self,p,hero)
            local list = {
                '杀敌数保本卡','木头保本卡','魔丸保本卡','全属性保本卡',
                '杀敌数翻倍卡','木头翻倍卡','魔丸翻倍卡','全属性翻倍卡',
                '炸弹卡','大炸弹卡','猜拳卡','gg卡'
            }
            local name = list[math.random(#list)]
            local it = hero:add_item(name)
            ac.player.self:sendMsg('恭喜玩家 '..p:get_name()..' 获得了'..(it.color_name or name),5)
        end, 
    },

    
}



ac.game:event '任务-圣龙气运'(function(self,p)
    local time = 2*60
    -- time = 20
    local rate = 80
    print('触发圣龙精魄：',p)
    -- p.hero:loop(time*1000,function()
        --概率触发事件
        if math.random(100000)/1000 <= rate then 

            local rand_list = award_list['天选之人']
            local rand_name,rand_rate = ac.get_reward_name(rand_list)
            -- print(rand_list,rand_name)  
            if not rand_name then 
                return true
            end
            --设置当前任务。
            if not award_list[rand_name] then 
                print('没有预设任务',rand_name)
                return 
            end
            --创建对话框 询问是否替换已有的任务
            print('触发天选之人：',p)
            if p.current_task then 
                local list = {
                    { name = "是" },
                    { name = "否" },
                }
                local task_detail = award_list[rand_name].tip 
                local title = task_detail..'\n'.."是否替换已有任务？"
                create_dialog(p,title,list,function (index)  
                    -- local name = list[index].name
                    --是 替换
                    if index == 1 then   
                        clear_task(p,award_list[rand_name])
                        if p:is_self() then 
                            new_ui:fresh()
                            new_ui:show()
                        end
                    end  
                end) 
            else
                clear_task(p,award_list[rand_name])
                if p:is_self() then 
                    new_ui:fresh()
                    new_ui:show()
                end
            end

        end
    -- end)

end)

--统计回调
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task['藏宝图'] = (p.task['藏宝图'] or 0) + 1
    --文字提醒
    if p.current_task and p.current_task.name =='超强装备' then 
        p:sendMsg('任务进度'..p.task['藏宝图']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['藏宝图'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
               new_ui:clear()
            end
        end
    end
end)
ac.game:event '触发羊皮无字事件'(function(trg,skill,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task['羊皮无字'] = (p.task['羊皮无字'] or 0) + 1

    if p.current_task and p.current_task.name =='超强功法' then 
        p:sendMsg('任务进度'..p.task['羊皮无字']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['羊皮无字'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
                new_ui:clear()
            end
        end
    end
end)

ac.game:event '触发锻造事件'(function(trg,skill,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task = p.task or {}
    p.task['超强石头'] = (p.task['超强石头'] or 0) + 1

    if p.current_task and p.current_task.name =='超强石头' then 
        p:sendMsg('任务进度'..p.task['超强石头']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['超强石头'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
                new_ui:clear()
            end
        end
    end
end)

ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task['超强伤害'] = (p.task['超强伤害'] or 0) + 1

    if p.current_task and p.current_task.name =='超强伤害' then 
        p:sendMsg('任务进度'..p.task['超强伤害']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['超强伤害'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
                new_ui:clear()
            end
        end
    end
end)

ac.game:event '单位-触发抵用券' (function(_,seller,u,__it,__u_raffle)
    if not finds(__u_raffle.name,'扭蛋券') then 
        return 
    end    
    --__it 为神符类，已经被销毁
    local self = __u_raffle
    local hero = u
    local p = hero.owner
    p.task = p.task or {}
    p.task['超强属性'] = (p.task['超强属性'] or 0) + 1

    if p.current_task and p.current_task.name =='超强属性' then 
        p:sendMsg('任务进度'..p.task['超强属性']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['超强属性'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
                new_ui:clear()
            end
        end
    end
end)

ac.game:event '触发黑暗骰子事件'(function(trg,skill,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task['超强卡片'] = (p.task['超强卡片'] or 0) + 1

    if p.current_task and p.current_task.name =='超强卡片' then 
        p:sendMsg('任务进度'..p.task['超强卡片']..'/'..p.current_task.need_cnt,2)
        --完成，给奖励
        if p.task['超强卡片'] == p.current_task.need_cnt then 
            p.current_task:award(p,hero)
            p.current_task = nil
            --清理ui 
            if p:is_self() then 
                new_ui:clear()
            end
        end
    end
end)

