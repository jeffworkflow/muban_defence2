--称号
local mt = ac.skill['积分礼包']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[chenghao1.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff种树熟练度≥1000%current%

|cffFFE799【称号属性】：|r
|cff00ff00+18  杀怪加全属性|r
|cff00ff00+1   每秒加木头|r
|cff00ff00+5% 全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 18,
['全伤加深'] = 5,
['每秒加木头'] = 1,
['全伤加深'] = function(self)
    if not self.owner then return 0 end
    local p =  self.owner.owner
    return p:Map_GetMapLevel()*10
end,
need_map_level = 1,
}
--称号