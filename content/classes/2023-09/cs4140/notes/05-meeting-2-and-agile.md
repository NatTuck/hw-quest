---
title: "cs4140 Notes: 05 Meeting 2 and Agile"
date: "2023-09-07"
---

## Next.js vs Remix.js

**For the JavaScript team**

I suggested next.js in your feedback, but even with Next.js you'll
need at least one more piece to have a complete full stack framework:
a DB library. It looks like the expected ORM library is called Prisma.

Remix looks like it provides a better startup with it's "stacks", but
then it looks like you'll have to do some work to plug it into a
server (maybe Express?) for a VPS deployment.

Once I know what you're doing, I'll have to spin up a test app and go
through the process so I can help with everything.

**Rails Team**

This startup stuff is pretty straightforward. You'll get to have some
fun when you realize you need to add a browser-side JS framework.

# Attendence

## Team Meeting

We're going to spend 15 minutes on this, then I'm going to ramble
about "Agile" for the rest of the period.

 - Pick notetaker
 - What's on this weeks report templates?
 - For each member:
   - What have you done?
 - Anything need discussion? 
   - Design questions?
   - Administrative choices?
 - Does everyone have stuff to do?

## Agile Software Project Management

According to professional "Agile Consultants", the story starts like this:

"In the bad old days, there was Waterfalll..."

"Waterfall" is a description of the engineering process to build a bridge:

 - First you collect requirements (where? how big? what's going to
   cross it? do ships need to fit under it? etc)
 - Then you have archetects and engineers do a design on paper
 - You double check the design to make sure it meets the requirements
   and is possible and efficient to build using the planned
   construction materials and techniques
 - After the design is complete, construction workers build the bridge
   exactly to the design

One thing that makes this work pretty well is that bridges are very
well understood, as are the materials and techniques to build one.

A process like this works pretty well for some types of software.
Specifically, if the software is reasonably simple, solves a
well-defined problem, needs to be nearly 100% reliable, and there's
plenty of time and money to available to build it.

A good example of this is software for spacecraft. You've got millions
of dollars and several years to write a five thousand line program
that needs to work perfectly and can't be patched once deployed.

But for more typical software projects this runs into problems right away:

 - Nobody knows what the requirements are.
   - They'll change during the project.
   - You'll discover new ones as you work.
 - In many cases, nobody's built a program like this before. Or if
   they have, they haven't shared what they learned in the process. If
   there were a standard program to do the job, you wouldn't be
   building a new one.
 - The person who knows the most about the requirements - the
   customer - will need help to see how that maps to software. This
   involves having the developers talk to the actual customer, not
   just at the beginning but continuously.

### Agile

The core idea of Agile is to lean in to the idea that software
development is a process of discovery rather than traditional up-front
engineering.

**Agile Manifesto**

An early formulation is the "Agile Manifesto"[1], which says software
projects should value:

 - Individuals and interactions over processes and tools.
 - Working software over comprehensive documentation.
 - Customer collaboration over contract negotiation.
 - Responding to change over following a plan.
 
[1] https://agilemanifesto.org/

**Kanban**

Kanban comes from outside the software world. Specifically, this
process was developed at Toyota to build cars.

It turns out that some of the same criticisims of up-front engineering
that apply to software also apply to a production line. Up front
engineering is good to build the first car, but Toyta was going to
keep building cars indefinately. This meant that it's possible to
learn from building today's car how to do better at building cars
tomorrow.

Since Toyota was trying to improve their process, the developed the
Kanban board - a technique to allow everyone to visualize the process
as it happened.

So the point of a Kanban board isn't just first order - to manage
building cars or software. It's also second order - to try to find
process improvements.

**Scrum**

A frequent question is: This Agile stuff is nice and all, but what are
we supposed to do?

Scrum is a concrete set of procedures to follow to try to get the
benefits of the Agile ideas. When do you talk to the customer? How do
you get working software? How do you get work done if you're
responding to change?

In Scrum, you divide development up in to one or two week "sprints".
For a sprint:

 - The team starts with a working program.
 - Each team member has tasks to work on.
 - Everyone completes their tasks.
 - That work is merged together into a new working program.
 - There are specific meetings and stuff.
 - There are administrative team members with roles like talking to
   the customer and assigning tasks.
 
This can work well or this can work poorly. It can make it easier for
managers to micromanage. It certainly makes a lot of money for
professional Scrum Consultants.

If you don't have a working program with new stuff after each sprint,
if sprints regularly extend longer than two weeks, or the developers
never talk directly to the custoemr, that's a bad sign for a Scrum
setup.

## What are we doing in this class?

Our plan is to be vaguely agile.

 - We're going to use a Kanban board for collaborative planning. 
 - We're going to try to talk to real customers once we move to
   main projects.
 - We're going to try to do continuous integration and deployment so
   we always have a working (and deployed) program.
