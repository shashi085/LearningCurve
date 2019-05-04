--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-04
-- Time: 19:11
-- To change this template use File | Settings | File Templates.
--


function newPlanet()
    local self = display.newImage("planet.png")
    self.x = display.contentCenterX
    self.y = display.contentCenterY
    self.alpha = 1
    self.health = 5
    return self
end




