local mt = ac.skill['黑科技礼包']
mt{
--等久
level = 0,
--图标
art = [[gaojivip.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加888全属性，攻击加888全属性，每秒加888全属性
|cff00ffff攻击减甲+地图等级*15
减少周围护甲+地图等级*250
|cffffff00物理伤害加深+地图等级*100%
技能伤害加深+地图等级*50%
|cffff0000全伤加深+地图等级*25%
对BOSS额外伤害+地图等级*10%
|cffff0000每秒加护甲+地图等级*10

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
['万分之一空气概率'] = 10000,
['局内地图等级'] = 1,

['杀怪加全属性'] = 888,
['攻击加全属性'] = 888,
['每秒加全属性'] = 888,

['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 250 * map_level
end,

['物理伤害加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 100 * map_level
end,

['技能伤害加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 50 * map_level
end,

['全伤加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 25 * map_level
end,

['对BOSS额外伤害'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
['每秒加护甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner 
    -- print('是否拥有爱国者导弹：',p.server['爱国者导弹'])
    if p.server['爱国者导弹'] < 1 then 
        hero:add_item('爱国者导弹1')
    end
end