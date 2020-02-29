
local mt = ac.skill['狩猎1']
mt{
--图标
art = "langxingoufei.blp",

title =[[|cff00ff00狼心狗肺|r]],

extr_tip = '|cffffff00点击可激活【一品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 3500000,
['护甲'] = 5000,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+350w 全属性
|cff00ff00+5000 护甲|r

]],
}



local mt = ac.skill['狩猎2']
mt{
--图标
art = "zhengyanxiazi.blp",

title =[[|cff00ff00睁眼虾子|r]],

extr_tip = '|cffffff00点击可激活【二品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 4000000,

tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+400w 全属性
攻击有10%几率造成|cffffff00（全属性*30）|cff00ff00的范围技能伤害|r

]],
--触发几率
chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
--范围
damage_area = 500,
--伤害
damage = function(self)
    return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*30)
end,
--冷却
cool = 1,
effect =[[Abilities\Spells\Human\Thunderclap\ThunderClapCaster.mdl]],
event_name = '造成伤害效果'
}

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target

    if not damage:is_common_attack()  then 
        return 
    end 
    ac.effect_ex{
        model = skill.effect,
        point = hero:get_point(),
    }:remove()
    for i, u in ac.selector()
		: in_range(hero,self.damage_area)
		: is_enemy(hero)
		: ipairs()
	do
        u:damage
        {
            source = hero,
            skill = skill,
            damage = skill.damage,
            damage_type = '法术'
        }
	end	
end



local mt = ac.skill['狩猎3']
mt{
--图标
art = "sheying.blp",

title =[[|cff00ffff杯弓蛇影|r]],

extr_tip = '|cffffff00点击可激活【三品食材】，激活后可以在狩猎系统中查看',
['全属性'] = 4500000,
['攻击减甲'] = 50,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+450w 全属性|r
|cff00ff00+50    攻击减甲|r


]],
}

local mt = ac.skill['狩猎4']
mt{
--图标
art = "taohua.blp",

title =[[|cff00ffff人面桃花|r]],

extr_tip = '|cffffff00点击可激活【四品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 5000000,
['减伤'] = 2.5,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+500w 全属性|r
|cff00ff00+2.5% 减伤|r


]],
}

local mt = ac.skill['狩猎5']
mt{
--图标
art = "simianchuge.blp",

title =[[|cff00ffff四面楚歌|r]],

extr_tip = '|cffffff00点击可激活【五品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 5500000,
['闪避'] = 2.5,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+550w 全属性|r
|cff00ff00+2.5% 闪避|r


]],
}

local mt = ac.skill['狩猎6']
mt{
--图标
art = "baxianguohai.blp",

title =[[|cffffff00八鲜过海|r]],

extr_tip = '|cffffff00点击可激活【六品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 6000000,
['免伤几率'] = 2.5,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+600w 全属性|r
|cff00ff00+2.5% 免伤几率|r


]],
}

local mt = ac.skill['狩猎7']
mt{
--图标
art = "huangquan.blp",

title =[[|cffffff00黄泉野菜|r]],

extr_tip = '|cffffff00点击可激活【七品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 6500000,
['暴击几率'] = 2.5,
['暴击伤害'] = 25,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+650w 全属性|r
|cff00ff00+2.5% 暴击几率
|cff00ff00+25%  暴击伤害|r


]],
}

local mt = ac.skill['狩猎8']
mt{
--图标
art = "yichouwannian.blp",

title =[[|cffffff00遗臭万年|r]],

extr_tip = '|cffffff00点击可激活【八品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 7000000,
['技暴几率'] = 2.5,
['技暴伤害'] = 25,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+700w 全属性|r
|cff00ff00+2.5% 技暴几率|r
|cff00ff00+25%  技暴伤害|r


]],
}

local mt = ac.skill['狩猎9']
mt{
--图标
art = "bamianlinglong.blp",

title =[[|cffff0000八面玲珑|r]],

extr_tip = '|cffffff00点击可激活【九品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 7500000,
['会心几率'] = 2.5,
['会心伤害'] = 25,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+750w 全属性|r
|cff00ff00+2.5% 会心几率|r
|cff00ff00+25%  会心伤害|r


]],
}

local mt = ac.skill['狩猎10']
mt{
--图标
art = "baiguiyeyan.blp",

title =[[|cffff0000百鬼夜宴|r]],

extr_tip = '|cffffff00点击可激活【帝品食材】，激活后可以在圣龙气运-狩猎系统中查看',
['全属性'] = 8000000,
['攻击间隔'] = -0.05,
tip = [[%extr_tip%

|cffFFE799【食材属性】：|r
|cff00ff00+800w 全属性|r
|cff00ff00-0.05  攻击间隔|r


]],
}


-- 神器
local magic_item = {
    '狩猎1',
    '狩猎2',
    '狩猎3',
    '狩猎4',
    '狩猎5',
    '狩猎6',
    '狩猎7',
    '狩猎8',
    '狩猎9',
    '狩猎10',
}
for i,value in ipairs(magic_item) do 
    local mt = ac.skill[value]
    --等久
    mt.level = 0
    --魔法书相关
    mt.is_order = 1 
    --物品类型
    mt.item_type = '消耗品'
    mt.content_tip = ''
    mt.item_type_tip = ''

    --使用物品
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
       
        local skl = hero:find_skill(self.name,nil,true)
        if skl and skl.level > 0 then 
            if self.add_item_count then  
                self:add_item_count(1) 
            end   
            return      
        end
        player:sendMsg('|cffFFE799【系统消息】|r|cffffff00激活成功|r |cff00ff00属性可在圣龙气运-狩猎系统中查看',2)
        skl:set_level(1)
        skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        
    end
end