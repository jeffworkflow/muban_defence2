
local mt = ac.skill['杀敌数保本卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
local mt = ac.skill['木头保本卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['魔丸保本卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['全属性保本卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['杀敌数翻倍卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['木头翻倍卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['魔丸翻倍卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['全属性翻倍卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}



local mt = ac.skill['炸弹卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['大炸弹卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['猜拳卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 

|cff00ff00可以在扭蛋处兑换一次超级扭蛋(百连抽)的机会|r
]],
--物品类型
item_type = '消耗品',
--不可点击
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

local mt = ac.skill['gg卡']
mt{
--等久
level = 1,
--图标
art = [[gjnd.blp]],
--说明
tip = [[ 
使用后，50%概率全属性翻倍，50%全属性归零（实际归100）
]],
--物品类型
item_type = '消耗品',
rate = 50,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local p = self.owner.owner 
    local hero = p.hero 
    local all_attr = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
    if math.random(100) <= self.rate then 
        hero:add('全属性',all_attr)
        p:sendMsg('翻倍',2)
    else 
        hero:add('全属性',-all_attr + 100)
        p:sendMsg('凉凉',2)
    end    
end


--[[剪刀”、“石头”、“布”、进行猜拳； 如果赢了，杀敌数/木头/魔丸/全属性全部翻倍；如果平手，杀敌数/木头/魔丸/全属性全部翻0.5倍；如果输了，杀敌数/木头/魔丸/全属性全部凉凉；]]
local temp = {
    '剪刀','石头','布',
    ['剪刀'] = 1,
    ['石头'] = 2,
    ['布'] = 3,
}
local temp_str = table.concat(temp,' ')
ac.game:event '玩家-聊天' (function(self, player, str)
    if not finds(temp_str,str)  then 
        return 
    end    
    local hero = player.hero
    local p = player
    local it = hero:has_item('猜拳卡')
    if not it then 
        return 
    end 

    local sys_str = temp[math.random(3)]
    local p_num = temp[str]
    local sys_num = temp[sys_str]
    local flag
    local all_attr = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
    if p_num == sys_num then 
    --平均 杀敌数/木头/魔丸/全属性全部翻0.5倍
        hero:add_kill_count(p.kill_count*0.5)
        hero:add_wood(p.wood*0.5)
        hero:add_rec_ex(p.rec_ex*0.5)
        hero:add('全属性',all_attr*0.5)
        flag = '平'
    elseif p_num-sys_num > 0 or p_num-sys_num == -2 then 
    --赢 杀敌数/木头/魔丸/全属性全部翻倍
        hero:add_kill_count(p.kill_count)
        hero:add_wood(p.wood)
        hero:add_rec_ex(p.rec_ex)
        hero:add('全属性',all_attr)
        flag = '赢'
    else 
    --输 杀敌数/木头/魔丸/全属性全部凉凉
        hero:add_kill_count(-p.kill_count)
        hero:add_wood(-p.wood)
        hero:add_rec_ex(-p.rec_ex)
        hero:add('全属性',-all_attr + 100)
        flag = '输'
    end
    p:sendMsg('【'..flag..'】 你出 '..str ..',系统出' ..sys_str  ,2)
    --扣卡
    it:add_item_count(-1)
end)  

