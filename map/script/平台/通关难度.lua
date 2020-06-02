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

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
|cffffff00【每秒加木头】+5*Lv
【每秒加魔丸】+5*Lv
【物品获取率】+100%
【每秒回血】+15%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*10+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
【护甲】+15%
【分裂伤害】+50%
【攻击减甲】+150

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*15+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
【攻击速度】+100%
【攻击距离】+250
【物理伤害加深】+200%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*20+10000）*Lv+1%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
【伤害公式】（智力*25+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
【杀怪加敏捷】+240*Lv
【移动速度】+125
【闪避】+25%
【物理伤害加深】+500%
【全伤加深】+100%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*30+10000）*Lv+1%敌人的最大生命值

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
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
|cff00ff00开局赠送一个可召唤|cff00ffff “爱国者导弹” |cff00ff00的物品，发放至宠物背包

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
    hero:add_item('爱国者导弹1')
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
item_type = '消耗品'
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
        ['弹道速度'] = 1000,
        ['弹道弧度'] = 0,
        ['弹道出手'] = {15, 0, 66},
    }
    local attribute ={
        ['攻击'] = function() return hero:get('攻击')+1000000000 end,

        ['物品获取率'] = hero:get('物品获取率'),
        ['木头加成'] = hero:get('木头加成'),
        ['金币加成'] = hero:get('金币加成'),
        ['杀敌数加成'] = hero:get('杀敌数加成'),
        ['魔丸加成'] = hero:get('魔丸加成'),--新资源

    }
    u:add_buff "召唤物"{
        attribute = attribute,
        skill = self,
        search_area = 800, --搜敌路径
    }

    --添加回收技能
    u:add_skill('回收','英雄',4)

    --如果有多重射 （存档）
    if hero:find_skill('炮台多重射',nil) then 
        u:add_skill('炮台多重射1','英雄')
    end
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
    ac.item.create_item('爱国者导弹1',u:get_point())  
    u:remove()
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
|cff00ff00使得召唤出来的狗熊，拥有350的攻击减甲

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

|cff00ffff攻击减甲+350

]],
['攻击减甲'] =350
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
|cff00ff00使得召唤出来的爱国者导弹，多重射+5

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

|cff00ffff多重射+5

]],
['多重射'] = 5
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

点击查看 |cff00ffff通关难度奖励|r
    ]],
    
}
mt.skills ={
    '吕布','熊灵分裂','鬼剑愁','爱国者导弹','张飞','熊灵攻击减甲','金克丝','炮台多重射','貂蝉','熊灵粉碎击','杰拉米'
}
