

local mt = ac.skill['功法升级书']
mt{
    --等久
    level = 1,
    --图标
    art = [[gongfashengji.blp]],
    --价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
    --说明
    tip = [[|cff00ff00点击选择要升级的功法，直接升一级

|cffcccccc【无需消耗魔丸】]],

    content_tip = '|cffFFE799说明：|r|n',
    --物品类型
    item_type = '消耗品',
    --购买价格
    wood = 0,
    skill_cnt = 8,
    upgrade_cnt = 1
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
            local key = skill:get_hotkey() 
            local str = clean_color(skill:get_title())
            local info = {
                name = '|cff00ff00升级 |cff'..ac.color_code[skill.color].. str .. ' |r',
                skill = skill,
            }
            table.insert(list,info)
        end
    end 
    if #list == 0 then 
        p:sendMsg('没有可升级的技能')
        --取消 --取消
        if self._count > 1 then 
            self:add_item_count(1) 
        else
            --重新添加给英雄
            owner:add_item(self.name)
        end   
        return 
    end    

    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'升级技能',list,function (index)
            self.dialog = nil
            local skl = list[index].skill
            if skl then 
                skl:upgrade(self.upgrade_cnt)
                if self._count > 0 then  
                    print(123,'再一次升级')
                    p:sendMsg('【系统消息】升级成功',5)
                    self:on_cast_start()
                    self:add_item_count(-1)
                end  
            else
                --取消 --取消
                if self._count > 1 then 
                    self:add_item_count(1) 
                else
                    --重新添加给英雄
                    owner:add_item(self.name,true)
                end     
            end
        end) 
    else 
        self:add_item_count(1) 
    end   

end 



local mt = ac.skill['功法连升书']
mt{
    --等久
    level = 1,
    --图标
    art = [[gongfashengji.blp]],
    --价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
    --说明
    tip = [[|cff00ff00点击选择要升级的功法，直接升五级

|cffcccccc【无需消耗魔丸】]],

    content_tip = '|cffFFE799【说明】：|r|n',
    --物品类型
    item_type = '消耗品',
    --购买价格
    wood = 0,
    skill_cnt = 8,
    upgrade_cnt = 5
}
mt.on_cast_start = ac.skill['功法升级书'].on_cast_start