local mt = ac.skill['移动的取款机']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "木头",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 180,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['敏捷%'] = 10,
	--介绍
	tip = [[ 
|cffffe799【敏捷】+10%

|cff00ff00到处送，所有玩家获得|cffffff00175木头

]],
	--技能图标
    art = [[jinbiguai.blp]],
    value = 175,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    
    --概率触发
    for i=1,10 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            pp.hero:add_wood(self.value) 
        end  
    end    
    local p = hero.owner 
    ac.player.self:sendMsg('|cffffe799【系统消息】|cff00ffff玩家 '..p:get_name()..' |cff00ff00的宠物是移动的取款机，所有玩家获得|cffffff00175木头|cff00ff00，请注意查收！',5)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
