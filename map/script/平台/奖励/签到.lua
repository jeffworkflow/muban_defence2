
local mt = ac.skill['签到']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[qiandao.blp]],
    title = '签到',
    tip = [[

点击查看 |cff00ffff签到成就|r，通过|cffffff00 屏幕右方的每日签到 |r获得

%is_qd% 
|cffffe799累计签到次数：|r%has_qd%|cffdf19d0(改名会清零)|r
|cffffe799本次签到奖励：|r|cff00ff00每秒加全属性+%本次签到奖励%
|cffffe799总签到奖励：|r|cff00ff00每秒加全属性+%每秒加全属性%
    ]],
    ui_tip = [[    
%is_qd% 
|cffffe799累计签到次数：|r%has_qd%|cffdf19d0(改名会清零)|r
|cffffe799本次签到奖励：|r|cff00ff00每秒加全属性+%本次签到奖励%
|cffffe799总签到奖励：|r|cff00ff00每秒加全属性+%每秒加全属性%
    ]],
    is_qd = function(self)
        local hero = self.owner
        local p = hero.owner
        local res
        if not p.qd_time then 
            res = '|cffff0000今日未签到|r'
        else
            if timediff(p:Map_GetGameStartTime(),p.qd_time,'day') > 0 then 
                res = '|cffff0000今日未签到|r'
            else
                res = '|cff00ff00今日已签到|r'
            end   
        end    
        return res
    end,
    has_qd = function(self)
        local hero = self.owner
        local p = hero.owner
        return p.cus_server['签到'] or p.server['签到'] or 0
    end,
    ['本次签到奖励'] = function(self)
        local hero = self.owner
        local p = hero.owner
        return (p.cus_server['签到'] or p.server['签到'] or 0) + 1
    end,
    ['每秒加全属性'] = function(self)
        local hero = self.owner
        local p = hero.owner
        local val = 0
         
        if self.has_qd > 0 then
            for i=1,self.has_qd do 
                val = val + i
            end
        end
        return val
    end,
    
}
mt.skills = {
    '开始签到','每日一签','我爱签到','签到小弟','签到小哥','签到小达人','签到大哥','签到大佬','签到大王','签到大圣'
}
--称号
local mt = ac.skill['开始签到']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=2 

|cffFFE799【成就属性】：|r
|cff00ff00+10   每秒加全属性|r
|cff00ff00+15   攻击减甲|r
|cff00ff00+25%  金币加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 10,
['攻击减甲'] = 15,
['金币加成'] = 25,
need_map_level = 1,
}

local mt = ac.skill['每日一签']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=5 

|cffFFE799【成就属性】：|r
|cff00ff00+30   每秒加全属性|r
|cff00ff00+15%  物理伤害加深|r
|cff00ff00+15%  杀敌数加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 30,
['杀敌数加成'] = 15,
['物理伤害加深'] = 15,
need_map_level = 3,
}

local mt = ac.skill['我爱签到']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=10 

|cffFFE799【成就属性】：|r
|cff00ff00+90    每秒加全属性|r
|cff00ff00+65    攻击减甲|r
|cff00ff00+35%   物品获取率|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 90,
['物品获取率'] = 35,
['攻击减甲'] = 65,
need_map_level = 5,
}

local mt = ac.skill['签到小弟']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaoxiaodi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=20 

|cffFFE799【成就属性】：|r
|cff00ff00+270   每秒加全属性|r
|cff00ff00+35%   技能伤害加深|r
|cff00ff00+50%   木头加成|r
|cff00ff00+10%   暴击伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 270,
['木头加成'] = 50,
['技能伤害加深'] = 35,
['暴击伤害系数'] = 10,
need_map_level = 7,
}

local mt = ac.skill['签到小哥']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaoxiaoge.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=30 

|cffFFE799【成就属性】：|r
|cff00ff00+810  每秒加全属性|r
|cff00ff00+25%  全伤加深|r
|cff00ff00+50%  魔丸加成|r
|cff00ff00+10%  技暴伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 810,
['魔丸加成'] = 50,
['全伤加深'] = 25,
['技暴伤害系数'] = 10,
need_map_level = 9,
}

local mt = ac.skill['签到小达人']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaoxiaodaren.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=45 

|cffFFE799【成就属性】：|r
|cff00ff00+100 杀怪加全属性|r
|cff00ff00+10% 生命上限|r
|cff00ff00+10% 每秒回血|r
|cff00ff00+3   每秒加杀敌数|r
|cff00ff00+10%  会心伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['每秒加杀敌数'] = 3,
['每秒回血'] = 10,
['生命上限%'] = 10,
['会心伤害系数'] = 10,
need_map_level = 11,
}

local mt = ac.skill['签到大哥']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaodage.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=60 

|cffFFE799【成就属性】：|r
|cff00ff00+150 杀怪加全属性|r
|cff00ff00+5%  闪避|r
|cff00ff00+15  每秒加木头|r
|cff00ff00+10% 物理伤害加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 150,
['每秒加木头'] = 15,
['闪避'] = 5,
['物理伤害加深系数'] = 10,
need_map_level = 13,
}

local mt = ac.skill['签到大佬']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaodalao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=75 

|cffFFE799【成就属性】：|r
|cff00ff00+200 杀怪加全属性|r
|cff00ff00+5%  免伤几率|r
|cff00ff00+30  每秒加魔丸|r
|cff00ff00+10% 技能伤害加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 200,
['每秒加魔丸'] = 30,
['免伤几率'] = 5,
['技能伤害加深系数'] = 10,
need_map_level = 15,
}

local mt = ac.skill['签到大王']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaodawang.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=90 

|cffFFE799【成就属性】：|r
|cff00ff00+250 杀怪加全属性|r
|cff00ff00+5%  减伤|r
|cff00ff00+25  每秒加护甲|r
|cff00ff00+10% 对BOSS额外伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 250,
['每秒加护甲'] = 25,
['减伤'] = 5,
['对BOSS额外伤害系数'] = 10,
need_map_level = 17,
}

local mt = ac.skill['签到大圣']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[qiandaodasheng.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=100 

|cffFFE799【成就属性】：|r
|cff00ff00+300  杀怪加全属性|r
|cff00ff00+100% 全伤加深|r
|cff00ff00+1    多重暴击|r
|cff00ff00+10%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 300,
['全伤加深'] = 100,
['多重暴击'] = 1,
['全伤加深系数'] = 1,
need_map_level = 19,
}
