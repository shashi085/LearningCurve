--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-04
-- Time: 22:10
-- To change this template use File | Settings | File Templates.
--


function newMainScreen(nextScreenFunctionArg)
    local self = display.newGroup()
    self.text = display.newText("", 0, 0, "Helvetica", 24)

    local centerX = display.contentCenterX
    local centerY = display.contentCenterY

    self.planet = display.newImage("planet.png")
    self.planet.x = centerX
    self.planet.y = display.contentHeight
    self.planet.alpha = 1
    self:insert(self.planet)

    local function showStartUpText()
        print("show sartuptext was called")
        self.text.text = "Tap here to start. Protect the planet!"
        self.text.x = centerX
        self.text.y = display.contentHeight - 30
        self.text:setFillColor(255, 255, 0)
        self:insert(self.text)
    end

    local function showTitle()
        print("show title was called")
        self.gameTitle = display.newImage("gametitle.png")
        self.gameTitle.alpha = 0
        self.gameTitle:scale(4, 4)
        self:insert(self.gameTitle)
        transition.to(self.gameTitle, {time=500, alpha=1, xScale=1, yScale=1, onComplete=showStartUpText})
    end

    transition.to(self.background, {time=2000, alpha=1, y=centerY, x=centerX})

    transition.to(self.planet, {time=2000, alpha=1, y=centerY, x=centerX, onComplete=showTitle})


    return self
end
