--物品名称
local mt = ac.skill['新人引导']
mt{
    --物品技能
    is_skill = true,
    level = 1 ,
    wood = 10,
    --颜色
    -- color = '紫',
    tip = [[

|cff00ff001、出来先完成任务【至凶之物】

|cff00ffff2、然后F3传送练功房，在左上角的NPC处开始神魂修炼

|cffffff003、在练功房右上角的NPC处，进行杀敌数抽奖

|cffff00004、回基地左下角开始做【三眼灵猴】等主线任务（打不过就回练功房）

|cffcccccc更多玩法自行摸索！愿君旗开得胜！|r
]],
    --技能图标
    art = [[yxsm.blp]],
    -- item_type ='消耗品'
}


ac.game:event '玩家-注册英雄' (function(trg, player, hero)
    if player:Map_GetMapLevel()<=5 then 
        hero:add_item('新人引导')
    end
end)