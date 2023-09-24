---
title: "cs4140 Notes: 12 CI with Github Actions"
date: "2023-09-24"
---

Github provides a way to run code automatically on our repository:
Github Actions

We can use this for two things:

 - Continuous Integration: Automatically run tests
 - Continuous Deployment: Automatically deploy if tests pass
 
Today we're just looking at CI.

**Testing Next**

Ref: [Github Actions: Nodejs](
https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-nodejs)

To start out:

 - Go to our main repo
 - Click "Actions"
 - Pick the "nodejs" testing workflow
 - This basically gives us a pull request to add a github workflow config file
 - Let's only do Node 18.x
 - Our run commands should be:
   - run: npm install
   - run: npx jest --all --ci


**Testing Rails**

Ref: [Github Actions: Rails](
https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-ruby)

Same process:

 - Go to our main repo
 - Click "Actions"
 - Pick the "ruby" testing workflow
 
Edit it into this:

```yaml
name: Ruby

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

permissions:
  contents: read

jobs:
  test:

    runs-on: ubuntu-latest
    strategy:
      matrix:
        ruby-version: ['3.2.2']

    steps:
    - uses: actions/checkout@v3
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with: 
        ruby-version: ${{ matrix.ruby-version }}
        bundler-cache: true # runs 'bundle install' and caches installed gems automatically        
    - name: Set up yarn
      uses:  actions/setup-node@v3
      with: 
        node-version: '18.x'
    - run: yarn
    - run: bundle exec rake assets:precompile
    - run: bundle exec rake test
```
 
## Overflow: HTML Rendering 

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

