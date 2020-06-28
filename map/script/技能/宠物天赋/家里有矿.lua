local mt = ac.skill['家里有矿']
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
	skill_type = "资源",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 150,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['生命上限%'] = 20,
	--介绍
	tip = [[ 
|cffffe799【生命上限】+20%

|cff00ff00在基地掉下大量木头

]],
	--技能图标
	art = [[jinkuang.blp]],
	--特效
	effect = [[Objects\InventoryItems\BundleofLumber\BundleofLumber.mdl]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
local temp = {'木头'}
function mt:on_cast_start()
    local skill = self
    local p = self.owner.owner
    local peon = self.owner
    local hero = p.hero
    ac.func_give_suipian(ac.main_unit:get_point(),temp)
    ac.player.self:sendMsg('|cffebb608【系统】|cff00ffff玩家 '..p:get_name()..' |cff00ff00的宠物家里有矿，往|cffffff00基地|cff00ff00撒了一堆木头，大家赶紧去抢！',5)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

local mt = ac.skill['木头']
mt{
--必填
is_skill = true,
--等级
level = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
tip = [[
随机神符出现啦，赶紧去寻找。
]],
--cd
cool = 0,
--模型
_model = [[Objects\InventoryItems\BundleofLumber\BundleofLumber.mdl]],
--物品
item_type = '神符'
}

--右击使用
function mt:on_cast_start()
    local hero = self.owner
    hero:add_wood(math.random(1,150))
end    
