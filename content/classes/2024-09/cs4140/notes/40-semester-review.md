---
title: "Notes: 40 Semester Review"
date: "2024-12-03"
---

## Where are we?

 - Last week of classes
 - Final Presentations: Friday, Dec 13 8:00 - 10:30 AM, this room.
 - We don't need 2.5 hours, so we'll use 9:00 - 10:30 am; be on time at 9.
 - Presentation assignments are posted. 

Next lecture:

 - Final meetings.


## Today: Semester Review


### Agile Dev

 - Upfront design doesn't usually make sense for software.
 - "If anyone knows how to do this, they've got the working software."
 - So instead the plan is to optimize for fast iteration.
 - And to figure out if each iteration work, it needs to be tested as
   quickly as possible.
 - The only person who can really evaluate whether the app is right is
   the customer.
 - So the key goal is to deliver a working program to the actual customer
   and get their feedback as frequently as possible.

Specific stuff:

 - Scrum - is a process that might help sometimetimes, but quicly devolves
   into so much ritual it misses the point.
 - Kanban Board - A neat way to keep track of what's happening and try to
   improve the process itself.


### Git & Github

 - Git is a distributed version control system.
 - It doesn't need a single centralized server.
 - But one can be convenient; Github is commonly used.
 - Github promotes one workflow: fork, feature branch, changes, pull
   request, code review, merge


### Web Development

Server:

 - You're writing an HTTP server
 - Can think of it as a function from request -> response
 - Frequently you've got a database for persistent state
 - Frameworks

Browser:

 - HTML / CSS / JavaScript
 - JavaScript can be simple, or complex and basically completely
   define the app UI.
 - Single page vs. multi-page app
 - Rendering / template library


### Taiga.io

 - Provides a Kanban board thing
 - Calls everything a "User Story"
 

### Actual User Stories

A scenario that can be enabled in software that:

 - Describes a plausible user who wants to do something.
 - Describes how the functionality would be tested.
 - Optimally, isn't too big to get a working version of in
   one development iteration. 


### Elixir & Phoenix

Elixir:

 - A functional programming language
 - Built on the Erlang VM
 - Good at I/O, string handling, concurrency.
 - Provides reliability features.
 - Which makes it solid for a web app, especially with
   realtime functionality through WebSockets.

Phoenix:

 - A web dev framework, providing all the basic stuff that
   a typical server-side web app needs.


### Web App Deployment

 - Need a server to deploy too. Modern VPSes are great.
 - Linux works pretty well on servers.
 - An app can be deployed to a dedicated user account for
   partial isolation; if isolation matters, it's worth thinking
   more.
 - App is a web server running on a high port behind a reverse proxy
   like Nginx
 - Where to build?
 - Assets?
 - Differences between dev and prod modes?


### Continuous Integration and Deployment

Automated Testing:

 - This helps catch bugs quickly.
 - It also prevents regressions - once you have a feature, you don't want that
   feature to code rot away as you make further changes.
 - CI means running the tests on every PR, which lets PRs get rejected if they
   fail tests.
 - Test coverage is a good thing to test for to avoid having CI not test your app.

Automated Deployment:

 - To double down on making sure you always have a working verison of your app, it's
   useful to deploy automatically.
 - If you're really dedicated, automatically deploy to production.
 - If you're a coward, set up a testing server to automatically deploy to.
 
 

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


### Next week: Final team meetings

