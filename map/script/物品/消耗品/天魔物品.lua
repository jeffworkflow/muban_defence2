local mt = ac.skill['地狱咆哮']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【地狱咆哮】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
    --触发几率
    chance = 10,
    cool = 1,
    --业务技能代码
    effect =[[zhansha.mdx]],
    event_name = '造成伤害效果',
    -- unique_name ='斩杀',
    -- cover = function(self)
    --     return self.chance
    -- end
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    if not damage:is_common_attack()  then 
        return 
    end 
    local life_rate = target:get('生命') / target:get('生命上限') * 100
    if life_rate < 15 then
        ac.effect_ex{
            model = self.effect,
            point = target:get_point()
        }:remove()
        target:kill(hero) 
    end
end
local mt = ac.skill['地狱意志']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【地狱意志】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
    --触发几率
    chance = 10,
    cool = 5,
    --业务技能代码
    effect =[[wuqi123.mdx]],
    event_name = '造成伤害效果',
    -- unique_name ='裂魂',
    -- cover = function(self)
    --     return self.chance
    -- end
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    if not damage:is_common_attack()  then 
        return 
    end 
    hero:add_buff '裂魂_攻击' {
        value = hero:get('力量') + hero:get('敏捷') + hero:get('智力'),
        model = self.effect,
        ref = 'hand',
        time = 1
    }
    
end
local mt = ac.buff['裂魂_攻击']
mt.cover_type = 0
function mt:on_add()
    self.eff = self.target:add_effect(self.ref, self.model)
    self.target:add('攻击',self.value)
end
function mt:on_remove()
    if self.eff then
       self.eff:remove()
    end
    self.target:add('攻击',-self.value)
end
function mt:on_cover(new)
    return new.value > self.value
end

local mt = ac.skill['鬼神之石']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【鬼神之石】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
    --触发几率
    chance = 10,
    cool = 5,
    --业务技能代码
    effect =[[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]],
    event_name = '造成伤害效果',
    -- unique_name ='鬼神之勇',
    -- cover = function(self)
    --     return self.chance
    -- end
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    if not damage:is_common_attack()  then 
        return 
    end 
    -- print('鬼神之勇',hero:get('生命上限') - hero:get('生命'))
    hero:add_buff '鬼神之勇' {
        value = hero:get('生命上限') - hero:get('生命'),
        model = self.effect,
        ref = 'hand',
        time = 1
    }
    
end
local mt = ac.buff['鬼神之勇']
mt.cover_type = 0
function mt:on_add()
    self.eff = self.target:add_effect(self.ref, self.model)
    self.target:add('全属性',self.value)
end
function mt:on_remove()
    if self.eff then
       self.eff:remove()
    end
    self.target:add('全属性',-self.value)
end
function mt:on_cover(new)
    return new.value > self.value
end

local mt = ac.skill['魂幡之灵']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【魂幡之灵】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
    --触发几率
    chance = 10,
    cool = 5,
    --业务技能代码
    effect =[[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]],
    event_name = '单位-即将死亡',
    heal = 60,
    -- unique_name ='守护天使',
    -- cover = function(self)
    --     return self.chance
    -- end
}
function mt:damage_start(unit,killer)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    hero:add_effect('chest',self.effect):remove()
    --目标减最大 
    hero:heal
    {
        source = hero,
        skill = skill,
        string = '守护天使',
        size = 10,
        heal = hero:get('生命上限') * skill.heal/100,
    }	
    -- hero:add('护甲',1000000000)
    return true
end

local mt = ac.skill['天灾骨钟']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【天灾骨钟】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['暴击极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
}

local mt = ac.skill['生死簿']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【生死簿】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['暴击极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
}
local mt = ac.skill['阎王印']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【阎王印】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['暴击极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
}
local mt = ac.skill['谛听的印记']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【谛听的印记】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['多重暴击几率极限'] = 5,
['多重暴击'] = 1,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+100W 全属性|r
|cff00ff00+100W 生命上限|r
|cff00ff00+500 护甲|r
|cff00ff00+5W 伤害减少|r
|cff00ff00+5W 生命回复|r
|cff00ff00藏宝图的掉落概率翻倍
 ]],
}
local mt = ac.skill['冥界本源']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【冥界本源】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['龙之血珠使用上限'] = 1,
['无谓因果使用上限'] = 1,

tip = [[%extr_tip%

+2000万 全属性
+4本 功法连升书
+1个 龙之血珠
+1个 无谓因果
龙之血珠使用上限+1，无谓因果使用上限+1
 ]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local it = ac.item.create_item('功法连升书',self.owner:get_point())
    it:set_item_count(4)
    hero:add_item(it)

    hero:add_item('龙之血珠')
    hero:add_item('无谓因果')
end

local mt = ac.skill['聚魂石']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【冥界本源】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['吞噬丹使用上限'] = 1,

tip = [[%extr_tip%

+2000万 全属性
+10个 点金石
+5个 天谕
+1个 吞噬丹
吞噬丹使用上限+1
 ]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()

    local it = ac.item.create_item('点金石',self.owner:get_point())
    it:set_item_count(10)
    hero:add_item(it) 

    local it = ac.item.create_item('天谕',self.owner:get_point())
    it:set_item_count(5)
    hero:add_item(it) 

    hero:add_item('吞噬丹')
end
-- 神器
local magic_item = {
    '地狱咆哮','地狱意志','鬼神之石','魂幡之灵','天灾骨钟','生死簿','阎王印',
    '谛听的印记','冥界本源','聚魂石'
}
ac.tm_item = magic_item
for i,value in ipairs(magic_item) do 
    local mt = ac.skill[value]
    --等久
    mt.level = 0
    --魔法书相关
    mt.is_order = 1 
    --物品类型
    mt.item_type = '消耗品'
    --目标类型
    mt.target_type = ac.skill.TARGET_TYPE_NONE
    mt.content_tip = ''
    mt.item_type_tip = ''
    --物品技能
    mt.is_skill = true
    --商店名词缀
    mt.store_affix = ''
    mt.specail_model = [[File00000376 - RC.mdx]]
	--忽略技能冷却
	mt.ignore_cool_save = true
    mt.passive = true

    --使用物品
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
       
        -- print('使用武器')
        local skl = hero:find_skill(self.name,nil,true)
        if skl then 
            if self.add_item_count then  
                self:add_item_count(1) 
            end   
            player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00无法重复激活成功|r ',2)
            return      
        end
        
        ac.game:event_notify('技能-插入魔法书',hero,'入魔',self.name)
        local skl = hero:find_skill(self.name,nil,true)
        player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00激活成功|r 可在圣龙气运-入魔中查看',2)
        skl:set_level(1)
        skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        
    end
end












