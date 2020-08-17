local mt = ac.skill['鼠灵法衣']
mt{
--等级
level = 0, --要动态插入
max_level = 1,
--图标
art = [[stt1.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+38  杀怪加全属性
+38  攻击加全属性
+15% 技能伤害加深

|cffcccccc杀死【鼠天瞳】获得，获得概率与通关难度/地图等级相关]],

['杀怪加全属性'] = 38,
['攻击加全属性'] = 38,
['技能伤害加深'] = 15,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
}


local mt = ac.skill['鼠灵护符']
mt{
--等级
level = 0, --要动态插入
max_level = 1,
--图标
art = [[stt2.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+38  每秒加全属性
+38  每秒加攻击
+38  每秒加生命上限
+1%  物理伤害加深系数

|cffcccccc杀死【鼠天瞳】获得，获得概率与通关难度/地图等级相关]],

['每秒加全属性'] = 38,
['每秒加攻击'] = 38,
['每秒加生命上限'] = 38,
['物理伤害加深系数'] = 1,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
}

local mt = ac.skill['鼠灵腰坠']
mt{
--等级
level = 0, --要动态插入
max_level = 1,
--图标
art = [[stt3.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+38  杀怪加攻击
+38  每秒加攻击
+5% 吸血

|cffcccccc杀死【鼠天瞳】获得，获得概率与通关难度/地图等级相关]],

['杀怪加攻击'] = 38,
['每秒加攻击'] = 38,
['吸血'] = 5,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
}

local mt = ac.skill['鼠灵项链']
mt{
--等级
level = 0, --要动态插入
max_level = 1,
--图标
art = [[stt4.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+38  杀怪加生命上限
+30% 分裂伤害
+30% 物理伤害加深

|cffcccccc杀死【鼠天瞳】获得，获得概率与通关难度/地图等级相关]],

['杀怪加生命上限'] = 38,
['分裂伤害'] = 30,
['物理伤害加深'] = 30,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
}



local mt = ac.skill['生肖十二魂']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[stt.blp]],
    tip = [[

点击查看 |cff00ffff生肖十二魂|r 成就，通过挑战|cff00ff00【十二生肖】|r获得
 ]],
    
}
mt.skills = {
    '鼠灵'
}


local mt = ac.skill['鼠灵']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[stt.blp]],
    tip = [[

点击查看 |cff00ffff鼠灵|r 成就，通过挑战|cff00ff00【鼠天瞳】|r获得
 ]],
    
}
mt.skills = {
    '鼠灵法衣','鼠灵护符','鼠灵腰坠','鼠灵项链'
}
