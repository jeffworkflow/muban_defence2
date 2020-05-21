local mt = ac.skill['红色小水滴']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[hsxsd.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+500w  全属性
+5000  护甲
+10%   吸血
+50W   攻击回血|r

]],
    ['吸血'] = 10,
    ['护甲'] = 5000,
    ['攻击回血'] = 500000,
    ['全属性'] = 5000000,
}

local mt = ac.skill['发光的蓝色灰烬']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[fgdlshj.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+2500w 全属性
+10%   暴击几率
+100%  暴击伤害
+50%   物理伤害加深
|r

]],
    ['暴击伤害'] = 100,
    ['暴击几率'] = 10,
    ['全属性'] = 25000000,
    ['物理伤害加深'] = 50,
}

local mt = ac.skill['发光的草药']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[fgdyc.blp]],
    tip = [[
 
|cffFFE799【扭蛋属性】：|r
|cff00ff00+500W 全属性|r
|cff00ff00赠送100点种树熟练度|r
|cff00ff00获得特殊技能：自动种树（点击神奇的种子试试）|r
]],
    ['全属性'] = 5000000,
}

function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    --开启自动种树
    p.auto_plant = true
    --给藏宝图10张，挖宝熟练度100点
    local it = ac.item.create_item('一颗神奇的种子')
    it:set_item_count(10)
    hero:add_item(it)
    p:Map_AddServerValue('sldzs',100) 
end


local mt = ac.skill['奇美拉的头颅']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[ReplaceableTextures\CommandButtons\BTNChimaera.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+500w 全属性
+50%  分裂伤害
+50%  攻击速度|r

]],
    ['分裂伤害'] = 50,
    ['攻击速度'] = 50,
    ['全属性'] = 5000000,
}

--====================超级扭蛋成就===================

local mt = ac.skill['玻璃大炮']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[bldp.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+20亿  攻击
-5000 护甲|r

]],
    ['攻击'] = 2000000000,
    ['护甲'] = -5000,
}

local mt = ac.skill['黄金罗盘']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[hjlp.blp]],
    tip = [[
|cffFFE799【扭蛋属性】：|r
|cff00ff00赠送10张藏宝图|r
|cff00ff00赠送100点挖宝熟练度|r
|cff00ff00获得特殊技能：自动寻宝（点击藏宝图试试）|r
]],


}
function mt:on_add()
    print('自动寻宝')
end 

local mt = ac.skill['诸界的毁灭者']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[zsdhmz.blp]],
    tip = [[
|cffFFE799【扭蛋属性】：|r
|cff00ff00+3亿 攻击
+150   攻击减甲
-0.05  攻击间隔|r

]],
    ['攻击'] = 300000000,
    ['攻击间隔'] = -0.05,
    ['攻击减甲'] = 150,
}   

local mt = ac.skill['末日的钟摆']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[mrzb.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+2500w 全属性
+5%    技暴几率
+50%  技暴伤害
+25%  技能伤害加深|r

]],
    ['技暴几率'] = 5,
    ['技暴伤害'] = 50,
    ['全属性'] = 25000000,
    ['技能伤害加深'] = 25,
}   


local mt = ac.skill['矮人的火枪']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[arhq.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+500w 全属性
+50    攻击距离
+35    攻击减甲|r

]],
    ['攻击距离'] = 50,
    ['攻击减甲'] = 35,
    ['全属性'] = 5000000,
}   



local mt = ac.skill['龙族血统']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[lzxt.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+2500w 全属性
+5W  护甲
+25  每秒加护甲
+10% 每秒回血|r

]],
    ['每秒加护甲'] = 25,
    ['每秒回血'] = 10,
    ['护甲'] = 50000,
    ['全属性'] = 25000000,
}   