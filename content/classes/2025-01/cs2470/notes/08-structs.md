---
title: "Lecture Notes: 08 Values and References"
date: "2025-02-17"
---


Stuff to cover:

 - Handling a linked list with a for loop.
 - Header files, include guards, modules.
 - Include quotes vs angle brackets.
 - The concept of "ownership", explicitly.
 - Passing a value by reference vs. by value.
 - Arrow vs dot in structs.
 - The "java" pattern (all refs).
 - Memory layouts of different structures.
 

```C
typedef struct game {
    char* team1_name;
    int team1_score;
    char* team2_name;
    int team2_score;
} game;

typedef struct season {
    game games[3];
} season;
```

 - Plymouth Panthers
 - Fitchburg Falcons
 - Massachusetts Maritime Buccaneers
 - Castleton Spartans



