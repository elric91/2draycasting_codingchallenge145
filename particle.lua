local Particle = {}

function Particle:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.pos = Vector:new(width / 2, height / 2)
    obj.rays = {}
    for a=0,360,.5 do
        table.insert(obj.rays, Ray:new(obj.pos, math.rad(a)))
    end
    return obj
end


function Particle:draw()
    love.graphics.circle("fill", self.pos.x, self.pos.y, 4)
    for i, ray in ipairs(self.rays) do
        ray:draw()
    end
end

function Particle:cast(walls)
    for i,ray in ipairs(self.rays)do
        local closest = nil
        local record = width + height
        for j,wall in ipairs(walls) do
            local pt = ray:cast(wall)
            if pt then
                local d = Vector.dist(self.pos, pt)
                if (d < record) then
                    record = d
                    closest = pt
                end
            end
        end
        if closest then
            love.graphics.line(self.pos.x, self.pos.y, closest.x, closest.y)
        end
    end
end

function Particle:update(x, y)
    self.pos.x, self.pos.y = x, y
end

return Particle
