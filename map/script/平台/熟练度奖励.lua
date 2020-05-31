local mt = ac.skill['熟练度奖励']
mt{
--等级
level = 1,
is_order = 1,
--图标
art = [[chenghao1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff种树熟练度≥1000

|cffFFE799【称号属性】：|r
|cff00ff00+18  杀怪加全属性|r
|cff00ff00+2   每秒加木头|r
|cff00ff00+5% 全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加敏捷'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*0.1, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*0.1, lv*10000)
    end
    return val
end,
['每秒加智力'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*0.1, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*0.1, lv*10000)
    end
    return val
end,
['每秒加力量'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*0.1, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*0.1, lv*10000)
    end
    return val
end,
['每秒加护甲'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*0.002, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*0.002, lv*10000)
    end
    return val
end,
['每秒加生命上限'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*1, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*1, lv*10000)
    end
    return val
end,
['每秒加攻击'] = function(self)
    local p = self.owner.owner
    local lv = p:Map_GetMapLevel()
    local val
    if lv >20 then 
        val = math.min(p.server['挖宝熟练度']*0.2, lv*lv*500+250)
    else
        val = math.min(p.server['挖宝熟练度']*0.2, lv*10000)
    end
    return val
end,
}