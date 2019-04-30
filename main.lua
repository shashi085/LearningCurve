require("CircleShape")

local circle = nil
local physicsWorld = nil

function love.load()
    physicsWorld = love.physics.newWorld(0, 9.81*64, true)
    circle = CircleShape.new(love.graphics.getWidth()/2, 0, 100, physicsWorld)

    local floor = {}
    floor.body = love.physics.newBody(physicsWorld, love.graphics.getWidth()/2, love.graphics.getHeight())
    floor.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 10)
    floor.fixture = love.physics.newFixture(floor.body, floor.shape)
end

function love.draw()
    circle:draw()
end

function love.update(dt)
   physicsWorld:update(dt)
end

function love.keypressed(key)
    if(key == "left") then circle:moveLeft() end
    if(key == "right") then circle:moveRight() end
end