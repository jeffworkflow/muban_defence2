local mt = ac.skill['技能升级']
mt{
    --等久
    level = 1,
    --图标
    art = [[other\suijijineng.blp]],
    --价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
    --说明
    tip = [[|n获得 |cffff0000随机技能|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]],

    content_tip = '|cffFFE799【说明】：|r|n',
    --物品类型
    item_type = '神符',
    --购买价格
    wood = 0,
    skill_cnt = 8
}


function mt:on_cast_start()
    local hero = self.owner 
    local owner = self.owner 
    local player = hero:get_owner()
    local p = hero:get_owner()
    --宠物也帮忙学技能
    hero = player.hero
    
    local list = {}
    for i=1,self.skill_cnt do 
        local skill = hero:find_skill(i,'英雄')
        if skill and skill.level < skill.max_level then 
            skill.gold = skill.level > 10 and 1000 or  500
            local key = skill:get_hotkey() 
            local info = {
                name = '升级 ' .. skill:get_title() .. ' ( 金币:' .. skill.gold .. ' )',
                skill = skill,
            }
            table.insert(list,info)
        end
    end 
    if #list == 0 then 
        p:sendMsg('没有可升级的技能')
        return 
    end    

    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'升级技能',list,function (index)
            local skl = list[index].skill
            if skl then 
                if p.gold > skl.gold then 
                    --扣钱
                    hero:addGold(-skl.gold)
                    --升级技能
                    skl:upgrade(1)
                else 
                    p:sendMsg('金币不足，升级失败')
                end    
                --再执行一遍
                hero:event_notify('单位-点击商店物品',self.seller,hero,self)
            else
                --取消
            end
            self.dialog = nil
        end) 
    end   

end 