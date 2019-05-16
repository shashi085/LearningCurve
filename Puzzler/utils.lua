--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-11
-- Time: 12:19
-- To change this template use File | Settings | File Templates.
--

function newutils()
    self = {}

    self.shuffleTable =  function( t )
        math.randomseed( os.time() )  -- Seed the pseudo-random number generator

        if ( type(t) ~= "table" ) then
            print( "WARNING: shuffleTable() function expects a table" )
            return false
        end

        local j

        for i = #t, 2, -1 do
            j = math.random( i )
            t[i], t[j] = t[j], t[i]
        end
        return t
    end

    self.aCharWasTapped = function(event)
        print (" a character belonging to group: " .. event.target.charGroupName .. " was pressed that has " .. event.target.text .. " in it")
        if event.target.charGroupName == self.charTrayGroupName then

        end

    end

    self.convertStringToCharTable = function(str)
        local charTable = {}
        strLen = string.len(str)

        for i = 1, strLen, 1 do
            charTable[i] = string.sub(str, i, i)
        end
        return charTable
    end


    self.getRamdonChars = function(count)
        local randomCharTable = {}
        for i = 1, count, 1 do
            local randomChar = string.char(math.random(97, 97+25))
            table.insert(randomCharTable, randomChar)
        end
        return randomCharTable
    end


    self.getEmptyCharTable = function(count)

        local emptyCharTable = {}
        for i = 1, count, 1 do
            table.insert(emptyCharTable, "")
        end
        return emptyCharTable

    end

    return self

end