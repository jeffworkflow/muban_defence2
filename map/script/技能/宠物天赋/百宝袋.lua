local mt = ac.skill['百宝袋']
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
	skill_type = "物品",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 300,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['智力%'] = 10,
	--介绍
	tip = [[ 
|cffffe799【智力】+10%

|cff00ff00点击从兜里掏出一件|cffffff00随机物品

]],
	--技能图标
	art = [[xiaodingdang.blp]],
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    
    --概率触发
    hero:add_item(ac.all_item[math.random(#ac.all_item)],true)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
