
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
end)

--boss技能列表
ac.skill_list3 = {
    '无敌','撕裂大地','伤害守卫','伤害守卫','boss光子灵枪'
    --'超新星',
}
--天赋技能
ac.skill_list4 = {
    '阿尔塞斯天赋','大地天赋','剑圣天赋','希尔瓦娜斯天赋','吉安娜天赋','炼金术士天赋',
	'赵子龙天赋','Pa天赋','手无寸铁的小龙女天赋','太极熊猫天赋','虞姬天赋','夏侯霸天赋',
    '至尊宝天赋','关羽天赋','鬼厉天赋','剑仙天赋','伊利丹天赋','狄仁杰天赋'
    --'超新星',
}

--技能羁绊
ac.skill_list5 = {}
--强化后的技能
ac.skill_list6 = {
    '强化后的X射线','强化后的不灭佛隐','强化后的刀刃旋风','强化后的剑刃风暴','强化后的憎恶','强化后的招架之力',
    '强化后的星落','强化后的暗之领域','强化后的死亡脉冲','强化后的水疗术','强化后的水舞','强化后的渡业妖爆',
    '强化后的火力支援','强化后的狂龙爆','强化后的疾步风','强化后的痛苦尖叫','强化后的神圣护甲','强化后的神威',
    '强化后的穿刺','强化后的红莲爆','强化后的缠绕','强化后的蚀魂魔舞','强化后的践踏','强化后的迷之领域',
    
}
--不受技能冷却影响
local temp = {}
for i,name in ipairs(ac.all_skill) do 
    table.insert(temp,name)
end    
for i,name in ipairs(ac.skill_list4) do 
    table.insert(temp,name)
end    
ac.wait(1000,function()
    for i,name in ipairs(temp) do 
        local mt = ac.skill[name]
        -- print(mt.name,mt.passive)
        if mt.passive then 
            mt.ignore_cool_save = true
        end    
        
    end    
end)
--统一定 技能价格 技能售价
for _,name in ipairs(ac.all_skill) do
    ac.skill[name].gold = 2000
end    

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