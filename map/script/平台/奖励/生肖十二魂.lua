local mt = ac.skill['鼠灵法衣']
mt{
--等级
level = 0, --要动态插入
max_level = 1,
--图标
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = 1000,

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
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = 1000,

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
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = 1000,

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
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = 1000,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
}



local mt = ac.skill['生肖十二魂']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[shibing.blp]],
    tip = [[

点击查看|cff00ffff通关勋章|r|cffffff00（每次通关有概率获得对应难度的勋章，获得概率和|cffff0000通关次数|cffffff00有关）
 ]],
    
}
mt.skills = {
    '鼠灵'
}


local mt = ac.skill['鼠灵']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[shibing.blp]],
    tip = [[

点击查看|cff00ffff通关勋章|r|cffffff00（每次通关有概率获得对应难度的勋章，获得概率和|cffff0000通关次数|cffffff00有关）
 ]],
    
}
mt.skills = {
    '鼠灵法衣','鼠灵护符','鼠灵腰坠','鼠灵项链'
}
