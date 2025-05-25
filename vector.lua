local Vector = {}

function Vector:new(x, y)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.x = x
    obj.y = y
    return obj
end

function Vector.__add(v1, v2)
    return Vector:new(v1.x + v2.x, v1.y + v2.y)
end

function Vector.__sub(v1, v2)
    return Vector:new(v1.x - v2.x, v1.y - v2.y)
end

function Vector.__tostring(v)
    return  ("(" .. v.x .. ", " .. v.y ..")")
end

function Vector:normalize()
    local l = (self.x * self.x + self.y * self.y)^.5
    if l == 0 then
        self.x, self.y = 0, 0
    else
        self.x, self.y = self.x / l, self.y / l
    end
end

function Vector.fromAngle(angle)
    return Vector:new( math.cos(angle), - math.sin(angle))
end

function Vector.dist(a, b)
    local c1 = b.x - a.x
    local c2 = b.y - a.y
    return math.sqrt(c1*c1 + c2*c2)
end

return Vector
