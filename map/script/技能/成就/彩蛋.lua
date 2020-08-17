local mt = ac.skill['错臂之交']
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
    art = [[cbzj.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+50万 全属性
+15%  练功房资源加成|r

]],
['全属性'] = 500000, 
  ['金币加成'] = 15, 
  ['木头加成'] = 15,
  ['经验加成'] = 15,
  ['魔灵加成'] = 15,
}
function mt:on_add()
    local hero  = self.owner
    
    local player = hero:get_owner()
    hero = player.hero
    ac.player.self:sendMsg('|cffebb608【系统】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
    ac.player.self:sendMsg('|cffebb608【系统】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
    ac.player.self:sendMsg('|cffebb608【系统】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
end   

local mt = ac.skill['大屠杀']
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
    art = [[datusha.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+30W 全属性
+35% 杀敌数加成|r

]],
  ['全属性'] = 300000, 
  ['杀敌数加成'] = 35,
}
function mt:on_add()
    local hero  = self.owner
    local p = hero:get_owner()
    hero = p.hero
    -- p:sendMsg('【系统消息】获得大屠杀',5)
end 




 
  

  









local mt = ac.skill['倒霉蛋']
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
    art = [[shuaishen.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+16888 木头
+16888 魔丸
+16888 杀敌数|r

]],
    add_wood = 16888,
    add_fire = 16888,
    add_kill = 16888,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_rec_ex(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    

local mt = ac.skill['游戏王']
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
    art = [[yxw.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1E   全属性
+10% 减伤
+5%  多重暴击几率
+1   多重暴击
+25% 全伤加深|r

]],
    ['全伤加深'] = 25,
    ['减伤'] = 10,
    ['全属性'] = 100000000,
    ['多重暴击几率'] = 5,
    ['多重暴击'] = 1,
}

local mt = ac.skill['八个技能的男人']
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
    art = [[jdbys.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+15   攻击减甲
+1W   魔丸

]],

    ['攻击减甲'] = 15,
    ['全属性'] = 1000000,

    add_fire = 10000,

}

function mt:on_add()
local hero  = self.owner
local player = hero:get_owner()
hero = player.hero

hero:add_rec_ex(self.add_fire)

end    

local mt = ac.skill['五道杠少年']
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
    art = [[wdgsn.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+5   杀怪加木头
+35% 木头加成|r

]],
    ['木头加成'] = 35,
    ['杀怪加木头'] = 5,
    ['全属性'] = 10000000,
}


local mt = ac.skill['实在是菜']
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
    art = [[shizaishicai.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1w 护甲
+1E  生命上限|r

]],
    ['护甲'] = 10000,
    ['生命上限'] = 100000000,
}

local mt = ac.skill['至尊赌神']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[zhizundushen.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+7500万 全属性
+100%  杀敌数加成
+100%  物品获取率
+100%  木头加成
+100%  魔丸加成
    ]],
    ['全属性'] = 75000000,
    ['杀敌数加成'] = 100,
    ['木头加成'] = 100,
    ['魔丸加成'] = 100,
    ['物品获取率'] = 100
}

local mt = ac.skill['大胃王']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   area = 800,
	--技能类型
	skill_type = "被动,力量",
	--被动
	passive = true,
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*200
end,
	--介绍
	tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00攻击10%几率造成范围全属性*200的技能伤害

]],
	--特效
    effect = [[Hero_Axe_N3S_E_Source.mdx]],
    art = [[daweiwang.blp]],
    damage_type = '法术',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            ac.effect(hero:get_point(), self.effect, 270, 1,'origin'):remove()
         
            for i, u in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : of_not_building()
                : ipairs()
            do
                -- u:add_buff '晕眩'
                -- {
                --     source = hero,
                --     time = self.time,
                -- }
                u:damage
                {
                    source = hero,
                    damage = self.damage,
                    skill = self,
                    damage_type = self.damage_type
                }
            end	
            
            --激活cd
            skill:active_cd()
    
        end
    end)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


local mt = ac.skill['第六根柱子']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[dlgzz.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+1500万 全属性
+1W  木头
+1   练功房数量
    ]],
    ['全属性'] = 15000000,
    ['木头'] = 10000,
    ['练功房怪'] = 1,
    add_wood = 10000,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_rec_ex(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    


local mt = ac.skill['不惧轮回']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[bujulunhui.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00每5秒触发一次|cff00ffff“不惧轮回” |cff00ff00对周围敌人造成全属性*175的伤害，并晕眩1秒|r
    ]],
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*175
    end,
    stun_time = 1,
    damage_area = 800,
    damage_type = '法术',
    effect = [[Hero_DoomBringer_N3S_V_mega.mdx]]
}
function mt:on_add()
    local hero = self.owner
    self.buf = hero:add_buff '不惧轮回'{
        damage = self.damage,
        damage_area = self.damage_area,
        damage_type = self.damage_type,
        effect = self.effect,
        skill = self,
        stun_time = self.stun_time,
    }

end  
function mt:on_remove()
    if self.buf  then self.buf:remove() self.buf = nil end
end


local mt = ac.buff['不惧轮回']
mt.cover_type = 0
mt.ref = 'origin'
mt.model = [[]]
mt.value = 0
mt.pulse = 5

function mt:on_add()
end
function mt:on_pulse()
    local skill = self.skill
    -- print(self.effect)
    -- self.target:add_effect('origin',self.effect):remove()
    ac.effect(self.target:get_point(), self.effect, 270, 2,'origin'):remove()

    for i,u in ac.selector()
    : in_range(self.target,self.damage_area)
    : is_enemy(self.target)
    : of_not_building()
    : ipairs()
    do
        u:add_buff '晕眩'{
            time =self.stun_time
        }
        u:damage
        {
            source = self.target,
            damage = self.damage,
            skill = skill,
            damage_type = skill.damage_type
        }
    end

end    
function mt:on_remove()
end


local mt = ac.skill['拯救仓鼠']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 1,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   area = 800,
	--被动
	passive = true,
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*50
end,
	--介绍
	tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+1000万 全属性
|cff00ff00+50   攻击距离
|cff00ffff+15   每秒加魔丸
|cffff0000攻击10% 几率造成|cffffff00（全属性*50+1%敌人的最大生命值）|cffff0000的范围技能伤害

]],
	--特效 Abilities\Spells\Human\HolyBolt.mdl
    effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdx]],
    --Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl
    --Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx
    art = [[zhegnjiucangshu.blp]],
    damage_type = '法术',
   
    ['全属性'] = 10000000,
    ['攻击距离'] = 50,
    ['每秒加魔丸'] = 15,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            -- print('造成伤害效果：',self.name)
            for i, u in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : of_not_building()
                : ipairs()
            do
                u:add_effect('chest',self.effect):remove()
                u:damage
                {
                    source = hero,
                    damage = self.damage,
                    skill = self,
                    damage_type = self.damage_type
                }
                u:damage
                {
                    source = hero,
                    damage = u:get('生命上限')*0.01,
                    skill = self,
                    real_damage = true
                }
            end	
            --激活cd
            skill:active_cd()
        end
    end)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
   

local mt = ac.skill['不朽金身']
mt{
--等级
level = 1, 
max_level = 1,
--图标
art = [[buxiujinshen.blp]],
--说明
tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+1500W 全属性
+75    攻击减甲
+2W    护甲
+5     每秒加杀敌数
-1秒   英雄复活时间
 ]],
['全属性'] = 15000000,
['减少复活时间'] = 1,
['攻击减甲'] = 75,
['护甲'] = 20000,
['每秒加杀敌数'] = 5,

}

local mt = ac.skill['小炮灰']
mt{
--等级
level = 1, 
max_level = 1,
--图标
art = [[xiaopaohui.blp]],
--说明
tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+50W 全属性
+5%  攻击
+50% 暴击伤害
+25% 物理伤害加深
 ]],
['全属性'] = 500000,
['攻击%'] = 5,
['暴击伤害'] = 50,
['物理伤害加深'] = 25,

}
local mt = ac.skill['神球小将']
mt{
--等级
level = 1, 
max_level = 1,
--图标
art = [[zuqiuxiaojiang.blp]],
--说明
tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+1500W 全属性
+100%  攻击速度
+188   攻击减甲
-0.05  攻击间隔
+50%   对BOSS额外伤害
 ]],
['全属性'] = 15000000,
['攻击速度'] = 100,
['攻击减甲'] = 188,
['攻击间隔'] = -0.05,
['对BOSS额外伤害'] = 50,

}

local mt = ac.skill['输出机器']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --商店名词缀
    store_affix = '',
    art = [[scjq.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+200W 全属性
+100% 攻击速度
+35%  物品获取率

]],
  ['全属性'] = 2000000, 
  ['攻击速度'] = 100,
  ['物品获取率'] = 35,
}


local mt = ac.skill['绝对C位']
mt{
--等级
level = 1, 
max_level = 1,
--图标
art = [[jdcw.blp]],
--说明
tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+150W 全属性
+250 减少周围护甲
+35% 木头加成
 ]],
['全属性'] = 1500000,
['减少周围护甲'] = 250,
['木头加成'] = 35,

}

local mt = ac.skill['科尔格的执着']
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
    art = [[bqyz.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1E 全属性
+25% 物理伤害加深系数
+50  每秒加护甲
+15% 每秒回血|r

]],
  ['全属性'] = 100000000, 
  ['物理伤害加深系数'] = 25,
  ['每秒加护甲'] = 50,
  ['每秒回血'] = 15,
}

local task_detail = {
    ['血魔'] = {
        rate = 0.15,
        award = '大屠杀',
        sendMsg = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +35%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +35%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +35%杀敌数加成|r',5)
        end,
    },
    
    ['藏宝阁阁主、藏经阁少阁主、剑魔、苏若颜、哪吒、牛头马面'] = {
        rate = 1.6,
        award = function(killer, target)
            local p = killer.owner
            if not p.flag_dlgzz then 
                p.flag_dlgzz = true
                local point = target:get_point()
                local u = ac.player(12):create_unit('爱我你就爆了我6',point)
                u:add_restriction '定身'
                u:add_restriction '缴械'
                u:add_buff '无敌'{
                    time = 2
                }
                u.owner_ship = p
            end
        end,
        sendMsg = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            -- ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
        end,
    },
    
    ['爱我你就爆了我6'] = {
        rate = 100,
        award = '第六根柱子',
        sendMsg = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|r 的|cffff0000 "第六根柱子" |r 已被击毙，奖励 |cffff0000+1500W全属性 +1W木头 +1练功房数量|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|r 的|cffff0000 "第六根柱子" |r 已被击毙，奖励 |cffff0000+1500W全属性 +1W木头 +1练功房数量|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|r 的|cffff0000 "第六根柱子" |r 已被击毙，奖励 |cffff0000+1500W全属性 +1W木头 +1练功房数量|r',5)
        end,
    },
    
    ['身陷火海的小老鼠'] = {
        rate = 18,
        award = '拯救仓鼠',
        sendMsg = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..p:get_name()..'|r |cff00ff00 不断地让身陷火海的小老鼠得到了解脱，惊喜获得彩蛋|cffffff00【拯救仓鼠】 |cff00ff00奖励 |cffff0000+1000W全属性 +50攻击距离 +15每秒加魔丸 攻击10%几率造成（全属性*75+1%敌人的最大生命值）的范围技能伤害|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..p:get_name()..'|r |cff00ff00 不断地让身陷火海的小老鼠得到了解脱，惊喜获得彩蛋|cffffff00【拯救仓鼠】 |cff00ff00奖励 |cffff0000+1000W全属性 +50攻击距离 +15每秒加魔丸 攻击10%几率造成（全属性*75+1%敌人的最大生命值）的范围技能伤害|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r玩家 |cff00ffff'..p:get_name()..'|r |cff00ff00 不断地让身陷火海的小老鼠得到了解脱，惊喜获得彩蛋|cffffff00【拯救仓鼠】 |cff00ff00奖励 |cffff0000+1000W全属性 +50攻击距离 +15每秒加魔丸 攻击10%几率造成（全属性*75+1%敌人的最大生命值）的范围技能伤害|r',5)
        end,
    },
}
--第六根柱子
ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    local ok
    for k,v in pairs(task_detail) do    
        -- print(k,name) 
        if finds(k,name) then
            ok = true
            name = k
            break
        end
    end  
    if not ok then 
        return 
    end
    local rate =task_detail[name].rate
    local award = task_detail[name].award
    local sendMsg = task_detail[name].sendMsg
    if math.random(100000)/1000 < rate then 
        local p = killer.owner
        local hero = p.hero
        --死亡单位如果有所有者，则奖励为所有者的。
        if target.owner_ship then 
            hero = target.owner_ship.hero
        end
        if not hero then return end
        p = hero.owner
        if type(award) =='function' then 
            award(killer, target)
        else
            local skl = hero:find_skill(award,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',award)
                if type(sendMsg) == 'function' then 
                    sendMsg(p)
                elseif sendMsg[3] then 
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    
                else 
                    p:sendMsg(sendMsg[1],sendMsg[2])
                    p:sendMsg(sendMsg[1],sendMsg[2])
                    p:sendMsg(sendMsg[1],sendMsg[2])
                end
            end   
        end
    end    
end)    


--实在是菜
ac.game:event '单位-死亡'(function(_,unit,killer)
    if not unit:is_hero() then 
        return 
    end 
    local player = unit:get_owner()
    player.dead_cnt = (player.dead_cnt or 0) +1
    local hero = unit
    if player.dead_cnt == 10 then 
        local skl = hero:find_skill('实在是菜',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','实在是菜')
            player.is_show_nickname = '实在是菜'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+1W护甲 +1E生命上限|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+1W护甲 +1E生命上限|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+1W护甲 +1E生命上限|r',6)
        end
    end    
    --小炮灰
    ac.dead_cnt = (ac.dead_cnt or 0) +1
    if ac.dead_cnt == 1 and get_player_count()>=2 then 
        local skl = hero:find_skill('小炮灰',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','小炮灰')
            player.is_show_nickname = '小炮灰'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么这么快就死了？？？ |r 获得成就|cffff0000 "小炮灰" |r，奖励 |cffff0000全属性+50万，攻击+5%，暴击伤害+50%，物理伤害加深+25%|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么这么快就死了？？？ |r 获得成就|cffff0000 "小炮灰" |r，奖励 |cffff0000全属性+50万，攻击+5%，暴击伤害+50%，物理伤害加深+25%|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么这么快就死了？？？ |r 获得成就|cffff0000 "小炮灰" |r，奖励 |cffff0000全属性+50万，攻击+5%，暴击伤害+50%，物理伤害加深+25%|r',6)
        end
    end


end)


--给彩蛋 拯救仓鼠
local time = 20*60
-- time = 20 --测试
local function create_u()
    local point = ac.rect.j_rect('huohai'):get_point()
    local u = ac.player(13):create_unit('身陷火海的小老鼠',point)
    u:add_buff '随机逃跑'{}
    --重新复活
    u:event '单位-死亡'(function(_,unit,killer)
        ac.wait(8*1000,function()
            create_u()
        end)
    end)
end
ac.wait(time*1000,function()
    create_u()
end)



--给彩蛋 不朽金身
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪1' then
        return
    end    
    if index > 10 then 
        --在线玩家数 >=2 杀死进攻怪>=180 没死亡过
        local player_cnt =get_player_count()
        if player_cnt >=2 then 
            for i=1,6 do 
                local p = ac.player(i)
                local player = ac.player(i) 
                if p:is_player() and 
                  (p.cnt_death or 0) == 0 and 
                  (p.kill_attack_cnt or 0 )>=150 then 
                    local hero = p.hero 
                    local skl = hero:find_skill('不朽金身',nil,true)
                    if not skl then 
                        --动态插入彩蛋
                        ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','不朽金身')
                        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00玩家|cff00ffff '..player:get_name()..' |r|cff00ff00保家卫国非常出色，竟然没死过，|r 获得惊喜彩蛋|cffffff00 【不朽金身】|r，奖励 |cffff0000全属性+1500W 攻击减甲+75 护甲+2W 每秒加杀敌数+5 英雄复活时间-1S|r',6)
                        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00玩家|cff00ffff '..player:get_name()..' |r|cff00ff00保家卫国非常出色，竟然没死过，|r 获得惊喜彩蛋|cffffff00 【不朽金身】|r，奖励 |cffff0000全属性+1500W 攻击减甲+75 护甲+2W 每秒加杀敌数+5 英雄复活时间-1S|r',6)
                        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00玩家|cff00ffff '..player:get_name()..' |r|cff00ff00保家卫国非常出色，竟然没死过，|r 获得惊喜彩蛋|cffffff00 【不朽金身】|r，奖励 |cffff0000全属性+1500W 攻击减甲+75 护甲+2W 每秒加杀敌数+5 英雄复活时间-1S|r',6)
                    end
                end
            end
        end
    end
end)

ac.game:event '游戏-开始' (function()
    local unit = ac.find_unit('游戏说明')
    unit:event '受到伤害效果'(function(_,damage)
        if not damage.source:is_hero() then 
            return 
        end    
        local rate = 0.45
        if math.random(100000)/1000 <= rate then 
            local hero = damage.source
            local player = hero:get_owner()
            local skl = hero:find_skill('输出机器',nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','输出机器')
            ac.player.self:sendMsg('|cffebb608【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+200W全属性 +100%攻击速度 +35%物品获取率|r',6)
            ac.player.self:sendMsg('|cffebb608【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+200W全属性 +100%攻击速度 +35%物品获取率|r',6)
            ac.player.self:sendMsg('|cffebb608【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+200W全属性 +100%攻击速度 +35%物品获取率|r',6)
            end
        end
    end)
end)


--彩蛋 破损的箱子