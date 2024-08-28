---
title: "cs4140 Notes: 02 Agile Software Dev"
date: "2024-08-27"
---

# Hello Again

 - Course Site
 - Inkfish registration

## Extra Discussion

 - We want persistent chat.
 - How much do people hate Microsoft Teams?
 - Someone want to spin up a rocket.chat?
 
## Topics We'll See

 - Git and the Github Workflow
 - Agile Management with a Kanban Board
 - Web Development
   - Concepts
   - Lots of details for specific software we'll use
 - State Mangement
   - Long term: Database
   - Various shorter term considerations
 - Software Testing
   - Continuous Integration
 - Simple server admin
 - Application Deployment
   - Continuous Deployment
 - Some security considerations
 - Application scaling

## Agile Software Project Management

According to professional "Agile Consultants", the story starts like this:

"In the bad old days, there was Waterfalll..."

I talked a bit about bridges last class; "Waterfall" is a description of 
the engineering process to build a bridge:

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
