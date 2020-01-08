local mt = ac.skill['神器·和田玉玺']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['藏宝图掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '藏宝阁'
}

local mt = ac.skill['神器·玉如意']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['羊皮纸掉落概率'] = 100,
['无字天书掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '藏经阁'
}


local mt = ac.skill['神器·狂鲨']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['强化石掉落概率'] = 100,
['天谕掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '剑冢'
}
local mt = ac.skill['神器·万花迎主']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['一颗神奇的种子掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '百花宫'
}

local mt = ac.skill['神器·金箍棒']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['扭蛋券(十连抽)掉落概率'] = 100,
['超级扭蛋券(十连抽)掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '龙宫'
}
local mt = ac.skill['神器·地狱天堂']
mt{
--图标
art = "wuqi2.blp",
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
['黑暗骰子掉落概率'] = 100,
effect = "wuqi2.mdx",

tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
skill_book_name = '罪恶城堡'
}

-- 神器
local magic_item = {
    '神器·和田玉玺','神器·玉如意','神器·狂鲨','神器·万花迎主','神器·金箍棒','神器·地狱天堂'
}
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
            return      
        end
        
        ac.game:event_notify('技能-插入魔法书',hero,self.skill_book_name,self.name)
        local skl = hero:find_skill(self.name,nil,true)
        player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00激活成功|r 可以在神器系统中查看',2)
        skl:set_level(1)
        skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        
    end
end


local temp = {
    ['藏宝阁阁主'] = '神器·和田玉玺',
    ['藏经阁少阁主'] = '神器·玉如意',
    ['剑魔'] = '神器·狂鲨',
    ['苏若颜'] = '神器·万花迎主',
    ['哪吒'] = '神器·金箍棒',
    ['牛头马面'] = '神器·地狱天堂',
    
}
--死亡掉落
ac.game:event '单位-死亡' (function (_,unit,killer) 
    local name = unit:get_name()
    if not temp[name] then return end 
    local p = killer:get_owner() 
    if not p.flag_all then 
        p.flag_all = {} 
    end
    if p.flag_all[temp[name]] then 
        return 
    end    
    p.flag_all[temp[name]] = true 
    --掉落物品
    ac.item.create_item(temp[name],unit:get_point())

end)












