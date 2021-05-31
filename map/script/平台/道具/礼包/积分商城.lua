--翅膀

local mt = ac.skill['力量之书']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
力量+%力量%% %（X=获得总数）
每个商品力量+1%，重复获得可叠加
]],
['力量%'] = function(self) return 1 * self.level end,
}

local mt = ac.skill['敏捷之书']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
敏捷+%敏捷%% %（X=获得总数）
每个商品敏捷+1%，重复获得可叠加
]],
['敏捷%'] = function(self) return 1 * self.level end,
}

local mt = ac.skill['智力之书']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
敏捷+%智力%% %（X=获得总数）
每个商品智力+1%，重复获得可叠加
]],
['智力%'] = function(self) return 1 * self.level end,
}
local mt = ac.skill['护甲之书']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
敏捷+%护甲%% %（X=获得总数）
每个商品护甲+1%，重复获得可叠加
]],
['护甲%'] = function(self) return 1 * self.level end,
}
local mt = ac.skill['全属性之书']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
敏捷+%力量%% %（X=获得总数）
每个商品全属性+1%，重复获得可叠加
]],
['力量%'] = function(self) return 1 * self.level end,
['敏捷%'] = function(self) return 1 * self.level end,
['智力%'] = function(self) return 1 * self.level end,
}


local mt = ac.skill['物品获取率系数']
mt{
--等级
level = 0,
max_level = 99999,
--图标
art = [[fabao1.blp]],
--说明
tip = [[
敏捷+%力量%% %（X=获得总数）
每个商品全属性+1%，重复获得可叠加
]],
['力量%'] = function(self) return 1 * self.level end,
['敏捷%'] = function(self) return 1 * self.level end,
['智力%'] = function(self) return 1 * self.level end,
}

--系数相关
for i,name in ipairs{'物品获取率系数','杀敌数加成系数','木头加成系数','魔丸加成系数','攻击减甲系数','暴击伤害系数','技暴伤害系数',
'物理伤害加深系数','技能伤害加深系数','会心伤害系数','全伤加深系数',} do 
    local mt = ac.skill[name..' ']
    mt{
        --等级
        level = 0,
        max_level = 99999,
        --说明
        tip = [[
]]..name..[[+%]]..name..[[% %（X=获得总数）
每个商品]]..name..[[+1%，重复获得可叠加
        ]],
        [name] = {1,99999},
    }
end

ac.skill['物品获取率系数 '].art = [[fabao1.blp]]
ac.skill['杀敌数加成系数 '].art = [[fabao1.blp]]
ac.skill['木头加成系数 '].art = [[fabao1.blp]]
ac.skill['魔丸加成系数 '].art = [[fabao1.blp]]
ac.skill['攻击减甲系数 '].art = [[fabao1.blp]]
ac.skill['暴击伤害系数 '].art = [[fabao1.blp]]
ac.skill['技暴伤害系数 '].art = [[fabao1.blp]]
ac.skill['物理伤害加深系数 '].art = [[fabao1.blp]]
ac.skill['技能伤害加深系数 '].art = [[fabao1.blp]]
ac.skill['会心伤害系数 '].art = [[fabao1.blp]]
ac.skill['全伤加深系数 '].art = [[fabao1.blp]]

local mt = ac.skill['物品获取率指数']
mt{
    --等级
    level = 0,
    max_level = 99999,
    art = [[fabao1.blp]],
    --说明
    tip = [[
        敏捷+%敏捷% %（X=获得总数）
        每个商品敏捷+1%，重复获得可叠加
    ]],
    ['物品获取率系数'] = function(self) return 1 * self.level end,
}



local mt = ac.skill['积分商城']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sffl.blp]],
    title = '积分商城',
    tip = [[

点击查看 |cff00ffff积分商城|r
    ]],
    
}--'五星好评礼包'
mt.skills = {
    '力量之书','敏捷之书','智力之书','护甲之书',
    '全属性之书','物品获取率系数 ','杀敌数加成系数 ','木头加成系数 ',
    '魔丸加成系数 ','攻击减甲系数 ','积分商城-下一页',
    
}

local mt = ac.skill['积分商城-下一页']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

点击查看 |cff00ffff下一页|r
    ]],
    
}
mt.skills = {
    '暴击伤害系数 ','技暴伤害系数 ','物理伤害加深系数 ','技能伤害加深系数 ','会心伤害系数 ','全伤加深系数 ',
}