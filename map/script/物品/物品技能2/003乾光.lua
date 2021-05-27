local mt = ac.skill['乾光']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "黑",
	--图标
	art = [[qianguang.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['移动速度'] = 800,
 ['敏捷%'] = 10,
 ['杀怪加敏捷'] = 10000,
 ['攻击加敏捷'] = 10000,
 ['每秒加敏捷'] = 10000,
 ['闪避'] = 15,
	--介绍
	tip = [[

|cffcccccc野逸东山，与世异荣

|cffffff00+%敏捷%%|r |cffffff00%|r 敏捷
|cffffff00+%杀怪加敏捷%|r 杀怪加敏捷
|cffffff00+%攻击加敏捷%|r 攻击加敏捷
|cffffff00+%每秒加敏捷%|r 每秒加敏捷
|cffffff00+%闪避%|r |cffffff00%|r 闪避
|cff00ffff【极致的移动速度】
]],
	--备注
	effect4 = [[移动速度极限]],
	v1 = {1,1},
	--业务技能代码
}
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
