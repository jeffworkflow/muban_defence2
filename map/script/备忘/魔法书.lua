
local slots = {9,10,11,12,5,6,7,8,1,2,3,4}



local function hide(skill)
    if not skill:is_hide() then 
        skill:hide()
        skill:remove_ability(skill.ability_id)
    end
end 

local function show(skill)
    if skill:is_hide() then 
        skill:add_ability(skill.ability_id)
        skill:show()
    end
    skill:fresh()
end 

local function update_page(hero)
    local player = hero:get_owner()
    if player:is_self() then 
        ClearSelection()
        SelectUnit(hero.handle,true)
    end 
end

local function hide_page(hero,page_type,page_id)

    page_id = page_id or 0 

    local page = page_type
    if page_id > 0 then 
        page = page_type .. '_' .. page_id
    end

    for i = 1, 12 do 
        local skill = hero:find_skill(slots[i],page,true)
        if skill then 
            hide(skill)
        end 
    end
end 

local function show_page(hero,page_type,page_id)

    page_id = page_id or 0 
    local page = page_type
    if page_id > 0 then 
        page = page_type .. '_' .. page_id
    end

    for i = 1, 12 do 
        local skill = hero:find_skill(slots[i],page,true)
        if skill then 
            show(skill)
        end 
    end

end

--[[

]]


ac.game:event '技能-获得' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 

    local player = hero:get_owner()
    local skill_list = {}

    local skill_book = {}

    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)
    
    local max_page_count = math.modf(#self.skills / 11)

    local page = page_type

    for page_id = 0,max_page_count do 

        if page_id > 0 then 
            page = page_type .. '_' .. page_id
        end 

        for i = 1, 11 do 
            local id = page_id * 11 + i 
            local name = self.skills[id]
            if name then 
                local skill = hero:add_skill(name,page,slots[i],{
                    book = self,
                    page_name = page,
                })
                table.insert(skill_list,skill)
                table.insert(skill_book,skill)
            end 
        end

        local end_name = '下一页'
        if page_id == max_page_count then 
            end_name = '关闭'
        end 

        local skill = hero:add_skill(end_name,page,slots[12],{
            book = self,
            page_count = max_page_count,
            current_page = page_id,
        })
        hide(skill)
        table.insert(skill_list,skill)
    end 

    self.skill_list = skill_list
    
    --不包含关闭技能的列表
    self.skill_book = skill_book

    for index,skill in ipairs(self.skill_list) do 
        hide(skill)
    end 
end)

ac.game:event '技能-施法完成' (function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 

    local page_type = self:get_type() .. '_' .. string.format("%01x",self.slotid)

    hero.skill_page = page_type

    self.parent_skill.hide_book = true 

    hide_page(hero,self:get_type(),0)

    show_page(hero,page_type,0)

    update_page(hero)

end)

ac.game:event '单位-失去技能'(function (_,hero,self)
    if self.is_spellbook == nil or self.skills == nil then 
        return 
    end 
    local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
    if skl and not skl:is_hide() then 
        skl:close()
    end 
    if self.skill_list then 
        for index,skill in ipairs(self.skill_list) do 
            skill:remove()
        end 
        self.skill_list = nil
    end 
    self.skill_book = nil
end)


local mt = ac.skill['关闭']

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
 
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = book:get_type()

    book.hide_book = nil 
    for index,skill in ipairs(book.skill_list) do 
        hide(skill)
    end 

    for skill in hero:each_skill(book:get_type(),true) do 
        show(skill)
    end 
end 

function mt:close()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    if book.hide_book == nil then 
        return 
    end 
    hero.skill_page = nil
    book.hide_book = nil 

    for index,skill in ipairs(book.skill_list) do 
        hide(skill)
    end

    for skill in hero:each_skill('英雄',true) do 
        show(skill)
    end 
end 

local mt = ac.skill['下一页']

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local book = self.book
    
    if book.hide_book == nil then 
        return 
    end 

    local page_type = book:get_type() .. '_' .. string.format("%01x",book.slotid)
    local current_page = self.current_page
 
    hide_page(hero,page_type,current_page)

    show_page(hero,page_type,current_page + 1)

    hero.skill_page = page_type .. '_' .. current_page + 1
end 


ac.game:event'单位-获得技能' (function (_,hero,skill)
    if skill and skill.slot_type == '英雄' then 
        local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
        if skl and not skl:is_hide() then 
            skl:close()
        end 
    end
end)

ac.game:event '玩家-选择单位' (function (_,player,unit)
    local hero = player:get_hero()
    if hero == unit or hero == nil then 
        return 
    end 
    local skl = hero:find_skill('关闭',hero.skill_page or '英雄')
    if skl and not skl:is_hide() then 
        skl:close()
    end 
end)


