local mt = ac.skill['初级赞助']
mt{
--等久
level = 0,
--图标
art = [[chujivip.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加188全属性，攻击加388全属性，每秒加888全属性
|cff00ffff杀敌数加成+75% 木头加成+75% 
物品获取率+75% 魔丸加成+75% |r
|cffff0000攻击减甲+50 减少周围护甲1000|r

|cffffff00地图等级>=5，效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
double_map_level = 10, --大于此地图等级，效果翻倍

['杀怪加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 188
    if map_level >= self.double_map_level then 
        value = 188 * 2
    end    
    return value 
end,
['攻击加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 388
    if map_level >= self.double_map_level then 
        value = 388 * 2
    end    
    return value 
end,
['每秒加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 888
    if map_level >= self.double_map_level then 
        value = 888 * 2
    end    
    return value 
end,
['杀敌数加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['木头加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['物品获取率'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['魔丸加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 75
    if map_level >= self.double_map_level then 
        value = 75 * 2
    end    
    return value 
end,
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 1000
    if map_level >= self.double_map_level then 
        value = 1000 * 2
    end    
    return value 
end,
['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 50
    if map_level >= self.double_map_level then 
        value = 50 * 2
    end    
    return value 
end,
}
