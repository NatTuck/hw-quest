---
title: "cs4250 Notes: 11-13 Exam2 Review"
date: "2026-11-13"
---

## Upcoming Meetings

Next Week:

- Monday, Nov 16: Project Work Day
- Wednesday, Nov 18: Lecture (how to pick a dev board?)
- Friday, Nov 20: Exam 2

Thanksgiving Week:

- Monday, Nov 23: Project Work Day

## What's on the Exam

- Realtime OS Scheduling 
- Pipelining
- Caches
- Multiprocessors and GPUs

## Scheduling

- We create a static set of tasks, each with a priority.
- Higher numbers are higher priority (in freertos, in linux it's the other way)
- The scheduler is a function that runs the highest priority
ready task
- We start the first task by running the scheduler
- Timers run on the timer interrupt (which the hardware clock does at fix intervals)




