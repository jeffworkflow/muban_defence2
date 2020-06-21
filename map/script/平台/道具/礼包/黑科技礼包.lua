local mt = ac.skill['黑科技礼包']
mt{
--等久
level = 0,
--图标
art = [[heikeji.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加488全属性，攻击加488全属性，每秒加488全属性
|cff00ff00攻击减甲+地图等级*15
|cff00ffff攻击距离+地图等级*15
|cff00ffff全伤加深+地图等级*15%
|cffffff00万分之一空气获得概率翻倍
|cffff0000局内地图等级+1

|cffFFE799【增强型导弹】|r
|cff00ff00开局赠送一个可召唤|cff00ffff “爱国者导弹” |cff00ff00的物品，发放至背包
|cff00ffff导弹攻击力=英雄攻击力+5E
|cffffff00导弹攻击距离=650
|cffff0000导弹继承英雄暴击几率/伤害，会心几率/伤害，物伤/全伤加深
|cffdf19d0如果已拥有【爱国者导弹】，则攻击力翻倍、攻击距离翻倍、攻击速度翻倍、多重射+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
['万分之一空气概率'] = 100,
['局内地图等级'] = 1,

['杀怪加全属性'] = 488,
['攻击加全属性'] = 488,
['每秒加全属性'] = 488,

['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,
['攻击距离'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,


['全伤加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,

}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner 
    -- print('是否拥有爱国者导弹：',p.server['爱国者导弹'])
    if p.server['爱国者导弹'] < 1 then 
        local it = hero:add_item('爱国者导弹1')
        it.owner_ship = p
    end
end