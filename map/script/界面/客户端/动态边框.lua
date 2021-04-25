
local tools ={
    add_frame = function (self,off_x,off_y,size,off_size,is_show,on_hide)
        -- print(333,self)
        if self.model_frame then 
            self.model_frame.is_show1 = is_show
            self.model_frame.on_hide = on_hide
            self.model_frame:show()
            return
        end
        local new_ui = class.panel:builder
        {
            parent = self,
            x = 800,--假的
            y = 800,--假的
            w = 80,
            h = 80,
            level = 5,
            is_show = false,
            normal_image = 'Transparent.tga',
            btn = {
                type = 'button',
            },
            model = {
                type = 'model',
                size = 1,
                model = [[tx6.mdx]],
            },
            get_show = function(self)
                -- print('动态边框',self.is_show1)
                return self.is_show1
            end,
            on_hide = on_hide
        }
        new_ui.is_show1 = is_show
        --默认为传进来控件的坐标
        new_ui:set_real_position(self:get_real_position())
        -- print('边框位置：',self:get_real_position())

        if off_x and off_y then 
            new_ui.model:set_model_offset(off_x,off_y)
        end    
        if size then 
            new_ui.model:set_size(size)
        end   
        if off_size then 
            local x,y,z = table.unpack(off_size)
            new_ui.model:set_scale(x,y,z)
        end    
        new_ui:show()   
        --如果外部有传参，会有问题。
        function new_ui.btn:on_button_mouse_enter()  
            if not new_ui:get_show() then 
                new_ui:hide()
                if new_ui.on_hide then 
                    new_ui:on_hide()
                end
            end     
        end   
        self.model_frame = new_ui
        return new_ui
    end,  
    
}
--赋予基础方法
for name, func in pairs(tools) do 
    class.ui_base[name] = func
end 


ac.fream_panel = class.panel.create('', 0, 0, 1920, 1080)
local panel =ac.fream_panel
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