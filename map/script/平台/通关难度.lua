--通关难度
local mt = ac.skill['吕布']
mt{
--等级
level = 0,
--图标
art = [[lhcq.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff青铜1星 

|cffFFE799【称号属性】：|r
|cff00ff00+15  杀怪加全属性|r
|cff00ff00+5%  杀敌数加成|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 2,
}

local mt = ac.skill['熊灵分裂'] --展示
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
}

--真正的熊灵分裂加成
local mt = ac.skill['熊灵分裂1'] 
mt{
--等级
level = 1,
title ='熊灵分裂',
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
['分裂伤害'] =100
}

local mt = ac.skill['爱国者导弹'] 
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local peon = p.peon
    peon:add_item('爱国者导弹1')
end

local mt = ac.skill['爱国者导弹1'] 
mt{
--等级
level = 1,
title ='爱国者导弹',
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
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
        ['攻击'] = function() return hero:get('攻击')+1000000 end,

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
    u:add_skill('回收','英雄',12)

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
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
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
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
}

--真正的熊灵攻击减甲加成
local mt = ac.skill['熊灵攻击减甲1'] 
mt{
--等级
level = 1,
title ='熊灵攻击减甲',
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
['攻击减甲'] =200
}


local mt = ac.skill['炮台多重射'] --展示
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
}

--真正的炮台多重射加成
local mt = ac.skill['炮台多重射1'] 
mt{
--等级
level = 1,
title ='炮台多重射',
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
['多重射'] = 4
}
function mt:on_add()
    print('炮台多重射被添加')
end


local mt = ac.skill['熊灵粉碎击'] --展示
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
}

--真正的熊灵粉碎击加成
local mt = ac.skill['熊灵粉碎击1'] 
mt{
--等级
level = 1,
title ='熊灵粉碎击',
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
need_map_level = 3,
event_name = '造成伤害效果',
chance = 5,
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
            damage = hero:get('攻击')*10,
            damage_type = '法术'
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
    art = [[moshen.blp]],
    title = '通关难度',
    tip = [[

点击查看 |cff00ffff通关难度|r
    ]],
    
}
mt.skills ={
    '吕布','熊灵分裂','梅卡托克','爱国者导弹','张飞','熊灵攻击减甲','金克丝','炮台多重射','貂蝉','粉碎击','杰拉米'
}
