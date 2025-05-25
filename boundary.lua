local Boundary = {}

function Boundary:new(x1, y1, x2, y2)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.a = Vector:new(x1, y1)
    obj.b = Vector:new(x2, y2)
    return obj
end

function Boundary:draw()
    love.graphics.line(self.a.x, self.a.y, self.b.x, self.b.y)
end

return Boundary
