---
title: "cs4140 Notes: 08 Framework Layouts"
date: "2023-09-14"
---

## HTTP Request/Response Sequence

**User clicks external link or types in URL**

 1. Browser sends HTTP request to server.
 1. There's probably a reverse proxy, which uses the HTTP Host header
    to route your request to your application HTTP server.
 1. App server uses routing mechanism to send request to handler. This
    routing mechanism generally considers:
     - Path
     - HTTP Method
 1. The handler is logically a function which takes an HTTP request
    and produces an HTTP response.
 1. Common kinds of HTTP response:
     - Success (HTTP 2xx)
       - A web page (HTML)
       - Serialized data (JSON)
       - Multimedia files (jpg, mp4)
       - Just a confirmation (e.g. you said DELETE, we did it)
     - A redirect (3xx)
     - Bad request errors (4xx)
     - Server errors (5xx)

**HTTP Requests in Rails**

We type in "/jokes"

Router:

 - config/routes.rb
 - ```rails routes```

So GET /jokes => jokes#index

That's a method called index in app/controllers/jokes_controller.rb

That method does two things:

 - Calls Joke.all
 - Puts the result in @jokes

The Joke class is a "model", and abstracts over the jokes database
table. It's defined in app/models/joke.rb

Looking in there: it's empty.

If we wanted to add business rules about data we'd put them here,
like validations (e.g. a joke must contain at least two capitol letters.)

The methods for Joke are defined by the ActiveRecord library and by
the schema. The schema is in db/schema.rb

So Joke.all reads all the records from the jokes table and transforms
each one into a Joke object with a field per column.

So we get a list of Joke's and put the result in @jokes. That @ is an
instance variable of our JokesController object which was instantiated
to handle the request.

The next thing that implicitly happens is that a "view" is rendered.

The view for an jokes#index method is in app/views/jokes/index.html.erb

And that's the template for the page that's generated. You'll note the
use of @jokes - all instance variables from the controller are available
in the template.

Some stuff is missing. That's in the layout: 
app/views/layouts/application.html.erb

New joke is jokes#new - same pattern.

Create joke is POST /jokes, which auto-routes to create.

Delete joke is DELETE to /jokes/[id], etc.

**HTTP Requests in Next**

We type in "/jokes"

Router:

 - Implicit based on paths under /app
 - In this case, /app/jokes - we find page.js not route.js

That file is is like our *view* in Rails.

We've got a layout here too: app/layout.js

The "controller" logic can go in our component for simple actions, as
long as we're careful about the React requirements of idempotence and
being cheap.

"Model" logic is over in our lib/jokes file, and that can enforce
business rules like validations.

More complex controller logic - like for POST or DELETE calls - goes
in a route.js file, which isn't a React component and therefore
doesn't mix controller and view responsibilities.

## HTML Rendering 

So our server sent a HTTP response containing a full HTML page. Now
what?

 1. Browser gets HTML page.
 1. Parses, starts rendering.
     - Browser can display partially rendered pages and even have
       them be interactive. This makes the complete execution model
       for web pages weird.
 1. External assets (JS, CSS, images) trigger more HTTP requests.
 1. JavaScript is executed synchronously with HTML parsing/rendering.
     - Show alert example
     - That includes *external* JS unless you "defer".
 1. Whenever this process blocks, or when everything is loaded, the JS
    engine for the tab goes into an event loop waiting for events to
    handle.

That raises a couple more questions.

**Where do those assets come from?**

In Rails:

 - Images are in app/assets/images
 - Styles are in app/assets/stylesheets - possibly compiled from scss.
 - JavaScript is in app/javascript

Generally, both styles and javascript are each bundled up into a
single file. Conceptually this needs to load once and then it's cached
for further requests. This does mean that your app needs some
mechanism to control what code runs on what page - next provides that
by clear default (a page is one React component), while I'm less sure
of the default mechanisms in modern Rails.

In Next:

 - The client-side JS is extracted from the app code.
 - CSS can be embedded.
 - Arbitrary static assets go in /public

## Local Navigation

When a user clicks a link to a different page within the app, the
mechanism may be slightly different.

Traditionally, this worked just like an external link:

 - Browser makes an HTTP request
 - Gets a page response
 - Renders the new page

A common new plan though is:

 - JavaScript makes an async HTTP request without navigating
   away from the current page.
 - The server sends back new content for a portion of the page,
   either the whole body or a single smaller component.
 - JavaScript patches the new portion into the current page.

Next definitely does the new thing by default. Rails may too,
if "turbolinks" are enabled.

The difference is important if you're using JavaScript global state. A
full page load resets the JS state, while a simulated page load does
not.


