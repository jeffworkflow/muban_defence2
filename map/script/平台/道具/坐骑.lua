--称号
local mt = ac.skill['风速狗']
mt{
--等级
level = 0,
--图标
art = [[xwly.blp]],
--说明
tip = [[

|cffffff00【要求地图等级>=%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 5K 自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【领域属性】：|r
|cff00ff00+25  杀怪加全属性|r
|cff00ff00+150  减少周围护甲|r
|cff00ff00+20%  物理伤害加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.server['挖宝积分'] or 0
end,
['杀怪加全属性'] = 25,
['减少周围护甲'] = 150,
['物理伤害加深'] = 20,
need_map_level = 4,
--特效
effect = [[JD_066_D.mdx]],
size = 1,--坐骑大小
high = 100, --人物高度
}

local mt = ac.skill['兜兜猪']
mt{
--等级
level = 0,
--图标
art = [[ltly.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【领域属性】：|r
|cff00ff00+55  杀怪加全属性|r
|cff00ff00+300  减少周围护甲|r
|cff00ff00+40%  物理伤害加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

['杀怪加全属性'] = 55,
['减少周围护甲'] = 300,
['物理伤害加深'] = 40,
need_map_level = 13,
--特效
effect = [[Txxxxxx (2).mdx]],
size = 1,--坐骑大小
high = 100, --人物高度
}


for i,name in ipairs({'风速狗','兜兜猪'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_zuoqi and hero.effect_zuoqi.model == self.effect then
            hero.effect_zuoqi:remove()
            hero.effect_zuoqi = nil
            return
        end
        -- print(self.high)
        hero.effect_zuoqi = hero:add_buff '坐骑'{
            model = self.effect,
            size = self.size,
            high = self.high or 100,
        }
    end    
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    