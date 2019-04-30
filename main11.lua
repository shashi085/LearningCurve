local circleX, circleY

function love.load()
    circleX = love.graphics.getWidth()/2
    circleY = love.graphics.getHeight()/2
end

function love.draw()
    love.graphics.circle("fill",circleX, circleY, 50, 32)
end

function love.update(dt)
    if (love.keyboard.isDown('a')) then
        circleX = circleX - 100 * dt
    end

    if (love.keyboard.isDown('d')) then
        circleX = circleX + 100 * dt
    end

    if (love.keyboard.isDown('w')) then
        circleY = circleY - 100 * dt
    end

    if (love.keyboard.isDown('s')) then
        circleY = circleY + 100 * dt
    end

end