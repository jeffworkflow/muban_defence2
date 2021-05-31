local mt = ac.skill['召唤狼']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "玄阶",
	--技能类型
	skill_type = "主动，召唤",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 40,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 10000,
	--施法范围
	area = 100,
	--介绍
	tip = [[|cff00bdec【主动施放】在任意位置召唤2只狼为你作战，持续时间25秒

【狼】属性已经在物编中写好，但需要额外增加下面属性：

        ['物品获取率'] = function() return hero:get('物品获取率') end,
        ['木头加成'] = function() return hero:get('木头加成') end,
        ['金币加成'] = function() return hero:get('金币加成') end,
        ['杀敌数加成'] = function() return hero:get('杀敌数加成') end,
        ['魔丸加成'] = function() return hero:get('魔丸加成') end,

当技能升级时，
召唤物的攻击=物编中的攻击*LV
召唤物的生命上限=物编中的生命上限*LV

当游戏难度提升时，攻击/生命上限/护甲=上一个难度的属性*难度系数1.68]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNSpiritWolf.blp]],
    unit_name = '狼',
    time = 25,
    cnt = 2
}

function mt:on_cast_start()
    --创建幻象进行攻击
    local hero = self.owner 
    local cnt = self.cnt 
    for i=1,cnt do 
        self:create_illusion()
    end
end
function mt:create_illusion()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = self.target

    local u = p:create_unit(self.unit_name,target:get_point())
    -- dummy:setColor(0,0,100) source-{math.random(360),100}
    
    -- local u =  hero:create_illusion(target:get_point())
    if not u then 
        print('无法创造出镜像')
        return 
    end
    -- u:add_restriction '无敌'
    -- u:setColor(0,0,100)
    local data = ac.table.UnitData[self.unit_name]
    local attribute = table_copy(data.attribute)
    
    local attr_mul = ac.get_difficult(ac.g_game_degree_attr)

    attribute['攻击'] = attribute['攻击']*attr_mul*self.level
    attribute['生命上限'] = attribute['生命上限']*attr_mul*self.level
    attribute['护甲'] = attribute['护甲']*attr_mul
    
    attribute['物品获取率'] = function() return hero:get('物品获取率') end
    attribute['木头加成'] = function() return hero:get('木头加成') end
    attribute['金币加成'] = function() return hero:get('金币加成') end
    attribute['杀敌数加成'] = function() return hero:get('杀敌数加成') end
    attribute['魔丸加成'] = function() return hero:get('魔丸加成') end

    
    u:remove_ability 'AInv'
	
    u:add_buff '召唤物'{
        time = self.time,
        attribute = attribute,
        remove_target = true,
        skill = self,
        follow = true,
        search_area = 1000, 
    }


end