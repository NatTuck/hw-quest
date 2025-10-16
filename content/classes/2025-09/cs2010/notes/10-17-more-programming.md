---
title: "cs2010 Notes: 10-17 More Programming"
date: "2025-10-15"
---

## Tree Chopper

Then go open it in a real editor (folder,
minecraft/saves/World/computercraft/...)

```lua
more = true
while more do
  more, data = turtle.inspect()
  if string.find(data.name, "log") then
    turtle.dig()
    turtle.digUp()
    turtle.up()
  end
end
```

Let's walk through this:

- This is a text file.
- It contains a sequence of "lines of code", which are almost but not quite
  the same as lines of text.

Example (this is two "lines of code" and three "lines of text"):

```lua
a = 3 +
    5
print(a)
```

Example (two lines of code, three lines of text):

```lua
print("giant")

print("squid")
```

- When we run the program (a text file containing code), each
  line of code is run in order, top to bottom.
- Some lines of code do something right away.
- Other lines of code are part of multi-line statements, and
  do something conditionally, repeatedly, or eventually.

So how does this work?

- We have a boolean variable, more, that starts as true.
- The next line is "while", which has special rules.
- While repeats its body (the code between do and the matching end)
  as long as the condition (here "more") is true.
- Then we inspect, seeing what block is in front of the turtle.
- If the block is a log, we chop it and go up.
- The "if" line is special: we execute the code in the body only
  if the condition is true.
- Repeat until there's no more block in front of the turtle.

## Simple Sequence

```lua
print(1)
print(2)
print(3)
```

That's interesting.

- Three lines of code, no tricks, they run in order.
- We're doing the same thing three times.
- We're using an incrementing number.
- We want a for loop.

```lua
for i = 1,3 do
  print(i)
end
```

- Again, three lines of code.
- Now we've got a for / end pair and an indented middle line.
- A "for" block has special rules:
  - All the lines until the matching "end" are our loop body.
  - Loop body is typically indented.
  - The loop body runs several times, once for each value in the
    range 1,3 (inclusive).
  - Those values are assigned to the variable i for each loop body
    execution.

```lua
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
turtle.dig()
turtle.forward()
```

We're ding the same thing three times again, so we can use a for loop again. We
still need to name the variable though. The name "_" is typically used for
variables that we don't plan to use.

```lua
for _ = 1,3 do
  turtle.dig()
  turtle.forward()
end
```

Let's dig a rectangle of size N * M.

```lua
n = 3
m = 5

for _ = 1,n do
  turtle.digDown()
  turtle.forward()
end

turtle.turnLeft()

for _ = 1,m do
  turtle.digDown()
  turtle.forward()
end

turtle.turnLeft()

for _ = 1,n do
  turtle.digDown()
  turtle.forward()
end

turtle.turnLeft()

for _ = 1,m do
  turtle.digDown()
  turtle.forward()
end
```

That's a lot of repeated, almost identical code.

We need the key trick of computer programming: Abstraction

We want to take things that are almost the same, name them,
and name the differences.

## Functions

Our tool for that in Lua is a function

```lua
n = 3
m = 5

function digTrench(x) do
  for _ = 1,m do
    turtle.digDown()
    turtle.forward()
  end
end

digTrench(n)
turtle.turnLeft()
digTrench(m)
turtle.turnLeft()
digTrench(n)
turtle.turnLeft()
digTrench(m)
```
