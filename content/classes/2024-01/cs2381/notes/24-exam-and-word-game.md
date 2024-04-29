---
title: "cs2381 Notes: 24 Exam, Word Game"
date: "2024-04-28"
---


First, let's do the [Sample Final](
https://homework.quest/classes/2024-01/cs2381/sample-final/).

Next, let's look at [HW13](
https://homework.quest/classes/2024-01/cs2381/sample-final/).

Key points:

 - HW13 uses a Kotlin library, so VSCode leaves us with red squiggles.
 - Network code is innately asynchronous. This requires some execution
   sequence compromise: threads, callbacks, etc.
 - This uses callbacks - your code won't run in order.
 - This uses a JSON decoder - note the type handling.
 - We're going to try to build a solution in class that explores at
   least some of the ideas.
 
