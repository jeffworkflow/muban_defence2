
local mt = ac.skill['黄盖']
mt{
title = '【英雄】黄盖',    
is_skill = 1,
item_type ='神符',
--等级
level = 0,
is_order = 1,
--图标
art = [[huanggai.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥5|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+100*Lv
【物理伤害加深】+50%
【每秒回血】+15%
【护甲】+15%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*10+10000）*Lv+1%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],

--特效
effect = [[GuanSuoPiFu2.mdx]]

}

local mt = ac.skill['关羽']
mt{
title = '【英雄】关羽',    
is_skill = 1,
item_type ='神符',
--等级
level = 0,
is_order = 1,
--图标
art = [[guangong.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥10|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+140*Lv
【力量】+15%
【移动速度】+100
【物理伤害加深】+200%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人
【伤害公式】（力量*15+10000）*Lv+1%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],

--特效
effect = [[zsgskin_guanyu_01.mdx]]

}

local mt = ac.skill['堕落天使']
mt{
title = '【英雄】堕落天使',     
    
is_skill = 1,
item_type ='神符',
--等级
level = 0,
is_order = 1,
--图标
art = [[tianshi.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥15|r

|cffFFE799【天赋属性】：|r
|cffffff00【智力】+20%
|cffffff00【每秒加木头】+7.5*Lv
【每秒加魔丸】+7.5*Lv
【物品获取率】+100%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*17.5+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],

--特效
effect = [[avengingangel.mdx]]

}

local mt = ac.skill['加百列']
mt{
is_skill = 1,
title = '【英雄】加百列',    
item_type ='神符',
--等级
level = 0,
is_order = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNMarine.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥20|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加敏捷】+240*Lv
【攻击间隔】-0.2
【攻击减甲】+350
【多重射】+3
【多重暴击几率】+5%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*20+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
--特效
effect = [[ArchAngelngelGabriel.mdx]]
}


local mt = ac.skill['王昭君']
mt{
is_skill = 1,
title = '【英雄】王昭君',    
--等级
level = 0,
is_order = 1,
--图标
art = [[wzj.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥25|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加智力】+280*Lv
【智力】+40%
【触发概率加成】+50%
【技能冷却】+25%
【技能伤害加深】+200%
【强大的冰盾系统】

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*22.5+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
--特效
effect = [[Npc_18.mdx]]
}

local mt = ac.skill['雅典娜']
mt{
is_skill = 1,
title = '【英雄】雅典娜',    
--等级
level = 0,
is_order = 1,
--图标
art = [[ydn.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥30|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加敏捷】+320*Lv
【敏捷】+50%
【移动速度】+150
【全伤加深】+250%
【强大的永生系统】

|cff00ffff【被动效果】攻击10%几率造成多次突袭伤害
【伤害公式】（敏捷*25+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
--特效
effect = [[hero_hc04.mdx]]
}

local mt = ac.skill['地图等级首充礼包']
mt{

title = '【商城】首充礼包',    
--等久
level = 0,
--图标
art = [[sffl.blp]],
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥12|r|cffcccccc（可与 【商城道具】首充礼包 叠加属性）

|cffFFE799【礼包属性】|r
|cff00ff00全属性加成+5%
初始全属性+150万 
初始护甲+1万
初始金币+80万
初始杀敌数+1500|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 1500000,
['护甲'] = 10000,
['力量%'] = 5,
['敏捷%'] = 5,
['智力%'] = 5,
--初始金币和杀敌数
init_gold = 800000,
init_kill_count = 1500,
}
function mt:on_add()
    local hero = self.owner
    hero:addGold(self.init_gold)
    hero:add_kill_count(self.init_kill_count)
end


local mt = ac.skill['地图等级成长礼包']
mt{
title = '【商城】成长礼包',  
--等久
level = 0,
--图标
art = [[chengzhanglibao.blp]],
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥18|r|cffcccccc（可与 【商城道具】成长礼包 叠加属性）

|cffFFE799【礼包属性】|r
|cff00ff00杀怪加68全属性，攻击加188全属性，每秒加688全属性 
|cff00ff00每秒加护甲+15
|cff00ffff杀敌数加成+15% 木头加成+15% 
物品获取率+15% 魔丸加成+15% |r
|cffff0000全伤加深+地图等级*10%|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

['杀怪加全属性'] = 68,
['攻击加全属性'] = 188,
['每秒加全属性'] = 688,
['每秒加护甲'] = 15,
['杀敌数加成'] = 15,
['木头加成'] = 15,
['物品获取率'] = 15,
['魔丸加成'] = 15,

['全伤加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
}

local mt = ac.skill['地图等级初级赞助']
mt{
title = '【商城】初级赞助',  
--等久
level = 0,
--图标
art = [[chujivip.blp]],
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥28|r|cffcccccc（可与 【商城道具】初级赞助 叠加属性）

|cffFFE799【礼包属性】|r
|cff00ff00杀怪加188全属性，攻击加688全属性，每秒加1888全属性
|cff00ffff杀敌数加成+75% 木头加成+75% 
物品获取率+75% 魔丸加成+75% |r
|cffff0000攻击减甲+50 减少周围护甲1000|r
|cffff0000每秒加护甲+10|r

|cffffff00地图等级>=5，效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
double_map_level = 10, --大于此地图等级，效果翻倍

['杀怪加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 188
    if map_level >= self.double_map_level then 
        value = 188 * 2
    end    
    return value 
end,
['攻击加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 688
    if map_level >= self.double_map_level then 
        value = 688 * 2
    end    
    return value 
end,
['每秒加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 1888
    if map_level >= self.double_map_level then 
        value = 1888 * 2
    end    
    return value 
end,
['杀敌数加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['木头加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['物品获取率'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['魔丸加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 1000
    if map_level >= self.double_map_level then 
        value = 1000 * 2
    end    
    return value 
end,
['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 50
    if map_level >= self.double_map_level then 
        value = 50 * 2
    end    
    return value 
end,
['每秒加护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 10
    if map_level >= self.double_map_level then 
        value = 10 * 2
    end    
    return value 
end,
}

local mt = ac.skill['地图等级高级赞助']
mt{
title = '【商城】高级赞助',  
--等久
level = 0,
--图标
art = [[gaojivip.blp]],
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥35|r|cffcccccc（可与 【商城道具】高级赞助 叠加属性，但此商品无 局内地图等级+1）

|cffFFE799【礼包属性】|r
|cff00ff00杀怪加888全属性，攻击加888全属性，每秒加888全属性
|cff00ffff攻击减甲+地图等级*15
减少周围护甲+地图等级*250
|cffffff00物理伤害加深+地图等级*100%
技能伤害加深+地图等级*50%
|cffff0000全伤加深+地图等级*25%
对BOSS额外伤害+地图等级*10%
|cffff0000每秒加护甲+地图等级*10


]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
['杀怪加全属性'] = 888,
['攻击加全属性'] = 888,
['每秒加全属性'] = 888,


['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 250 * map_level
end,

['物理伤害加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 100 * map_level
end,

['技能伤害加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 50 * map_level
end,

['全伤加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 25 * map_level
end,

['对BOSS额外伤害'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
['每秒加护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
}

local mt = ac.skill['肝帝']
mt{
--等久
level = 0,
--图标
art = [[gandi.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000地图等级=60|r自动激活

|cffFFE799【肝帝奖励】|r
|cff00ff00杀怪加全属性+888 攻击加全属性+888 每秒加全属性+888
|cff00ffff攻击减甲+888 减少周围护甲+1888
|cffffff00暴击加深+488% 技暴加深+488% 会心伤害+488%
|cffff0000物理伤害加深+488% 技能伤害加深+488% 全伤加深+488%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 888,
['攻击加全属性'] = 888,
['每秒加全属性'] = 888,
['攻击减甲'] = 888,
['减少周围护甲'] = 1888,
['暴击加深'] = 488,
['技暴加深'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,
}
