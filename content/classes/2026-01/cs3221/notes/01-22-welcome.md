---
title: "Notes: 01-22 Intro Lab"
date: "2026-01-20"
---

Welcome to Analysis of Algorithms

## First, Quick Syllabus

- Three lectures / 1 lab a week.
- This is traditionally taught mostly as a math class, and we're
  using a math-style (online) textbook.
- We've got labs, and we'll be doing both mathy stuff and code.
- Grades: Attendance, Problem Sets, Labs, Exams
- Labs: No personal electronics or unapproved websites
- Don't use LLMs to generate code and then use that code in your solution unless
an assignment tells you to.
- Exception: Using an LLM to help generate LaTeX math syntax for HW is okay, one
line at a time, when you already know what the math should look like.
- Do ask LLMs questions. Major chatbots have definitely read all the algo
textbooks and can help a lot, including with how to phrase proof arguments.
Prompt with things like "don't give me the proof but...".

## Setup: Describing and Counting

I like the initial examples in the textbook:

```
99 bottles of beer on the wall, 99 bottles of beer.
Take one down, pass it around, 98 bottles of beer on the wall.
 
98 bottles of beer on the wall, 98 bottles of beer.
Take one down, pass it around, 97 bottles of beer on the wall.
  
...

1 bottle of beer on the wall, 1 bottle of beer.
Take one down, pass it around, no more bottles of beer on the wall.
```

Now, let's abstract slightly:

```python
def beer_song(nn):
  text = ""

  for ii in range(nn, 0, -1):
    text += f"""
    {ii} bottles of beer on the wall, {ii} bottles of beer.
    Take one down, pass it around, {ii-1} bottles of beer on the wall.
    """

  return text
```

We have:

- Clearly described an algorithm for generating the song text.
- Now that it's clearly described, we can analyze it.
- Simplest analysis is counting stuff.
- Simplest thing to count: How long is the resulting song.

```python
def beer_song_length(nn):
  return len(beer_song(nn))
```

That's an integer -> integer function. But its kind of funny looking. How can
we write it with normal integer math body?

The numbers themselves vary in length and make it a little complex, so let's simplify
and just count "words".

```python
import re

def beer_song_length(nn):
  return len(re.split(r"\W+", beer_song(nn)))
```

How many words each time through the loop? 24

How many times through the loop? nn

So the function we want is this one:

$$ b(x) = 24x $$
