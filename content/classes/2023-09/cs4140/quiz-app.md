---
title: "Notes: Quiz App"
date: "2023-08-27"
draft: true
---

## Basic Concept

High school teachers create quizzes for students to take.

## Possible User Stories

 - As a Teacher, I want to create quizzes so that students can take them.
 - As a Teacher, I want to be able to share a quiz with a list of students.
   - Share link?
 - As a Student, I want to take a quiz I have received so I can get credit for it.
 - As a Student, I want to be able to see my score so I know how bad I did.
 - As a Teacher, I want to see quiz results so I can give students grades.

## Possible Data Model

DB Tables:

 - Users
   - Two kinds: Teacher, Student
   - Is that one or two tables? How about ORM models?
 - Quiz
   - belongs to Teacher
 - Question
   - belongs to Quiz
 - Answer
   - belongs to Student
   - belongs to Question

## Minimum Non-viable Product

 - Users resource
   - Name field
   - Teacher flag
 - Teachers can create quizzes
 - Teachers can create true/false questions, with correct answers
 - Students can answer questions for a quiz, then submit
 - Students can see their score
 - Teachers can see a report showing everyone's score
