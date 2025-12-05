---
title: "CS 2010: 12-05 Better Sample Final Exam"
date: "2025-12-03"
---

# CS 2010 Fall 2025 Better Sample Final

## Question 1: Hardware Review (25 points)

### 1a. Base Conversions (10 points)

Perform the following base conversions. Show your work.

* Convert 547 (base 8) to binary.
* Convert 10110100 (base 2) to hexidecimal.
* Convert 10110100 (base 2, 8 bit signed) to hexidecimal.
* Convert 255 (decimal) to hex and binary.

### 1b. Two's Complement (8 points)

For 8-bit two's complement:

| Decimal | 8-bit binary |
|---------|--------------|
| 42      |              |
| -42     |              |
| 255     |              |
| -128    |              |
|         | 11110000     |
|         | 01111111     |

### 1c. Boolean Logic (7 points)

Simplify: `Q = A'B + AC + A'BC'` using Boolean algebra or K-map.

### Write out the truth tables for

* A and B
* A or B
* A xor B

## What do the following computer components do?

* Storage disk
* RAM
* CPU
* Network adapter

## Question 2: Lua Basics (15 points)

What does each of the following Lua programs print? Show step-by-step execution.

### 2a

```lua
x = 5
if x > 3 then
  print("big")
else
  print("small")
end
```

### 2b

```lua
local x = 3
for i = 1,4 do
  x = x + i
  print(i .. ": " .. x)
end
```

### 2c

```lua
local x = 3
while x < 30 do
  print(x)
  if x < 10 then
    x = x * 5
  else
    x = x - 6
  end
end
```

### 4a. What does it print? (8 points)

**4a.1**

```lua
local x = 7
print(x)
```

**4a.2**

```lua
local x = 7
function foo()
  print(x)
end
foo()
```

**4a.3**

```lua
local x = 7
function foo()
  local x = 9
  print(x)
end
foo()
print(x)
```

4a.4

```lua
local x = 7
function foo()
  local x = 9
  x = x + 2
  print(x)
end
foo()
print(x)
```

## Question 5: Git and Github

ssh-keygen creates two files:

* ~/.ssh/id_ed25519
* ~/.ssh/id_ed25519.pub

Which one has the key we should add to our github account to
so we can push changes?

## Networking

What's the difference between "http" and "https" in a URL?
