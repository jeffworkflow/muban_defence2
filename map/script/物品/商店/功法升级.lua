local mt = ac.skill['功法升级']
mt{
    --等久
    level = 1,
    is_order = "1",
    --图标
    art = [[gongfashengji.blp]],
    --价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
    --说明
    tip = [[|cff00ff00点击选择要升级的功法

|cffffe799【升级功法需消耗一定数量的魔丸】：
|cff00ff00提升1-5级：需要500*功法等级的魔丸
|cff00ffff提升6-10级：需要2500*功法等级的魔丸
|cffffff00提升11-15级：需要5000*功法等级的魔丸
|cffff0000提升16-20级：需要10000*功法等级的魔丸]],

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
            if skill.level <= 5 then 
                skill.rec_ex = skill.level*500
            elseif skill.level <= 10 then 
                skill.rec_ex = skill.level*2500
            elseif skill.level <= 15 then 
                skill.rec_ex = skill.level*5000
            else
                skill.rec_ex = skill.level*10000
            end
            local key = skill:get_hotkey() 
            local str = clean_color(skill:get_title())
            local info = {
                name = '|cff00ff00升级 |cff'..ac.color_code[skill.color].. str .. ' |r|cffff0000( 魔丸:' .. skill.rec_ex .. ' )',
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
                if p.rec_ex >= skl.rec_ex then 
                    --扣钱
                    hero:add_rec_ex(-skl.rec_ex)
                    --升级技能
                    skl:upgrade(1)
                else 
                    p:sendMsg('|cffffe799【系统消息】|cff00ff00魔丸不足',5)
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