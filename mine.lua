local args = {...}
local err = 0

syntax_err = 1
too_large_err = 2
no_chest_err = 3
chest_id = "minecraft:chest"
max_size = 128

local function getError()
	if 	err == syntax_err then
		print("Will dig front and right\nPlace next to chest,\notherwise will stop when full\nSyntax:\nmine <mineLen>\n")
	elseif err == too_large_err then
		print("Requested area too large!\nMax size is "..tostring(max_size).."\b")
	elseif err == no_chest_err then
		print("Chest not found\n")
	end
end

local mineLen = tonumber(args[1])
if mineLen == nil then err = syntax_err
elseif mineLen > max_size then err = too_large_err end
getError()

local x = 0, y = 0, z = 0
local dir = 0 --0 front 1 right 2 back 3 left

local function turnRight()
	turtle.turnRight()
	dir = math.mod(dir + 1,4)
end

local function turnLeft()
	turtle.turnLeft()
	dir = math.mod(dir - 1,4)
end

local function turnAround()
	turnLeft()
	turnLeft()
end

local function turn(d)
	if d == math.mod(dir - 1, 4) then
		turnLeft()
	elseif d == math.mod(dir + 1, 4) then
		turnRight()
	elseif d == math.mod(dir + 2, 4) then
		turnAround()
	end
end

local function goHoriz(destx, desty)
	turn('f')
	while y != desty do
		if y > desty then 
			turtle.back() 
			y = y - 1
		else 
			turtle.forward()
			y = y + 1
		end
	end
	turn('r')
	while x != destx do
		if x > destx then 
			turtle.back() 
			x = x - 1
		else 
			turtle.forward()
			x = x + 1
		end
	end
end

local function goVert(destz)
	while z != destz do
		if z > destz then 
			turtle.down() 
			z = z - 1
		else 
			turtle.up()
			z = z + 1
		end
	end
end

local function isInventoryFull()
	local i = 1
	while i <= 16 do
		if turtle.getItemCount(i) == 0 then return false end
	end
	return true
end

local function storeInChest()
	local i = 0
	while i < 4 do
		local succ, data = turtle.inspect()
		if data[1] == chest_id then
			local j = 1 
			while j <= 16 do
				turtle.select(j)
				turtle.drop()
				j = j + 1
			end
			break
		else turnRight() end
		i = i + 1
	end
end

local function digSquare(lenx, leny)
	
end