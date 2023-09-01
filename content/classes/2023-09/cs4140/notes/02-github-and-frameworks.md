---
title: "cs4140 Notes: 02 Github and Frameworks"
date: "2023-08-27"
---

# Hello Again

 - Course Site
 - Inkfish registratoin
   - Passwords must be > 12 characters
 - Discord is bad: Can't paste or send links
   - Use the Gitter Matrix server?
   - Host an instance of Rocket Chat?
   - Free Version of Slack?
   - Task for this week's report: 
     - Look at the problem of persistent chat services that are free or easily self-hosted and recommend one.

# Full Stack Web Frameworks

## Overview of How Web Apps Work

**Web Page**

 - An HTML document. 
 - Nowadays that implies CSS styling and possibly simple JS logic internal to the page.
 - Static - if you reload, it's the same unless manually updated.
 - Associated with a specific URL.

**Web Site**

 - A collection of web pages.
 - Simplest case is a directory tree of HTML documents.

**Static web server**

 - Gets an HTTP request with a path
 - Reads file at path under the directory ("document root")
 - Sends that file to the requestor
 
**Web Application**

In the general case, a web application is a program that:

 - Gets an HTTP request
 - Uses arbitrary program logic to generate a response
 - Frequently the program functions as a web server, although it
   could interface with an external web server in some other way 
   instead
 - That's *very* open ended. A web framework provides some structure.

**Common Framework Elements**

 - Router
 - Controller
 - ORM
 - Template
 - Asset Pipeline

## What do we want in a framework

 - Provides good support for application logic on a web server.
 - Interface to a relational (SQL) database. Must support (SQLite or H2) and (PostgreSQL or MariaDB).
   - Migrations: A way to change DB schema in flight.
 - Separation between business logic (e.g. models, controllers) and page rendering (e.g. templates).
 - A way to manage in-browser assets - JS and CSS - preferably with standard NPM modules and some sort of asset build system.
 
## Example Frameworks

 - Python / Django
 - Ruby on Rails
 - Next JS
 - Remix JS
 - Elixir / Phoenix
 - Scala / Lift
 - ...

I'd prefer to not see PHP here. I don't really want to contribute to filling anyone's brain with that.

