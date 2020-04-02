--buff
local mt = ac.buff['坐骑']
mt.cover_type = 0
-- mt.cover_max = 1
-- 死亡之后保持buff
mt.keep = true
mt.eff = nil

function mt:on_add()
    local hero = self.target
    local high = self.high
    local size = self.size
    local model = self.model
    local zq_hight = self.zq_hight
    hero:set_high(high)

    self.follow = self.target:follow{
        source = self.target,
        model = self.model,
        angle_follow = true,
        face_follow = true,
        distance = 0,
        high = zq_hight or 0,
        skill = false,
        size = size or 1,
        remove_instant = true, --立即移除
    }
    --变身
    --japi.SetUnitModel(follow.mover.handle,model)
end

function mt:on_remove()
    --还原高度
    self.target:set_high(0)
    if self.follow then
        self.follow:remove()
    end
end

-- 叠加事件
function mt:on_cover(new)
    -- print('错误！坐骑buff被重复添加')
	return true
end