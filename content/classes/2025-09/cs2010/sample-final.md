---
title: "CS 2010 Sample Final Exam"
date: "2025-12-05"
---

# CS 2010 Fall 2025 Sample Final Exam

**Instructions:**
- Answer all questions completely.
- Write your name on each page.
- No computers, phones, or AI assistance.
- Bring pencil, paper notes, and a calculator.
- 120 minutes.

**Total: 100 points**

## Question 1: Hardware Review (25 points)

### 1a. Base Conversions (10 points)
Perform the following base conversions. Show your work.

1a-i. Convert (547)_8 to binary.

1a-ii. Convert (101101)_2 to hexadecimal.

1a-iii. Convert 255 (decimal) to hex and binary.

### 1b. Two's Complement (8 points)
For 8-bit two's complement:

| Decimal | 8-bit binary |
|---------|--------------|
| 42      |              |
| -42     |              |
|         | 11110000     |
|         | 01111111     |

### 1c. Boolean Logic (7 points)
Simplify: `Q = A'B + AC + A'BC'` using Boolean algebra or K-map.

## Question 2: Lua Basics (15 points)

What does each of the following Lua programs print? Show step-by-step execution.

### 2a.
```lua
x = 5
if x > 3 then
  print("big")
else
  print("small")
end
for i = 1, 3 do
  print(i)
end
```

### 2b.
```lua
local a = {1, 2, 3}
for i, v in ipairs(a) do
  print(i .. ": " .. v)
end
```

## Question 3: Turtle Movement and Dead Reckoning (20 points)

### 3a. Predict Path (10 points)
A turtle starts at (0,0) facing north (positive Z).

Predict final position after:
```
turtle.forward()
turtle.turnRight()
turtle.forward()
turtle.dig()
turtle.up()
turtle.forward()
```

### 3b. Write Turtle Code (10 points)
Write a Lua function `dig_trench(n)` that digs down and moves forward `n` blocks.

## Question 4: Functions and Scope (15 points)

### 4a. What does it print? (8 points)
```lua
function outer()
  local x = 10
  function inner()
    print(x)
    x = 20
  end
  inner()
  print(x)
end
outer()
```

### 4b. Fix the Bug (7 points)
This tree chopper doesn't return home. Add dead reckoning.
```lua
function chop_tree()
  while turtle.inspectUp() do
    turtle.digUp()
    turtle.up()
  end
end
-- Add position tracking and return
```

## Question 5: Git and Collaboration (10 points)

Describe the steps to collaborate on a GitHub repo:
1. Fork the repo.
2. ...
3. Submit pull request.

What command resolves a merge conflict after `git pull`?

## Question 6: Networking and Web (15 points)

### 6a. HTTP Client (10 points)
What does this print if the URL returns "hello\nworld"?
```lua
local resp = http.get("https://example.com/data")
if resp then
  print(resp.readLine())
  print(resp.readLine())
  resp.close()
end
```

### 6b. Web Concepts (5 points)
Explain DNS -> IP -> TCP -> HTTP in a web request.

---
*End of exam*
