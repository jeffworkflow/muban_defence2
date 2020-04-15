local mt = ac.skill['高级赞助']
mt{
--等久
level = 0,
--图标
art = [[yjcjzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加288全属性，攻击加488全属性，每秒加888全属性，
|cff00ffff暴击几率+25% 暴击伤害+500% 
技暴几率+25% 技暴伤害+500%
攻击减甲+125 全伤加深+250% |r
|cffffff00杀敌数额外+1|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
chance = 10,
['杀怪加全属性'] = 288,
['额外杀敌数'] = 1,
['攻击减甲'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 15 * map_level
end,

}
