local Ray = {}

function Ray:new(pos, angle)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.pos = pos
    obj.dir = Vector.fromAngle(angle)
    return obj
end

function Ray:draw()
    love.graphics.push()
    love.graphics.translate(self.pos.x, self.pos.y)
    love.graphics.setColor(1,1,1,.2)
    love.graphics.line(0, 0, self.dir.x * 10, self.dir.y *10)
    love.graphics.pop()
end

function Ray:lookAt(x, y)
    self.dir.x = x - self.pos.x
    self.dir.y = y - self.pos.y
    self.dir:normalize()
end

function Ray:cast(wall)
    local x1 = wall.a.x
    local y1 = wall.a.y
    local x2 = wall.b.x
    local y2 = wall.b.y
    local x3 = self.pos.x
    local y3 = self.pos.y
    local x4 = self.pos.x + self.dir.x
    local y4 = self.pos.y + self.dir.y

    local den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
    if den == 0 then return end

    local t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den
    local u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den

    if (t > 0 and t < 1 and u > 0) then
        local ptx = x1 + t * (x2 - x1)
        local pty = y1 + t * (y2 - y1)
        return Vector:new(ptx, pty)
    else
        return
    end
end

return Ray
