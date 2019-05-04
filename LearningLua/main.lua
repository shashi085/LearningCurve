require("physics")

local square = display.newRect(20, 20, 20, 20)
physics.start()
physics.addBody(square, "dynamic")
print ("hello world")


local square2 = display.newRect(40, 40, 40, 40)
physics.addBody(square2, "dynamic")

