-- Project: Attack of the Cuteness Game
-- http://MasteringCoronaSDK.com
-- Version: 1.0
-- Copyright 2013 J. A. Whye. All Rights Reserved.
-- "Space Cute" art by Daniel Cook (Lostgarden.com) 

-- housekeeping stuff

display.setStatusBar(display.HiddenStatusBar)

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local scoreTxt
local spawnEnemy
local gameTitle
local sndKill = audio.loadSound("boing-1.wav")
local sndBlast = audio.loadSound("blast.mp3")
local sndLose = audio.loadSound("wahwahwah.mp3")
local score = 0
local hitPlanet
local planetDamage
local planet

local function createPlayScreen()
	local background = display.newImage("background.png")
	background.y = 130
	background.aplha = 0
	background:addEventListener("tap", shipSmash)
	
	planet = display.newImage("planet.png")
	planet.x = centerX
	planet.y = display.contentHeight 
	planet.alpha = 1
	planet:addEventListener("tap", shipSmash)
	--planet.numHits=
	
	transition.to(background, {time=2000, alpha=1, y=centerY, x=centerX})

	local function showTitle()
		gameTitle = display.newImage("gametitle.png")
		gameTitle.alpha = 0
		gameTitle:scale(4, 4)
		transition.to(gameTitle, {time=500, alpha=1, xScale=1, yScale=1})
		startGame()
	end
	
	
	transition.to(planet, {time=2000, alpha=1, y=centerY, x=centerX, onComplete=showTitle})
end

function spawnEnemy()
	
		local enemy = display.newImage("beetleship.png")
		enemy:addEventListener("tap", shipSmash)
		
		if(math.random(2) == 1) then
			enemy.x = math.random(-100, -10)
		else
			enemy.y = math.random(display.contentWidth + 10, display.contentWidth + 100)
		end
		
		enemy.y = math.random(display.contentHeight)
		enemy.trans = transition.to(enemy, {x=centerX, y=centerY, time=3500, onComplete=hitPlanet})
		
end

function shipSmash(event)
	local obj = event.target
	display.remove(obj)
	audio.play(sndKill)
	transition.cancel(event.target.trans)
	score = score + 28
	scoreTxt.text = "Score: " .. score
	spawnEnemy()
	return true
end

function startGame()
	score = 0
	local text = display.newText("Tap here to start. Protect the planet!", 0, 0, "Helvetica", 24)
	text.x = centerX
	text.y = display.contentHeight - 30
	text:setTextColor(255, 254, 0)
	local function goAway(event)
		display.remove(event.target)
		text = Nil
		spawnEnemy()
		display.remove(gameTitle)
		scoreTxt = display.newText("Score: 0", 0, 0, "Helvetica", 22)
		scoreTxt.x = centerX
		scoreTxt.y = display.screenOriginY + 10
		return true
	end
	
	text:addEventListener("tap", goAway)
	
end

function hitPlanet(obj)
	display.remove(obj)
	planetDamage()
	audio.play(sndBlast)
end

function planetDamage()
	
	local function goAway(obj)
		planet.xScale = 1
		planet.yScale = 1
		--planet.alpha = planet.numHits = 10
	end
	
	transition.to(planet, {time=200, xScale=1.2, yScale=1.2, alpha=1, onComplete=goAway})
	
end



createPlayScreen()



