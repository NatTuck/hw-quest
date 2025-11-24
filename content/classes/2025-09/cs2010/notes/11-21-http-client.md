---
title: "cs2010 Notes: 11-21 HTTP Client"
date: "2025-11-19"
---

## ComputerCraft HTTP Client

```lua
local args = { ... }
if #args ~= 1 then
 print("Needs an argument")
 return
end

local req = http.get(args[1])
-- readLine returns a line or nil
print(req.readAll())
req.close()
```

Plan:

- Create an "image" text file on Github. Two colors to start.
- Make code that downloads that file and then
  uses it as instructions to draw the image with two block colors.
- Parameterize it on file name.
- Make another image.
- Show both file names working.

```lua
local args = { ... }
if #args ~= 1 then
	print("Usage: draw <filename>")
	return
end

local filename = args[1]
local url = "https://raw.githubusercontent.com/NatTuck/patterns/refs/heads/main/" .. filename

print("Fetching " .. url)

local response = http.get(url)
if not response then
	print("Failed to fetch file")
	return
end

local content = response.readAll()
response.close()

-- Parse the content into lines
local lines = {}
for line in content:gmatch("[^\r\n]+") do
	table.insert(lines, line)
end

print("Image size: " .. #lines[1] .. "x" .. #lines)

-- Refuel the turtle
local function refuel()
	turtle.select(1)
	turtle.refuel(10)
	print("Current fuel: " .. turtle.getFuelLevel())
end

-- Select white block (slot 2)
local function selectWhite()
	turtle.select(2)
end

-- Select black block (slot 3)
local function selectBlack()
	turtle.select(3)
end

-- Place a block down
local function placeBlock()
	if not turtle.detectDown() then
		turtle.placeDown()
	end
end

-- Build one row of the image
local function buildRow(rowData, rowIndex)
	print("Building row " .. rowIndex)

	-- Move to the start of this row
	if rowIndex > 1 then
		turtle.turnLeft()
		turtle.forward()
		turtle.turnRight()
	end

	-- Build each pixel in the row
	for i = 1, #rowData do
		local pixel = rowData:sub(i, i)

		if pixel == "1" then
			selectWhite()
			placeBlock()
		elseif pixel == "0" then
			selectBlack()
			placeBlock()
		end

		-- Move to the next position
		if i < #rowData then
			turtle.forward()
		end
	end

	-- Return to the start of the row
	for i = 1, #rowData - 1 do
		turtle.back()
	end
end

-- Main build function
local function buildImage()
	refuel()

	-- Build each row
	for i, line in ipairs(lines) do
		buildRow(line, i)
	end

	print("Finished building image!")
end

buildImage()
```
