local mt = ac.skill['地狱咆哮']
mt{
--图标
art = "ditupaoxiao.blp",
extr_tip = '|cffffff00点击可激活【地狱咆哮】，激活后可在圣龙气运-入魔中查看',
['减伤极限'] = 5,
['减伤'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+5W 护甲|r
|cff00ff00+5% 减伤（无视减伤上限）|r

|cff00ffff【唯一被动-斩杀】攻击 10% 几率直接秒杀低血量的敌人
 ]],
    --触发几率
    chance = 10,
    cool = 3,
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
art = "diyuyizhi.blp",
extr_tip = '|cffffff00点击可激活【地狱意志】，激活后可在圣龙气运-入魔中查看',
['免伤几率'] = 5,
['全属性'] = 20000000,
['攻击'] = 50000000,
['免伤几率极限'] = 5,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+5000W 攻击|r
|cff00ff00+5% 免伤几率（无视免伤几率上限）|r

|cff00ffff【唯一被动-裂魂】攻击10%几率增加超强攻击力
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
    -- self.eff = self.target:add_effect(self.ref, self.model)
    self.target:add('攻击',self.value)
end
function mt:on_remove()
    -- if self.eff then
    --    self.eff:remove()
    -- end
    self.target:add('攻击',-self.value)
end
function mt:on_cover(new)
    return new.value > self.value
end

local mt = ac.skill['鬼神之石']
mt{
--图标
art = "guishi.blp",
extr_tip = '|cffffff00点击可激活【鬼神之石】，激活后可在圣龙气运-入魔中查看',
['闪避极限'] = 5,
['闪避'] = 5,
['全属性'] = 20000000,
['生命上限'] = 300000000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+3亿 生命上限|r
|cff00ff00+5% 闪避（无视闪避上限）|r

|cff00ffff【唯一被动-鬼神之勇】攻击10%几率增加（已损失生命值）的全属性
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
art = "duohunpan.blp",
extr_tip = '|cffffff00点击可激活【魂幡之灵】，激活后可在圣龙气运-入魔中查看',

['全属性'] = 20000000,
['每秒加全属性'] = 10000,
['杀怪加攻击'] = 20000,
['全伤加深'] = 100,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+1W 每秒加全属性|r
|cff00ff00+2W 杀怪加攻击|r
|cff00ff00+100% 全伤加深|r

|cff00ffff【唯一被动-守护天使】死亡时有 25% 几率复活，并恢复60%生命
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
art = "tianzai.blp",
extr_tip = '|cffffff00点击可激活【天灾骨钟】，激活后可在圣龙气运-入魔中查看',
['暴击几率极限'] = 5,
['移动速度'] = 50,
['暴击几率'] = 5,
['暴击伤害'] = 1000,
['全属性'] = 20000000,
['吸血'] = 100,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+50   移动速度|r
|cff00ff00+100% 吸血|r
|cff00ff00+5% 暴击几率（无视暴击几率上限）|r
|cff00ff00+1000% 暴击伤害|r
 ]],
}

local mt = ac.skill['生死簿']
mt{
--图标
art = "shengsibu.blp",
extr_tip = '|cffffff00点击可激活【生死簿】，激活后可在圣龙气运-入魔中查看',
['技暴几率极限'] = 5,
['技暴几率'] = 5,
['技暴伤害'] = 500,
['全属性'] = 20000000,
['对BOSS额外伤害'] = 10,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+5% 技暴几率（无视技暴几率上限）|r
|cff00ff00+500% 技暴伤害|r
|cff00ff00+10% 对BOSS额外伤害|r
 ]],
}
local mt = ac.skill['阎王印']
mt{
--图标
art = "yanwangyin.blp",
extr_tip = '|cffffff00点击可激活【阎王印】，激活后可在圣龙气运-入魔中查看',
['会心几率极限'] = 5,
['会心几率'] = 5,
['会心伤害'] = 250,
['全属性'] = 20000000,
['攻击%'] = 20,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+20% 攻击|r
|cff00ff00+5% 会心几率（无视会心几率上限）|r
|cff00ff00+250% 会心伤害|r
 ]],
}
local mt = ac.skill['谛听的印记']
mt{
--图标
art = "ditingyinji.blp",
extr_tip = '|cffffff00点击可激活【谛听的印记】，激活后可在圣龙气运-入魔中查看',
['多重暴击几率极限'] = 5,
['多重暴击'] = 1,
['多重暴击几率'] = 5,
['全属性'] = 20000000,
['生命上限%'] = 20,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+20% 生命上限|r
|cff00ff00+5% 多重暴击几率（无视多重暴击几率上限）|r
|cff00ff00+1 多重暴击|r
 ]],
}
local mt = ac.skill['冥界本源']
mt{
--图标
art = "minjiebenyuan.blp",
extr_tip = '|cffffff00点击可激活【冥界本源】，激活后可在圣龙气运-入魔中查看',
['龙之血珠使用上限'] = 1,
['无谓因果使用上限'] = 1,
['全属性'] = 20000000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+2本 功法连升书|r
|cff00ff00+1个 龙之血珠|r
|cff00ff00+1个 无谓因果|r

|cff00ffff龙之血珠使用上限+1，无谓因果使用上限+1|r
 ]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local it = ac.item.create_item('功法连升书',self.owner:get_point())
    it:set_item_count(2)
    hero:add_item(it)

    hero:add_item('龙之血珠')
    hero:add_item('无谓因果')
end

local mt = ac.skill['聚魂石']
mt{
--图标
art = "juhunshi.blp",
extr_tip = '|cffffff00点击可激活【冥界本源】，激活后可在圣龙气运-入魔中查看',
['吞噬丹使用上限'] = 1,
['全属性'] = 20000000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性|r
|cff00ff00+25个 强化石|r
|cff00ff00+5个 天谕|r
|cff00ff00+1个 吞噬丹|r

|cff00ffff吞噬丹使用上限+1|r
 ]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()

    local it = ac.item.create_item('强化石',self.owner:get_point())
    it:set_item_count(25)
    hero:add_item(it) 

    local it = ac.item.create_item('天谕',self.owner:get_point())
    it:set_item_count(5)
    hero:add_item(it) 

    hero:add_item('吞噬丹')
end

local mt = ac.skill['鬼魅光毛刀']
mt{
--图标
art = "tianmo1.blp",
extr_tip = '|cffffff00点击可激活【鬼魅光毛刀】，激活后可在圣龙气运-入魔中查看',
['全属性'] = 20000000,
['敏捷%'] = 10,
['分裂伤害'] = 100,
['攻击减甲'] = 350,
['攻击间隔极限'] = -0.05,
['攻击间隔'] = -0.05,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性
|cff00ff00+10%   敏捷
|cff00ff00+100%  分裂伤害
|cff00ff00+350   攻击减甲
|cff00ff00-0.05  攻击间隔（无视攻击间隔极限）
 ]],
}

local mt = ac.skill['惊龙集魂笔']
mt{
--图标
art = "tianmo2.blp",
extr_tip = '|cffffff00点击可激活【惊龙集魂笔】，激活后可在圣龙气运-入魔中查看',
['全属性'] = 20000000,
['智力%'] = 10,
['技能伤害加深'] = 200,
['杀怪加杀敌数'] = 2,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性
|cff00ff00+10%   智力
|cff00ff00+200%  技能伤害加深
|cff00ff00+2     杀怪加杀敌数
 ]],
}

local mt = ac.skill['乾离幻藤珠']
mt{
--图标
art = "tianmo3.blp",
extr_tip = '|cffffff00点击可激活【乾离幻藤珠】，激活后可在圣龙气运-入魔中查看',
['全属性'] = 20000000,
['力量%'] = 10,
['物理伤害加深'] = 400,
['杀怪加木头'] = 30,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性
|cff00ff00+10%   力量
|cff00ff00+400%  物理伤害加深
|cff00ff00+30     杀怪加木头
 ]],
}

local mt = ac.skill['虎纹绣魔瓶']
mt{
--图标
art = "tianmo4.blp",
extr_tip = '|cffffff00点击可激活【虎纹绣魔瓶】，激活后可在圣龙气运-入魔中查看',
['全属性'] = 20000000,
['力量%'] = 5,
['敏捷%'] = 5,
['智力%'] = 5,
['全伤加深'] = 100,
['杀怪加魔丸'] = 100,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性
|cff00ff00+5%    全属性
|cff00ff00+100%  全伤加深
|cff00ff00+100     杀怪加魔丸
 ]],
}

local mt = ac.skill['鬼迷心窍']
mt{
--图标
art = "tianmo5.blp",
extr_tip = '|cffffff00点击可激活【鬼迷心窍】，激活后可在圣龙气运-入魔中查看',
['全属性'] = 20000000,
['护甲%'] = 10,
['对BOSS额外伤害'] = 100,


tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
|cff00ff00+2000W 全属性
|cff00ff00+10%    护甲
|cff00ff00+100%  对BOSS额外伤害

|cff00ffff【被动-造宝】每隔180秒，造出一个随机装备
 ]],
cool = 180,
passive = true ,
ignore_cool_save = true,
}
function mt:on_add()
	local skill = self
	local hero = self.owner
	-- give_award(self,true)
	--计时器检测
	if not self.timer then 
		self.timer = ac.loop(1000,function()
			if skill:is_cooling() then 
				return 
			end
			--物品施法
            local name = ac.all_item[math.random(#ac.all_item)]
            print('给了随机装备',self.name,name)
            hero:add_item(name)
            self:active_cd()
			if not self.owner then 
				self.timer:remove()
				self.timer = nil
			end
		end)
	end
end
function mt:on_remove()
	local hero = self.owner
	-- print('进入on_remove',self.name,self.timer)
    if self.timer then 
        self.timer:remove()
        self.timer = nil
    end 
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end




-- 神器
local magic_item = {
    '地狱咆哮','地狱意志','鬼神之石','魂幡之灵','天灾骨钟','生死簿','阎王印',
    '谛听的印记','冥界本源','聚魂石','鬼魅光毛刀','惊龙集魂笔','乾离幻藤珠','虎纹绣魔瓶','鬼迷心窍'
}
ac.tm_item = magic_item
for i,value in ipairs(magic_item) do 
    local mt = ac.skill[value]
    --等久
    mt.level = 0
    mt.max_level = 1
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
    --谁掉落，谁的
    mt.owner_ship = true
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
            player:sendMsg('|cffebb608【系统】|r|cff00ff00无法重复激活成功|r ',2)
            return true --不加true的话，会执行加属性。 
        end
        
        ac.game:event_notify('技能-插入魔法书',hero,'入魔',self.name)
        local skl = hero:find_skill(self.name,nil,true)
        player:sendMsg('|cffebb608【系统】|r|cff00ff00激活成功|r 可在圣龙气运-入魔中查看',2)
        skl:set_level(1)
        skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        
    end
end












