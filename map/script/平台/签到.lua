

local mt = ac.skill['签到']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[qiandao.blp]],
    title = '签到',
    tip = [[
    
%is_qd% 
|cffffe799累计签到次数：|r%has_qd%
|cffffe799本次签到奖励：|r|cff00ff00每秒加全属性+%每秒加全属性%
|cffffe799总签到奖励：|r|cff00ff00每秒加全属性+%每秒加全属性%

点击查看 |cff00ffff签到成就|r
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
        return p.server['签到']
    end,
    ['每秒加全属性'] = function(self)
        local hero = self.owner
        local p = hero.owner
        return p.server['签到']
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
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=2 

|cffFFE799【成就属性】：|r
|cff00ff00+5     每秒加全属性|r
|cff00ff00+15%  金币加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 5,
['金币加成'] = 15,
need_map_level = 1,
}

local mt = ac.skill['每日一签']
mt{
--等级
level = 0,
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=5 

|cffFFE799【成就属性】：|r
|cff00ff00+15    每秒加全属性|r
|cff00ff00+15%  攻击速度|r
|cff00ff00+15%  杀敌数加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 15,
['杀敌数加成'] = 15,
['攻击速度'] = 15,
need_map_level = 3,
}

local mt = ac.skill['我爱签到']
mt{
--等级
level = 0,
--图标
art = [[qiandao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=10 

|cffFFE799【成就属性】：|r
|cff00ff00+30    每秒加全属性|r
|cff00ff00+15    攻击减甲|r
|cff00ff00+15%  物品获取率|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 30,
['物品获取率'] = 15,
['攻击减甲'] = 15,
need_map_level = 5,
}

local mt = ac.skill['签到小弟']
mt{
--等级
level = 0,
--图标
art = [[qiandaoxiaodi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=20 

|cffFFE799【成就属性】：|r
|cff00ff00+60    每秒加全属性|r
|cff00ff00+15%  物理伤害加深|r
|cff00ff00+15%  木头加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 60,
['木头加成'] = 15,
['物理伤害加深'] = 15,
need_map_level = 7,
}

local mt = ac.skill['签到小哥']
mt{
--等级
level = 0,
--图标
art = [[qiandaoxiaoge.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=30 

|cffFFE799【成就属性】：|r
|cff00ff00+90    每秒加全属性|r
|cff00ff00+15%  技能伤害加深|r
|cff00ff00+15%  魔丸加成|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 90,
['魔丸加成'] = 15,
['技能伤害加深'] = 15,
need_map_level = 9,
}

local mt = ac.skill['签到小达人']
mt{
--等级
level = 0,
--图标
art = [[qiandaoxiaodaren.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=45 

|cffFFE799【成就属性】：|r
|cff00ff00+5     杀怪加全属性|r
|cff00ff00+5%  每秒回血|r
|cff00ff00+5k   每秒加金币|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加全属性'] = 15,
['每秒加金币'] = 5000,
['每秒回血'] = 5,
need_map_level = 11,
}

local mt = ac.skill['签到大哥']
mt{
--等级
level = 0,
--图标
art = [[qiandaodage.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=60 

|cffFFE799【成就属性】：|r
|cff00ff00+15    杀怪加全属性|r
|cff00ff00+2.5% 闪避|r
|cff00ff00+1     每秒加杀敌数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 15,
['每秒加杀敌数'] = 1,
['闪避'] = 2.5,
need_map_level = 13,
}

local mt = ac.skill['签到大佬']
mt{
--等级
level = 0,
--图标
art = [[qiandaodalao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=75 

|cffFFE799【成就属性】：|r
|cff00ff00+30    杀怪加全属性|r
|cff00ff00+2.5%  免伤几率|r
|cff00ff00+5     每秒加木头|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 30,
['每秒加木头'] = 5,
['免伤几率'] = 2.5,
need_map_level = 15,
}

local mt = ac.skill['签到大王']
mt{
--等级
level = 0,
--图标
art = [[qiandaodawang.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=90 

|cffFFE799【成就属性】：|r
|cff00ff00+90    杀怪加全属性|r
|cff00ff00+2.5%  减伤|r
|cff00ff00+15    每秒加魔丸|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 90,
['每秒加魔丸'] = 15,
['减伤'] = 2.5,
need_map_level = 17,
}

local mt = ac.skill['签到大圣']
mt{
--等级
level = 0,
--图标
art = [[qiandaodasheng.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff累计签到次数=5 

|cffFFE799【成就属性】：|r
|cff00ff00+90   杀怪加全属性|r
|cff00ff00+5    每秒加护甲|r
|cff00ff00+15% 全伤加深|r
|cff00ff00+1    多重暴击|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 90,
['每秒加护甲'] = 5,
['全伤加深'] = 15,
['多重暴击'] = 1,
need_map_level = 19,
}
