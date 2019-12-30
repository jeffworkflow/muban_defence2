local mt = ac.skill['守护神']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "护甲+光环类",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['力量%'] = 10,
	--介绍
	tip = [[
|cffffe799【力量】+10%

|cff00ffff所有队友|cffffff00【每秒加护甲+2.5】
|cff00ffff基地|cffffff00【每秒加护甲+5】

]],
	--技能图标
    art = [[wugui.blp]],
    
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = self.owner.owner
    --队友加属性
    for i=1,10 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            pp.hero:add('每秒加护甲',2.5)  
        end  
    end  
    --基地加属性
    if ac.main_unit then
        ac.main_unit:add('每秒加护甲',5)  
    end    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    local p = self.owner.owner
    --队友加属性
    for i=1,10 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            pp.hero:add('每秒加护甲',-2.5)  
        end  
    end  
    --基地加属性
    if ac.main_unit then
        ac.main_unit:add('每秒加护甲',-5)  
    end 
end
