local mt = ac.skill['你真棒']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 75*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "物品",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 180,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['生命上限%'] = 20,
	--介绍
	tip = [[ 
|cffffe799【生命上限】+20%

|cff00ff00对乔巴进行一顿称赞，75%概率可获得它|cffffff00精心研制的药水

]],
	--技能图标
	art = [[nizhenbang.blp]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    
    --概率触发
    if math.random(100) <= self.chance then
        hero:add_item(ac.consumable_item[math.random(#ac.consumable_item)],true)
    end    

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
