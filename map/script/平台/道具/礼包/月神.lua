local mt = ac.skill['月神']
mt{
--等级
level = 0, 
max_level = 1,
cool = 1,
--图标
art = [[yueshen.blp]],
--说明
tip = [[
|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

【属性】
获得一个可自动跟随的知己-月神
吞噬丹吞噬上限+2
功法强化上限+2
练功房数量+3
英雄全伤加深+488%
每隔5分钟赠送下面任意一项东西
吞噬丹*1
天谕*5
功法连升书*2
龙之血珠*1
无谓因果*1

|cffFFE799【知己属性】：|r
|cff00ff00点击获得/收回一个知己
|cff00ffff单位攻击力=800%英雄攻击力
|cffffff00单位攻击10%概率让她的敌人神魂颠倒，晕眩敌人2.5秒，并造成范围物理伤害（伤害公式：攻击力*100）
|cffff0000继承英雄分裂伤害、攻击减甲、暴击几率/伤害，会心几率/伤害，物伤/全伤加深
]],
}
local function create_unit(self)
    local skill =self
    local hero = self.owner
    local p = hero:get_owner()
    if p.id >10 then return end 
    local attribute ={
        ['攻击'] = function() return hero:get('攻击')*8 end,
        ['攻击间隔'] = function() return hero:get('攻击间隔') end,
        ['攻击速度'] = function() return hero:get('攻击速度') end,
        ['生命上限'] = function() return hero:get('生命上限') end,
        ['魔法上限'] = function() return hero:get('魔法上限') end,
        ['生命恢复'] = function() return hero:get('生命恢复') end,
        ['魔法恢复'] = function() return hero:get('魔法恢复') end,
        ['移动速度'] = 522,

        ['分裂伤害'] = function() return hero:get('分裂伤害') end,
        ['攻击减甲'] = function() return hero:get('攻击减甲') end,

        ['暴击几率'] = function() return hero:get('暴击几率') end,
        ['暴击伤害'] = function() return hero:get('暴击伤害') end,
        ['会心几率'] = function() return hero:get('会心几率') end,
        ['会心伤害'] = function() return hero:get('会心伤害') end,
        ['物理伤害加深'] = function() return hero:get('物理伤害加深') end,
        ['全伤加深'] = function() return hero:get('全伤加深') end,

        ['物品获取率'] = function() return hero:get('物品获取率') end,
        ['木头加成'] = function() return hero:get('木头加成') end,
        ['金币加成'] = function() return hero:get('金币加成') end,
        ['杀敌数加成'] = function() return hero:get('杀敌数加成') end,
        ['魔丸加成'] = function() return hero:get('魔丸加成') end,
    }
    if not p.unit_ys then 
        p.unit_ys = p:create_unit('月神',hero:get_point()-{math.random(360),100})
        p.unit_ys:remove_ability 'AInv'
        p.unit_ys:add_ability 'Aloc'
        p.unit_ys:add_restriction '无敌'
        p.unit_ys:add_buff "召唤物"{
            attribute = attribute,
            skill = self,
            follow = true,
            search_area = 500, --搜敌路径    
        }
    end   
    
    skl = p.unit_ys:add_skill('神魂颠倒2','隐藏')
end

local temp = {
'吞噬丹*1','天谕*5','功法连升书*2','龙之血珠*1','无谓因果*1'        
}
function mt:on_add()
    local skill =self
    local hero = self.owner
    local p = hero:get_owner()
    --获得时，自动创建 随从
    create_unit(self)
    --每5分钟给东西。
    local time = 5*60
    -- time = 5
    self.timer = hero:loop(time*1000,function()
        local str = temp[math.random(#temp)]
        --取名字和数量
        local name,cnt = string.match(str, "(%S+)%*(%d+)")
        cnt = tonumber(cnt)
        local it = ac.item.create_item(name,hero:get_point())
        if cnt >1 then 
            it:set_item_count(cnt)
        end
        hero:add_item(it)
    end)
end
function mt:on_cast_start()
    local p=self.owner.owner
    if p.unit_ys then 
        p.unit_ys:remove()
        p.unit_ys = nil
    else
        create_unit(self)
    end
end
function mt:on_remove()
    if self.timer then 
        self.timer:remove()
        self.timer = nil
    end
end


--魔剑技能
local mt = ac.skill['神魂颠倒2'] 
mt{
--等级
level = 1,
--图标
art = [[huolinger.blp]],
--说明
tip = [[

|cffFFE799【能力说明】：|r
|cff00ff00攻击10%概率让她的敌人神魂颠倒，晕眩敌人1.5秒，并造成范围物理伤害（伤害公式：英雄攻击力*15）
 ]],
event_name = '造成伤害效果',
chance = 10,
damage_area = 600,
skill_attack = 100,
effect = [[MXXXT28 -  F.mdx]],
effect2 = [[ZHeart.MDX]]
}

function mt:damage_start(damage)
    local source =self.owner
    local p = source.owner
    local hero = source
    local skill =self
    local target = damage.target

	if not damage:is_common_attack()  then 
		return 
    end 
    for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(source)
		: ipairs()
	do
        u:damage
        {
            source = source,
            skill = skill,
            damage = source:get('攻击')*skill.skill_attack,
            damage_type = '物理'
        }
        u:add_buff '晕眩'{
            time = 2.5,
            model = skill.effect2,
            size = 1.5
        }
	end	
end
