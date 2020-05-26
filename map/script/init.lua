base = require 'base'
japi = require 'jass.japi'
jass = require 'jass.common'
storm = require 'jass.storm'
dzapi = require 'jass.dzapi'
japi.SetOwner("mtp")
--官方存档和商城
require 'util'
-- print(1)
require 'war3'
-- print(2)
require 'types'
-- print(3)
require 'ac'
-- require '框架拓展'
-- print(4)
require 'ui'
require '界面'
-- print(5)
require '通用'
require '平台'
-- print(6)
require '游戏'
-- print(7)
require '物品'
-- print(8)
require '技能'
-- print(9)
require '英雄'
-- print(10)
require '刷怪'
-- print(11)
-- -- print(12)
require '测试'
-- print(13)
--设置天空模型 
-- jass.SetSkyModel([[sky.mdx]])
-- jass.CreateDestructable(base.string2id('B04E'), 0, 0, 0, 1, 0) 


ac.wait(0,function ()
    local function light(type)
        local light = {
            'Ashenvale',
            'Dalaran',
            'Dungeon',
            'Felwood',
            'Underground',
            'Lordaeron',
        }
        if not tonumber(type) or tonumber(type) > #light or tonumber(type) < 1 then
            return
        end
        local name = light[tonumber(type)]
        jass.SetDayNightModels(([[Environment\DNC\DNC%s\DNC%sTerrain\DNC%sTerrain.mdx]]):format(name, name, name), ([[Environment\DNC\DNC%s\DNC%sUnit\DNC%sUnit.mdx]]):format(name, name, name))
    end
    -- light(3)
    print('游戏开始时间：',time2string(ac.player(1):Map_GetGameStartTime()))
    ac.player(16):setColor(7)    
end);
--测试难2
ac.wait(1199,function ()
    for i=1,6 do 
        local p = ac.player(i)
        p:Map_SaveServerValue('wxnd',10) --网易服务器
    end
end)