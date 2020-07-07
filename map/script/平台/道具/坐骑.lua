--称号
local mt = ac.skill['风速狗']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi1.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥2000%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+36  杀怪加敏捷|r
|cff00ff00+20% 物理伤害加深|r
|cff00ff00+25% 攻击速度|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 36,
['物理伤害加深'] = 20,
['攻击速度'] = 25,
need_map_level = 2,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[JD_066_D.mdx]],
size = 2,--坐骑大小
high = 90, --人物高度
}

local mt = ac.skill['兜兜猪']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi2.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥7500%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+56  杀怪加敏捷|r
|cff00ff00+40% 物理伤害加深|r
|cff00ff00+1   每秒加杀敌数|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 56,
['物理伤害加深'] = 40,
['每秒加杀敌数'] = 1,
need_map_level = 5,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[Txxxxxx (2).mdx]],
size = 1,--坐骑大小
high = 100, --人物高度
}

local mt = ac.skill['星空麋鹿']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi3.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥16000%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+76  杀怪加敏捷|r
|cff00ff00+60% 物理伤害加深|r
|cff00ff00+25  移动速度|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 76,
['物理伤害加深'] = 60,
['移动速度'] = 25,
need_map_level = 8,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[JD-XIANLU123.mdx]],
size = 2.1,--坐骑大小
high = 110, --人物高度
}

local mt = ac.skill['烈焰凤凰']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi4.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥27500%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+96  杀怪加敏捷|r
|cff00ff00+80% 物理伤害加深|r
|cff00ff00+2   每秒加杀敌数|r
|cff00ff00+10% 扭蛋券(十连抽)/超级扭蛋券(十连抽)掉落概率|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 96,
['物理伤害加深'] = 80,
['每秒加杀敌数'] = 2,
['扭蛋券(十连抽)掉落概率'] = 10,
['超级扭蛋券(十连抽)掉落概率'] = 10,

need_map_level = 11,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[Phoenix2.mdx]],
size = 1.3,--坐骑大小
high = 150, --人物高度
zq_hight = 100,
}

local mt = ac.skill['地狱蜘蛛']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi5.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥42000%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+116 杀怪加敏捷|r
|cff00ff00+100% 物理伤害加深|r
|cff00ff00+25% 吸血|r
|cff00ff00+10% 扭蛋券(十连抽)/超级扭蛋券(十连抽)掉落概率|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 116,
['物理伤害加深'] = 100,
['吸血'] = 25,
['扭蛋券(十连抽)掉落概率'] = 10,
['超级扭蛋券(十连抽)掉落概率'] = 10,
need_map_level = 14,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[Beth`tilac.mdx]],
size = 0.6,--坐骑大小
high = 120, --人物高度
}

local mt = ac.skill['紫霜龙鹰']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi6.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥59500%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+136 杀怪加敏捷|r
|cff00ff00+120% 物理伤害加深|r
|cff00ff00+3   每秒加杀敌数|r
|cff00ff00+10% 扭蛋券(十连抽)/超级扭蛋券(十连抽)掉落概率|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 136,
['物理伤害加深'] = 120,
['每秒加杀敌数'] = 3,
['扭蛋券(十连抽)掉落概率'] = 10,
['超级扭蛋券(十连抽)掉落概率'] = 10,
need_map_level = 17,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[Hero_Phoenix_N1_purple.mdx]],
size = 1.2,--坐骑大小
high = 150, --人物高度
zq_hight = 100,
}

local mt = ac.skill['炎宿朱雀']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi7.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥80000%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+156  杀怪加敏捷|r
|cff00ff00+140% 物理伤害加深|r
|cff00ff00+1    多重射|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 156,
['物理伤害加深'] = 140,
['多重射'] = 1,
need_map_level = 20,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[zhuque.mdx]],
size = 1.3,--坐骑大小
high = 150, --人物高度
zq_hight = 100,
}

local mt = ac.skill['苍魂青龙']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi8.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥103500%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+176  杀怪加敏捷|r
|cff00ff00+160% 物理伤害加深|r
|cff00ff00+4    每秒加杀敌数|r
|cff00ff00+10%  扭蛋券(十连抽)/超级扭蛋券(十连抽)掉落概率|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 176,
['物理伤害加深'] = 160,
['每秒加杀敌数'] = 4,
['扭蛋券(十连抽)掉落概率'] = 10,
['超级扭蛋券(十连抽)掉落概率'] = 10,
need_map_level = 23,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[yulong.mdx]],
size = 1,--坐骑大小
high = 150, --人物高度
zq_hight = 100,

}

local mt = ac.skill['晶蓝天马']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi9.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥130000%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+196  杀怪加敏捷|r
|cff00ff00+180% 物理伤害加深|r
|cff00ff00+1    多重暴击|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 196,
['物理伤害加深'] = 180,
['多重暴击'] = 1,
need_map_level = 26,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[Pet_TMXK.mdx]],
size = 2.1,--坐骑大小
high = 110, --人物高度
}

local mt = ac.skill['金角天马']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zuoqi10.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff白嫖熟练度≥159500%current%

|cffFFE799【坐骑属性】：|r
|cff00ff00+216  杀怪加敏捷|r
|cff00ff00+200% 物理伤害加深|r
|cff00ff00+5    每秒加杀敌数|r
|cff00ff00+10%  扭蛋券(十连抽)/超级扭蛋券(十连抽)掉落概率|r

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加敏捷'] = 216,
['物理伤害加深'] = 200,
['每秒加杀敌数'] = 5,
['扭蛋券(十连抽)掉落概率'] = 10,
['超级扭蛋券(十连抽)掉落概率'] = 10,
need_map_level = 29,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['白嫖熟练度'] or 0
    local str = '|cffdf19d0（当前熟练度：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
--特效
effect = [[JD_477_D.mdx]],
size = 2.3,--坐骑大小
high = 170, --人物高度
}


local mt = ac.skill['元祖巨龙']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[zulong.blp]],
--说明
tip = [[|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

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

|cffff0000【点击可更换坐骑外观，所有坐骑属性可叠加】|r]],
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
need_map_level = 29,
--特效
effect = [[186e8aea6a983e82.mdx]],
size = 0.75,
high = 250,
zq_hight = 95,
distance = 90,
angle = 5,

--伤害
damage = function(self)
return (self.owner:get('敏捷')+self.owner:get('力量')+self.owner:get('智力'))*250
end,
damage_area = 1300,
--被动事件
event_name = "造成伤害效果",
cool = 1,
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
model = [[jn_tf3.mdx]],
model_size = 10,
}

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	
	--创建特效
    local angle = hero:get_point() / target:get_point()
    ac.effect_ex{
        model = skill.model,
        size = 1.5,
        point = hero:get_point(),
        angle = angle,
        -- size = skill.mode_size 
    }:remove()

	--计算伤害
	for _,unit in ac.selector()
	: in_sector(hero:get_point(),self.damage_area,angle,120 )
	: is_enemy(hero)
	: ipairs()
	do 
		unit:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
			damage_type = '法术'
		}
		unit:damage
		{
			source = hero,
			damage = unit:get('生命上限')/100*2,
			skill = skill,
			real_damage = true
		}
	end 
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end




for i,name in ipairs({'风速狗','兜兜猪','星空麋鹿','烈焰凤凰','地狱蜘蛛','紫霜龙鹰','炎宿朱雀','苍魂青龙','晶蓝天马','金角天马','元祖巨龙'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_zuoqi and hero.effect_zuoqi.model == self.effect then
            hero.effect_zuoqi:remove()
            hero.effect_zuoqi = nil
            return
        end
        -- print(self.high)
        hero.effect_zuoqi = hero:add_buff '坐骑'{
            model = self.effect,
            size = self.size,
            high = self.high or 100,
            zq_hight = self.zq_hight,
            distance = self.distance,
            angle = self.angle
        }
    end    
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    