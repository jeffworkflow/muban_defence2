

local ui = require 'ui.client.util'

local globals = require 'jass.globals'




local unit = ac.player(16):create_unit('e001',ac.point(0,0),270)
local range = ac.player(16):create_unit('e001',ac.point(0,0),270)
unit:set_high(10)
range:set_high(10)

local timer

local region = ac.region.create()

--读取地形编辑器上的矩形 转换成lua矩形对象
local function init_rect()
    for i=1,16 do
        -- local name = 'build_' .. i
        local name ='wq'
        local rect = ac.rect.j_rect(name)
        if rect then
            region = region + rect
        end
    end
end

init_rect()

--判断世界坐标是否能建造 返回boolean
local function can_build(point)
    return region < point
end




--创建一个选择器
local function create_selector(hero,name)
    local selector = {}

    -----建筑模型---------
    local path = get_unit_slk(name,'file')
    local type = path:sub(path:len() - 3,path:len())
    if type ~= '.mdl' and type ~= '.mdx' then
        path = path .. '.mdx'
    end
    unit:change_model(path)

    unit:setColor(20,100,20,100)
    local size = tonumber(get_unit_slk(name,'modelScale')) or 1
    jass.SetUnitScale(unit.handle,size,size,size)

    -----显示范围的圈子-------
    local data = ac.table.unit[name]
    local area = 300
    if data and data.attribute then
        area = data.attribute['攻击距离'] or area
    end
    range:change_model('F2_model\\warming_ring_green.mdx')
    size = area / 200
    jass.SetUnitScale(range.handle,size,size,size)

    selector.name = name
    selector.hero = hero

    local last = true
    ------------------------------
    selector.timer = game.loop(5,function ()
        local x,y = japi.GetMouseX(),japi.GetMouseY() + 10
        local point = ac.point(x,y)
        local is_build = can_build(point)
        if unit.model_file and unit.model_file == '' then
            if selector.timer then
                selector.timer:remove()
                selector.timer = nil
            end
            return
        end

        if last ~= is_build then
            if is_build then
                unit:setColor(20,100,20,100)
                range:change_model('F2_model\\warming_ring_green.mdx')
            else
                unit:setColor(100,20,20,100)
                range:change_model('F2_model\\warming_ring_red.mdx')
            end

        end


        last = is_build

        japi.SetUnitPosition(unit.handle,x,y)
        japi.SetUnitPosition(range.handle,x,y)
    end)

    ac.is_build_select = true

    function selector:remove(not_message)
        if self.timer then
            self.timer:remove()
            self.timer = nil
        end
        if ac.is_build_select then 
            ac.is_build_select = nil
            ForceUICancel()
        end 
       

        unit:set_model_force('')
        range:set_model_force('')

        if not not_message then
            game.wait(200,function ()
                local info = {
                    type = 'build',
                    func_name = 'on_end',
                }
                ui.send_message(info)
            end)
        end
        
    end

    return selector
end

local selector

ac.clear_selector = function ()
    if selector then 
        selector:remove()
        selector = nil
    end 
end 

ac.build_select = function (msg)

    if selector == nil then
        return true
    end

    if msg.code == 512 then
        selector:remove()
        selector = nil
        return true
    end

    if msg.type ~= 'mouse_down' then
        return true
    end

    local hero = selector.hero
    local name = selector.name

    --右键
    if msg.code == 4 then

    --左键
    elseif msg.code == 1 then

        local x,y = japi.GetMouseX(),japi.GetMouseY() + 10
        local point = ac.point(x,y)

        if not can_build(point) then
            ac.player.self:sendMsg("该位置不能建造。")
            return false
        end

        local info = {
            type = 'build',
            func_name = 'on_build',
            params = {
                [1] = math.modf(japi.GetMouseX()),
                [2] = math.modf(japi.GetMouseY()),
            }
        }
        ui.send_message(info)

        selector:remove(true)
        selector = nil
        return true
    end

    selector:remove()
    selector = nil

    return true
end

ac.game:event '单位-准备建造' (function (_,hero,name)
    local player = hero:get_owner()


    local skill = hero:find_skill('移动','英雄')
    skill.area = 0
    skill:fresh()

    if not player:is_self() then
        return
    end
    if selector then
        selector:remove()
        selector = nil
    end


    game.wait(33,function ()
        ForceUIKey('M')
        selector = create_selector(hero,name)
    end)

end)


ac.game:event '玩家-选择单位' (function (_,player,hero)
    local skill = hero:find_skill('移动','英雄')
    if skill then
        skill.area = skill.data.area
        skill:fresh()
    end


    if player:is_self() then
        if selector then
            selector:remove(true)
            selector = nil
        end
    end
end)

ac.game:event '玩家-取消选择单位' (function (_,player,hero)
    local skill = hero:find_skill('移动','英雄')
    if skill then
        skill.area = skill.data.area
        skill:fresh()
    end
    if player:is_self() then
        if selector then
            selector:remove(true)
            selector = nil
        end
    end
end)

