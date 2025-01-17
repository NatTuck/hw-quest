---
title: "Notes: 41 Final Meeting"
date: "2024-12-05"
---

## Where are we?

 - Final Presentations: Friday, Dec 13 8:00 - 10:30 AM, this room.
 - We don't need 2.5 hours, so we'll use 9:00 - 10:30 am; be on time at 9.
 - See Inkfish for presentation reqs.


## Remainder of Semester Review

### Functional Programming

Functional programming is a style that focuses on data and
transforming it into other data. This contrasts with OO, which focuses
on modeling objects that combine data with behavior.

Two core concepts: Immutable data, pure functions

Immutable data:

 - Think of data in the program as values.
 - Once a value is constructed, it can't be changed.
 - If you want a different value, that means making a new one.
 - This makes a bunch of things easier to reason about, since broad
   classes of bug become impossible.
 - This sounds less efficient, but in terms of asymptotic complexity
   doesn't typically make things much worse - sometimes adds a factor
   of log(N), but can even allow for optimizations like caching.

Pure functions:

 - A pure function takes some input values and, based on that,
   deterministically produces an output value.
 - It doesn't do anything else. No side effects, no accessing shared state.
 - Pure functions are easy to test - you just check that they produce the
   expected output for given inputs.
 - Pure functions are safe to run repeatedly or not at all, since they
   don't have side effects. This can be useful for optimziations (like
   caching function results) or techniques like transactions where
   code needs to be retried.
 - No useful program can be 100% pure functions, because doing anything
   would be a side effect, but some programs get pretty close.
   
Elixir is a functional language: 

 - Doesn't allow values to be mutated.
 - Does allow side effects, but programs tend to be mostly built from
   pure functions.
 - Common patterns heavily rely on explicitly managing any sort of shared
   or persistent state (e.g. with GenServer).


### CRUD Resources / REST

A common pattern for web apps:

 - Data is stored in a SQL database.
 - Each type of data gets its own table in the DB, which stores a
   collection of records.
 - Each type of data is called a resource.
 - The application performs four five basic operations on each
   resource: list, show, create, update, delete.
 - This can be handled by a base URL (e.g. http://app.com/images )
   with slight variations for each operation.
   - GET /images lists all images
   - GET /images/5 shows image with id=5
   - POST /images creates a new image
   - PUT /images/5 updates an image
   - DELETE /images/5 deletes an image
 - This pattern provides a reasonable basic structure for a web app,
   and also makes sense for a JSON API, which could be used by
   JS code on a web page or for machine-to-machine operations.



### React.js

JS-heavy web apps typically need some way to render dynamic web
content. This can be done with a template system, but React provides
a neat variation on that theme.

React implements a pattern called functional reactive programming:

 - Your app has some sort of state, typically a single complex value.
 - You write a (pure) render function to transform the state into what
   the user currently sees.
 - For each action the user can take, you write a pure function to
   take the old state and the action and product a new state, which
   triggers a re-render.

This pattern makes the most sense for video games (think of a 3D
rendering engine that draws a new frame every 1/60th of a second), but
works well for web pages.

The render function outputs HTML, so React provides a HTML-in-JS
template system called JSX.

The rest of React is a bunch of patterns and optimizations to make
this work well for dynamic web apps.


### Phoenix: DeadViews, Channels, LiveViews

The default sequence for a Phoenix app is:

 - Get HTTP request
 - Run controller action, which might query database and calculates
   the values needed for the template.
 - Use template to generate HTML
 - Send HTTP response

That means either a page-load for every interaction if the response
is HTML or at least a request for every interaction if the request
was from JS and the response is JSON.

Being able to keep open a connection is sometimes nicer, so Phoenix
provdes a Channels API that does that. But then you need some sort
of client-side rendering - e.g. a JS rendering framework like React.

Everyone knows it'd be better to write all Elixir code, so LiveView
allows partial template renders on the server which can be pushed to
the browser over a channel and then updated with minimal/built-in JS.


### Elixir: Transient State with GenServer

 - Long-term state goes in the DB.
 - Single page, in browser state is managed in JS.
 - But if you want state that surivives a page load or is accessible
   to multiple users but doesn't last forever, it's nice to store it
   in the app server.
 - Elixir provides some tools for this like GenServer
 - This was used for Multiplayer Hangman



### NextJS

 - Sometimes you want to get really complicated with your JS.
 
 
### Cross-Origin Policy and CORS

 - Sometimes you want to load stuff from another host
   using JS.


### Dependencies

 - Licensing
   - Think about open source
   - Paying license fees for deps doesn't just cost money
 - Security
   - I didn't get to do this rant.
   - find . -name "package.json" | wc -l
   - find . -name "package.json" -exec grep -nH author {} \;
   - All of those authors could inject code into your app.


### Performance

 - HTTP response time components
 - Profile
 - Optimize
 - Other performance considerations


### Scaling and Replication

 - You pretty quickly want more than one server
 - For performance
 - For reliablity
 - That's easy, except for the DB


### Next week: Final Presentations

