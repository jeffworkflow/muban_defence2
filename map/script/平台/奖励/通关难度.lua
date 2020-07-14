--通关难度
local mt = ac.skill['吕布']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[lvbu.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00士兵1段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+80*Lv
【吸血】+10%
【攻击距离】+50
【物理伤害加深】+50%

|cff00ffff【被动效果】攻击10%几率变身魔神，持续8秒

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 2,
}


local mt = ac.skill['鬼剑愁']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[dagongjiang.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00主教3段

|cffFFE799【天赋属性】：|r
|cffffff00【每秒加木头】+4*Lv
【每秒加魔丸】+4*Lv
【物品获取率】+75%
【每秒回血】+15%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*10+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 6,
}

local mt = ac.skill['张飞']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zhangfei.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00国王5段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+120*Lv
【护甲】+25%
【每秒回血】+25%
【攻击减甲】+150
【物理伤害加深】+200%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*15+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 9,
}

local mt = ac.skill['金克丝']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[jinkesi.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00传奇7段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加敏捷】+160*Lv
【敏捷】+25%
【攻击距离】+250
【物理伤害加深】+250%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*17.5+10000）*Lv+1%敌人的最大生命值

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 11,
}


local mt = ac.skill['貂蝉']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[diaochan.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00超凡入圣9段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加智力】+200*Lv
【技暴几率】+10%
【技暴伤害】+100%
【技能伤害加深】+100%

|cff00ffff【被动效果】攻击10%几率触发法阵， 闪避+50%, 触发概率加成+50%, 技能冷却+50%，持续8秒；法阵生成及消失时都会造成范围技能伤害
【伤害公式】（智力*20+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 13,
}


local mt = ac.skill['杰拉米']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[jielami.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00超绝群伦10段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加敏捷】+240*Lv
【移动速度】+125
【闪避】+25%
【物理伤害加深】+500%
【全伤加深】+100%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*22.5+10000）*Lv+1%敌人的最大生命值

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 15,
}


local mt = ac.skill['熊灵分裂'] --展示
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[xiongling1.blp]],
title ='熊灵能力：分裂击',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00骑士2段

|cffFFE799【能力说明】：|r
|cff00ff00使得召唤出来的狗熊，强化攻击并拥有350%的分裂伤害

]],
need_map_level = 4,
}

--真正的熊灵分裂加成
local mt = ac.skill['熊灵分裂1'] 
mt{
--等级
level = 1,
title ='分裂击',
--图标
art = [[xiongling1.blp]],
--说明
tip = [[

|cff00ffff攻击+250%
|cff00ffff分裂伤害+350%

]],
need_map_level = 4,
['攻击%'] =250,
['分裂伤害'] =350,

}



local mt = ac.skill['爱国者导弹'] 
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[paotai.blp]],

--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00堡垒4段

|cffFFE799【能力说明】：|r
|cff00ff00开局赠送一个可召唤|cff00ffff “爱国者导弹” |cff00ff00的物品，发放至背包

|cff00ffff导弹攻击力=英雄攻击力+5E
|cffffff00导弹攻击距离=650
|cffff0000导弹继承英雄暴击几率/伤害，会心几率/伤害，物伤/全伤加深

]],
need_map_level = 8,
}
-- function mt:on_add()
--     local hero = self.owner
--     local p = hero.owner
--     local peon = p.peon
--     peon:add_item('爱国者导弹1')
-- end

function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local it = hero:add_item('爱国者导弹1')
    -- print(it,p,hero)
    it.owner_ship = p
    -- print(it,p,hero,it.owner_ship)
end


local mt = ac.skill['爱国者导弹1'] 
mt{
--等级
level = 1,
title ='爱国者导弹',
--图标
art = [[paotai.blp]],
content_tip = [[|cffFFE799能力说明：|r]],
--说明
tip = [[


|cff00ff00点击召唤|cff00ffff “爱国者导弹” |cff00ff00为你战斗
]],
need_map_level = 3,
target_type = ac.skill.TARGET_TYPE_POINT,
range = 1000,
item_type = '消耗品',
has_mall = function(self)
    local p = self.owner.owner 
    local hero = p.hero
    return hero:find_skill('黑科技礼包',nil) and 1 
end,
mul = function(self)
    local p = self.owner.owner 
    local hero = p.hero
    local val = hero:find_skill('黑科技礼包',nil)  and 2 or 1
    return val
end
}
function mt:on_cast_start()
    local hero = self.owner
    local p = hero.owner
    hero = p.hero
    local u = p:create_unit('爱国者导弹',self.target:get_point())
    u:add_restriction '无敌'
    u:add_restriction '定身'
    u.weapon = {
        ['弹道模型'] = [[Abilities\Weapons\Mortar\MortarMissile.mdl]],
        ['弹道速度'] = 3500,
        ['弹道弧度'] = 0,
        ['弹道出手'] = {15, 0, 66},
    }
    local attribute ={
        ['攻击'] = function() return (hero:get('攻击')+500000000)*self.mul end,
        ['攻击距离'] = 650 * self.mul ,
        
        ['攻击速度'] = function() return hero:get('攻击速度') + (self.has_mall or 0)*200 end ,
        ['攻击间隔'] = function() return hero:get('攻击间隔') end ,
        ['暴击几率'] = function() return hero:get('暴击几率') end ,
        ['暴击伤害'] = function() return hero:get('暴击伤害') end , 
        ['会心几率'] = function() return hero:get('会心几率') end ,
        ['会心伤害'] = function() return hero:get('会心伤害') end , 
        ['物理伤害加深'] = function() return hero:get('物理伤害加深') end ,
        ['全伤加深'] = function() return hero:get('全伤加深') end ,


        ['物品获取率'] = function() return hero:get('物品获取率') end ,
        ['木头加成'] = function() return hero:get('木头加成') end ,
        ['金币加成'] = function() return hero:get('金币加成') end , 
        ['杀敌数加成'] = function() return hero:get('杀敌数加成') end ,
        ['魔丸加成'] = function() return hero:get('魔丸加成') end ,--新资源

    }
    u:add_buff "召唤物"{
        attribute = attribute,
        skill = self,
        search_area = 1300, --搜敌路径
    }
    if self.has_mall then 
        u:add('多重射',1)
    end

    --添加回收技能
    u:add_skill('回收','英雄',4)
    u:add_skill('攻击','英雄',9)

    --如果有多重射 （存档）
    if hero:find_skill('炮台多重射',nil) then 
        u:add_skill('炮台多重射1','英雄')
    end
    p.paotai = u
end


local mt = ac.skill['回收'] 
mt{
--等级
level = 1,
--图标
art = [[paotai.blp]],
--说明
tip = [[

|cffFFE799【能力说明】：|r
|cff00ff00点击切换为|cff00ffff “物品” |cff00ff00形态

]],
need_map_level = 3,
}
function mt:on_cast_start()
    local u = self.owner
    local p = u.owner
    local it = ac.item.create_item('爱国者导弹1',u:get_point())  
    it.owner_ship = p
    u:remove()
    p.paotai = nil
end


local mt = ac.skill['熊灵攻击减甲'] --展示
mt{
--等级
level = 0,
is_order = 1,
title ='熊灵能力：攻击减甲',
--图标
art = [[xiongling1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00皇后6段

|cffFFE799【能力说明】：|r
|cff00ff00使得召唤出来的狗熊，拥有666的攻击减甲

]],
need_map_level = 10,
}

--真正的熊灵攻击减甲加成
local mt = ac.skill['熊灵攻击减甲1'] 
mt{
--等级
level = 1,
title ='攻击减甲',
--图标
art = [[sbkd.blp]],
--说明
tip = [[

|cff00ffff攻击减甲+666

]],
['攻击减甲'] =666
}


local mt = ac.skill['炮台多重射'] --展示
mt{
--等级
level = 0,
is_order = 1,
title ='炮台能力：多重射',
--图标
art = [[paotai.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00万古传芳8段

|cffFFE799【能力说明】：|r
|cff00ff00使得召唤出来的爱国者导弹，多重射+2

]],
need_map_level = 12,
}

--真正的炮台多重射加成
local mt = ac.skill['炮台多重射1'] 
mt{
--等级
level = 1,
title ='多重射',
--图标
art = [[paotai.blp]],
--说明
tip = [[

|cff00ffff多重射+2

]],
['多重射'] = 2
}
function mt:on_add()
    print('炮台多重射被添加')
end


local mt = ac.skill['熊灵粉碎击'] --展示
mt{
--等级
level = 0,
is_order = 1,
title ='熊灵能力：粉碎击',
--图标
art = [[xiongling1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00冠世一绝10段

|cffFFE799【能力说明】：|r
|cff00ff00使得召唤出来的狗熊，攻击10%概率造成范围物理伤害（伤害公式：英雄攻击力*20），并晕眩敌人1秒

]],
need_map_level = 14,
}

--真正的熊灵粉碎击加成
local mt = ac.skill['熊灵粉碎击1'] 
mt{
--等级
level = 1,
title ='粉碎击',
--图标
art = [[xiongling1.blp]],
--说明
tip = [[

|cff00ffff攻击10%概率造成范围物理伤害（伤害公式：英雄攻击力*20），并晕眩敌人1秒

]],
need_map_level = 3,
event_name = '造成伤害效果',
chance = 10,
damage_area = 500,
effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]]
}

function mt:damage_start(damage)
    local source =self.owner
    local p = source.owner
    local hero = p.hero
    local skill =self
    local target = damage.target

	if not damage:is_common_attack()  then 
		return 
    end 
    for i, u in ac.selector()
		: in_range(source,self.damage_area)
		: is_enemy(source)
		: ipairs()
	do
        u:damage
        {
            source = source,
            skill = skill,
            damage = hero:get('攻击')*20,
            damage_type = '物理'
        }
        u:add_buff '晕眩'{
            time =1,
            model = skill.effect,
            ref = 'origin'
        }
	end	
end


local mt = ac.skill['通关难度']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[nandu.blp]],
    title = '通关难度奖励',
    tip = [[

点击查看|cff00ffff通关难度奖励|r，每通关一次即可获得|cffffff00对应难度的1段|r
    ]],
    
}
mt.skills ={
    '通关勋章','吕布','熊灵分裂','鬼剑愁',
    '爱国者导弹','张飞','熊灵攻击减甲','金克丝',
    '炮台多重射','貂蝉','通关难度-下一页'
}


local mt = ac.skill['通关难度-下一页']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

点击查看 |cff00ffff下一页|r
    ]],
    
}
mt.skills = {
    '熊灵粉碎击','杰拉米'
}
