local panel = ac.ui.client.panel
local message = require 'jass.message'
--把魔兽自带的提示框移出屏幕外
-- japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
--还原魔兽自带的位置 
-- japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0,0.16)  
--当前指向的按钮
local MouseButton = nil
local shop_icon ={
    ['金币'] = [[UI\Widgets\ToolTips\Human\ToolTipGoldIcon.blp]],
    ['木头'] = [[UI\Widgets\ToolTips\Human\ToolTipLumberIcon.blp]],
    ['杀敌数'] = [[UI\small_kill.blp]],
    ['魔丸'] = [[UI\small_rec_ex.blp]],
    ['积分'] = [[UI\small_jifen.blp]],
    ['耗蓝'] =[[UI\Widgets\ToolTips\Human\ToolTipManaIcon.blp]],
    ['食物'] = [[UI\Widgets\ToolTips\Human\ToolTipSupplyIcon.blp]],
}
ac.shop_icon = shop_icon
local tool ={
    common = function(self)
        local new_ui = class.panel:builder
        {
            x = 1390,
            y = 400,
            w = 530,
            h = 400,
            level = 5,
            is_show = false,
            alpha = 0.8 ,
            _type = 'tooltip_backdrop',
            title = {type = 'text',x = 16,y = 16,font_size = 15,},
            create_icon = function(self)
                self.icon_buttons =self.icon_buttons or {}
                for i=1,4 do 
                    local new_ui = class.panel:builder
                    {
                        parent = self,
                        x = 16,
                        init_x = 16,
                        y = 35+16,
                        normal_image = '',
                        img = {
                            w = 22,
                            h = 22,
                            type = 'texture',
                            normal_image = '',
                        },
                        text = {
                            x = 30,
                            type = 'panel',
                            normal_image = '',
                            text = {
                                type = 'text',
                                font_size = 11,
                                text = '',
                                align = 'auto_width',
                            }
                        },
                    }
                    table.insert(self.icon_buttons,new_ui)
                end
            end,
            fresh = function(self,skill,unit)
                unit = unit or ac.dummy
                --先清空
                for i,new_ui in ipairs(self.icon_buttons) do 
                    new_ui.img:set_normal_image('')
                    new_ui.text.text:set_text('')
                end
                --改变 tip 的初始y
                local x,y = self.tip:get_position()
                y = self.tip.init_y
                --根据skill 设置对应的 icon 数据
                local icons = self:set_icons(skill,unit)

                if #icons >0 then 
                    self.tip:set_position(x,y)
                else
                    self.tip:set_position(x,y - 30)
                end
                --再根据物品货币，动态显示
                local temp_w = {}
                for i,data in ipairs(icons) do 
                    local i_path = shop_icon[data.coin]
                    self.icon_buttons[i].img:set_normal_image(i_path)
                    self.icon_buttons[i].text.text:set_text(data.val)
                    local w = ac.ui.get_auto_width(self.icon_buttons[i].text.text:get_text(),self.icon_buttons[i].text.text.font_size)
                    table.insert(temp_w,w)
                    self.icon_buttons[i].text.text:set_width(w)
                    --动态改变起始X坐标
                    if i > 1 then 
                        -- local text_w = self.icon_buttons[i-1].w
                        local text_w = temp_w[i-1]
                        local gap = text_w + 16 + 30
                        local x,y = self.icon_buttons[i-1]:get_position()
                        x =  x+gap
                        -- print('间隙：',data.coin,text_w,gap,x,self.icon_buttons[i-1].text.text:get_text(),self.icon_buttons[i-1].text.text.font_size)
                        self.icon_buttons[i]:set_position(x,y) 
                    end
                end
                --刷新其他
                local title = skill.color_name or skill:get_title()
                if skill.type_name =='技能栏' then 
                    title = skill:get_title()
                end
                local tip = skill:get_tip()..(skill.suit_tip or '')
                self.title:set_text(title)
                self.tip:set_text(tip)
                self:set_position(1380, 810 - self.h )
            end,
            tip = {type = 'text',x = 16,y = 65+22,init_y = 65+22,align = 'auto_height',font_size = 11},
            set_icons = function(self,skill,unit)
                self.icons = {}
                if unit.unit_type ~='商店' and skill.cost > 0  then
                    table.insert(self.icons,{coin = '耗蓝',val = jass.R2I(skill:get_cost())})
                end

                local item =  skill
                local gold,show_gold,player_gold = item:buy_price()
                local wood,show_wood,player_wood = item:buy_wood()
                local kill_count,show_kill_count,player_kill = item:buy_kill_count()  
                local jifen,show_jifen,player_jifen = item:buy_jifen()
                local rec_ex,show_rec_ex,player_rec_ex = item:buy_rec_ex()
                gold = player_gold or gold
                wood = player_wood or wood
                kill_count = player_kill or kill_count
                jifen = player_jifen or jifen
                rec_ex = player_rec_ex or rec_ex
                if unit.unit_type ~='商店' and item.sell_price then 
                    show_gold = item:sell_price()
                    show_wood = item:sell_wood()
                    show_kill_count = item:sell_kill_count()
                    show_jifen = item:sell_jifen()
                    show_rec_ex = item:sell_rec_ex()
                end
                if gold >0 and ((unit.unit_type ~='商店' and skill.type_name =='物品') or unit.unit_type =='商店') then 
                    skill.coin = '金币'
                    table.insert(self.icons,{coin = '金币',val = show_gold})
                end
                if wood >0 and ((unit.unit_type ~='商店' and skill.type_name =='物品') or unit.unit_type =='商店') then 
                    skill.coin = '木头'
                    table.insert(self.icons,{coin = '木头',val = show_wood})
                end
                if kill_count >0 and ((unit.unit_type ~='商店' and skill.type_name =='物品') or unit.unit_type =='商店') then 
                    skill.coin = '杀敌数'
                    table.insert(self.icons,{coin = '杀敌数',val = show_kill_count})
                end
                if rec_ex >0 and ((unit.unit_type ~='商店' and skill.type_name =='物品') or unit.unit_type =='商店') then 
                    skill.coin = '魔丸'
                    table.insert(self.icons,{coin = '魔丸',val = show_rec_ex})
                end
                if jifen >0 and ((unit.unit_type ~='商店' and skill.type_name =='物品') or unit.unit_type =='商店') then 
                    skill.coin = '积分'
                    table.insert(self.icons,{coin = '积分',val = show_jifen})
                end
                return self.icons
            end
        }
        self['通用'] = new_ui
        self.show_tips = self.show_tips or {}
        table.insert(self.show_tips,new_ui)
        return new_ui
    end,
    hide = function(self)
        for i,new_ui in ipairs(self.show_tips) do 
            new_ui:hide()
        end
        -- class.panel.hide(self['通用'])
        --还原魔兽自带的位置 
        japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0,0.16)
    end,
    show =function(self,name)
        class.panel.show(self[name])
        -- class.panel.show(self)
        --把魔兽自带的提示框移出屏幕外
        japi.FrameSetPoint(japi.FrameGetTooltip(),8,game_ui,8,0.3,0.16)
    end,
    init_data = function(self)
        self:common():create_icon()
    end,
    add = function(self,new_ui)
        if not new_ui.name then 
            return 
        end
        self.show_tips = self.show_tips or {}
        table.insert(self.show_tips,new_ui)
        self[new_ui.name] = new_ui
        return self
    end
}
tool:init_data()
ac.ui.tooltip = tool
--更新提示框
function panel.updateToolTip(button)
    if button == nil then
        tool:hide()
        return
    end

    local unit = ac.unit.j_unit(japi.GetRealSelectUnit())
    if unit == nil then
        tool:hide()
        return
    end
    local skill 
    if button.type_name == '技能栏' then 
        if unit.unit_type == '商店' and unit.sell_item_list then 
            skill = unit.sell_item_list[button.old_slot_id]
        else
            local skl = unit:find_skill( button.slot_id, unit.skill_page or '英雄',true)
            skill = skl 
            if skill then 
                skill.type_name = '技能'
            end
            -- if skl and skl.is_ui_text then 
            --     skill = skl 
            -- end
            -- print('打印当前指向的技能',skill,button.slot_id,(unit.skill_page or '英雄'))
        end
    elseif button.type_name == '物品栏' then 
        skill = unit:get_slot_item(button.slot_id)
        if skill then 
            skill.type_name = '物品'
        end
    end     
    if not skill then 
        tool:hide()
        return
    end
    if skill.fetter then
        -- tool.fetter_tool_tip:fresh()
        tool['英雄tip']:fresh(skill,unit)
        tool:show('英雄tip')
    elseif skill.show_ui then 
        tool[skill.show_ui]:fresh(skill,unit)
        tool:show(skill.show_ui)
    else
        tool['通用']:fresh(skill,unit)
        tool:show('通用')
    end
end
local MouseButton
--鼠标进入事件
function panel:on_button_mouse_enter(button)
    MouseButton = button
    panel.updateToolTip(MouseButton)
    panel.show_skill_range(MouseButton)
end
--鼠标离开事件
function panel:on_button_mouse_leave(button)
    MouseButton = nil
    tool:hide()
    panel.hide_skill_range()
end

--画按钮
local function init()
    local slots = {9,10,11,12,5,6,7,8,1,2,3,4}
    
    local function create_button(p,x,y,w,h)
        local button = p:add_button('',x,y,w,h)
        return button
    end

    local slot_id = 0
    --整个技能栏的面板
    local skillPanel = panel:add_panel('',1480,841,417,230)
    local buttonList = {}
    --画12个技能栏按钮
    for row = 0, 2 do
        local y = 3 + row * 68 + row * 9
        for column = 0, 3 do 
            slot_id = slot_id + 1
            local x = 4 + column * 90 + column * 15
            local button = create_button(skillPanel,x, y, 90, 68)
            button.old_slot_id = slot_id
            button.slot_id = slots[slot_id]
            button.type_name = '技能栏'
            buttonList[slot_id] = button
        end 
    end

    skillPanel.buttonList = buttonList
    panel.skillPanel = skillPanel

    slot_id = 0
    --整个物品栏的面板
    local itemPanel = panel:add_panel('',1235,875,179,201)
    local buttonList = {}
    for row = 0,2 do
        local y = 4 + row * 56 + row * 13
        for column = 0,1 do 
            slot_id = slot_id + 1
            local x = 4 + column * 75 + column * 21
            local button = create_button(itemPanel,x, y, 75, 56)
            button.slot_id = slot_id
            button.type_name = '物品栏'
            buttonList[slot_id] = button
        end 
    end
    itemPanel.buttonList = buttonList
    panel.itemPanel = itemPanel

    local button = create_button(panel,989,908,65,49)
    button.type_name = '属性栏'
end
init()

--每秒刷新
game.loop(1000,function()
    --如果正在看 分享界面 返回
    -- print(ac.is_sharing)
    if ac.is_sharing then 
        return 
    end
    if ac.player.self then
        ac.ui.client.panel.updateToolTip(MouseButton)
        -- ac.ui.client.panel.updateAttr()
    end
end)

function panel.show_skill_range(button)
    if not ac.range then 
        return 
    end
    if button == nil then
        panel.hide_skill_range()
        return
    end

    local unit = ac.unit.j_unit(japi.GetRealSelectUnit())
    if unit == nil then
        panel.hide_skill_range()
        return
    end
    
    local skill 
    if button.type_name == '技能栏' then 
        if unit.unit_type == '商店' and unit.sell_item_list then 
            skill = unit.sell_item_list[button.old_slot_id]
        else
            local skl = unit:find_skill( button.slot_id, unit.skill_page or '英雄',true)
            skill = skl 
            -- if skl and skl.is_ui_text then 
            --     skill = skl 
            -- end
            -- print('打印当前指向的技能',skill,button.slot_id,(unit.skill_page or '英雄'))
        end
    elseif button.type_name == '物品栏' then 
        skill = unit:get_slot_item(button.slot_id)
    end     
    if not skill then 
        panel.hide_skill_range()
        return
    end
    local range = ac.range
    if skill.range then
        range:set_model('t5_attackringa.mdx')
        local size = skill.range / 200
        range:set_size(size)
        range:set_position(unit:get_point()) 
    else
        range:set_model('.mdx')
    end
    
end
function panel.hide_skill_range()
    if not ac.range then 
        return 
    end
    local range = ac.range
    range:set_model('.mdx')
end


------------==开始复制通用 tooltip-------------------
function get_str_line(str,count)
    local a = 1
    local b = 1
    local c = 0
    local line = 0
    count = count - 3
    str = str:gsub('|c%w%w%w%w%w%w%w%w','')
    str = str:gsub('|r','')
     while (a <= str:len()) do
        local s = str:sub(a,a)
        if s:byte() > 127 then
            c = c+1
            if c == 3 then
                c = 0
            end
        else
            c = 0
        end
        if (b > count and c == 0) or s == '\n' or a == str:len() then
            if s == '\n' then
                s = str:sub(a - b + 1,a - 1)
            else
                s = str:sub(a - b + 1,a)
            end
            line = line + 1
            b = 0
        end
        a = a+1
        b = b+1
    end
    return line
end
local tool2 = class.panel:builder
{
    _type = 'tooltip_backdrop',
    x = 0,--假的
    y = 0,--假的
    w = 350,
    h = 200,
    level = 5,
    is_show = false,
    alpha = 0.8,

    title = {type = 'text',x = 16,y = 16,font_size = 15,},
    -- off_tip_x = 
    tip = {type = 'text',x = 16,y = 65,old_x=16,old_y=65,align = 'auto_height',font_size = 11,},
}
local tools ={
    tooltip = function (self,title,tip,pos,pWidth,pHeight,font_size)
        
        local width,height = pWidth or 350 ,pHeight or 200
        local x,oy = self:get_real_position() 

        local max_height = get_str_line(tip or [[]],13*3-1) * 24 + 32
        if max_height < height then 
            max_height = height
        end 
        y = oy - max_height / 2 + self.h / 2 

        if pos == nil or pos == 0 then 
            x = x + self.w + 5 
        elseif pos == 1 or pos == -1 then 
            x = x - width - 5 
        elseif pos == 2 then 
            x = x - width / 2  + self.w / 2
            y = oy - max_height
        end 

        x = math.min(math.max(10,x),1900)
        y = math.min(math.max(10,y),1080)

        local title_str = title
        local title_align = 'auto_newline'
        if type(title) == 'table' then 
            title_str = title[1] 
            title_align = title[2]
        end 

        tool2.tip:set_width(width or 530)
        tool2.title:set_text(title)
        tool2.tip:set_text(tip)
        if title == '' or not title then 
            tool2.tip:set_position(tool2.tip.x,tool2.title.y)
        else 
            tool2.tip:set_position(tool2.tip.old_x,tool2.tip.old_y)
        end    
        if anchor then 
            self:set_tooltip_follow(tool2, anchor)
        else 
            tool2:set_position(x, y)
        end 
        tool2:show()
    end,
    remove_tooltip = function(self)
        tool2:hide()
    end,
}
ac.tooltip = tooltip

local real_remove = class.ui_base.remove_tooltip
for name, func in pairs(tools) do 
    class.ui_base[name] = func
end 
tools.old_remove_tooltip =  real_remove


-- tool['通用']
-- ac.loop(0.01*1000,function()
--     local name = ac._all_skill[math.random(#ac._all_skill)]
--     local skill = ac.skill[name]
--     skill.owner = ac.dummy
--     ac.ui.tooltip['通用']:fresh(skill,nil)
--     ac.ui.tooltip:show('通用')
--     ac.is_sharing = true


-- end)