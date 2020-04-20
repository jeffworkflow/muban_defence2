local mt = ac.skill['罪恶城堡通行证']
mt{
--等久
level = 0,
--图标
art = [[ahtxz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00多重暴击几率+10% 翻倍概率+5%|r
|cff00ffff开局赠送5个黑暗骰子
黑暗骰子掉落概率提高一倍
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['移动速度'] = 150,
['多重暴击几率'] = 10,
['木头翻倍概率'] = 5,
['魔丸翻倍概率'] = 5,
['杀敌数翻倍概率'] = 5,
['全属性翻倍概率'] = 5,
['黑暗骰子掉落概率'] = 100,
-- ['局内地图等级'] = 1,
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local peon = p.peon
    peon:add_item('罪恶城堡通行证 ')
end

local mt = ac.skill['罪恶城堡通行证 ']
mt{
--等久
level = 1,
--图标
art = [[ahtxz.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cff00ff00点击获取 |cff00ffff5个黑暗骰子
 ]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
passive = true
} 

function mt:on_cast_start()
    local hero = self.owner
    local items = self
    local p = hero:get_owner()
    local peon = p.peon
    local it = ac.item.create_item('黑暗骰子')
    it:set_item_count(5)
    peon:add_item(it)

end    
