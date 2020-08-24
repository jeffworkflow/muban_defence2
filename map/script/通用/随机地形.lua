
local rdmap = {}
setmetatable(rdmap, rdmap)
--结构
local mt = {}
rdmap.__index = mt
ac.rdmap = rdmap

mt.map = {}
mt.map_walls = {}
mt.map_walls[1] = {}
mt.map_walls[2] = {}
mt.wall_rate = 40

function mt:random_map()
    local x = self.width
    local y = self.height
    local wall_rate = self.wall_rate
	for i=self.minx,self.maxx,64 do
		for j=self.miny,self.maxy,64 do 
			if not self.map[i] then 
				self.map[i] = {}
			end
			if not self.map_walls[1][i] then 
				self.map_walls[1][i]= {}
			end
			if not self.map_walls[2][i] then 
				self.map_walls[2][i]= {}
			end
			if i==self.minx or i == self.maxx or j ==self.minx or j==self.maxy then 
				self.map[i][j] = 1 
			else
				self.map[i][j] = math.random(100) < wall_rate and 1 or 0
			end
		end
	end
end

--点周围 九宫格内 墙的数量 
-- n 圈数
function mt:get_map_walls(posX,posY,n)
	local wallCount = 0
	local n = n or 1 
	for i=posX -64*n,posX+64*n,64 do
		for j=posY -64*n,posY+64*n,64 do 
			if i>=self.minx and i<self.maxx and j>=self.miny and j < self.maxy then 
				if i == posX and j ==posY then 
				else
					wallCount = wallCount + self.map[i][j]
				end
			else
				wallCount = wallCount + 1
			end
		end
	end
	
	self.map_walls[n][posX][posY] = wallCount
	return wallCount
end

--降噪
function mt:smooth_map(flag)
	for i=self.minx,self.maxx,64 do
		for j=self.miny,self.maxy,64 do 
			self:get_map_walls(i,j,1)
			self:get_map_walls(i,j,2)
		end
	end
	for i=self.minx,self.maxx,64 do
		for j=self.miny,self.maxy,64 do 
			-- local walls1 = self:get_map_walls(i,j,1)
			-- local walls2 = self:get_map_walls(i,j,2)
			local walls1 = self.map_walls[1][i][j]
			local walls2 = self.map_walls[2][i][j]
			-- print(i,j,walls1,walls2)
			if not flag then
				self.map[i][j] = (walls1 >=5 or walls2 <=2) and 1 or 0 
				-- if self.map[i][j] == 1 then 
				-- 	self.map[i][j] =  walls1 >=4 and 1 or 0
				-- else
				-- end
			else
				self.map[i][j] =  walls1 >=5 and 1 or 0
				-- if self.map[i][j] == 1 then 
				-- 	self.map[i][j] =  walls1 >=4 and 1 or 0
				-- else
				-- 	self.map[i][j] =  walls1 >=5 and 1 or 0
				-- end
			end
		end
	end
end
-- function mt:smooth_map(n)
-- 	local n= n or 1
-- 	for i=self.minx,self.maxx,64 do
-- 		for j=self.miny,self.maxy,64 do 
-- 			local walls = self.map_walls[i][j]
-- 			if walls > 4 then 
-- 				self.map[i][j] = 1
-- 			elseif walls <4 then 
-- 				self.map[i][j] = 0
-- 			end	
-- 		end
-- 	end
-- end
--生成地图
function mt:create()
	--形成大体框架
	self:random_map()

	--降噪
	--重复四次：W'(p) = R1(p) >= 5 || R2(p) <= 2
	-- for i=1,4 do 
    --     self:smooth_map()
	-- end
	-- --重复三次：W'(p) = R1(p) >= 5
	-- for i=1,3 do 
    --     self:smooth_map(true)
    -- end
    --创建树
    self:create_point()
    
end
function mt:c1()
	if self.effs then 
		for i,data in ipairs(self.effs) do 
			data.eff:remove()
			data.point:remove_block()
		end
		self.effs = nil 
	end
	self:smooth_map()
    --创建树
    self:create_point()
end

function mt:c2()
	if self.effs then 
		for i,data in ipairs(self.effs) do 
			data.eff:remove()
			data.point:remove_block()
		end
		self.effs = nil 
	end
	self:smooth_map(true)
    --创建树
    self:create_point()
end
--创建树（特效） ,不可通行点
function mt:create_point()
    self.effs = self.effs or {}
	for i=self.minx,self.maxx,64 do
        for j=self.miny,self.maxy,64 do 
            if self.map[i][j] == 1 then 
                local point = ac.point(i,j)
                local eff = ac.effect_ex{
                    point = point,
                    model = [[Abilities\Spells\Human\Thunderclap\ThunderclapTarget.mdl]]
                }
                point:add_block(nil,nil,nil,true)
                table.insert(self.effs,{eff = eff,point = point})
            end
        end
    end
end
--移除
function mt:remove()
	if self.effs then 
		for i,data in ipairs(self.effs) do 
			data.eff:remove()
			data.point:remove_block()
		end
		self.effs = nil 
	end

end
local function init()
    local minx,miny,maxx,maxy = ac.rect.map:get()
    mt.minx = minx
    mt.miny = miny 
    mt.maxx = maxx
    mt.maxy = maxy 

	print('地图宽高：',minx,miny,maxx,maxy)
    mt:create()
end	
-- ac.wait(0,function()
-- 	init()

-- end)
