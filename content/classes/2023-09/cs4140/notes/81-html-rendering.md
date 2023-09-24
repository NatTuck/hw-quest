---
title: "cs4140 Notes: 09 Automated Testing"
date: "2023-09-17"
draft: true
---

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


