--物品名称
local mt = ac.skill['十连换']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[zshxl.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[
点击开启/关闭杀敌数十连换，
当前状态：%switch%
    ]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
switch = function(self)
    return ac.player.self.switch_xxn == true and '开启' or '关闭'
end,
--冷却
cool = 0,
--物品技能
is_skill = true,
}
--开关
function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local p =hero.owner 
    -- p.switch_xxn = p.switch_xxn ~= true and true or false
    p.switch_xxn = not p.switch_xxn and true or false
end

function mt:on_remove()
end