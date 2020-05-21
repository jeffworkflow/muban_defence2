--翅膀

local mt = ac.skill['东皇钟']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥3000

|cffFFE799【法宝属性】：|r
|cff00ff00+36  杀怪加智力|r
|cff00ff00+10% 技能伤害加深|r
|cff00ff00+5%  魔丸加成|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 3,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 36,
['技能伤害加深'] = 10,
['魔丸加成'] = 5,
--特效
effect = [[JL-FB1.mdx]]
}


local mt = ac.skill['轩辕剑']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao2.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥9000

|cffFFE799【法宝属性】：|r
|cff00ff00+56  杀怪加智力|r
|cff00ff00+20% 技能伤害加深|r
|cff00ff00+15% 吸血|r
|cff00ff00+15% 藏宝图掉落概率|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 6,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 56,
['技能伤害加深'] = 20,
['吸血'] = 15,
['藏宝图掉落概率'] = 15,
--特效
effect = [[JL-FB2.mdx]]
}

local mt = ac.skill['缚妖索']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao3.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥18000

|cffFFE799【法宝属性】：|r
|cff00ff00+76  杀怪加智力|r
|cff00ff00+30% 技能伤害加深|r
|cff00ff00+7.5% 魔丸加成|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 9,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 76,
['技能伤害加深'] = 30,
['魔丸加成'] = 7.5,
--特效
effect = [[JL-FB3.mdx]]
}

local mt = ac.skill['青莲宝色旗']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao4.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥30000

|cffFFE799【法宝属性】：|r
|cff00ff00+96  杀怪加智力|r
|cff00ff00+40% 技能伤害加深|r
|cff00ff00+5%  每秒回血|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 12,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 96,
['技能伤害加深'] = 40,
['每秒回血'] = 5,
--特效
effect = [[JL-FB4.mdx]]
}

local mt = ac.skill['莫邪宝剑']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao5.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥45000

|cffFFE799【法宝属性】：|r
|cff00ff00+116 杀怪加智力|r
|cff00ff00+50% 技能伤害加深|r
|cff00ff00+10% 魔丸加成|r
|cff00ff00+10% 藏宝图掉落概率|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 15,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 116,
['技能伤害加深'] = 50,
['藏宝图掉落概率'] = 10,
['魔丸加成'] = 10,
--特效
effect = [[JL-FB5.mdx]]
}

local mt = ac.skill['盘古斧']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao6.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥63000

|cffFFE799【法宝属性】：|r
|cff00ff00+136 杀怪加智力|r
|cff00ff00+60% 技能伤害加深|r
|cff00ff00+75  攻击距离|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 18,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 36,
['技能伤害加深'] = 60,
['攻击距离'] = 75,
--特效
effect = [[JL-FB6.mdx]]
}

local mt = ac.skill['招妖幡']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao7.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥84000

|cffFFE799【法宝属性】：|r
|cff00ff00+156  杀怪加智力|r
|cff00ff00+70% 技能伤害加深|r
|cff00ff00+12.5%  魔丸加成|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 21,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 156,
['技能伤害加深'] = 70,
['魔丸加成'] = 12.5,
--特效
effect = [[JL-FB7.mdx]]
}

local mt = ac.skill['昊天塔']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao8.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥108000

|cffFFE799【法宝属性】：|r
|cff00ff00+176  杀怪加智力|r
|cff00ff00+80% 技能伤害加深|r
|cff00ff00+5%  多重暴击几率|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 24,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 176,
['技能伤害加深'] = 80,
['多重暴击几率'] = 5,
--特效
effect = [[JL-FB8.mdx]]
}

local mt = ac.skill['太极符印']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao9.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥135000

|cffFFE799【法宝属性】：|r
|cff00ff00+196  杀怪加智力|r
|cff00ff00+90% 技能伤害加深|r
|cff00ff00+15%  魔丸加成|r
|cff00ff00+15%  藏宝图掉落概率|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 27,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 196,
['技能伤害加深'] = 90,
['藏宝图掉落概率'] = 15,
['魔丸加成'] = 15,
--特效
effect = [[JL-FB9.mdx]]
}

local mt = ac.skill['崆峒印']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[fabao10.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度≥165000

|cffFFE799【法宝属性】：|r
|cff00ff00+216  杀怪加智力|r
|cff00ff00+100% 技能伤害加深|r
|cff00ff00-0.1  攻击间隔|r

|cffff0000【点击可更换法宝外观，所有法宝属性可叠加】|r
]],
need_map_level = 210,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加智力'] = 36,
['技能伤害加深'] = 100,
['攻击间隔'] = -0.1,
--特效
effect = [[JL-FB10.mdx]]
}


for i,name in ipairs({'东皇钟','轩辕剑','缚妖索','青莲宝色旗','莫邪宝剑','盘古斧','招妖幡','昊天塔','太极符印','崆峒印'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_fabao then 
            hero.effect_fabao:remove()
        end     
        hero.effect_fabao = hero:add_effect('chest',self.effect)
    end   
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    