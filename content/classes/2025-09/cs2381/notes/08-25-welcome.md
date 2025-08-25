---
title: "cs2381 Notes: 08-25 Welcome"
date: "2025-08-23"
---

- This is CS 2010, Data Structures and Intermediate Programming
- I am Nat Tuck
  - Call me Nat, Tuck, Prof Tuck, Dr Tuck
  - Not Mr Tuck, that's incorrect formal address in an academic context.

**What's This Class**

- Data Structures: How can we store complex data efficiently?
- Intermediate Programming: How can we write programs that are several hundred
or even a thousand lines of code and have them work?

**Attendance**

- Today I'll be taking attendance manually.
- Starting on Friday, we'll be using a tool called Inkfish to take attendance.
Bring a device and punch in the code in the first 5 minutes of class or you
lose attendance points.
- Get at least one device (phone works) signed into Inkfish and signed up for
the class before Friday.

**Course Site and Syllabus**

- My web site is https://homework.quest/
- Go there, and then click CS 2381
- Let's look at the syllabus.

**Lab Tomorrow**

- We'll be setting up our lab software and then doing some programming.

**Homework 1**

- Will be introduced in lab tomorrow.
- Due next Monday at Midnight.
- Typing practice.
- A bunch of programming exercises.

**Aider Demo**

LLMs exist. They can be useful to help with programming.

You can do some simple programming with web chat interfaces. They're really
good to help understand error messages.

But they're even more useful if they can see and directly edit the source code
in your project. There are several useful tools for that, but I'm going to show
you one that works nicely with the workflows I recommend: aider.

Now, the goal of this class is for you to learn to write programs yourself, with
the skills and knowledge that you've personally learned in your own brain.

But an excellent way to learn how to write is by reading and discussing, and
LLMs can help you do that. So let's do an example of that.

Let's write a quick command line tic-tac-toe program in Java and see how that
goes.

```
$ mkdir tictactoe
$ cd tictactoe
$ git init .
$ aider
aider> /add TicTacToe.java
aider> Write a simple command-line tic-tac-toe program where the opponent makes
random legal moves.
```


Now we can compile and run our program manually:

```
$ javac TicTacToe
$ java TicTacToe
```

Let's look at that code.

This is Java. It looks a lot like other languages. If you've only done Python,
then there are a couple big differences:

- Everything is in a class.
- All executable statements must be in a method in a class.
- There are types everywhere.

Some more relevant details:

- Every program has a main class. Here that's TicTacToe.
- Execution starts at the main method.
- Within a method, code executes statement by statement, top to bottom.
- Let's walk through it.

Now let's make it more complicated. It's be nice to use a build tool:

```
aider> /add pom.xml TicTacToe.java
aider> Write a maven config where we can run the program with mvn compile exec:java
exec:java
aider> /run mvn compile exec:java
(fix the directory issue)
...
```


