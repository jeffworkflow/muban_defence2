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
    local val = math.min(p.server['挖宝熟练度'], p:Map_GetMapLevel()*10000)*0.1
    return val
end,
['每秒加智力'] = function(self)
    local p = self.owner.owner
    local val = math.min(p.server['看书熟练度'], p:Map_GetMapLevel()*10000)*0.1
    return val
end,
['每秒加力量'] = function(self)
    local p = self.owner.owner
    local val = math.min(p.server['打造熟练度'], p:Map_GetMapLevel()*10000)*0.1
    return val
end,
['每秒加护甲'] = function(self)
    local p = self.owner.owner
    local val = math.min(p.server['种树熟练度'], p:Map_GetMapLevel()*10000)*0.002
    return val
end,
['每秒加生命上限'] = function(self)
    local p = self.owner.owner
    local val = math.min(p.server['白嫖熟练度'], p:Map_GetMapLevel()*10000)
    return val
end,
['每秒加攻击'] = function(self)
    local p = self.owner.owner
    local val = math.min(p.server['摇骰子熟练度'], p:Map_GetMapLevel()*10000)*0.2
    return val
end,
}