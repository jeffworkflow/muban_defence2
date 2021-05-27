
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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],

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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],

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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],

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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
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

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
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

local mt = ac.skill['商城御剑守护']
mt{
--等久
level = 0,
--图标
art = [[yujian.blp]],
title = '【商城】御剑守护',  
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥23|r|cffcccccc（可与 【商城道具】御剑守护 叠加属性，但此商品无 外观效果）

|cffFFE799【属性】：|r
|cff00ff00+10  每秒加护甲
|cff00ffff+5% 减伤
|cff00ffff+5% 免伤几率
|cffffff00+5% 闪避
|cffffff00+5% 每秒回血
|cffff0000+1  练功房数量

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加护甲'] = 10,
['减伤'] = 5,
['免伤几率'] = 5,
['闪避'] = 5,
['每秒回血'] = 5,
['练功房怪'] = 1,

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

|cffFFE799【获得方式】|r
|cffff0000地图等级≥55|r

|cffFFE799【肝帝奖励】|r
|cff00ff00杀怪加全属性+1888 攻击加全属性+1888 每秒加全属性+1888
|cff00ffff攻击减甲+1888 减少周围护甲+3888
|cffffff00暴击伤害+488% 技暴伤害+488% 会心伤害+488% 多重暴击+1
|cffff0000物理伤害加深+488% 技能伤害加深+488% 全伤加深+488%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 1888,
['攻击加全属性'] = 1888,
['每秒加全属性'] = 1888,
['攻击减甲'] = 1888,
['减少周围护甲'] = 3888,
['暴击加深'] = 488,
['技暴加深'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,
['多重暴击'] = 1,
}


local mt = ac.skill['魔灵限定']
mt{
--等久
level = 0,
--图标
art = [[molingxianding.blp]],
title = '【魔灵限定】',  
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥7|r

|cffFFE799【奖励属性】|r
|cff00ff00+16.8   杀怪加全属性|r
|cff00ff00+16.8   攻击减甲|r
|cffffff00+1%     会心几率|r
|cffffff00+10%    会心伤害|r
|cffff0000+16.8%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 16.8,
['攻击减甲'] = 16.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8,

}

local mt = ac.skill['地图等级元祖巨龙']
mt{
--等久
level = 0,
--图标
art = [[zulong.blp]],
title = '【商城】元祖巨龙',  
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥45|r|cffcccccc（可与 【商城道具】元祖巨龙 叠加属性，但此商品无 外观效果）

|cffFFE799【坐骑属性】：|r
|cff00ff00+8888 杀怪加全属性|r
|cff00ff00+250  移动速度|r
|cff00ff00+500  攻击距离|r
|cffffff00+488% 技能伤害加深|r
|cffffff00+488% 物理伤害加深|r
|cffffff00+488% 全伤加深|r
|cffff0000+10%   多重暴击几率|r
|cffff0000+1      多重暴击|r

|cff00ffff【祖龙气息】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*250+2%敌人的最大生命值）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 8888,
['移动速度'] = 250,
['攻击距离'] = 500,
['技能伤害加深'] = 488,
['物理伤害加深'] = 488,
['全伤加深'] = 488,
['多重暴击几率'] = 10,
['多重暴击'] = 1,
    passive = true,
    ignore_cool_save = true,
    --伤害
    damage = function(self)
        return (self.owner:get('敏捷')+self.owner:get('力量')+self.owner:get('智力'))*250
    end,
    damage_area = 1300,
    --被动事件
    event_name = "造成伤害效果",
    cool = 3,
    chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    model = [[jn_tf3.mdx]],
    model_size = 10,
}
mt.damage_start = ac.skill['元祖巨龙'].damage_start


local mt = ac.skill['圣斗士']
mt{
is_skill = 1,
title = '【英雄】圣斗士',    
--等级
level = 0,
is_order = 1,
--图标
art = [[hjsds.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥40|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+275*Lv
【攻击减甲】+488
【每秒加护甲】+68
【全伤加深】+350%
【极致的攻击速度】

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*12.5*Lv+2%敌人的最大生命值）

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--特效
effect = [[JD_xuemai01.mdx]]
}

local mt = ac.skill['等级天尊']
mt{
is_skill = 1,
title = '【英雄】天尊',    
--等级
level = 0,
is_order = 1,
--图标
art = [[tianzun.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥50|r|cffcccccc（可与 【商城英雄】天尊 叠加属性）

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+488*Lv
【每秒加护甲】+88
【攻击减甲】+888
【全伤加深】+488%
【强大的永生系统】

|cff00ffff【被动效果】攻击10%几率造成超大范围技能伤害 
【伤害公式】（全属性*15*Lv+1%敌人的最大生命值）

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--特效
effect = [[xianzhang.mdx]]
}

local mt = ac.skill['火焰之王']
mt{
is_skill = 1,
title = '【英雄】火焰之王',    
--等级
level = 0,
is_order = 1,
--图标
art = [[hyzw.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000火把积分≥1500，地图等级≥30|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+250*Lv
【分裂伤害】+500%
【暴击几率】+5%
【暴击伤害】+500%
【技暴几率】+5%
【技暴伤害】+250%
【会心几率】+5%
【会心伤害】+125%
【多重暴击几率】+5%
【多重暴击】+1

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】全属性*15*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--特效
effect = [[tj53.mdx]]
}


local mt = ac.skill['地图等级天罡苍羽翼']
mt{
--等久
level = 0,
--图标
art = [[tgcyy.blp]],
title = '【商城】天罡苍羽翼',  
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥60|r|cffcccccc（可与 【商城道具】天罡苍羽翼 叠加属性，但此商品无 外观效果）

|cffFFE799【翅膀属性】：|r
|cff00ff00+50% 全伤加深系数|r
|cff00ff00+50% 全属性|r
|cff00ff00+50% 生命上限|r
|cff00ff00+50% 护甲|r
|cff00ff00+25% 减伤|r
|cff00ff00+25% 免伤几率|r
|cff00ff00+25% 闪避|r
|cff00ff00+25% 每秒回血|r
|cff00ff00+25% 技能冷却|r
|cff00ff00+25% 触发概率加成|r
|cff00ff00【秒杀练功房怪物】
|cff00ff00【开局赠送随机神阶功法，到玩家背包】

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r

]],
['全伤加深系数'] = 50,
['力量%'] = 50,
['敏捷%'] = 50,
['智力%'] = 50,
['生命上限%'] = 50,
['护甲%'] = 50,
['减伤'] = 25,
['免伤几率'] = 25,
['闪避'] = 25,
['每秒回血'] = 25,
['技能冷却'] = 25,
['触发概率加成'] = 25,
['秒杀练功房的怪物'] = 1,
}
mt.on_add = ac.skill['天罡苍羽翼'].on_add


local mt = ac.skill['地图等级苍天帝剑']
mt{
--等久
level = 0,
--图标
art = [[ctdj.blp]],
title = '【商城】苍天帝剑',  
is_order = 1,
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥65|r|cffcccccc（可与 【商城道具】苍天帝剑 叠加属性，但此商品无 外观效果）

|cffFFE799【神兵属性】：|r
|cff00ff00+50% 全伤加深系数|r
|cff00ff00+50% 攻击|r
|cff00ff00+488% 暴击伤害|r
|cff00ff00+488% 技暴伤害|r
|cff00ff00+488% 会心伤害|r
|cff00ff00+488% 物理伤害加深|r
|cff00ff00+488% 技能伤害加深|r
|cff00ff00+488% 全伤加深|r
|cff00ff00+488% 对BOSS额外伤害|r
|cff00ff00+1    多重暴击|r
|cff00ff00【强化物品必定成功】
|cff00ff00【开局赠送一个随机黑色物品】

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r

]],
['全伤加深系数'] = 50,
['攻击%'] = 50,
['暴击伤害'] = 488,
['技暴伤害'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,
['对BOSS额外伤害'] = 488,
['多重暴击'] = 1,
['强化成功概率'] = 100,
}
mt.on_add = ac.skill['苍天帝剑'].on_add





local japi = require("jass.japi")
local slk = require 'jass.slk'

for i,name in ipairs({
    '亚瑟王','撼地神牛','不朽剑圣','暗夜寒星',
	'诸葛亮','布莱特','吕布','鬼剑愁',
	'张飞','金克丝','貂蝉','杰拉米','黄盖',
	'关羽','堕落天使','加百列','王昭君','雅典娜',
	'剑仙','等级天尊','圣斗士','火焰之王'
}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        local target_name = self.name
        if target_name =='等级天尊' then 
            target_name = '天尊'
        end
        --连续点两下Pa取消特效
        if player.last_tran_unit and player.last_tran_unit == self.name then 
            target_name = hero:get_name()
        end    

        local id 
        local new_model 
        -- if not finds(target_name,'至尊宝','王昭君','雅典娜','不朽剑圣','魔化的小龙女','黄金圣斗士','萧若兰','复仇天神') then 
            id = ac.table.UnitData[target_name].id
            new_model = slk.unit[id].file
            if new_model and not getextension(new_model) then 
                new_model = new_model..'.mdl'
            end	
        -- else
        --     new_model = self.unit_model
        -- end    
        -- print(new_model)
        --改模型
        if self.level > 0 then 
            japi.SetUnitModel(hero.handle,new_model)
        end   
        player.last_tran_unit = target_name  
        -- ac.wait(10,function() 
        --     --改变大小
        --     if name == '骨龙' then 
        --         hero:set_size(2.5)
        --     elseif name == '精灵龙' then 
        --         hero:set_size(1.5)
        --     else
        --         hero:set_size(1)
        --     end  
            
        -- end)
    end 
-- mt.on_add = mt.on_cast_start --自动显示特效
end    


--额外处理 地图等级50级时，且有天尊商城道具的，额外给技能
ac.game:event '玩家-注册英雄' (function(_, player, hero)
    -- hero
    -- 加技能
    if hero:get_name() ~='天尊' then 
        return 
    end
    local p = player 
    if p:Map_GetMapLevel() > 49 and p:Map_HasMallItem('TZ') then 
        hero:add_skill('剑气冲霄2','英雄')
    end

end)
