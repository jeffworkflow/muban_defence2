local mt = ac.skill['S4精英版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '看书熟练度',
--图标
art = [[fadajing.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '种树熟练度',
--图标
art = [[zhongzi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00种树熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='种树熟练度',
award_cnt = 10000,
need_map_level = 5,
}


local mt = ac.skill['S4精英版奖励3']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '杀戮值',
--图标
art = [[shaluzhi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+500   |cff00ff00杀戮值|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='魔灵争霸',
award_cnt = 500,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励4']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '暴击伤害系数',
--图标
art = [[baoji.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00暴击伤害系数|r

]],
['暴击伤害系数'] = 5,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励5']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的号令',
--图标
art = [[mddhl.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+100% 会心伤害|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['会心伤害'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励6']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '白嫖熟练度',
--图标
art = [[niudantiancai.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff六个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励7']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '摇骰子熟练度',
--图标
art = [[anheishaizi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff七个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00摇骰子熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='摇骰子熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励8']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '爱心积分',
--图标
art = [[aixin.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff八个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+2000   |cff00ff00爱心积分|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 2000,
need_map_level = 5,
}




local mt = ac.skill['S4精英版奖励9']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '技暴伤害系数',
--图标
art = [[jibao.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff九个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00技暴伤害系数|r

]],
['技暴伤害系数'] = 5,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励10']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的天命',
--图标
art = [[mddtm.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+100% 全伤加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['全伤加深'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励11']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '打造熟练度',
--图标
art = [[suijiwupin.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00打造熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='打造熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励12']
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
|cff00ff00累计获得|cff00ffff十二个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00挖宝熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='挖宝熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励13']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '看书熟练度',
--图标
art = [[fadajing.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 10000,
need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励14']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '会心伤害系数',
--图标
art = [[huixin.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00会心伤害系数|r

]],
['会心伤害系数'] = 5,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S4精英版奖励15']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的饰衣',
--图标
art = [[mddsy1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+200% 技能伤害加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['技能伤害加深'] = 200,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[zhongzi.blp]],
title = '种树熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00种树熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='种树熟练度',
award_cnt = 10000,
need_map_level = 5,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local name = ac.server.key2name('s2jj')
    local flag = p.server[name] or 0
    local cnt = tonumber(string.match(self.name, "S4进阶版奖励(%d+)"))
    print('S4奖励n',self.name,cnt)
    if flag >= cnt then 
        return 
    end

    local key = ac.server.name2key(self.award)
    p:Map_AddServerValue(key,self.award_cnt)
    --保存标识
    p:Map_AddServerValue('s2jj',1)

end


local mt = ac.skill['S4进阶版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[niudantiancai.blp]],
title = '白嫖熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励3']
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
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+2000   |cff00ff00爱心积分|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 2000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励4']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[ReplaceableTextures\CommandButtons\BTNClawsOfAttack.blp]],
title = '物理伤害加深系数',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00物理伤害加深系数|r

]],
['物理伤害加深系数'] = 5,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励5']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的权利',
--图标
art = [[mddql.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+10% 技能伤害加深系数|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['技能伤害加深系数'] = 10,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励6']
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
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff六个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励7']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[niudantiancai.blp]],
title = '白嫖熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff七个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励8']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[shaluzhi.blp]],
title = '杀戮值',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff八个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+500   |cff00ff00杀戮值|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='魔灵争霸',
award_cnt = 500,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励9']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[ReplaceableTextures\CommandButtons\BTNRobeOfTheMagi.blp]],
title = '技能伤害加深系数',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff九个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00技能伤害加深系数|r

]],
['技能伤害加深系数'] = 5,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励10']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的战衣',
--图标
art = [[mddzy.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+10%  护甲|r
|cff00ff00+10%  攻击|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['护甲%'] = 10,
['攻击%'] = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励11']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[anheishaizi.blp]],
title = '摇骰子熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00摇骰子熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='摇骰子熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励12']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[suijiwupin.blp]],
title = '打造熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十二个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00打造熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='打造熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励13']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[zhongzi.blp]],
title = '种树熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+10000   |cff00ff00种树熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='种树熟练度',
award_cnt = 10000,
need_map_level = 5,
}
mt.on_add = ac.skill['S4进阶版奖励1'].on_add

local mt = ac.skill['S4进阶版奖励14']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[ReplaceableTextures\PassiveButtons\PASBTNGnollCommandAura.blp]],
title = '全伤加深系数',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5%   |cff00ff00全伤加深系数|r

]],
['全伤加深系数'] = 5,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S4进阶版奖励15']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的险境',
--图标
art = [[mddxj.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S4赛季通行证】
|cff00ff00累计获得|cff00ffff十五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+10% 会心伤害系数|r
|cff00ff00+10% 攻击减甲系数|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['攻击减甲系数'] = 10,
['会心伤害系数'] = 10,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}


for i,name in ipairs({
    'S4精英版奖励1','S4精英版奖励2','S4精英版奖励3','S4精英版奖励4',
    'S4精英版奖励5','S4精英版奖励6','S4精英版奖励7','S4精英版奖励8',
    'S4精英版奖励9','S4精英版奖励10','S4精英版奖励11','S4精英版奖励12',
    'S4精英版奖励13','S4精英版奖励14','S4精英版奖励15',
}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner
        local p = hero.owner
        local name = self.name:gsub('精英版','进阶版') 
        -- print('动态插入数据1:',name)
        if (p.mall['S4赛季通行证'] or 0 ) > 0 then 
            -- print('动态插入数据2:',name)
            ac.game:event_notify('技能-插入魔法书',hero,'S4赛季',name)
        end
    end
end


