
local mt = ac.skill['宠物传说']
mt{
title = '宠物传说',
art = [[chongwuchuanshuo.blp]],
tip = [[

|cff00ff00携带该宠物通关N2以上，就等于点亮该宠物
%active1% 点亮宠物5 - 物理伤害加深系数+1%
%active2% 点亮宠物10 - 技能伤害加深系数+1%
%active3% 点亮宠物15 - 全伤加深系数+1%
%active4% 点亮宠物20 - 物理伤害加深系数+2%
%active5% 点亮宠物25 - 技能伤害加深系数+2%
%active6% 点亮宠物30 - 全伤加深系数+2%
%active7% 点亮宠物35 - 物理伤害加深系数+3%
%active8% 点亮宠物40 - 技能伤害加深系数+3%
%active9% 点亮宠物40 - 技能伤害加深系数+3%
 ]],
content = '',
active = function(self)
    local p = self.owner.owner 
    local cnt =0
    for i=1,64 do 
        if has_flag(p.server['宠物纪念册'],2^(i-1)) then 
            cnt = cnt + 1 
        end
    end
    return cnt
end,
active1 =function(self) return self.active >=5 and '|cff00ff00' or '|cffcccccc' end,
active2 =function(self) return self.active >=10 and '|cff00ff00' or '|cffcccccc' end,
active3 =function(self) return self.active >=15 and '|cff00ff00' or '|cffcccccc' end,
active4 =function(self) return self.active >=20 and '|cff00ff00' or '|cffcccccc' end,
active5 =function(self) return self.active >=25 and '|cff00ff00' or '|cffcccccc' end,
active6 =function(self) return self.active >=30 and '|cff00ff00' or '|cffcccccc' end,
active7 =function(self) return self.active >=35 and '|cff00ff00' or '|cffcccccc' end,
active8 =function(self) return self.active >=40 and '|cff00ff00' or '|cffcccccc' end,
active9 =function(self) return self.active >=45 and '|cff00ff00' or '|cffcccccc' end,
['物理伤害加深系数'] = function(self) 
    local val = 0
    if self.active >=5 then 
        val = val +1
    end 
    if self.active >=20 then 
        val = val +2
    end
    if self.active >=35 then 
        val = val +3
    end
    return  val
end,
['技能伤害加深系数'] = function(self) 
    local val = 0
    if self.active >=10 then 
        val = val +1
    end 
    if self.active >=25 then 
        val = val +2
    end
    if self.active >=40 then 
        val = val +3
    end
    return  val
end,
['全伤加深系数'] = function(self) 
    local val = 0
    if self.active >=15 then 
        val = val +1
    end 
    if self.active >=30 then 
        val = val +2
    end
    return  val
end,

}
local mt = ac.skill['宠物纪念册']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cwpf.blp]],
    title = '宠物纪念册',
    tip = [[

点击查看 |cff00ffff宠物纪念册|r|cffcccccc（可存档成就）|r
    ]],
    
}
mt.skills = {
    '宠物传说','宠物纪念册1','宠物纪念册2','宠物纪念册3','宠物纪念册4','宠物纪念册5','宠物纪念册6','宠物纪念册7','宠物纪念册8','宠物纪念册9',
} 
function mt:on_add()
    local hero = self.owner 
    local p = hero:get_owner()
    --黑名单和反作弊处理 有31则视为
    local flag_val = 46
    if has_flag(p.server['宠物纪念册'],2^(flag_val-1)) or not ac.flag_use_mall then
        return 
    end

    for index,skill in ipairs(self.skill_book) do 
        if index >1 then 
            local min = tonumber(string.sub(skill.name,16, -1))
            min =  (min -1)*5+1
            local max = min + 4 
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
            if ok_cnt == 5 then 
                skill:set_level(1)
            end    
        end
    end     
end    

--所有属性
local mt = ac.skill['宠物纪念册1']
mt['杀怪加敏捷'] = 35
mt['移动速度'] = 35
mt['木头加成'] = 35
mt['暴击伤害'] = 35
mt{
title = '赏金猎人',
art = [[shangjinlieren.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【001】-【005】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加敏捷
+35  移动速度
+35% 木头加成
+35% 暴击伤害

]],
content = '',
}

local mt = ac.skill['宠物纪念册2']
mt['杀怪加智力'] = 35
mt['攻击距离'] = 35
mt['魔丸加成'] = 35
mt['技暴伤害'] = 35
mt{
title = '神奇宝贝',
art = [[shenqibaobei.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【006】-【010】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加智力
+35  攻击距离
+35% 魔丸加成
+35% 技暴伤害

]],
content = '',
}



local mt = ac.skill['宠物纪念册3']
mt['杀怪加力量'] = 35
mt['攻击减甲'] = 100
mt['杀敌数加成'] = 35
mt['会心伤害'] = 35
mt{
title = '驯宠小霸王',
art = [[xiaobawang.blp]],

tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【011】-【015】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加力量
+100 攻击减甲
+35% 杀敌数加成
+35% 会心伤害

]],
content = '',
}


local mt = ac.skill['宠物纪念册4']
mt['杀怪加攻击'] = 35
mt['减少周围护甲'] = 1000
mt['物品获取率'] = 35
mt['物理伤害加深'] = 35
mt{
title = '龟基赛跑',
art = [[saipao.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【016】-【020】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35   杀怪加攻击
+1000 减少周围护甲
+35%  物品获取率
+35%  物理伤害加深

]],
content = '',
}


local mt = ac.skill['宠物纪念册5']
mt['杀怪加生命上限'] = 35
mt['吸血'] = 35
mt['每秒回血'] = 10
mt['技能伤害加深'] = 35
mt{
title = '洋洋得意',
art = [[xiyangyang.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【021】-【025】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加生命上限
+35% 吸血
+10% 每秒回血
+35% 技能伤害加深

]],
content = '',
}

local mt = ac.skill['宠物纪念册6']
mt['杀怪加智力'] = 35
mt['攻击速度'] = 35
mt['每秒加护甲'] = 15
mt['全伤加深'] = 15
mt{
title = '笑书神侠',
art = [[xssx.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【026】-【030】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35   杀怪加智力
+35% 攻击速度
+15   每秒加护甲
+15% 全伤加深

]]}

local mt = ac.skill['宠物纪念册7']
mt['杀怪加力量'] = 35
mt['分裂伤害'] = 35
mt['每秒加杀敌数'] = 3
mt['对BOSS额外伤害'] = 15
mt{
title = '无尽的绝望',
art = [[wjdjw.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【031】-【035】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35   杀怪加力量
+35% 分裂伤害
+3   每秒加杀敌数
+15% 对BOSS额外伤害

]]}

local mt = ac.skill['宠物纪念册8']
mt['杀怪加敏捷'] = 35
mt['触发概率加成'] = 10
mt['每秒加木头'] = 15
mt['多重暴击'] = 1
mt{
title = '快乐西游',
art = [[klxy.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【036】-【040】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加敏捷
+10% 触发概率加成
+15  每秒加木头
+1   多重暴击

]]}

local mt = ac.skill['宠物纪念册9']
mt['杀怪加智力'] = 35
mt['攻击减甲'] = 100
mt['每秒加魔丸'] = 30
mt['全伤加深系数'] = 5
mt{
title = '爱屋及乌',
art = [[aiwujiwu.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00携带编号为【041】-【045】的宠物通关N2以上

|cffffe799【成就属性】|r:|cff00ff00
+35  杀怪加智力
+100 攻击减甲
+15  每秒加魔丸
+5% 全伤加深系数

]]}


for i=1,10 do 
    local mt = ac.skill['宠物纪念册'..i]
    mt{
    --等级
    level = 0,
    max_level = 1,
    strong_hero = 1, --作用在人身上
    --图标
    
    --说明
    -- tip = [[

-- %content%
-- %attr_tip%|r]],
    content = '',
    attr_tip = function(self)
        local tip = '|cff00ffff集齐后激活【赏金猎人】，增加属性:\n|cff00ff00'
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
                print('宠物毕业:',p.peon.data.cid,p.peon:get_name())
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


