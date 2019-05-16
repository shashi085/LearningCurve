--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-10
-- Time: 17:30
-- To change this template use File | Settings | File Templates.
--


function newGameUtils()

    self = {}

    local function convertStringToCharTable(str)
        local charTable = {}
        strLen = string.len(str)

        for i = 1, strLen, 1 do
            charTable[i] = string.sub (s, i, i)
        end
        return charTable
    end


end

