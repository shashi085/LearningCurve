--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-04
-- Time: 23:09
-- To change this template use File | Settings | File Templates.
--


function newBackground()
    self = {}
    local centerX = display.contentCenterX
    local centerY = display.contentCenterY

    self.background = display.newImage("background.png")
    self.background.y = 130
    self.background.aplha = 0
    transition.to(self.background, {time=2000, alpha=1, y=centerY, x=centerX})
    return self
end




