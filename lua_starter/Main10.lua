----displayString="hello world"
----
----function love.draw()
----    love.graphics.print(displayString, 400, 300)
----end
--
----print (" what is your name fucker?")
----
----local player = io.read()
----
----print("welcome to the game fucker " .. player)
----
----
----
--
--currentX = 0
--
--function love.draw()
--    love.graphics.setColor(255, 0, 0, 255)
--    love.graphics.line(0,0,640,480)
--
--    love.graphics.setColor(0,0,255,255)
--    love.graphics.line(0, love.graphics.getHeight()/2,
--                       love.graphics.getWidth()/2, love.graphics.getHeight()/2 )
--
--    love.graphics.setColor(0, 255, 0, 123)
--    love.graphics.polygon('fill',
--        {currentX + 0, 100,
--        currentX + 200, 100,
--        currentX + 200, 300,
--        currentX + 0, 300
--        }
--
--    )
--
--end
--
--
--function love.update(dt)
----    print("update called here!")
--    if( currentX < love.graphics.getWidth()) then
--        currentX = currentX + 100 * dt
--    else
--        currentX = 0
--    end
--
--end
--
--function love.load()
----    print("some message chuck norris")
--    love.graphics.setBackgroundColor(255, 255, 255, 255)
--end
--
--function love.quit()
--    love.graphics.print("good bye", 100, 100)
--end

local imageFile
local frames = {}
local activeFrame
local currentFrame = 1

function love.load()
    imageFile = love.graphics.newImage("planestuff.png")
    frames[1] = love.graphics.newQuad(0, 0, 128, 64, imageFile:getDimensions())
    frames[2] = love.graphics.newQuad(128, 0, 128, 64, imageFile:getDimensions())
    frames[3] = love.graphics.newQuad(0, 64, 128, 64, imageFile:getDimensions())
    frames[4] = love.graphics.newQuad(128, 64, 128, 64, imageFile:getDimensions())
    activeFrame = frames[currentFrame]
end

function love.draw()
    love.graphics.draw(imageFile, activeFrame,
        love.graphics.getWidth() / 2 -
            select(3, activeFrame:getViewport()) / 2
        ,
        love.graphics.getHeight()/2 - --32
            select(4, activeFrame:getViewport()) / 2
    )
end

local elapsedTime = 0

function love.update(dt)
    elapsedTime = elapsedTime + dt

    if(elapsedTime > 1) then
        if(currentFrame < 4) then
            currentFrame = currentFrame + 1
        else
            currentFrame = 1
        end
        activeFrame = frames[currentFrame]
        elapsedTime = 0
    end
end






























