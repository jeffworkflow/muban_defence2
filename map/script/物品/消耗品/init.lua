
require '物品.消耗品.吞噬丹'
require '物品.消耗品.世界吞噬丹'
require '物品.消耗品.随机技能书'
-- require '物品.消耗品.新手礼包'
-- require '物品.消耗品.召唤boss'
-- require '物品.消耗品.召唤练功怪'

require '物品.消耗品.抽奖券'

require '物品.消耗品.熔炼石'

require '物品.消耗品.恶魔果实'
require '物品.消耗品.藏宝图'

-- require '物品.消耗品.勇士徽章'

-- require '物品.消耗品.完美的鸡头'
-- require '物品.消耗品.完美的鸡汤'
-- require '物品.消耗品.完美的鸡翅'
-- require '物品.消耗品.完美的鸡腿'
-- require '物品.消耗品.完美的鸡蛋'

require '物品.消耗品.点金石'
require '物品.消耗品.龙之血珠'
require '物品.消耗品.无谓因果'

require '物品.消耗品.强化石'
require '物品.消耗品.天谕'

require '物品.消耗品.神器'
require '物品.消耗品.功法升级书'

require '物品.消耗品.羊皮纸'
require '物品.消耗品.无字天书'
require '物品.消耗品.卡片'
require '物品.消耗品.一颗神奇的种子'
require '物品.消耗品.黑暗骰子'
require '物品.消耗品.扭蛋券'
require '物品.消耗品.天魔物品'
require '物品.消耗品.天神物品'
require '物品.消耗品.卡片2'
require '物品.消耗品.超级藏宝图'

ac.all_card={}
for name,data in pairs(ac.skill) do 
    if type(data) == 'table' then 
        if data.is_card  then 
            data.raffle = [[黑暗骰子*30]]
            data.on_selled_remove = true 
            table.insert(ac.all_card,name)
        end     
    end
end
-- ac.all_card = {
--     '杀敌数保本卡','木头保本卡','魔丸保本卡','全属性保本卡',
--     '杀敌数翻倍卡','木头翻倍卡','魔丸翻倍卡','全属性翻倍卡',
--     '炸弹卡','大炸弹卡','猜拳卡','gg卡',
--     '基地复活次数卡','泻药卡','猜拳卡','gg卡',
-- }
