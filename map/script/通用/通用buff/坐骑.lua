--buff
local mt = ac.buff['坐骑']
mt.cover_type = 1
mt.cover_max = 1
-- 死亡之后保持buff
mt.keep = true
mt.eff = nil

function mt:on_add()
    local hero = self.target
    local higt = self.higt
    local size = self.size
    local model = self.model
    local zq_higt = self.zq_higt

    hero:set_high(higt)

    self.follow = self.target:follow{
        source = self.target,
        model = self.model,
        angle_follow = true,
        face_follow = true,
        distance = 0,
        high = zq_higt or 0,
        skill = false,
        size = size or 1,
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
    print('错误！坐骑buff被重复添加')
	return false
end