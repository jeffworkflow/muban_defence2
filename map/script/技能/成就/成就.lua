
local mt = ac.skill['勤劳的矿工']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[qrdkg.blp]], 
    --
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+30   攻击减甲
+1000  护甲|r

]],
    ['全属性'] = 1000000,
    ['攻击减甲'] = 30,
    ['护甲'] = 1000,
}

local mt = ac.skill['挖宝小能手']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[wbxns.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+50   移动速度
+50%  攻击速度
-0.05 攻击间隔|r

]],
    ['全属性'] = 3000000,
    ['移动速度'] = 50,
    ['攻击速度'] = 50,
    ['攻击间隔'] = -0.05,
}

local mt = ac.skill['黑格的陨石']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[hgdys.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+5%  技暴几率
+50%   技暴伤害
+25%   技能伤害加深|r

]],
    ['全属性'] = 5000000,
    ['技暴几率'] = 5,
    ['技暴伤害'] = 50,
    ['技能伤害加深'] = 25,
}


local mt = ac.skill['法老的遗产']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[fldyc.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+50  每秒加木头
+50%  木头加成|r

]],
    ['全属性'] = 7500000,
    ['每秒加木头'] = 50,
    ['木头加成'] = 50,
}


local mt = ac.skill['ONE_PIECE']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[oneps.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+5%  会心几率
+50%   会心伤害
+25%   全伤加深|r

]],
    ['全属性'] = 20000000,
    ['会心几率'] = 5,
    ['会心伤害'] = 50,
    ['全伤加深'] = 25,
    
}


local mt = ac.skill['百佛图']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[baifotu.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+100w  生命上限
+1000  护甲|r

]],
    ['全属性'] = 1000000,
    ['生命上限'] = 1000000,
    ['护甲'] = 1000,
}

local mt = ac.skill['洗髓经']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[xisuijing.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+50w  伤害减少
+50w  生命恢复|r

]],
    ['全属性'] = 3000000,
    ['伤害减少'] = 500000,
    ['生命恢复'] = 500000,
}
local mt = ac.skill['易筋经']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[yijinjing.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+2.5%  减伤
+2.5%  每秒回血|r

]],
    ['全属性'] = 5000000,
    ['减伤'] = 2.5,
    ['每秒回血'] = 2.5,
}
local mt = ac.skill['天诀']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[tianjue.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+25%  技能伤害加深
+50%  攻击速度|r

]],
    ['全属性'] = 7500000,
    ['技能伤害加深'] = 25,
    ['攻击速度'] = 50,
}


local mt = ac.skill['七十二绝技']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[qishier.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+1     多重暴击
+5%  多重暴击几率
+25%   全伤加深|r

]],
    ['全属性'] = 20000000,
    ['多重暴击'] = 1,
    ['多重暴击几率'] = 5,
    ['全伤加深'] = 25,
}


local mt = ac.skill['锻造学徒']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[xuetu.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+350W 攻击
+2.5%  强化成功概率|r

]],
    ['全属性'] = 1000000,
    ['攻击'] = 3500000,
    ['强化成功概率'] = 2.5,
}

local mt = ac.skill['锻造师傅']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shifu.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+50%  物理伤害加深
+2.5%  强化成功概率|r

]],
    ['全属性'] = 3000000,
    ['物理伤害加深'] = 50,
    ['强化成功概率'] = 2.5,
}

local mt = ac.skill['锻造匠人']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[gongjiang.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+50%  攻击速度
-0.05 攻击间隔
+2.5%  强化成功概率|r

]],
    ['全属性'] = 5000000,
    ['攻击速度'] = 50,
    ['攻击间隔'] = -0.05,
    ['强化成功概率'] = 2.5,
}
local mt = ac.skill['锻造宗师']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[zongshi.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+5%  暴击几率
+50%  暴击伤害
+2.5%  强化成功概率|r

]],
    ['全属性'] = 7500000,
    ['暴击几率'] = 5,
    ['暴击伤害'] = 50,
    ['强化成功概率'] = 2.5,
}

local mt = ac.skill['天外飞仙']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[tianwaifeixian.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+5%   会心几率
+50%  会心伤害
+25%  全伤加深
+2.5% 强化成功概率|r

]],
    ['全属性'] = 20000000,
    ['会心几率'] = 5,
    ['会心伤害'] = 50,
    ['强化成功概率'] = 2.5,
}

local mt = ac.skill['我爱养花种树']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[wayhzs.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+10  每秒加木头
+25%  木头加成|r

]],
    ['全属性'] = 1000000,
    ['每秒加木头'] = 10,
    ['木头加成'] = 25,

}


local mt = ac.skill['果实累累']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[gsll.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+20  每秒加魔丸
+25%  魔丸加成

]],
    ['全属性'] = 3000000,
    ['每秒加魔丸'] = 20,
    ['魔丸加成'] = 25,
    
}

local mt = ac.skill['辛勤的园丁']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[xqdyd.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+50%  攻击速度
+50%  分裂伤害|r

]],
    ['全属性'] = 5000000,
    ['攻击速度'] = 50,
    ['分裂伤害'] = 50,
    
}

local mt = ac.skill['冷月葬花魂']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[lyzhh.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+1   每秒加杀敌数
+25%  杀敌数加成|r

]],
    ['全属性'] = 7500000,
    ['每秒加杀敌数'] = 1,
    ['杀敌数加成'] = 25,
}

local mt = ac.skill['蚂蚁森林']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[mysl.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+5   每秒加杀敌数
+50%  杀敌数加成
+25%  全伤加深|r

]],
    ['全属性'] = 4000000,
    ['每秒加杀敌数'] = 5,
    ['杀敌数加成'] = 50,
    ['全伤加深'] = 25,
}

local mt = ac.skill['欢乐扭蛋']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[huanleniudan.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+2.5%  会心几率|r

]],
    ['全属性'] = 1000000,
    ['会心几率'] = 2.5,
}

local mt = ac.skill['扭蛋高手']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[niudangaoshou.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+500W 攻击
+50%  会心伤害|r

]],
    ['全属性'] = 3000000,
    ['攻击'] = 5000000,
    ['会心伤害'] = 50,
}

local mt = ac.skill['扭蛋天才']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[niudantiancai.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+1W  杀怪加攻击
+20W  每秒加攻击|r

]],
    ['全属性'] = 5000000,
    ['杀怪加攻击'] = 10000,
    ['每秒加攻击'] = 200000,
}

local mt = ac.skill['扭蛋大魔王']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[damowang.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+5%  技暴几率
+50%  技暴伤害|r

]],
    ['全属性'] = 7500000,
    ['技暴几率'] = 5,
    ['技暴伤害'] = 50,
}

local mt = ac.skill['扭蛋大神']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shendan.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+50%  技能伤害加深
+15%  全伤加深|r

]],
    ['全属性'] = 20000000,
    ['技能伤害加深'] = 50,
    ['全伤加深'] = 15,
}

local mt = ac.skill['一笔巨款']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[jukuan.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+2500  杀敌数
+5000  木头
+20000  魔丸|r

]],
    ['全属性'] = 1000000,
    add_kill = 2500,
    add_wood = 5000,
    add_fire = 20000,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_rec_ex(self.add_fire)
    hero:add_kill_count(self.add_kill)
end   

local mt = ac.skill['玄远之学']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[xuanxue.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+2.5%  所有翻倍概率|r

]],
    ['全属性'] = 3000000,

    ['木头翻倍概率'] = 2.5,
    ['魔丸翻倍概率'] = 2.5,
    ['杀敌数翻倍概率'] = 2.5,
    ['全属性翻倍概率'] = 2.5,
    
}

local mt = ac.skill['三冬暖']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[ReplaceableTextures\CommandButtons\BTN3M3.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
凉凉时返还5%资源|r

|cffcccccc凉凉的瞬间不会感到特别寒冷]],
    ['全属性'] = 5000000,
    ['返还资源'] = 5,
    
}

local mt = ac.skill['源源不断的本钱']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[benqian.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+750W 全属性
+10  每秒加杀敌数
+10  每秒加木头
+10  每秒加魔丸
+10w  每秒加全属性|r

]],
    ['全属性'] = 7500000,
    ['每秒加杀敌数'] = 10,
    ['每秒加木头'] = 10,
    ['每秒加魔丸'] = 10,
    ['每秒加全属性'] = 100000,
}

local mt = ac.skill['du神']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[dushen.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2000W 全属性
+5%   会心几率
+50%  会心伤害
+15%  全伤加深|r

]],
    ['全属性'] = 20000000,
    ['会心几率'] = 5,
    ['会心伤害'] = 50,
    ['全伤加深'] = 15,
}