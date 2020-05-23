local mt = ac.skill['财源滚滚']
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
	skill_type = "木头",
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

|cff00ff00钱越滚越多，点击获得|cffffff00【20%当前木头】|cff00ff00的木头

]],
	--技能图标
	art = [[jinzhu.blp]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    local p = self.owner.owner
    hero:add_wood(p.wood * 0.2)  

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
