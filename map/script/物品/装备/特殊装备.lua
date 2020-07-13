local mt = ac.skill['噬魂棒']
mt{
    level = 1 ,
    specail_model = [[File00000376 - RC.mdx]],
    unique = true,
    title = '|cffdf19d0噬魂棒|r',
    tip = [[ 
|cffcccccc上古时期，一根充满戾气的魔棒，可吸引天地洪荒之气

|cff00ff00藏宝图掉落概率+10%
|cff00ff00羊皮纸、无字天书掉落概率+10%
|cff00ff00强化石、天谕掉落概率+10%
|cff00ffff一颗神奇的种子掉落概率+10%
|cff00ffff扭蛋券(十连抽)、超级扭蛋券(十连抽)掉落概率+10%
|cff00ffff黑暗骰子掉落概率+10%
|cffffff00万分之一空气，触发概率加成+50%
 ]],
    --技能图标
    art = [[shihunbang.blp]],
    ['藏宝图掉落概率'] = 10,
    ['羊皮纸掉落概率'] = 10,
    ['无字天书掉落概率'] = 10,
    ['强化石掉落概率'] = 10,
    ['天谕掉落概率'] = 10,
    ['扭蛋券(十连抽)掉落概率'] = 10,
    ['超级扭蛋券(十连抽)掉落概率'] = 10,
    ['黑暗骰子掉落概率'] = 10,
    ['万分之一空气概率'] = 50,
}


local mt = ac.skill['太初威丸弹弓']
mt{
    level = 1 ,
    specail_model = [[File00000376 - RC.mdx]],
    unique = true,
    title = '|cffdf19d0太初威丸弹弓|r',
    tip = [[ 
|cffcccccc上古时期，一根充满戾气的魔棒，可吸引天地洪荒之气

|cff00ff00藏宝图掉落概率+10%
|cff00ff00羊皮纸、无字天书掉落概率+10%
|cff00ff00强化石、天谕掉落概率+10%
|cff00ffff一颗神奇的种子掉落概率+10%
|cff00ffff扭蛋券(十连抽)、超级扭蛋券(十连抽)掉落概率+10%
|cff00ffff黑暗骰子掉落概率+10%
|cffffff00万分之一空气，触发概率加成+50%
 ]],
    --技能图标
    art = [[shihunbang.blp]],
    ['攻击间隔极限'] = -0.05,
}

local mt = ac.skill['打狗棒']
mt{
    level = 1 ,
    specail_model = [[File00000376 - RC.mdx]],
    unique = true,
    title = '|cffdf19d0太初威丸弹弓|r',
    tip = [[ 
|cffcccccc上古时期，一根充满戾气的魔棒，可吸引天地洪荒之气

|cff00ff00藏宝图掉落概率+10%
|cff00ff00羊皮纸、无字天书掉落概率+10%
|cff00ff00强化石、天谕掉落概率+10%
|cff00ffff一颗神奇的种子掉落概率+10%
|cff00ffff扭蛋券(十连抽)、超级扭蛋券(十连抽)掉落概率+10%
|cff00ffff黑暗骰子掉落概率+10%
|cffffff00万分之一空气，触发概率加成+50%
 ]],
    --技能图标
    art = [[shihunbang.blp]],
    ['秒杀练功房的怪物'] = 1,
}

ac.game:event '造成伤害结束' (function (_,damage)
    local source = damage.source
    local target = damage.target
    if not finds(target:get_name(),'经验怪','金币','木头','魔丸','功法怪') then 
        return
    end    
    if not source:is_hero() then 
        return 
    end
    local p = source:get_owner()
    if source:get('秒杀练功房的怪物') >0 then 
        target:kill(source)
    end
end)

