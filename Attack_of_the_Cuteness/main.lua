-- Project: Attack of the Cuteness Game
-- http://MasteringCoronaSDK.com
-- Version: 1.0
-- Copyright 2013 J. A. Whye. All Rights Reserved.
-- "Space Cute" art by Daniel Cook (Lostgarden.com) 

-- housekeeping stuff

physics = require("physics")
require("MainScreen")
require("Background")
require("Enemy")
require("Planet")
physics.start()
physics.setGravity( 0, 9.8 )

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
local shipCollided
local background
local mainScreen
local ClearMainScreenLoadNextScene
local startGame
local health = 5
local shipTimer
local enemyTime = 3500
local decrementEnemyTime
local shipSpawnTimer = 3000


function load()
	background = newBackground()
	mainScreen = newMainScreen()
	mainScreen.text:addEventListener("tap", ClearMainScreenLoadNextScene)
end

function ClearMainScreenLoadNextScene(event)
	print("clear screen called here")
	display.remove(mainScreen)
	startGame()
	return true
end




function spawnEnemy()
	local enemy = newEnemy()
	physics.addBody(enemy, "dynamic", {radius = 20})
	enemy:addEventListener("tap", shipSmash)
	enemy.collision = shipCollided
	enemy:addEventListener("collision", enemy)
	enemy.trans = transition.to(enemy, {x=centerX, y=centerY, time=enemyTime, onComplete=planetDamage})
end

function shipSmash(event)
	local obj = event.target
	display.remove(obj)
	audio.play(sndKill)
	transition.cancel(event.target.trans)
	score = score + 28
	scoreTxt.text = "Score: " .. score

--	spawnEnemy()
end


function shipCollided(self, event)
	if event.phase == "began" then
		print("ship collided")
		local obj = event.target
		local otherObj = event.other
		display.remove(obj)
		audio.play(sndKill)
		transition.cancel(event.target.trans)
		score = score + 28
		scoreTxt.text = "Score: " .. score

		if otherObj.name == "bullet"  then
			display.remove(otherObj)
			transition.cancel(event.other.trans)
			score = score + 28
			scoreTxt.text = "Score: " .. score
		end
--		spawnEnemy()
	end
		return true
end


function startGame()
	timer.resume(shipTimer)
	timer.resume(enemyTimeTimer)
	print("start Game was called")
	score = 0
	planet = newPlanet()
	physics.addBody(planet, "static")
	planet.collision = planetDamage
	planet:addEventListener("collision", planet)
	scoreTxt = display.newText("Score: 0", 0, 0, "Helvetica", 22)
	scoreTxt.x = centerX
	scoreTxt.y = display.screenOriginY + 10
	spawnEnemy()
end

--function hitPlanet(obj)
--	display.remove(obj)
--	planetDamage()
--	audio.play(sndBlast)
--end

function planetDamage(event)
--	if event.phase == "began" then
		print ("planet damaged")
		display.remove(event.target)
		audio.play(sndBlast)

		local function backToNormal(obj)
			planet.xScale = 1
			planet.yScale = 1
			planet.health = planet.health -1
			enemyTime = 3500
			shipSpawnTimer = 3000
			print("planet health: ".. planet.health)
			if(planet.health < 1) then
				timer.cancel(shipTimer)
				timer.cancel(enemyTimeTimer)
			end
		end
		transition.to(planet, {time=200, xScale=1.2, yScale=1.2, alpha=1, onComplete=backToNormal})
--	end
--	return true
end

function decrementEnemyTime()
	enemyTime = enemyTime - 200
	shipSpawnTimer = shipSpawnTimer - 100
	print ("new speed: " .. enemyTime)
	print ("new shipSpawnTimer: "..shipSpawnTimer)
end



load()

shipTimer = timer.performWithDelay(3000, spawnEnemy, 0)
enemyTimeTimer = timer.performWithDelay(2000, decrementEnemyTime, 0)
timer.pause(shipTimer)
timer.pause(enemyTimeTimer)



