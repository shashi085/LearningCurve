-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

puzzle = require("Puzzle")

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

totalHeight = display.contentHeight
totalWidth = display.contentWidth
xCenter = totalWidth / 2
yCenter = totalHeight / 2



background = display.newImage("backgroundfree.jpg", xCenter, yCenter)
background:scale( 1, 1.5 )

puzzle = newPuzzle()

-- include the Corona "composer" module
--local composer = require "composer"

-- load menu screen
--composer.gotoScene( "menu" )