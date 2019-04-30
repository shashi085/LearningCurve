local music

local volume = 0.5

function love.load()

    love.audio.setVolume(volume)
    music = love.audio.newSource("mario.mp3", "queue")
    music:play()
    soundEffect = love.audio.newSource("Bill_clinton.mp3", "static")

end

function love.keypressed(key)
    if(key == "down") then
        if(volume >= 0 ) then volume = volume - 0.1 end
    end

    if(key == "up") then
        if(volume <= 1 ) then volume = volume + 0.1 end
    end

    if(key == "space") then
        soundEffect:stop()
        soundEffect:play()
    end

    if(key == "p") then
        if(music:isPlaying()) then music:pause()
        else music:play()
        end
    end



    print("update called here!")

    love.audio.setVolume(volume)

end