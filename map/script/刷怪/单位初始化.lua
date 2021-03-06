
local function get_difficult(degree,br)
    local base =1
    --难度系数
    local base_rate = br or 1.68
    local degree = degree or 1 
    if degree == 1 then 
        return base 
    else
        return get_difficult(degree -1,base_rate) *base_rate  
    end 
end    
ac.get_difficult=get_difficult

local function add_skl(unit,name)

    local skl = unit:find_skill(name,nil,true)
    if skl then 
        skl:remove()
    end
    local skl = unit:add_skill(name,'英雄')
    if name =='重生' then 
		skl.cnt = 99999999
		skl.time = 2
		skl.cool = 60*5
    end
end

local function init_attribute(unit)
    
    -- 英雄返回
    if unit:is_hero() then  return end 
    -- 根据难度增强属性。
    local name = unit:get_name()
    local data = ac.table.UnitData[name]
    if not data then return end 
    -- 再次初始化业务端字段，以免漏掉处理
    unit.name = data.name
    unit.category = data.category
    unit.unit_type= data.unit_type
    unit.missile_art= data.missile_art
    unit.index= data.index
    unit.gold= data.gold
    unit.wood= data.wood
    unit.rec_ex= data.rec_ex
    unit.exp= data.exp
    unit.fall_rate= data.fall_rate
    unit.fall_save_rate= data.fall_save_rate
    -- unit.high = data.high
    --设置高度
    if data.high then 
        unit:set_high(data.high)
    end
    --设置搜敌范围
    unit:set_search_range(800)
    local attr_mul = get_difficult(ac.g_game_degree_attr)
    --根据难度增强属性 
    if data.attribute then  
        unit:set('攻击',(data.attribute['攻击']or 1) * (attr_mul or 1))
        unit:set('生命上限',(data.attribute['生命上限']or 1) * (attr_mul or 1))
        unit:set('魔法上限',(data.attribute['魔法上限']or 1))
        unit:set('生命恢复',(data.attribute['生命恢复']or 0))
        unit:set('魔法恢复',(data.attribute['魔法恢复']or 0))
        unit:set('护甲',(data.attribute['护甲']or 1) *  (attr_mul or 1))
        unit:set('魔抗',(data.attribute['护甲']or 1) *  (attr_mul or 1))

        unit:set('暴击伤害',(data.attribute['暴击伤害'] or 0) * (attr_mul or 1))
    end    

    --单独增强最终boss
    if _in(unit:get_name(),'九头怪','奇美拉','蜥蜴领主','山岭巨人','基尔加丹') then
        unit:set('攻击减甲',data.attribute['攻击减甲'] * (attr_mul or 1))
    end  

    if _in(unit:get_name(),'虚空诺亚','最强魔帝') then
        unit:set('攻击减甲',data.attribute['攻击减甲'] * (attr_mul or 1) + 100)
    end 

    if _in(unit:get_name(),'一棒男','戴瑟提克','格里弗','克尔苏加德','虚空诺亚','最强魔帝','太阳神','鼠天瞳','牛金刚','武伯都','兔飞','辰龙','紫','马不凡') then
        unit:set('每秒回血',1.25 * ((ac.g_game_degree_attr or 1 ) -1))
    end  

    --初始化技能
    if data.skill_names then 
        if type(data.skill_names) =='string' then 
            add_skl(unit,data.skill_names)
        else
            for i,name in ipairs(data.skill_names) do  
                add_skl(unit,name)
            end
        end
    end
end
ac.unit.init_attribute = init_attribute    
--单位创建 属性增强
ac.game:event '单位-创建' (function(_,unit)  
    ac.unit.init_attribute(unit)
    if unit:get_name() == '哪吒' then
        unit:add_effect('hand left',[[Mx_qiubaihongyingqiang.mdx]])
    end    

    
end)