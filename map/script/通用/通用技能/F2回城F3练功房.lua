local rect = require "types.rect"
local mt = ac.skill['F2回城']
mt{
	--技能id
	ability_id = 'A01H',
    --必填
    is_skill = true,
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --拾取cd，太快会触发2次。
    cool = 0,
    --目标数据
    cus_target_data = '按键',
    --图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}
function mt:on_add()
    self:hide()
end    
function mt:on_cast_start()
    local hero = self.owner
    local point = ac.map.rects['出生点']:get_point()
    hero:blink(point,true,false,true)
end

local mt = ac.skill['F3小黑屋']
mt{
	--技能id
	ability_id = 'AX11',
    --必填
    is_skill = true,
    --等级
    level = 1,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --拾取cd，太快会触发2次。
    cool = 0,
    --目标数据
    cus_target_data = '按键',
    --图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}
function mt:on_add()
    self:hide()
end    

function mt:on_cast_start()
    local hero = self.owner
    local it = self.target
    local p = hero:get_owner()

    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
    if finds(ac.g_game_degree_name,'深渊冒险') then 
        point = ac.rect.j_rect('zxzw1'):get_point()
    end
    hero:blink(point,true,false,true)  
end