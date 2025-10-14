---
title: "cs2010 Notes: 10-13 Programming Intro"
date: "2025-10-13"
---

In lab last week, we used Turtles in Minecraft.

We're going to be spending most of the rest of the semester trying to
get turtles to do more and more complex stuff.

## Using a Computer

Every turtle is a ComputerCraft computer, which pretends to be an old-style
computer with a command line interface.

This is both a quaint affectation and practical for an introduction to
programming. "Real" computers aren't exactly like ComputerCraft, but the
commands are basically the same as a modern command line interface.

Commands:

- ls : List files
- edit (name) : Edit a text file
- mv (src) (dst) : Move / rename a file
- rm (name) : Remove file
- go (directions and counts) : Move the Turtle
- (blargh) - Run the program from the file (blargh).lua

## Lua REPL

Turtles use a programming language called Lua.

- Not the #1 most popular programming language.
- Kind of popular as an extension language, especially for
  stuff like UIs in video games.
- Similar to other languages. Very much like JavaScript. A bit less
  like Python or Ruby. Not like C or Java.
- I could rant about why any common language is awful (or great). Lua
  is fine.

Start lua from the CLI with `lua`.

### Data

```
lua> 1
lua> 1 + 1
lua> 3 * 4
lua> "hello"
lua> print("hello")
lua> print(1)
lua> "hello" + 3
lua> "hello " .. "there"
lua> "hello " .. 3
lua> 3 + "5"
```

Any programming language has some basic data types that it supports. Here we've
got numbers and strings.

Note that there are operations on numbers and strings, and (specific to a given
language) how the operations handle mixing input types.

Once we have *values*, we can stick them in variables.

```
lua> a = 5
lua> a + 5
lua> c = a * 3
lua> c
```

There's one more kind of value in Lua that we need to deal with, called
a table:

```
lua> goat = {name = "Bob", color="green"}
lua> goat.name
```

### Effects

Data is fun, but we'd like our computer programs to do stuff.

We get extra fun with turtles because doing stuff can involve interacting with
the Minecraft game world.

Turtle stuff lives on an object called "turtle".

```
lua> turtle.dig()
lua> turtle.digDown()
lua> turtle.detect()
lua> a, b = turtle.inspect()
lua> b.name
lua> turtle.select(3) # Put some blocks in slot 3
lua> turtle.place()
lua> turtle.placeDown()
```

### Looping

For loop:

```
lua> for i = 1,5 do turtle.dig(); turtle.forward(); end
```

## Lua Program

In the REPL, we get to type in one line of code at a time.

A program is a text file containing a bunch of lines of code.

dig5.lua

```lua
for i = 1,5 do
  turtle.dig()
  turtle.forward()
end
```

Let's build a program to cut down trees.

```
edit lumber.lua
print("lumber")
```

Then go open it in a real editor (folder,
minecraft/saves/World/computercraft/...)

```lua
x, data = turtle.inspect()
if string.find(data.name, "log") then
  turtle.dig()
  turtle.digUp()
  turtle.up()
end
```
