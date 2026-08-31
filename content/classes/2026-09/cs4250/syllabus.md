---
title: "CS 4250 Fall 2026: Syllabus"
date: "2026-08-01"
---

{{< lead >}}
Computer Architecture (3 credits)
{{< /lead >}}

[&larr; Back to Course Site](../)

<blockquote>
<b>Course Catalog:</b><br>
Fundamental concepts of computer design using a quantitative,
performance-oriented approach. Topics include: measurement of performance
instruction sets design; hardwired and micro-coded processor design;
pipelining; memory hierarchy; I/O. Assembly language programming is studied
through a series of short projects. Falls.
<br>Prereq: CS 2225
</blockquote>

# Course Info

- Instructor: Nat Tuck
- Email: \<<nathaniel.tuck@plymouth.edu>\>
- Office: D&M 305
- Lecture: Monday, Wednesday, Friday @ 10:10-11:00am in D&M 417
- Final Exam: Friday, Dec 18 @ 8:00-10:30am ([schedule](
https://www.plymouth.edu/sites/default/files/media/2026-03/Fall%202026%20Final%20Exam%20Schedule.pdf))
- Course Site: <https://homework.quest/> click "cs4250"

{{< officehours "2026-09" >}}

## Student Learning Outcomes

Successful students will:

- Understand how concrete hardware is structured and operates at the
  transistor, gate, datapath, and system levels.
- Be able to read and write RISC-V assembly language and understand the
  relationship between assembly, ISA design, and hardware implementation.
- Be able to interface a microcontroller with peripherals using protocols
  such as GPIO and I2C.
- Understand processor pipelining, instruction-level parallelism, and
  memory hierarchy design trade-offs.
- Be able to run and program both a general-purpose OS (Linux) and a
  real-time OS (FreeRTOS) on embedded hardware.
- Be able to design, build, and present a working embedded systems project
  using a RISC-V development board with peripherals.

## Texts

No required textbook.

## Required Materials

- An SG2000-based microcontroller dev board with at least 256MB of RAM
  (e.g. Milk-V Duo S or Pine64 Oz64)
- An I2C display
- An input device or sensor (e.g. microphone, button, potentiometer)

## Grading

<table class="table table-striped">
  <thead>
  <tr>
   <td>Thing</td>
   <td>Weight</td>
 </tr>
  </thead>
  <tbody>
 <tr>
   <td>Homework</td>
   <td>20</td>
 </tr>
  <tr>
   <td>Labs</td>
   <td>20</td>
 </tr>
  <tr>
   <td>Exams (2)</td>
   <td>20</td>
 </tr>
  <tr>
   <td>Semester Project</td>
   <td>40</td>
 </tr>
  </tbody>
</table>

**Semester Project**

You will build a working project using a RISC-V development board with
peripherals plugged in. You will propose a project in week 3 and begin
implementation in week 4. The project culminates in a final presentation
during finals week.

**Labs**

Hands-on lab assignments working directly with the SG2000 hardware,
including GPIO control, I2C device communication, bit-level register
manipulation, and NPU usage.

**Homework**

Regular written assignments covering background reading and conceptual
topics in computer architecture.

**Exams**

There will be two exams covering material from the first and second thirds of
the course. The final third of the course will be exam-free so we can focus
on the semester project.

**Letter Grades**

&ge; 93 &rarr; A, &ge; 90 &rarr; A-, <br>
&ge; 87 &rarr; B+, &ge; 83 &rarr; B, &ge; 80 &rarr; B-, <br>
&ge; 77 &rarr; C+, &ge; 73 &rarr; C, &ge; 70 &rarr; C-, <br>
&ge; 67 &rarr; D+, &ge; 63 &rarr; D, &ge; 60 &rarr; D-, <br>
else (&lt; 60) &rarr; F

# Tentative Schedule

{{< schedule >}}

<tr>
 <td>1</td>
 <td>Aug 31</td>
 <td>Intro to Architecture; Order Your Stuff</td>
 <td></td>
</tr>
<tr>
 <td>2</td>
 <td>Sep 07&nbsp;†</td>
 <td>Electronics: Resistors, Diodes, Transistors</td>
 <td>Lab: GPIO</td>
</tr>
<tr>
 <td>3</td>
 <td>Sep 14</td>
 <td>Linux on the SG2000</td>
 <td>Project Proposals</td>
</tr>
<tr>
 <td>4</td>
 <td>Sep 21</td>
 <td>Instruction Set Architectures; RISC-V Assembly</td>
 <td>Lab: Direct Bit Twiddling</td>
</tr>
<tr>
 <td>5</td>
 <td>Sep 28</td>
 <td>Review; Exam 1</td>
 <td>Exam 1</td>
</tr>
<tr>
 <td>6</td>
 <td>Oct 05</td>
 <td>FreeRTOS on the SG2000</td>
 <td></td>
</tr>
<tr>
 <td>7</td>
 <td>Oct 12</td>
 <td>Device I/O</td>
 <td>Lab: I2C Display</td>
</tr>
<tr>
 <td>8</td>
 <td>Oct 19</td>
 <td>The 8051 on the SG2000</td>
 <td></td>
</tr>
<tr>
 <td>9</td>
 <td>Oct 26</td>
 <td>Processor Datapath, Pipelining, ILP; Memory Hierarchy</td>
 <td>Lab: CPU Data &amp; Memory Hierarchy</td>
</tr>
<tr>
 <td>10</td>
 <td>Nov 02</td>
 <td>Review; Exam 2</td>
 <td>Exam 2</td>
</tr>
<tr>
 <td>11</td>
 <td>Nov 09&nbsp;†</td>
 <td>Multiprocessors</td>
 <td>Lab: SG2000 NPU</td>
</tr>
<tr>
 <td>12</td>
 <td>Nov 16</td>
 <td>Final Project Work</td>
 <td></td>
</tr>
<tr>
 <td>13</td>
 <td>Nov 23&nbsp;‡</td>
 <td>Thanksgiving Recess — No Class</td>
 <td></td>
</tr>
<tr>
 <td>14</td>
 <td>Nov 30</td>
 <td>Bonus Topic</td>
 <td></td>
</tr>
<tr>
 <td>15</td>
 <td>Dec 07</td>
 <td>Final Project: Polish</td>
 <td></td>
</tr>
<tr>
 <td>-</td>
 <td>Dec 14-18</td>
 <td>Finals Week</td>
 <td>Final Project Presentations</td>
</tr>

{{< /schedule >}}

- † No class on Monday, Sep 07 (Labor Day) or Wednesday, Nov 11 (Veterans Day)
- ‡ No class Wednesday, Nov 25 through Friday, Nov 27 (Thanksgiving Recess)

{{< syllabus-common "2026-09" >}}
