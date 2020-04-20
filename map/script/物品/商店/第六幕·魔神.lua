local mt = ac.skill['魔神之路']
mt{
    effect2 = [[Void Teleport Target.mdx]],
    max_succ_cnt = function()
        return ac.g_game_degree_attr * 2
    end --最大挑战次数
}
local function create_u(skill,unit_name,target_rect,f)
    local self= skill
    local p=self.owner.owner
    local hero =p.hero 

    local rect = ac.rect.j_rect(target_rect)
    local point = rect:get_point()
    local u = ac.player(12):create_unit(unit_name,point)
    u:event '单位-死亡'(function(_,unit,killer)
        --多面板显示
        p.flag_mszl = true
        --激活属性
        f(unit,killer) 
        --删除另一只怪
        for i, u in ac.selector()
            : in_rect(ac.rect.j_rect('moshen4'))
            : is_enemy(hero)
            : of_not_building()
            : ipairs()
        do 
            u:remove()
        end
        p.flag_ms = false
    end)
    --创建区域离开事件
    local reg = ac.map.regions['moshen4']
    reg:event '区域-离开'(function(trg,unit)
        if hero ~= unit then 
            return 
        end  
        if u and u:is_alive() then 
            u:remove()
        end
        p.flag_ms = false
        --删除自己的
        trg:remove()  
    end)
end


function mt:on_cast_start()
    local p=self.owner.owner
    local hero =p.hero 
    if (p.cnt_succ_ms or 0) >= self.max_succ_cnt then
        p:sendMsg('|cffffe799【系统消息】|r更多挑战在高难度开放',5)
        return true
    end

    if p.flag_ms then 
        p:sendMsg('已经挑战，请勿重复点击',5)
        return true 
    end
    p.flag_ms = true

    local cnt = (p.cnt_succ_tm or 0) + 1
    local name = '天魔BOSS'..(p.cnt_succ_ms or 0) + 1
    if cnt <= 10 then 
        create_u(self,name,'moshen2',function(unit,killer)
            -- local it_name = ac.tm_item[math.random(#ac.tm_item)]
            
            local it_name = p:random(ac.tm_item,true)
            if it_name then 
                ac.item.create_item(it_name,unit:get_point())
            end
            --p:sendMsg('恭喜击败'..name,5)
            --天魔次数+1
            p.cnt_succ_tm = (p.cnt_succ_tm or 0) + 1 
            --魔神挑战次数+1
            p.cnt_succ_ms = (p.cnt_succ_ms or 0) + 1 
            p.cnt_dz = (p.cnt_dz or 0) + 1 
        end)
    end

    local cnt = (p.cnt_succ_ts or 0) + 1
    local name = '天神BOSS'..(p.cnt_succ_ms or 0) + 1
    if cnt <= 10 then 
        create_u(self,name,'moshen3',function(unit,killer)
            local it_name = p:random(ac.ts_item,true)
            -- local it_name = ac.ts_item[math.random(#ac.ts_item)]
            if it_name then 
                ac.item.create_item(it_name,unit:get_point())
            end
            -- p:sendMsg('恭喜击败'..name,5)
            --天神+1
            p.cnt_succ_ts = (p.cnt_succ_ts or 0) + 1 
            --魔神挑战次数+1
            p.cnt_succ_ms = (p.cnt_succ_ms or 0) + 1 
            p.cnt_dz = (p.cnt_dz or 0) + 1 
        end)
    end
end

local mt = ac.skill['渡劫']
mt{
    pulse =0.1,
    dz_cnt = 50,
    cnt_dz = function(self)
        return ac.player.self.cnt_dz or 0
    end
}

function mt:on_cast_start()
    local p=self.owner.owner
    local hero = p.hero 
    if (p.cnt_dz or 0) <=0 then
        p:sendMsg('挑战次数不够',5)
        return true
    end

    if p.flag_dz then 
        p:sendMsg('已经在渡劫，请勿重复点击',5)
        return true 
    end
    p.flag_dz = true
    --扣除次数
    p.cnt_dz = p.cnt_dz -1

    ac.wait(2*1000,function()
        local bff = hero:add_buff '渡劫' {
            skill = self,
            damage = 100000000 * (p.cnt_succ_dz or 0 + 1),
            time = self.dz_cnt * self.pulse,
            pulse = self.pulse,
            dz_cnt = self.dz_cnt
        }

        --创建区域离开事件
        local reg = ac.map.regions['dujie2']
        reg:event '区域-离开'(function(trg,unit)
            if hero ~= unit then 
                return 
            end  
            --删掉buff
            if bff then 
                bff:remove()
                bff =nil 
            end
            --删除自己的
            trg:remove()  
        end)
    end)

end

--渡劫buff

local mt = ac.buff['渡劫']
mt.cover_type = 0
mt.ref = 'overhead'
mt.model = [[Lightnings Long.mdx]]
-- mt.model = [[File00000376 - RC.mdx]]
function mt:on_add()
    -- self.eff = ac.unit_effect(self.target,{
    --     model = self.model,
    --     height = 100,
    --     animation = 'New'
    -- })
    
    self.eff = self.target:add_effect(self.ref, self.model)
    local p = self.target.owner
end
function mt:on_pulse()
    self.target:damage
    {
        source = self.target,
        skill = self.skill,
        damage = self.damage,
        real_damage =  true
    }

end
function mt:on_remove()
    if self.eff then
       self.eff:remove()
       self.eff = nil
    end
    local p = self.target.owner
    local hero = self.target
    p.flag_dz = false

    --完成加属性，半途离去，不处理
    print('buff删除',self.pulse_count ,self.dz_cnt)
    if self.pulse_count >= (self.dz_cnt - 1) then 
        --记录成功次数
        p.cnt_succ_dz = (p.cnt_succ_dz or 0) + 1 
        --加属性
        hero:add('力量%',5)
        hero:add('敏捷%',5)
        hero:add('智力%',5)
        
        --传送回练功房
        local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
        hero:blink(point,true,false,true)
        ac.player.self:sendMsg('|cffffe799【系统提示】|r|cff00ff00恭喜|cff00ffff'..p:get_name()..'|r|cff00ff00渡劫成功，获得5%全属性',5)
    end
end



