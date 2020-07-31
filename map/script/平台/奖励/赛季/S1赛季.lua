local mt = ac.skill['S1精英版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '挖宝熟练度',
--图标
art = [[chanzi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00挖宝熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='挖宝熟练度',
award_cnt = 5000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '复制令牌',
--图标
art = [[lingpai.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00开局十分钟赠送的神奇的令牌，可额外获得一个

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}


local mt = ac.skill['S1精英版奖励3']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的头颅',
--图标
art = [[modidetoulu.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00-5%   生命上限|r
|cff00ff00+100% 全伤加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['生命上限%'] = -5,
['全伤加深'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[fadajing.blp]],
title = '看书熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S0赛季通行证】
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 5000,
need_map_level = 5,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local name = ac.server.key2name('s1jj')
    local flag = p.server[name] or 0
    local cnt = tonumber(string.match(self.name, "%d+"))
    print('S1奖励n',self.name,cnt)
    if flag >= cnt then 
        return 
    end

    local key = ac.server.name2key(self.award)
    p:Map_AddServerValue(key,self.award_cnt)
    --保存标识
    p:Map_AddServerValue('s1jj',1)

end


local mt = ac.skill['S1进阶版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[aixin.blp]],
title = '爱心积分',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S0赛季通行证】
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+1000   |cff00ff00爱心积分|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 1000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励3']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的心脏',
--图标
art = [[mddxz.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S0赛季通行证】
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+15%  生命上限|r
|cff00ff00+15%  每秒回血|r
|cff00ff00+100% 全伤加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['生命上限%'] = 15,
['每秒回血'] = 15,
['全伤加深'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}


for i,name in ipairs({'S1精英版奖励1','S1精英版奖励2','S1精英版奖励3'}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner
        local p = hero.owner
        local name = self.name:gsub('精英版','进阶版') 
        -- print('动态插入数据1:',name)
        if (p.mall['S1赛季通行证'] or 0 ) > 0 then 
            -- print('动态插入数据2:',name)
            ac.game:event_notify('技能-插入魔法书',hero,'S1赛季',name)
        end
    end
end


