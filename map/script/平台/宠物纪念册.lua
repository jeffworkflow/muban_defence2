local mt = ac.skill['宠物纪念册']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[zuiqiangmoling.blp]],
    title = '宠物纪念册',
    tip = [[

点击查看 |cff00ffff宠物纪念册|r
    ]],
    
}
mt.skills = {
    '宠物纪念册1','宠物纪念册2','宠物纪念册3','宠物纪念册4',
} 
function mt:on_add()
    local hero = self.owner 
    local p = hero:get_owner()
    for index,skill in ipairs(self.skill_book) do 
        local min = tonumber(string.sub(skill.name,16, -1))
        min =  (min -1)*10+1
        local max = min + 9 
        local content = ''
        local ok_cnt = 0 
        for i = min,max do 
            --有毕业 则 cid ac.peon_list
            if has_flag(p.server['宠物纪念册'],2^(i-1)) and ac.peon_list[i] then 
                content = content ..'|cff00ff00【'..string.format('%03d',i)..'】'..ac.peon_list[i]..'|r \n'
                ok_cnt = ok_cnt + 1
            else
                content = content ..'【'..string.format('%03d',i)..'】'..'？？？ \n'
            end        
        end    
        skill:set('content',content)
        skill:fresh_tip()
        if ok_cnt == 10 then 
            skill:set_level(1)
        end    
    end     
end    
--所有属性
local mt = ac.skill['宠物纪念册1']
mt['力量'] = 1000
local mt = ac.skill['宠物纪念册2']
mt['敏捷'] = 1000
local mt = ac.skill['宠物纪念册3']
mt['智力'] = 1000

for i=1,10 do 
    local mt = ac.skill['宠物纪念册'..i]
    mt{
    --等级
    level = 0,
    max_level = 1,
    strong_hero = 1, --作用在人身上
    --图标
    art = [[ReplaceableTextures\CommandButtons\BTNNetherDragon.blp]],
    --说明
    tip = [[%content%
%attr_tip%
|r]],
    content = '',
    attr_tip = function(self)
        local tip = '|cff00ffff集齐后激活【XXX】，增加属性:\n'
        for key,val in sortpairs(ac.unit.attribute) do 
            if self[key] then  
                local per_str = finds(ac.base_attr,key)  and '' or '%'
                if self[key] < 0 then 
                    tip = tip  ..""..bignum2string(self[key])..per_str..' '.. key ..'\n'
                else     
                    tip = tip  .."+"..bignum2string(self[key])..per_str..' '.. key ..'\n'
                end    
            end
        end        
        return tip
    end
    }
end    


local function save_cwjnc() 
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            local val = 2^(p.peon.data.cid -1)
            local key = ac.server.name2key('宠物纪念册')
            if not has_flag(p.server['宠物纪念册'],val) then 
                -- print('宠物毕业:',p.peon.data.cid,p.peon:get_name())
                p:Map_AddServerValue(key,val)
            end    
        end
    end
end
--注册获得方式 难二以上，游戏胜利激活
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end   
    if ac.g_game_degree_attr < 2 then 
        return 
    end   
    save_cwjnc() 
end)
--无尽开始
ac.game:event '游戏-无尽开始'(function(trg) 
    save_cwjnc()
end)


