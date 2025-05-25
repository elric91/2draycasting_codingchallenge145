Vector = require("vector")
Boundary = require("boundary")
Ray = require("ray")
Particle = require("particle")

width = 400
height = 400
local walls = {}
local xoff = 0
local yoff = 100000


function love.load()
    success = love.window.setMode(width, height)
    for i=1,5 do
        local x1 = love.math.random(width)
        local y1 = love.math.random(height)
        local x2 = love.math.random(width)
        local y2 = love.math.random(height)
        table.insert(walls, Boundary:new(x1,y1, x2,y2))
    end
    table.insert(walls, Boundary:new(0,0, width,0))
    table.insert(walls, Boundary:new(width,0, width,height))
    table.insert(walls, Boundary:new(0,height, width, height))
    table.insert(walls, Boundary:new(0,0, 0, height))
    particle = Particle:new()
end

function love.update()
    particle:update(love.math.noise(xoff) * width, love.math.noise(yoff) * height)
    xoff = xoff + 0.01
    yoff = yoff + 0.01
end

function love.draw()
    for i, wall in ipairs(walls) do
        wall:draw()
    end
    particle:draw()
    particle:cast(walls)
end

