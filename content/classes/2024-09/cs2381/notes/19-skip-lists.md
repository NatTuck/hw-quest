---
title: "cs2381 Notes: 19 LogN and Skip Lists"
date: "2024-10-05"
---

Material:

 - Binary search on ArrayList
 - Skip lists

Core idea:

 - Searching through a list takes O(n) time.
 - Searching through a *sorted* list only needs to take O(log n) time,
   as long as you have some way to quickly jump to the middle of the
   unsearched part of the list.
