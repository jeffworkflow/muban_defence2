local ui = require 'ui.client.util'
local new_ui = class.panel:builder
{
    x = 1800,--假的
    y = 408,--假的
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
        normal_image = 'ahtxz.blp',

        remain_time = {
            type = 'text',
            y = 64,
            font_size = 12,
            align = 'center',
            color = 0xffff0000,
            text = '10:00'
        },
        on_button_clicked = function (self)
            print('天选之人点击传送',ac.player.self)
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
    },
    
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
    end,
    show1 = function(self)
        self:show()
        self.bt:add_frame(38,-42,1.24,{1,1.38,1})
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
        -- print('点击同步后,准备弹窗1',p)
        if not p.current_task then 
            return
        end
        --取消动态边框
        if p:is_self() then 
            if new_ui.bt.model_frame then 
                new_ui.bt.model_frame:hide()
            end
        end
        -- print('点击同步后,准备弹窗2',p)
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
local function create_boss(where)
    local u = ac.player(12):create_unit('太阳神',where)
    u:add_skill('金色鎏金','英雄')
    u:add_skill('金色莲花','英雄')
    u:add_skill('净化','英雄')
    u:event '单位-死亡'(function(_,unit,killer)
        --绝世神剑
        for i=1,6 do 
            local p = ac.player(i)
            local hero =p.hero
            if p:is_player() then 
                local name = '绝世神剑'
                local key = ac.server.name2key(name)
                if p:Map_GetServerValue(key) < ac.skill[name].max_level  then 
                    --激活成就（存档） 
                    p:Map_AddServerValue(key,1) --网易服务器
                    --动态插入魔法书
                    local skl = hero:find_skill(name,nil,true) 
                    if not skl  then 
                        ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',name)
                        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00太阳神已被击杀，恭喜玩家 |cff00ffff'..p:get_name()..'|r获得|cffff0000【可存档成就】'..name..'|r，成就属性可在“最强魔灵-隐藏成就”中查看',6) 
                    else
                        skl:upgrade(1)
                        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00太阳神已被击杀，恭喜玩家|cff00ffff'..p:get_name()..'|r 的|cffff0000【可存档成就】'..name..'|r得到了升级，升级后的属性可在“最强魔灵-隐藏成就”中查看',6) 
                    end   
                end   
            end
        end
    end)

end
--检测 天选之人 全体完成次数，进入 神魔之剑
local succ_cnt = 0
local function check_txzr(flag) 
    succ_cnt = succ_cnt + 1
    if not flag then 
        if succ_cnt ~= 7 then 
            return 
        end
    end
    --触发万象天工
    ac.wait(0,function()
        ac.player.self:sendMsg('|cffffe799【团队任务开启！】|r |cffffff00基地左上方|cff00ff00出现了一个古老的魔法阵，传说通过它可以前往|cff00ffff 万象天宫 |cff00ff00，杀死里面的太阳神，所有玩家可获得 |cffff0000可存档神器【绝世神剑】|r',5)
        ac.player.self:sendMsg('|cffffe799【团队任务开启！】|r |cffffff00基地左上方|cff00ff00出现了一个古老的魔法阵，传说通过它可以前往|cff00ffff 万象天宫 |cff00ff00，杀死里面的太阳神，所有玩家可获得 |cffff0000可存档神器【绝世神剑】|r',5)
        ac.player.self:sendMsg('|cffffe799【团队任务开启！】|r |cffffff00基地左上方|cff00ff00出现了一个古老的魔法阵，传说通过它可以前往|cff00ffff 万象天宫 |cff00ff00，杀死里面的太阳神，所有玩家可获得 |cffff0000可存档神器【绝世神剑】|r',5)
    end)
    --创建魔法阵
    local rect = ac.rect.j_rect('npc2')
    local target_rect = ac.rect.j_rect('jueshishenjian') 
    ac.effect_ex{
        -- model = [[dr_chuansongzhan.mdx]],
        model = [[Void Teleport Yellow To.mdx]],
        
        size = 1.1,
        point = rect:get_point()

    }
    local reg = ac.region.create(rect)  
    reg:event '区域-进入' (function(trg, hero)
        if reg < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
            --传送到另一个地方
            hero:blink(target_rect,true,false,true)

        end
    end)
    --创建boss
    local where = ac.rect.j_rect('jueshishenjian1'):get_point()
    create_boss(where)
end
ac.check_txzr = check_txzr
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
|cff00ff00点击前往|cff00ffff 藏宝阁|cff00ff00

|cffffe799【任务条件】|r     
|cff00ff00获得并成功使用|cffffff0030张藏宝图     

|cffffe799【任务奖励】|r|cff00ff00随机红装         
        ]],
        --奖励
        award = function(self,p,hero)
            check_txzr()
            local list = ac.quality_item['红']
            local name = list[math.random(#list)]
            local it = hero:add_item(name)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强装备】|cff00ff00，获得'..(it.color_name or name),5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强装备】|cff00ff00，获得'..(it.color_name or name),5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强装备】|cff00ff00，获得'..(it.color_name or name),5)
        end,
    },

    ['超强功法'] ={
        name = '超强功法',
        rect = 'cjg1',
        art = 'cqgf.blp',
        need = '羊皮无字', 
        need_cnt = 30,
        tip = [[
|cff00ff00点击传送到|cff00ffff 藏经阁

|cffffe799【任务条件】|r 
|cff00ff00获得并成功使用|cffffff0030张羊皮纸或
无字天书     

|cffffe799【任务奖励】|r|cff00ff00随机天阶功法         
        ]],
        --奖励
        award = function(self,p,hero)
            check_txzr()
            local list = ac.quality_skill['天阶']
            --添加给购买者
            local name = list[math.random(#list)]
            local it = ac.item.add_skill_item(name,hero)
            
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强功法】|cff00ff00，获得'..(it.color_name or name),5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强功法】|cff00ff00，获得'..(it.color_name or name),5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强功法】|cff00ff00，获得'..(it.color_name or name),5)
        end, 
    },
    ['超强石头'] ={
        name = '超强石头',
        rect = 'jianzhong1',
        art = 'cqst.blp',
        need = '超强石头',
        need_cnt = 30,
        tip = [[
|cff00ff00点击前往|cff00ffff 剑冢

|cffffe799【任务条件】|r 
|cff00ff00获得并成功使用
|cffffff0030个强化石或天谕     
  
|cffffe799【任务奖励】|r|cff00ff008个天谕        
        ]],
        --奖励
        award = function(self,p,hero)
            check_txzr()
            local it = ac.item.create_item('天谕',hero:get_point())
            it:set_item_count(8)
            hero:add_item(it)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强石头】|cff00ff00，获得 |cffff00008个天谕',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强石头】|cff00ff00，获得 |cffff00008个天谕',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强石头】|cff00ff00，获得 |cffff00008个天谕',5)
        end, 
    },
    ['超强伤害'] ={
        name = '超强伤害',
        rect = 'bhg1',
        art = 'cqsh.blp',
        need = '超强伤害',
        need_cnt = 30,
        tip = [[
|cff00ff00点击前往|cff00ffff 百花宫|cff00ff00   

|cffffe799【任务条件】|r 
|cff00ff00获得并成功使用
|cffffff0030个一个神奇的种子    
   
|cffffe799【任务奖励】|r|cff00ff00全伤加深+50%
       ]],
        --奖励 全伤加深50%
        award = function(self,p,hero)
            check_txzr()
            local hero = p.hero
            hero:add('全伤加深',50)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强伤害】|cff00ff00，奖励 |cffff0000全伤加深+50%',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强伤害】|cff00ff00，奖励 |cffff0000全伤加深+50%',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强伤害】|cff00ff00，奖励 |cffff0000全伤加深+50%',5)
        end, 
    },
    ['超强属性'] ={
        name = '超强属性',
        rect = 'longgong1',
        art = 'cqsx.blp',
        need = '超强属性',
        need_cnt = 30,
        tip = [[
|cff00ff00点击前往|cff00ffff 龙宫

|cffffe799【任务条件】      
|cff00ff00获得并成功使用|cffffff0030张扭蛋券（十连抽）或 
超级扭蛋券（十连抽）   

|cffffe799【任务奖励】|r|cff00ff00全属性+10%         
        ]],
        --奖励 全属性加5%
        award = function(self,p,hero)
            check_txzr()
            local hero = p.hero
            hero:add('力量%',10)
            hero:add('敏捷%',10)
            hero:add('智力%',10)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强属性】|cff00ff00，奖励 |cffff0000全属性+10%',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强属性】|cff00ff00，奖励 |cffff0000全属性+10%',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强属性】|cff00ff00，奖励 |cffff0000全属性+10%',5)
        end, 
    },
    ['超强卡片'] ={
        name = '超强卡片',
        rect = 'zeds1',
        art = 'ahtxz.blp',
        need = '超强卡片',
        need_cnt = 30,
        tip = [[
|cff00ff00点击前往|cff00ffff 罪恶城堡

|cffffe799【任务条件】|r 
|cff00ff00获得并成功使用|cffffff0030个黑暗骰子     

|cffffe799【任务奖励】|r|cff00ff00随机超强卡片         
        ]],
        --奖励
        award = function(self,p,hero)
            check_txzr()
            local list = {
                '杀敌数保本卡','木头保本卡','魔丸保本卡','全属性保本卡',
                '杀敌数翻倍卡','木头翻倍卡','魔丸翻倍卡','全属性翻倍卡',
                '炸弹卡','大炸弹卡','猜拳卡','gg卡'
            }
            local name = list[math.random(#list)]
            local it = hero:add_item(name)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强卡片】|cff00ff00，获得|cffff0000'..it.name,5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强卡片】|cff00ff00，获得|cffff0000'..it.name,5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00历经千经万苦，|cff00ffff '..p:get_name()..' |cff00ff00终于完成任务|cffffff00【超强卡片】|cff00ff00，获得|cffff0000'..it.name,5)
        end, 
    },

    
}

ac.game:event '任务-圣龙气运'(function(self,p)
    local time = 2*60
    -- time = 10
    p.hero:loop(time*1000,function()
        -- 天选之人概率
        p.txzr_cnt = (p.txzr_cnt or 0) + 1
        local rate = 18 - ((p.txzr_cnt-1)*0.5)
        -- local rate = 90 - ((p.txzr_cnt-1)*0.5)
        rate = rate * (1 + p:get('天选之人概率')/100)
        print('触发天选之人：',p,rate,p.txzr_cnt,p:get('天选之人概率'))

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
            local hero = p.hero 
            ac.effect_ex{
                model = [[206.mdx]],
                point = hero:get_point(),
                size = 1.5
            }:remove()
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00天将降大任于斯人也！天空突然一道闪电划过，|cff00ffff '..p:get_name()..' |cff00ff00成为了|cffff0000 天选之人|cff00ff00，获得任务 |cffffff00【'..rand_name..'】 |cff00ff00，任务可在|cffffff00屏幕右方|cff00ff00查看',8)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00天将降大任于斯人也！天空突然一道闪电划过，|cff00ffff '..p:get_name()..' |cff00ff00成为了|cffff0000 天选之人|cff00ff00，获得任务 |cffffff00【'..rand_name..'】 |cff00ff00，任务可在|cffffff00屏幕右方|cff00ff00查看',8)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00天将降大任于斯人也！天空突然一道闪电划过，|cff00ffff '..p:get_name()..' |cff00ff00成为了|cffff0000 天选之人|cff00ff00，获得任务 |cffffff00【'..rand_name..'】 |cff00ff00，任务可在|cffffff00屏幕右方|cff00ff00查看',8)
            --创建对话框 询问是否替换已有的任务
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
                            new_ui:show1()
                        end
                    end  
                end) 
            else
                clear_task(p,award_list[rand_name])
                if p:is_self() then 
                    new_ui:fresh()
                    new_ui:show1()
                end
            end

        end
    end)

end)

--统计回调
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero.owner
    p.task = p.task or {}
    p.task['藏宝图'] = (p.task['藏宝图'] or 0) + 1
    --文字提醒
    if p.current_task and p.current_task.name =='超强装备' then 
        p:sendMsg('|cffffe799【系统消息】|r当前挖宝任务进度 |cffff0000'..p.task['藏宝图']..'|r/'..p.current_task.need_cnt,2)
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
        p:sendMsg('|cffffe799【系统消息】|r当前看书任务进度 |cffff0000'..p.task['羊皮无字']..'|r/'..p.current_task.need_cnt,2)
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
        p:sendMsg('|cffffe799【系统消息】|r当前强化任务进度 |cffff0000'..p.task['超强石头']..'|r/'..p.current_task.need_cnt,2)
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
        p:sendMsg('|cffffe799【系统消息】|r当前种树任务进度 |cffff0000'..p.task['超强伤害']..'|r/'..p.current_task.need_cnt,2)
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
        p:sendMsg('|cffffe799【系统消息】|r当前白嫖任务进度 |cffff0000'..p.task['超强属性']..'|r/'..p.current_task.need_cnt,2)
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
        p:sendMsg('|cffffe799【系统消息】|r当前摇骰子任务进度 |cffff0000'..p.task['超强卡片']..'|r/'..p.current_task.need_cnt,2)
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

