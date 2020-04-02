

local mt = ac.skill['签到']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[qiandao.blp]],
    title = '签到',
    tip = [[
%is_qd%
累计签到： %has_qd%
点击查看 |cff00ffff签到|r
    ]],
    is_qd = function(self)
        local hero = self.owner
        local p = hero.owner
        local res
        if not p.qd_time then 
            res = '今日未签到'
        else
            if timediff(p:Map_GetGameStartTime(),p.qd_time,'day') > 0 then 
                res = '今日未签到'
            else
                res = '今日已签到'
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
['杀怪加全属性'] = 15,
['杀敌数加成'] = 5,
need_map_level = 2,
--特效
effect = [[lhcq.mdx]]
}

local mt = ac.skill['每日一签']
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
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.server['挖宝积分'] or 0
end,

['杀怪加攻击'] = 50,
['护甲'] = 500,
['物品获取率'] = 10,
need_map_level = 3,
--特效
effect = [[sbkd.mdx]]
}
