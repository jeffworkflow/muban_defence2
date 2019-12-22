local panel = ac.ui.client.panel

local task = class.panel:builder{
    parent = panel, --父级
    x = 1494,
    y = 196,
    w = 418,
    h = 572,
    level = 2,
    is_show = true,
    normal_image = 'image\\black.tga',
    alpha = 0.3,

    title = {
        x = 0,
        y = 0,
        w = 418,
        h = 40,
        normal_image = 'image\\black.tga',
        type = 'texture',
        text = {
            x = 18,y = 10,w = 65,h = 21,font_size = 13,text = '榜单任务',type = 'text'
        }
    },
}

for i = 0,6 do
    local y = 50 + i * 13 + 62 * i
    local item = task:add_panel('image\\black.tga',11,y,394,62)
    item:set_alpha(0.5)

    local progress = item:add_texture('image\\blue.tga',62,0,332,62)
    progress:set_alpha(0.5)

    --模拟一下任务进度
    local index = math.random(1,100) / 100 * 332
    progress:set_width(index)

    local icon = item:add_texture('image\\duanzanwudis.blp',0,0,62,62)
    local title = item:add_text('吞噬成长',82,8,72,23,12)
    local tip = item:add_text('|cffaeaeae参与击杀100只野狼即可完成任务。|r',82,37,72,230,9)--x,y,w,h,font_size
    local time = item:add_text('|cffaeaeae限时：35s|r',360,6,30,20,9,'right')
end






--==========================汉康素材
local task = class.panel:builder{
    parent = panel, --父级
    x = 864,
    y = 196,
    w = 412,
    h = 592,
    level = 2,
    is_show = true,
    normal_image = 'image\\rwbg.tga',
}

for i=0,6 do
    local y = 66 + i * 13 + 62 * i
    local item = task:add_panel('',30,y,375,62)

    --x,y,w,h
    local icon_back = item:add_panel('image\\rwtb.tga',0,0,62,62)
    local icon_art = icon_back:add_texture('image\\duanzanwudis.blp',0,0,62,62)

    local Text_panel = item:add_panel('image\\xxbg.tga',63,2,308,43)
    local title = Text_panel:add_text('|cfff18f24吞噬成长|r',10,5,100,20,10)   --x,y,w,h,font_size
    local tip = Text_panel:add_text('|cff5fb878参与击杀100只野狼即可完成任务。|r',10,25,100,20,8)
    local time = Text_panel:add_text('|cff8d8d8d限时：59s|r',180,4,100,20,9,'right')

    --进度条
    local progress_panel = item:add_panel('',63,48,308,11)
    progress_panel.text = progress_panel:add_text('|cff8d8d8d进度:|r',0,0,20,7,7)
    progress_panel.frame = progress_panel:add_texture('image\\rwjdbg.tga',30,0,230,11)
    progress_panel.pro = progress_panel.frame:add_texture('image\\green.tga',2,2,226,7)

    --模拟一下任务进度
    local index = math.random(1,100) / 100 * 226
    progress_panel.pro:set_width(index)


end