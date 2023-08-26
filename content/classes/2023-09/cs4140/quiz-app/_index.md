---
title: "CS4140: Quiz App"
---

## Basic Concept

Teachers create quizzes for students to take.



## User Stories

 - As a Teacher, I want to create quizzes so that students can take them.
 - As a Teacher, I want to be able to share a quiz with a list of students.
   - Share link?
 - As a Student, I want to take a quiz I have recieved so I can get credit for it.
 - As a Teacher, I want to see quiz results so I can give 


## Data Model

DB Tables:

 - Users
   - Two kinds: Teacher, Student
 - Quiz
   - belongs to Teacher
 - Question
   - belongs to Quiz
 - Answer
   - belongs to Student
   - belongs to Question

## Versions

 - Quizon - Python/Django
 - Quizby - Ruby/Rails
 - Quizix - JS/Remix

...

 - Quizir - Elixir/Phoenix
 - Quizet - Rust/Rocket
 - QuizKit - Clojure/Kit
