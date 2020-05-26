require '平台.base'
require '平台.config'
require '平台.自定义服务器'
-- require '平台.房间显示'
require '平台.初始化'

require '平台.道具'
require '平台.宠物技能'

require '平台.最强魔灵'

require '平台.地图等级'
require '平台.活动'
require '平台.评论数'
require '平台.武林大会'
require '平台.精彩活动'
-- require '平台.重置版奖励'

require '平台.赛季奖励'

require '平台.隐藏成就'
require '平台.宠物纪念册'
require '平台.通关难度'
require '平台.签到'
require '平台.熟练度奖励'



--[[流程：
1.读取开关 开继续，关停止   读取服务器1次
2.读取 每个玩家 选择难度的数据，在游戏开始时。  读取服务器最大6次。
3.读取 16个 排行榜数据。

]]