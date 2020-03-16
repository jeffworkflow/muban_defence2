
local slot = {
    1,2,3,4,5,
    14,6,13,7,
    12,11,10,9,8
}
--业务：抽奖 类似 王者荣耀 夺宝
local new_ui = class.panel:builder
{
    x = 430,--假的
    y = 142,--假的
    w = 1068,
    h = 607,
    level = 5,
    -- is_show = true,
    is_show = false,
    normal_image = [[image\抽奖\bg.blp]],
    alpha = 0.7,

    --关闭按钮
    close_button = {
        type = 'button',
        x = 1068 -32-5,
        y = 5,
        w = 32,
        h = 32,
        normal_image = 'image\\抽奖\\close.tga',
        has_ani = true,
        on_button_clicked = function (self,button)
            local pannel = self.parent
            pannel:hide()
        end, 
    },
    --开始按钮
    start_button = {
        type = 'button',
        x = 415,
        y = 280,
        w = 241,
        h = 59,
        normal_image = [[image\抽奖\btn_start.tga]],
        has_ani = true,
        on_button_clicked = function(self)
            local p = ac.player.self
            
            p.save_coin = 10 --测试
            if p.save_coin or 0  >= 1 then 
                p.save_coin = p.save_coin -1 

                local pannel = self.parent
                local name = pannel:get_reward_name()
                pannel:start(1,name)
                self:hide()
            else
                p:sendMsg('票子不够')
            end
        end
    },
       

    award_list = {
        { rand = 10,      name = '食物链顶端的人'},
        { rand = 10,     name = '秀才'},
        { rand = 10,      name = '举人'},
        { rand = 10,      name = '进士'},
        { rand = 10,      name = '探花'},
        { rand = 10,      name = '榜眼'},
        { rand = 10,      name = '状元'},
        { rand = 10,      name = '王昭君'},
        { rand = 10,      name = '王昭君1'},
        { rand = 2,      name = '王昭君2'},
        { rand = 0.1,      name = '王昭君3'},
        { rand = 0.2,      name = '王昭君4'},
        { rand = 0.3,      name = '王昭君5'},
        { rand = 0.4,      name = '王昭君6'},
        { rand = 7,      name = '王昭君7'},
    },

    
    --预设20个奖品位置
    create_btns = function(self)
        self.btns = {}
        self.choose_btns = {}
        local space = 2 --字间距
        local base_i = 1
        local base_x = 67
        local base_y = 56
        local ix = 1
        for i =1,20 do 
            if i == 7 or i == 8 or i == 9 or i == 12 or i == 13 or i == 14 then
            else 
                -- local pic = self:add_button(img_path, base_x +(base_i-1)*(space+186), base_y, 186, 124)
                -- print(slot[ix],self.award_list[slot[ix]],self.award_list[slot[ix]].name)
                local name = self.award_list[slot[ix]].name
                local pic = self:add_award_ui(base_x +(base_i-1)*(space+186), base_y,name)
                self.btns[slot[ix]] = pic
                local pic = self:add_button([[]], base_x +(base_i-1)*(space+186), base_y, 186, 124)
                self.choose_btns[slot[ix]] = pic
                ix = ix + 1
            end

            base_i = base_i + 1
            if i%5 == 0 then 
                base_y = base_y + 124 + space
                base_i = 1
            end
        end  

    end,
    add_award_ui = function(self,x,y,name)
        local skl = ac.skill[name]
        -- print('art:',name,skl.art,skl.tip)
        local award_ui = class.panel:builder
        {
            parent = self,
            x = x,--假的
            y = y,--假的
            w = 186,
            h = 124,
            normal_image = [[image\抽奖\bg_award.tga]],--背景
            name = name,
            icon = {
                type = 'texture',
                x = 55,
                y = 13,
                w = 76,
                h = 76,
                normal_image = skl.art,--背景
            },
            btn = {
                type = 'button',
                x = 55,
                y = 13,
                w = 76,
                h = 76,
                normal_image = [[]],--背景
                on_button_mouse_enter = function(self)
                    -- print('按钮进入咯')
                    self:tooltip(skl:get_title(),skl:get_tip(),0,400,84,10)
                end   
            },
            text = {
                type = 'text',
                x = 55,
                y = 98,
                w = 76,
                h = 16,
                text = name,
                align = 'center',
                font_size =10,
            },
        }
        return award_ui
    end,
    start = function(self,start,target)
        --一共转多久
        local time =2 
        local speed = 0.05 --0.1秒位移一个物品
        local moved = 0 --已经位移数
        local max_cnt = math.floor(time/0.01 + speed *20 /0.01)
        ac.timer(0.01 * 1000,max_cnt,function(t)
            if ('%.2f').format(t.cnt * 0.01) ~= ('%.2f').format(speed * (moved +1)) then 
                return
            end 
            moved = moved + 1 
            local slot = (start + moved) % 14 
            slot = slot == 0 and 14 or slot
            -- print('激活：',slot)
            self.choose_btns[slot]:set_normal_image([[image\抽奖\bg_choosed.tga]])
            --抽中
            if t.cnt * 0.01 >= time and self.btns[slot].name == target then 
                print('中奖啦：',slot,self.btns[slot].name,target)
                self.choose_btns[slot]:blink(0.7,0.2,true)
                self.start_button:show()
                t:remove()
            else
                self.choose_btns[slot]:fade(0.3) --淡化2秒
            end
        end)


    end,
    get_reward_name = function(self)
        local rand_list = self.award_list
        local rand_name,rand_rate = ac.get_reward_name(rand_list)
        return rand_name,rand_rate
    end,  
    --初始化
    new = function(self)
        local pannel = self
        self:create_btns()
        --  --拥有多少门票
         local has_tickets = self:add_text('拥有 |cff00ff00100|r',415,348, 241, 24,12,'center')
    end,    

}
ac.wait(100,function()
    new_ui:new()
end)

local game_event = {}
game_event.on_key_down = function (code)
    -- if code == KEY.F5 then 
    --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
    -- end
    if code == KEY.F7 then 
        if new_ui == nil then return end 
        if new_ui.is_show then 
            new_ui:hide()
        else 
            new_ui:show()
        end 
    elseif code == KEY.ESC then 
        new_ui:hide()
    end 
end 
game.register_event(game_event)


--淡化
function class.ui_base:fade(time)
    --进行淡化
    ac.timer(time/100 * 1000,100,function(t)
        -- print((100-t.cnt)/100) 
        self:set_alpha((100-t.cnt)/100)
    end)
end   

--闪烁
function class.ui_base:blink(time,speed,keep)
    local time = time or 1
    local speed = speed or 0.2 --一闪烁来回时间
    local per_speed = 100 /(speed / 2 /0.001) 
    local flag=1
    local current_alpha = 1
    ac.timer(0.001*1000,math.floor(time/0.001),function(t)

        current_alpha = (current_alpha*100 - per_speed * flag)/100
        -- print('闪烁:',current_alpha)
        self:set_alpha(current_alpha)
        --变淡
        if current_alpha <= 0 then 
            flag = -1
        elseif current_alpha >= 1 then 
            flag = 1
        end

        if t.count <=0  then 
            local v = keep and 1 or 0 
            self:set_alpha(v)
        end
        
    end)
end   