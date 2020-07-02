local mall = {
    {'SCLB','首充礼包',1},
    {'CZLB','成长礼包',1},

    {'CJZZ','初级赞助',1},
    {'GJZZ','高级赞助',1},
    {'TXZCBG','藏宝阁通行证',1},
    {'TXZCJG','藏经阁通行证',1},
    {'TXZJZ','剑冢通行证',1},
    {'TXZBHG','百花宫通行证',1},
    {'TXZLG','龙宫通行证',1},
    {'TXZZECB','罪恶城堡通行证',1},

    {'JX','剑仙',1},
    {'TZ','天尊',1},
    {'HKJLB','黑科技礼包',1},
    
    {'YZJL','元祖巨龙',1},
    {'YS','月神',1},
}


local mt = ac.skill['满赞']
mt{
--等久
level = 0,
--图标
art = [[quanzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000购买全部商城道具|cffcccccc（御剑守护 除外）|r后自动激活

|cffFFE799【满赞奖励】|r
|cff00ff00杀怪加全属性+1888 攻击加全属性+1888 每秒加全属性+1888
|cff00ffff攻击减甲+1888 减少周围护甲+3888
|cffffff00暴击伤害+488% 技暴伤害+488% 会心伤害+488% 多重暴击+1
|cffff0000物理伤害加深+488% 技能伤害加深+488% 全伤加深+488%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 1888,
['攻击加全属性'] = 1888,
['每秒加全属性'] = 1888,
['攻击减甲'] = 1888,
['减少周围护甲'] = 3888,
['暴击伤害'] = 488,
['技暴伤害'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,
['多重暴击'] = 1,


}

ac.game:event '玩家-注册英雄' (function(_,p,hero)
    if not p.mall then 
        return 
    end
    local flag = true
    for i,data in ipairs(mall) do 
        local mall_name = data[2]
        if not p.mall[mall_name] or p.mall[mall_name] < 1  then 
            flag = false
            break
        end
    end        

    if flag then 
        local skl = hero:find_skill('满赞',nil,true)
        if skl then 
            skl:set_level(1)
        end
    end    

end)
