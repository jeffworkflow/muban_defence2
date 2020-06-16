
require '物品.商店.扭蛋.扭蛋'
require '物品.商店.扭蛋.扭蛋(十连抽)'
require '物品.商店.扭蛋.扭蛋(百连抽)'

require '物品.商店.扭蛋.超级扭蛋'
require '物品.商店.扭蛋.超级扭蛋(十连抽)'
require '物品.商店.扭蛋.超级扭蛋(百连抽)'


require '物品.商店.扭蛋.翻倍'

--扭蛋发送文本相关特殊处理
local player = require 'ac.player'

-- function player.__index:sendMsg1(text, time)
--     if self.flag_nd_text then 
--         return
--     end    
--     jass.DisplayTimedTextToPlayer(self.handle, 0, 0, time or 60, text)
-- end