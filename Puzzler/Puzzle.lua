--
-- Created by IntelliJ IDEA.
-- User: shashi
-- Date: 2019-05-09
-- Time: 19:23
-- To change this template use File | Settings | File Templates.
--

--require("utils")
require("PuzzlesSet")

function newPuzzle()
    self = {}
    local puzzleBox = {}
    local answerBox = {}
    local charsBox = {}
    local convertStringToCharTable
    local getRamdonChars
    local getEmptyCharTable
    local getNextQuestionAndAnswer
    local askNewPuzzle
    local displayNewPuzzle
    local removeFromGroup
    local getAnswerBoxTray
    local displayInBoxes
    local shuffleTable

    self.answerGroup = {}
    self.answerTrayCharCount = 16
    self.puzzleGroup = {}
    self.questions = {"hello", "bello", "trello", "kello"}
    self.answers = {"asdf123123", "asdf123123", "asdf123123", "asdf123123" }
    self.PuzzleSet = newPuzzleSet()
    self.totalHeight = display.contentHeight
    self.availableHeight =  self.totalHeight
    self.totalWidth = display.contentWidth
    self.heightDivision = self.availableHeight / 10
    self.Ypadding = 20
    self.XPadding = 20
    self.charTrayGroupName = "charTrayGroup"
    self.answerTrayGroupName = "answerTrayGroup"
    self.currentQuestion = ""
    self.currentAnswer = ""
    self.correctAnswer = false


    self.xCenter = self.totalWidth / 2
    self.yCenter = self.totalHeight / 2

    puzzleBox.height = self.heightDivision * 7
    puzzleBox.YTop = 0
    puzzleBox.YBottom = puzzleBox.YTop + puzzleBox.height
    puzzleBox.width = self.totalWidth
    puzzleBox.xCenter = self.totalWidth / 2
    puzzleBox.yCenter = puzzleBox.height / 2

    self.puzzleBox = puzzleBox

    answerBox.height = self.heightDivision * 1
    answerBox.YTop = puzzleBox.YBottom
    answerBox.YBottom = answerBox.YTop + answerBox.height
    answerBox.width = self.totalWidth
    answerBox.xCenter = answerBox.width / 2
    answerBox.yCenter = (answerBox.YTop + answerBox.YBottom) / 2

    self.answerBox = answerBox

    charsBox.height = self.heightDivision * 2
    charsBox.YTop = answerBox.YBottom
    charsBox.YBottom = self.availableHeight
    charsBox.width = self.totalWidth
    charsBox.xCenter = self.totalWidth / 2
    charsBox.yCenter = (charsBox.YTop + charsBox.YBottom) / 2

    self.charsBox = charsBox

    function askNewPuzzle()
        local currentQuestion, currentAnswer = getNextQuestionAndAnswer()
        self.currentAnswer = currentAnswer
        self.currentQuestion = currentQuestion

        print("asking question: " .. currentQuestion)
        print("answer: " .. currentAnswer .. " with length: " .. string.len(currentAnswer))


        for i = table.maxn(self.puzzleGroup.answerTrayGroup), 1, -1 do
            self.puzzleGroup.answerTrayGroup[i].rect:removeSelf()
        end

        local answerTrayBoxLocations = getAnswerBoxTray(answerBox, string.len(currentAnswer))
        local answerTable = getEmptyCharTable(string.len(currentAnswer))

        for i,t in ipairs(answerTable) do
            print('Record',i)
            print('char',t)
        end

        local answerTrayGroup = displayInBoxes(answerTrayBoxLocations, Nil, self.answerTrayGroupName)
        self.puzzleGroup.answerTrayGroup = answerTrayGroup

        displayNewPuzzle(currentQuestion, currentAnswer)

    end

    function getNextQuestionAndAnswer()
        local index = math.random(1, table.maxn(self.PuzzleSet))
        local newRandomPuzzle = self.PuzzleSet[index]
        print ('returning: question:" '..newRandomPuzzle.question .. " answeR: " .. newRandomPuzzle.answer)
        return newRandomPuzzle.question, newRandomPuzzle.answer
        --
    end

    function displayNewPuzzle(puzzleString, answerString)

        self.puzzleGroup.puzzle.text = puzzleString

        local answerTray = self.puzzleGroup.answerTrayGroup
        for i = 1, table.maxn(answerTray), 1 do
            answerTray[i].rect.text = Nil
        end


        local answerCharsTable = convertStringToCharTable(answerString)
        local answerTableLength = table.maxn(answerCharsTable)
        local remainingLen = self.answerTrayCharCount - answerTableLength
        local randomCharsTable = getRamdonChars(remainingLen)
        local answerCharsFullTable = table.copy(answerCharsTable, randomCharsTable)
        local charBoxTrayTable = shuffleTable(answerCharsFullTable)

        local charTrayGroup = self.puzzleGroup.charTrayGroup --.displayChar .text

        if(answerCharsFullTable ~= Nil and table.maxn(charTrayGroup) ~= table.maxn(answerCharsFullTable)) then
            print("what the fuck bitch!")
        end

        for i = 1, table.maxn(charBoxTrayTable), 1 do
            local displayChar = charTrayGroup[i].displayChar
            local charToShow = charBoxTrayTable[i]
            displayChar.text = charToShow
            displayChar.isSelected = false
            displayChar.x = displayChar.xLocation
            displayChar.y = displayChar.yLocation
        end
    end




    function shuffleTable( t )
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

    local function findFirstEmptyBox(answerTrayGroup)
        print("findFirstEmptyBox: length of answer TrayGropup: " .. #answerTrayGroup)
        for i = 1, #answerTrayGroup, 1 do
            local box = answerTrayGroup[i].rect
            print ("findFirstEmptyBox: checking location: ".. i)
            if box.text == Nil then
                print("found it at loc: " .. i)
                return box
            else
                print("not found. content is: " .. box.text)
            end
        end
        return Nil
    end

    local function checkAnswerBoxFull(tray)
        for i = 1, #tray, 1 do
            local box = tray[i].rect
            print("checkAnswerBoxFull: checking location: ".. i)
            if box.text == Nil then
                return false
            end
        end
        return true
    end

    local function reconstructString(tray)
        local stringBox = {}
        for i = 1, #tray, 1 do
            local box = tray[i].rect
            if box.text ~= Nil then
                table.insert(stringBox, box.text)
            end
        end
        return table.concat(stringBox)
    end

    local function aCharWasTapped(event)
        print (" a character belonging to group: " .. event.target.charGroupName .. " was pressed that has " .. event.target.text .. " in it and isSelected: " .. tostring(event.target.isSelected))
        local charTapped = event.target
        if(charTapped.isSelected == false) then
            local firstEmptyBox = findFirstEmptyBox(self.puzzleGroup.answerTrayGroup)
            if firstEmptyBox~= Nil then
--                transition.to(charTapped, {time=500, x=firstEmptyBox.centerX, y=firstEmptyBox.centerY})
                print("moving charTapped from " .. charTapped.x .. " to " .. firstEmptyBox.x)
                charTapped.x = firstEmptyBox.x
                charTapped.y = firstEmptyBox.y
                charTapped.answerBox = firstEmptyBox
                print ("type of charTapped: " .. type(charTapped))
                firstEmptyBox.text = charTapped.text
                charTapped.isSelected = true

                --check if we have an answer
                if(checkAnswerBoxFull(self.puzzleGroup.answerTrayGroup)) then
                    print("answer tray got full. checking result")
                    local proposedAnswer = reconstructString(self.puzzleGroup.answerTrayGroup)
                    print("proposed answer: "..proposedAnswer)
                    if proposedAnswer == self.currentAnswer then
                        print("we got a winner!!")
                        timer.performWithDelay(1000, askNewPuzzle)
                    end
                end


            end
        else
            charTapped.x = charTapped.xLocation
            charTapped.y = charTapped.yLocation
            charTapped.answerBox.text = Nil
            charTapped.answerBox = Nil
            charTapped.isSelected = false
        end
    end

    function convertStringToCharTable(str)
        local charTable = {}
        strLen = string.len(str)

        for i = 1, strLen, 1 do
            charTable[i] = string.sub(str, i, i)
        end
        return charTable
    end


    function getRamdonChars(count)
        local randomCharTable = {}
        for i = 1, count, 1 do
            local randomChar = string.char(math.random(97, 97+25))
            table.insert(randomCharTable, randomChar)
        end
        return randomCharTable
    end


    function getEmptyCharTable(count)

        local emptyCharTable = {}
        for i = 1, count, 1 do
            table.insert(emptyCharTable, "")
        end
        return emptyCharTable

    end


    function getAnswerBoxTray(answerBox, charCount)

        if charCount > 16 then
            print("what the fuck bitch!")
        end

        local boxLocations = {}
        local TotalXoffset = self.XPadding + (answerBox.width - self.XPadding) % charCount
        local boxWidth = (answerBox.width - TotalXoffset) / charCount
        local leftOffset = math.floor(TotalXoffset / 2)
        local currentX = leftOffset
        local currentShelfTopY = answerBox.YTop + self.Ypadding
        local currentShelfBottomY = answerBox.YBottom - self.Ypadding
        local boxHeight = currentShelfBottomY - currentShelfTopY


        for i = 1, charCount, 1 do
            local box = {}
            box.centerX = currentX + math.floor(boxWidth / 2)
            box.centerY = math.floor(currentShelfTopY + currentShelfBottomY) / 2
            box.width = boxWidth
            box.height = boxHeight
            table.insert(boxLocations, box)
            currentX = currentX + boxWidth
        end

        print("==answer holder tray dimensions")
        for i = 1, charCount, 1 do
            print("  " .. boxLocations[i].centerX .. "  " .. boxLocations[i].centerY ..
                    "  " .. boxLocations[i].width .. "  " .. boxLocations[i].height)
        end

        return boxLocations

    end


    local function getCharsBoxTray(charsBox, charCount)
        local boxLocations = {}
        local TotalXoffset = self.XPadding + (charsBox.width - self.XPadding) % charCount --(self.totalWidth % self.answerTrayCharCount)
        local boxWidth = math.floor((charsBox.width - TotalXoffset) / charCount)
        local leftOffset = math.floor(TotalXoffset / 2)
        local currentX = leftOffset
        local currentShelfTopY = charsBox.YTop + self.Ypadding
        local shelfBottomY = charsBox.YBottom - self.Ypadding
        local currentShelfBottomY = math.floor((currentShelfTopY + shelfBottomY) / 2)
        local boxHeight = currentShelfBottomY - currentShelfTopY


        --setting up top shelf
        for i = 1, charCount, 1 do
            local box = {}
            box.centerX = currentX + math.floor(boxWidth / 2)
            box.centerY = math.floor((currentShelfTopY + currentShelfBottomY) / 2)
            box.width = boxWidth
            box.height = boxHeight
            table.insert(boxLocations, box)
            currentX = currentX + boxWidth
        end

        currentX = leftOffset
        currentShelfTopY = currentShelfBottomY
        currentShelfBottomY = shelfBottomY

        --setting up botton shelf
        for i = 1, charCount, 1 do
            local box = {}
            box.centerX = currentX + math.floor(boxWidth / 2)
            box.centerY = math.floor((currentShelfTopY + currentShelfBottomY) / 2)
            box.width = boxWidth
            box.height = boxHeight
            table.insert(boxLocations, box)
            currentX = currentX + boxWidth
        end

        for i = 1, charCount*2, 1 do
            print("  " .. boxLocations[i].centerX .. "  " .. boxLocations[i].centerY ..
                    "  " .. boxLocations[i].width .. "  " .. boxLocations[i].height)
        end

        return boxLocations
    end

    function removeFromGroup(group)

        for i = table.maxn(group), 1, -1 do
            group[i].rect:removeSelf()
        end
    end

    function displayInBoxes(boxLocations, characterArray, groupName)
        local answerGroup = {}
        if(characterArray ~= Nil and table.maxn(boxLocations) ~= table.maxn(characterArray)) then
            print "what the fuck!"
        end

        local paint = { 1, 0, 0.5 }
        for i = 1, table.maxn(boxLocations), 1 do
            local boxGroup = {}
            box = boxLocations[i]
            local rect = display.newRoundedRect(box.centerX, box.centerY, box.width, box.height, 10)
            rect.stroke = paint
            rect.strokeWidth = 4
            rect:setFillColor(255,255,255,0)

            if characterArray ~= Nil then
                charTodisplay = characterArray[i]
                rect.text = charTodisplay
                local displayChar = display.newText(charTodisplay, box.centerX, box.centerY, "Helvetica", 48)
                displayChar.xLocation = box.centerX
                displayChar.yLocation = box.centerY
                displayChar.isSelected = false
                displayChar.charGroupName = groupName
                displayChar:setFillColor(1, 0, 0)
                displayChar:addEventListener("tap", aCharWasTapped)
                boxGroup.displayChar = displayChar
            end
            boxGroup.rect = rect
            table.insert(answerGroup, boxGroup)
        end

        return answerGroup
    end

    local function setupPuzzle()

        local index = math.random(1, 4)
        self.currentQuestion = self.questions[index]
        print("asking question: " .. self.currentQuestion)

        local paint = { 1, 0, 0.5 }
        --setup puzzle box and add puzzle text--
        local puzzleBoxRect = display.newRect(puzzleBox.xCenter, puzzleBox.yCenter, puzzleBox.width, puzzleBox.height)
        puzzleBoxRect.stroke = paint
        puzzleBoxRect.strokeWidth = 4
        puzzleBoxRect:setFillColor(255,255,255,0)
        self.puzzleBoxRect = puzzleBoxRect

        local puzzle = display.newText(self.currentQuestion, puzzleBox.xCenter, puzzleBox.yCenter, puzzleBox.width-10, puzzleBox.height-10, "Helvetica", 48)
        puzzle:setFillColor(1, 1, 0)
--        self.puzzleBox = puzzle
        self.puzzleGroup.puzzle =  puzzle
        --setup puzzle box done

        --setup charBox and add chars
        self.currentAnswer = self.answers[index]
        print("answer: " .. self.currentAnswer .. " with length: " .. string.len(self.currentAnswer))
        local answerCharsTable = convertStringToCharTable(self.currentAnswer)
        local answerTableLength = table.maxn(answerCharsTable)
        local remainingLen = self.answerTrayCharCount - answerTableLength
        local randomCharsTable = getRamdonChars(remainingLen)
        local answerCharsFullTable = table.copy(answerCharsTable, randomCharsTable)


        local charBoxRect = display.newRect(charsBox.xCenter, charsBox.yCenter, charsBox.width, charsBox.height)
        charBoxRect.stroke = paint
        charBoxRect.strokeWidth = 4
        charBoxRect:setFillColor(255,255,255,0)
        local charBoxTrayTable = shuffleTable(answerCharsFullTable) ---- {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p" }
        local charTrayBoxLocations = getCharsBoxTray(charsBox, table.maxn(charBoxTrayTable) / 2) --getAnswerTray()
        local charTrayGroup = displayInBoxes(charTrayBoxLocations, charBoxTrayTable, self.charTrayGroupName)
        --setup charBox was finished


        --setup answerBox and add answerBoxes
        local answerBoxRect = display.newRect(answerBox.xCenter, answerBox.yCenter, answerBox.width, answerBox.height)
        answerBoxRect.stroke = paint
        answerBoxRect.strokeWidth = 4
        answerBoxRect:setFillColor(255,255,255,0)

        local answer = self.answers[index]
        print("answer: " .. answer .. " with length: " .. string.len(answer))

        local answerTrayBoxLocations = getAnswerBoxTray(answerBox, string.len(answer))
        local answerTable = getEmptyCharTable(string.len(answer))

        for i,t in ipairs(answerTable) do
            print('Record',i)
            print('char',t)
        end

        local answerTrayGroup = displayInBoxes(answerTrayBoxLocations, Nil, self.answerTrayGroupName)
        --setup answerBox don

        self.puzzleGroup.answerTrayGroup = answerTrayGroup
        self.puzzleGroup.charTrayGroup = charTrayGroup
        askNewPuzzle()

    end

    setupPuzzle()

    local function resetPuzzle()

    end

    return self
end

