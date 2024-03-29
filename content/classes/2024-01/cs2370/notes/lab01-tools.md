---
title: "cs2370 Notes: Lab 01 - Introducing our Tools"
date: "2024-01-22"
---

**Lab Rules**

 - No personal electronics; they can be in the room, but not out. If
   you need to check a text message, step out of the lab room.
 - Only approved web resources:
   - Inkfish ( https://inkfish.homework.quest/ )
   - The course website ( https://homework.quest/ )
   - The two textbooks linked from the course website.
   - The official documentation for Python or the specific
     libraries we are using for a given lab.

I agree that these rules are obnoxious. But the only way to practice
something is to do it, and we're trying to practice writing code from
scratch without external help.


**Lab Workstations**

 - Log in with your USNH username.
 - These have fixed software which will be limiting, and they
   don't reliably persist settings.
 - I recommend using OneDrive, but not allowing it to take over your
   local Documents folder.


**Register for Inkfish**

 - Go to https://inkfish.homework.quest/
 - Type in your school email address under Get a Password. The @usnh.edu one.
 - The email will show up in your spam folder within 10 minutes.
 - Pick a long enough password.
 - Hit "all classes" and request access to this class.

**First Teams, Pair Programming**

 - You will usually be working with a partner in lab.
 - Today we'll assign them as people get registered on Inkfish.

Pair programming works as follows:

 - Both partners sit in front of one computer.
 - One person is the pilot - they get the keyboard. The other person
   is the copilot.
 - The pilot types, the co-pilot watches and provides helpful feedback
   (or at least calls out typos).
 - After each section of the assignment, the partners switch roles.

Why?

 - Harder to get distracted.
 - Harder to stay stuck.
 - If one partner doesn't understand something, they have someone to
   discuss it with.
 - Better chance to catch non-obvious mistakes.

**Content we need for this lab**

 - A Python program is a series of statements (think "commands")
 - The Python interpreter (a program called "python") executes the
   program in such a way that it looks like the statements run in
   order.
 - The print function prints something out.

```python
print("Input x")
text = input("> ")
x = int(text)
print("x + 4 =", x + 4)
```

This example has a several new compliications:

 - The "input" function reads a line of text from the user.
 - Execution of the program stops until the user finishes typing and presses enter.
 - We can store things in variables, giving them a name so we can refer to them later.
 - We have two different types of value: strings and integers.
 - Functions sometimes accept more than one argument, seperated by commas.

Interactive examples:

```
>>> 3 + 2
>>> a = 3
>>> a + 2

>>> "3" + 2
>>> int("3")
>>> '3'
>>> str(3)
>>> 2 + int("3")
>>> "2" + str(3)

>>> print("hi")
>>> print("a", "b")
>>> print("a", 3, "b")
>>> type('hi')
>>> type(3)
>>> type(3 / 2)
```

**The Mechanics of Completing a Lab**

(Walk through completing the first part of Lab 01)

 - Download the starter code.
 - Figure out where the download went.
   - Probably your "Downloads" directory.
 - Move the starter code somewhere more appropriate.
 - If it's an archive, unpack it.
 - Figure out what you're supposed to submit.
   - Typically a single Python source file.
   - Rename that file, if possible, to include the names
     of the partners working on it.
 - Open that file in IDLE.
 - Figure out what to do.
   - Do it.
   - Remember to swap pilot/co-pilot roles after each section.
 - Run the tests locally, if possible.
 - Submit the file to Inkfish.
   - Wait for the tests to run.
   - If the tests fail, fix and resubmit.

Important tactical suggestions:

 - Run the tests first. Then submit the starter code.
 - Read both the assignment and the tests to figure out what
   you're supposed to do and how it's being autograded.
 - Do one problem at a time.
   - Then run the tests.
   - Then submit your work.
 

**Lab 01**

Now you do the (rest of the) lab.
