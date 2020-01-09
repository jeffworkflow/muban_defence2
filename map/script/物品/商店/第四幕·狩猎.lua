
local mt = ac.skill['狩猎1']
mt{
--图标
art = "langxingoufei.blp",
title =[[|cff00ff00 【一品食材】-狼心狗肺|r]],
extr_tip = '点击可激活【一阶神兵】，激活后可以在神兵系统中查看',
['木头加成'] = 100,
tip = [[%extr_tip%

|cffFFE799【神兵属性】：|r
|cff00ff00+70w 攻击|r
|cff00ff00+15% 攻速|r
|cff00ff00+5%  物理伤害加深|r
|cff00ff00+1%  暴击几率|r
|cff00ff00+10% 暴击加深|r

|cffff0000【点击可更换神兵外观，所有神兵属性可叠加】|r
]],
}

-- 神器
local magic_item = {
    '狩猎1',
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
        player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00激活成功|r 可以在狩猎中中查看',2)
        skl:set_level(1)
        skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        
    end
end