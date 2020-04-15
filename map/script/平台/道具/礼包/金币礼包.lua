local mt = ac.skill['金币礼包']
mt{
--等久
level = 0,
--图标
art = [[jblb.blp]],
is_order = 1,
is_skill =true ,
content_tip = '',
--说明
tip = [[

|cffFFE799【领取条件】|r商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加1000金币，杀怪+1000金币，攻击+1000金币
开局赠送一本黄阶功法书（四选一），发放英雄背包|r
 ]],
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}
function mt:on_add()
    local hero = self.owner
    hero:add_item('金币礼包 ')
end

local function get_skl(skill)
    local self = skill
    local item = self 
    local list = {}
    local hero =self.owner
    local player = hero.owner
    self.skill_list_xs = {}
    for i=1,self.cnt do 
        local skl_list = ac.quality_skill['黄阶']
        local name = skl_list[math.random(#skl_list)]
        table.insert(self.skill_list_xs,name)
    end 
    
    for _,skill_name in ipairs(self.skill_list_xs) do
        local skill = ac.skill[skill_name]
        local info = {
            name = skill:get_name() .. '  (' .. (skill.skill_type or '') ..')' ,
            skill = skill,
        }
        table.insert(list,info)
    end    
    
    if not self.dialog  then 
        self.dialog = create_dialog(player,'选择你要的技能',list,
        function (index)
            self.dialog = nil
            local skill = list[index].skill
            ac.item.add_skill_item(skill:get_name(),hero)
            if self._count > 0 then  
                self:on_cast_start()
                self:add_item_count(-1)
            end  
        end)
    else
        self:add_item_count(1)    
    end    
end


local mt = ac.skill['金币礼包 ']
mt{
--等久
level = 1,
--图标
art = [[szdlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[
|cffFFE799【领取条件】|r商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加1000金币，杀怪+1000金币，攻击+1000金币
开局赠送一本黄阶功法书（四选一），发放英雄背包|r
]],
attr_tip = '',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--每秒金币
per_gold = 1000,
--杀怪加金币
kill_gold = 1000,
--攻击加金币
attack_gold = 1000,
cnt = 4,
passive = true
} 
function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    --添加给英雄
    hero:add('每秒加金币',self.per_gold)
    hero:add('杀怪加金币',self.kill_gold)
    hero:add('攻击加金币',self.attack_gold)
    --选择技能
    get_skl(self)
    
    local tip = '|cffFFE799【系统消息】|r|cff00ff00自动激活 |cff00ffff金币礼包|r|cff00ff00 礼包属性可在最强魔灵-礼包中查看'
    p:sendMsg(tip,3)
end
