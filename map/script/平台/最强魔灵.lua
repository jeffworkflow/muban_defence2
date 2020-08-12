local jass = require 'jass.common'
local mt = ac.skill['最强魔灵']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[zuiqiangmoling.blp]],
    title = '最强魔灵',
    tip = [[

点击查看 |cff00ffff最强魔灵|r，里面包含所有 |cffffff00可存档内容
    ]],
    
}
mt.skills = {
    '礼包','签到','地图等级','通关难度',
    '称号','神器','翅膀','领域','坐骑',
    '法宝','最强魔灵-下一页'
    -- ,'精彩活动' '游戏说明',
} 
local mt = ac.skill['最强魔灵-下一页']
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
    '成神','隐藏成就','精彩活动','新的征程','贪婪魔窟','关爱萌新成就','魔灵争霸成就','荣耀赛季'
}

local mt = ac.skill['成神']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[moshen.blp]],
    title = '成神',
    tip = [[

点击查看 |cff00ffff成神|r，完成 |cffffff00第六幕任务|r 获得
    ]],
    
}
mt.skill_name ={
    '番天印','战舰之舵','量天尺','虚空王座','天眼','血羽之心','天神之息','灭世者','宇宙之心','太初锁灵鼓',
    '晨钟暮鼓','龙皇之心','封神结','烟月神镜','天星奇光镯'
}
mt.skills = {
}


local mt = ac.skill['地图等级']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[dtdj.blp]],
    title = '地图等级奖励',
    tip = [[

点击查看 |cff00ffff地图等级奖励|r
    ]],
    
}
mt.skills = {
    '黄盖','魔灵限定','关羽','地图等级首充礼包','堕落天使',
    '地图等级成长礼包','加百列','商城御剑守护','王昭君',
    '地图等级初级赞助','地图等级-下一页'
}
local mt = ac.skill['地图等级-下一页']
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
    '雅典娜','地图等级高级赞助','圣斗士','地图等级元祖巨龙','等级天尊','肝帝',
}


local mt = ac.skill['游戏说明']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yxsm.blp]],
    title = '游戏说明',
    tip = [[

点击查看 |cff00ffff游戏说明
    ]],
}
mt.skills = {
    '游戏难度说明','地图等级说明1','地图等级1','地图等级2','挖宝熟练度说明','勇士徽章说明','宠物天赋说明','比武积分说明','其它可存档内容说明'
}
-- '无尽挑战说明','神龙碎片说明',
local mt = ac.skill['礼包']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sffl.blp]],
    title = '礼包',
    tip = [[

点击查看 |cff00ffff礼包|r
    ]],
    
}--'五星好评礼包'
mt.skills = {
    '入群礼包','金币礼包','木材礼包','赤灵限定',
    '首充礼包','成长礼包','通行证','赞助',
    '黑科技礼包','月神'
}

local mt = ac.skill['赞助']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[chujivip.blp]],
    title = '赞助',
    tip = [[

点击查看 |cff00ffff赞助
    ]],
    
}
mt.skills = {
    '初级赞助','高级赞助',
    '满赞'
}
-- ,'肝帝'

local mt = ac.skill['通行证']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ahtxz.blp]],
    tip = [[

点击查看 |cff00ffff通行证
    ]],
    
}
mt.skills = {
    '藏宝阁通行证','藏经阁通行证','剑冢通行证','百花宫通行证','龙宫通行证','罪恶城堡通行证',
    -- '满赞'
}

-- ,'肝帝'

local mt = ac.skill['首充']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sffl.blp]],
    title = '首充',
    tip = [[

点击查看 |cff00ffff首充
    ]],
    
}
mt.skills = {
    '限量首充','首充大礼包'
}

local mt = ac.skill['神器']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[wuqi10.blp]],
    title = '神器',
    tip = [[

点击查看 |cff00ffff神器|r，主要通过 |cffffff00不断打造|r 获得
    ]],
    
}
mt.skills = {
    '熔炉炎刀','冰莲穿山剑','紫阳白涛剑','霜之哀伤','熔炉流星刀','冰魂火焰枪','霸王莲龙锤','方天画戟','桃花天香棒','苍雷噬金枪','苍天帝剑'
}
-- '灭神紫霄剑','方天画戟','圣神无双剑',

local mt = ac.skill['翅膀']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[chibang10.blp]],
    title = '翅膀',
    tip = [[

点击查看 |cff00ffff翅膀|r，主要通过 |cffffff00不断摇骰子|r 获得
    ]],
    
}
mt.skills = {
    '小精灵之翼','火精灵之翼','杰拉米之翼','暗羽翼','光羽翼','玄羽绣云翼','绝世阳炎翼','龙吟双型翼','金鳞双型翼','赤魔双型翼','天罡苍羽翼'
}
-- '龙吟双形翼','金鳞双型翼','赤魔双形翼',
local mt = ac.skill['称号']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[chenghao10.blp]],
    title = '称号',
    tip = [[

点击查看 |cff00ffff称号|r，主要通过 |cffffff00不断种树|r 获得
    ]],
    
}
mt.skills = {
    '热血青年','逆天改命','横扫六合','北斗七星','战神崛起','战神无敌','毁天灭地','爆肝之王','真龙天子','大至尊','江山代有才人出'
}
-- '称号-下一页'
local mt = ac.skill['称号-下一页']
mt{
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

点击查看 |cff00ffff下一页
    ]], 
    is_spellbook = 1,
    is_order = 2,
}
mt.skills = {'九洲帝王','逆天改命',}

local mt = ac.skill['英雄']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yxpf.blp]],
    title = '英雄皮肤',
    tip = [[

点击查看 |cff00ffff英雄皮肤
    ]],
}
mt.skills = {
    '赵子龙','Pa','虞姬','手无寸铁的小龙女','太极熊猫','关羽','狄仁杰','伊利丹','至尊宝','鬼厉','英雄-下一页'
}

local mt = ac.skill['英雄-下一页']
mt{
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

点击查看 |cff00ffff下一页
    ]], 
    is_spellbook = 1,
    is_order = 2,
}
mt.skills = {'剑仙','关公','加百列','不朽剑圣','魔化的小龙女','黄金圣斗士','萧若兰','复仇天神',}
-- '王昭君','雅典娜',

local mt = ac.skill['领域']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[lingyu10.blp]],
    title = '领域',
    tip = [[

点击查看 |cff00ffff领域|r，主要通过 |cffffff00不断看书|r 获得
    ]],
    
}
mt.skills = {
    '血雾领域','龙腾领域','迦蓝领域','极寒领域','黄龙天翔领域','焚魂镇妖领域','真武青焰领域','琉光十色领域','孤风青龙领域','远影苍龙领域'
}
-- '烈火金焰领域','领域-下一页','烈火天翔领域'
local mt = ac.skill['领域-下一页']
mt{
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

点击查看 |cff00ffff下一页
    ]], 
    is_spellbook = 1,
    is_order = 2,
}
mt.skills = {'真武青焰领域','罗刹夜舞领域',}

local mt = ac.skill['坐骑']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[zuoqi10.blp]],
    title = '坐骑',
    tip = [[

点击查看 |cff00ffff坐骑|r，主要通过 |cffffff00不断白嫖|r 获得
    ]],
    
}
mt.skills = {
    '风速狗','兜兜猪','星空麋鹿','烈焰凤凰','地狱蜘蛛','紫霜龙鹰','炎宿朱雀','苍魂青龙','晶蓝天马','金角天马','元祖巨龙'
}

local mt = ac.skill['法宝']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[fabao10.blp]],
    title = '法宝',
    tip = [[

点击查看 |cff00ffff法宝|r，主要通过 |cffffff00不断挖宝|r 获得
    ]],
    
}
mt.skills = {
    '东皇钟','轩辕剑','缚妖索','青莲宝色旗','莫邪宝剑','盘古斧','招妖幡','昊天塔','太极符印','崆峒印','御剑守护'
}



--循环遍历 skill_book 的技能
local function upgrade_skill(player,skill)
    local self = skill
    local hero = skill.owner
    for index=1,table.maxnum(self.skill_book) do 
        local skill = self.skill_book[index]
        if skill then 
            if skill.is_spellbook == 1 then  
                --处理动态插入
                if skill.skill_name  then
                    for i=1,#skill.skill_name do 
                        local name = skill.skill_name[i]
                        local has_mall = player.mall[name] or (player.server and player.server[name])
                        if has_mall and has_mall > 0 then 
                            ac.game:event_notify('技能-插入魔法书',hero,skill.name,name)
                            local skl = hero:find_skill(name,nil,true)
                            skl.item_type = nil --动态插入的技能，如果是消耗品且为0级,设置为nil再升级就有对应的属性。 案例：天神物品
                            skl:set_level(has_mall)
                        end
                    end
                end
                upgrade_skill(player,skill)
            else
                local has_mall = player.mall[skill.name] or (player.server and player.server[skill.name])
                if has_mall and has_mall > 0 then 
                    print('激活：',player:get_name(),skill.name,has_mall)
                    skill:set_level(math.floor(has_mall))
                end
                if skill.name == '江山代有才人出' then 
                    local has_rank
                    -- print('江山代有才人出:',player,player.cus_server['今日白嫖排名'],player.cus_server['今日挖宝排名'])
                    player.cus_server = player.cus_server or {}
                    for name,v in pairs(player.cus_server) do 
                        if finds(name,'排名') and v >0 and v<=10 then 
                            skill:set_level(1)
                            --顺便添加 风骚技能（隐藏）
                            local hero = skill.owner
                            hero:add_skill('风骚','隐藏')
                            break
                        end
                    end
                end   
                --特殊处理 英雄 类别的
                if finds(self.name ,'英雄','英雄-下一页','至尊宝') then 
                    local has_baibian = player.mall and player.mall['百变英雄礼包'] or 0
                    if has_baibian and has_baibian > 0 then 
                        skill:set_level(1)
                    end
                end    
            end    
        end
    end    
end    
ac.upgrade_skill = upgrade_skill
--{'礼包','武器','翅膀','称号','神圣领域','英雄','游戏说明','武林大会'}
for i,name in ipairs({'最强魔灵'}) do
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner 
        local player = hero:get_owner()
        upgrade_skill(player,self)
    end  
end    


--注册添加给英雄
ac.game:event '玩家-注册英雄' (function(_, player, hero)
    hero:add_skill('最强魔灵','英雄',12)
end) 