--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-04
-- Time: 23:12
-- To change this template use File | Settings | File Templates.
--

function newEnemy()
    self = {}
    self = display.newImage("beetleship.png")
    self.name = "enemy"
    if(math.random(2) == 1) then
        self.x = math.random(-100, -10)
    else
        self.xScale = -1
        self.x = math.random(display.contentWidth + 10, display.contentWidth + 100)
    end

    self.y = math.random(display.contentHeight)
    return self
end


