local mt = ac.skill['召唤F4战斗机']
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
	color = "天阶",
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
	tip = [[ 
|cff00bdec【主动施放】在任意位置召唤F4战斗机为你作战，持续时间25秒

 ]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFlyingMachine.blp]],
    unit_name = 'F4战斗机',
    time = 25,
    cnt = 1
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
    attribute['多重射'] = 5+math.floor(self.level/4)
    
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