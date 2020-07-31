local mt = ac.skill['S1精英版奖励1']
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
|cff00ff00+5000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 5000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励2']
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
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00打造熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='打造熟练度',
award_cnt = 5000,
need_map_level = 5,
}


local mt = ac.skill['S1精英版奖励3']
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
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+1000   |cff00ff00爱心积分|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 1000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励4']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '攻击减甲',
--图标
art = [[ReplaceableTextures\CommandButtons\BTNGhoulFrenzy.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+66   |cff00ff00攻击减甲|r

]],
['攻击减甲'] = 66,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励5']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的獠牙',
--图标
art = [[ReplaceableTextures\CommandButtons\BTNCannibalize.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+5%  吸血|r
|cff00ff00+1w  护甲|r
|cff00ff00+200% 暴击伤害|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['吸血'] = 5,
['护甲'] = 10000,
['暴击伤害'] = 200,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励6']
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
|cff00ff00+1000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 1000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励7']
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
|cff00ff00累计获得|cff00ffff七个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+100   |cff00ff00杀戮值|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='杀戮值',
award_cnt = 100,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励8']
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
|cff00ff00累计获得|cff00ffff八个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00摇骰子熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='摇骰子熟练度',
award_cnt = 5000,
need_map_level = 5,
}




local mt = ac.skill['S1精英版奖励9']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '减少周围护甲',
--图标
art = [[ReplaceableTextures\CommandButtons\BTNSpiritOfVengeance.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff九个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+666   |cff00ff00减少周围护甲|r

]],
['减少周围护甲'] = 666,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励10']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的触手',
--图标
art = [[mddcs.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+50   攻击距离|r
|cff00ff00+1    多重射|r
|cff00ff00+100% 技暴伤害|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['攻击距离'] = 50,
['多重射'] = 1,
['技暴伤害'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励11']
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
|cff00ff00累计获得|cff00ffff十一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+1000   |cff00ff00爱心积分|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 1000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励12']
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
|cff00ff00累计获得|cff00ffff十二个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 5000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励13']
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
|cff00ff00累计获得|cff00ffff十三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00打造熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='打造熟练度',
award_cnt = 5000,
need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励14']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '对BOSS额外伤害',
--图标
art = [[ReplaceableTextures\CommandButtons\BTNSacrifice.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff十四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+25   |cff00ff00对BOSS额外伤害|r

]],
['对BOSS额外伤害'] = 25,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S1精英版奖励15']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝之翼',
--图标
art = [[mdzy.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+33   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+25   移动速度|r
|cff00ff00+1     多重暴击|r
|cff00ff00+50%  会心伤害|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 33,
['每秒加护甲'] = 6,
['移动速度'] = 25,
['多重暴击'] = 1,
['会心伤害'] = 50,

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
art = [[niudantiancai.blp]],
title = '白嫖熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 5000,
need_map_level = 5,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local name = ac.server.key2name('s1jj')
    local flag = p.server[name] or 0
    local cnt = tonumber(self.name:sub(16,-1))
    print('奖励n',self.name,cnt)
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
art = [[zhongzi.blp]],
title = '种树熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff两个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00种树熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='种树熟练度',
award_cnt = 5000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励3']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+100   |cff00ff00杀戮值|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='杀戮值',
award_cnt = 100,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励4']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[ReplaceableTextures\PassiveButtons\PASBTNGnollCommandAura.blp]],
title = '全伤加深',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+25%   |cff00ff00全伤加深|r

]],
['全伤加深'] = 25,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励5']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的凝视',
--图标
art = [[item\qiu524.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+50%  物品获取率|r
|cff00ff00+200% 物理伤害加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['物品获取率'] = 50,
['物理伤害加深'] = 200,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励6']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff六个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 5000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励7']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff七个荣耀战令|cff00ff00后获得 

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

local mt = ac.skill['S1进阶版奖励8']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[chanzi.blp]],
title = '挖宝熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff八个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00挖宝熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='挖宝熟练度',
award_cnt = 5000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励9']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[baoji.blp]],
title = '暴击伤害',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff九个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+100%   |cff00ff00暴击伤害|r

]],
['暴击伤害'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励10']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的暴怒',
--图标
art = [[mddfn.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+50%  杀敌数加成|r
|cff00ff00+100% 技能伤害加深|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['杀敌数加成'] = 50,
['技能伤害加深'] = 100,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励11']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十一个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+100   |cff00ff00杀戮值|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='杀戮值',
award_cnt = 100,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励12']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十二个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00白嫖熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='白嫖熟练度',
award_cnt = 5000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励13']
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
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十三个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+5000   |cff00ff00种树熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='种树熟练度',
award_cnt = 5000,
need_map_level = 5,
}
mt.on_add = ac.skill['S1进阶版奖励1'].on_add

local mt = ac.skill['S1进阶版奖励14']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[jibao.blp]],
title = '技暴伤害',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十四个荣耀战令|cff00ff00后获得 

|cffFFE799【属性】：|r
|cff00ff00+50%   |cff00ff00技暴伤害|r

]],
['技暴伤害'] = 50,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}

local mt = ac.skill['S1进阶版奖励15']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '魔帝的咆哮',
--图标
art = [[mddpx.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【S1赛季通行证】
|cff00ff00累计获得|cff00ffff十五个荣耀战令|cff00ff00后获得 

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+6    每秒加护甲|r
|cff00ff00+50%  木头加成|r
|cff00ff00+50% 对BOSS额外伤害|r

]],
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['每秒加护甲'] = 6,
['木头加成'] = 50,
['对BOSS额外伤害'] = 50,

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


