local mt = ac.skill['番天印']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【番天印】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
杀怪加智力 +88
技能伤害加深 +8.8%
魔丸加成 +8.8%

 ]],
}
local mt = ac.skill['战舰之舵']
mt{
--图标
art = "hetianyuxi.blp",
extr_tip = '|cffffff00点击可激活【战舰之舵】，激活后可在圣龙气运-踢馆-藏宝阁中查看',
['减伤极限'] = 5,
['全属性'] = 20000000,
['护甲'] = 50000,

tip = [[%extr_tip%

|cffFFE799【神器属性】：|r
杀怪加敏捷 +88
移动速度 +5
伤害减少 +8.8万

 ]],
}

-- 神器
local magic_item = {
    '番天印','战舰之舵'
}
ac.ts_item = magic_item
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
        local p = self.owner:get_owner()
        hero = player.hero 
       
        local key = ac.server.name2key(self.name)
        local skl = hero:find_skill(self.name,nil,true)
        if skl then 
            if skl.level< skl.max_level then 
                --激活成就（存档） 
                p:Map_AddServerValue(key,1) --网易服务器
                skl:upgrade(1)
                p:sendMsg('|cffff0000【可存档成就】'..self.name..'+1',6) 
            else
                if self.add_item_count then  
                    self:add_item_count(1) 
                end   
                p:sendMsg('|cffff0000【可存档成就】'..self.name..'已满级',6) 
                return      
            end
        else
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            ac.game:event_notify('技能-插入魔法书',hero,'成神',self.name)
            local skl = hero:find_skill(self.name,nil,true)
            player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00激活成功|r 可在圣龙气运-入魔中查看',2)
            skl:set_level(1)
            skl.passive = true
            skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
        end
    end
end












