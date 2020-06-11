
ac.quality_skill = {}
ac.all_skill = {} --游戏内用的所有skill --去除 '天赋','真天赋','真天阶','神阶','真神阶'
ac._all_skill = {} --底层用的所有skill

--总技能 
ac.wait(0,function()
    for i,data in pairs(ac.skill) do 
        if type(data) == 'table' then 
            if data.color and finds(data.color,'阶','天赋') then 
                if not ac.quality_skill[data.color] then 
                    ac.quality_skill[data.color] ={}
                end    
                table.insert(ac.quality_skill[data.color],data.name)

                table.insert(ac._all_skill,data.name)
                if not _in(data.color,'天赋','真天赋','真天阶','神阶','真神阶') then
                    -- print(data.name,data.color)
                    table.insert(ac.all_skill,data.name)
                end    
            end 
        end	
    end	
    
    --排序
    for color,list in pairs(ac.quality_skill) do 
        table.sort(list,function (a,b)
            return a < b
        end)
    end 
    table.sort(ac.all_skill,function (strA,strB)
        return strA<strB
    end)

    --不受技能冷却影响 除了主动，被动统一不受技能冷却影响
    for i,name in ipairs(ac._all_skill) do 
        local mt = ac.skill[name]
        -- print(mt.name,mt.passive)
        if mt.passive then 
            mt.ignore_cool_save = true
        end    
        
    end  

    --统一定 技能价格 技能售价
    for _,name in ipairs(ac._all_skill) do
        ac.skill[name].gold = 2000
    end  
end)


--技能羁绊
ac.skill_list5 = {}    
--F9 任务说明
local function initialize()
    local unit = ac.player(16):create_dummy('e001',ac.point(0,0),0)

    local list = ac.all_skill

    table.sort(list,function (a,b) return a < b end)
    
    for index,name in ipairs(list) do 
        local skill = unit:add_skill(name,'隐藏')
        local title = name
        local tip = skill:get_simple_tip(nil,1)
        local art = skill:get_art()

        local quest = CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED,title,tip,art)
        skill:remove()
    end 
    unit:remove()
end 



-- initialize()