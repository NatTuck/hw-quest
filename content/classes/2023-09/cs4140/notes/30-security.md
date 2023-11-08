---
title: "Notes: 30 Security"
date: "2023-11-07"
---


# Sessions

We don't ask for a password to load every page, instead our app /
framework will have some concept of a session.

 - Cookies
   - Header
   - Generally specific to {domain, port, proto}
 - window.localStorage
   - Specific to {domain, port, proto}
   - Send auth header with fetchRequests
   - Authenticate web socket on connect

What to store?

 - Session ID
   - Look it up in database
   - Maybe something faster than DB?
 - Cryptographic token
   - Avoid DB lookup
   - Potentially non-trivial to revoke session


# API authentication

What if you want to authenate a program (e.g. script, app) rather than
a person?

API key:

 - Issue the developer an API key.
 - This is a long string of opaque text.
 - It could just be a user ID and long password.
 - It could be a cryptographically signed token.
 - No human needs to remember it.
 - Generally the connection is secured with SSL, so it can be secret.
 - It can be sent on every request.

What if you want to authenticate a person through a third party app?

 - You want to be able to detect abuse by the person.
 - You want to be able to detect abuse by the app.
 
Process: OAuth

 - The app constructs a link that the user clicks.
 - This brings the user to your site in a browser.
 - They log in, and approve delegating access to the app.
 - You store permission for the app to act as the user.
 - You redirect to the app's web server with a code.
 - The app then sends an HTTP request exchanging the code
   for a user-specific API key.

Benefits:

 - The app can't act as the user without permission.
 - The user can't impersonate the app.
 
 
# More Security Stuff

# Webapp Security

NIST Guidelines: https://pages.nist.gov/800-63-3/

## Your Web App is Network Accessible

This means that your site can be accessed by over a billion people, who are
effectively anonymous.

They can send any network packets they want to your server. It's up to you
to make sure that people with internet access can't get your server and the
applications running on it to do things you don't want.

One way to look at internet servers is that they provide a publicly 
accessible interface, controlled by the developers and administrators. In this
view the idea that some people are "hackers" and are doing something wrong
is silly. If you didn't want them doing it, you shouldn't have hooked up a
server that provided that option.

In general, a key idea is to be careful with user input. If you have data
that came from a remote request, assume it's out to get you and don't pass
it on to any potentially dangerous API calls without carefully considering
how things could go wrong.


## General Attacks

### Too Broad an API

Consider a form to download a file:

```
<form action="/download" method="post">
<select name="file">
  <option>foo.txt</option>
  <option>bar.jpg</option>
</select>
<input type="submit">
</form>
```

This should send something like "file=foo.txt" as one of the request
parameters. Then your app will open "file.txt" in the appropriate
directory and send it along.

What if the user sends a POST request asking for "file=/etc/tls/cert.key".
Your app goes ahead and opens the file and sends it along. And the attacker
has your HTTPS private key and can impersonate your server.

The two approaches to mitigate this issue are:

1. Indirection. Send "file_id=7" instead, and look up the name of the file
   in the legal_downloads table in your database.
2. Sanitize the input. Verifiy that the input has no slashes, or dots, or
   tildes in it before opening the file. This works if you catch every bad
   case, but that can be hard.

### Cross Site Request Forgery (XSRF) Attacks

 - Users in web apps are generally authenticated by session cookies.
 - Any time a user with an appropriate cookie in their browser makes
   a request to the server, they're authenticated by the cookie.
 - Forms on web sites are submitted as a HTTP POST request.
 - Nothing stops somoene from making a form on another web site that
   has an "action" attribute pointing at your server.
 - When a user submits the form on the other site, if they're already
   logged in on your site, they're an authenticated user making an
   apparently legitimate request.
 - The form doesn't have to be visible and can be triggered by JavaScript.

Example:

 - Imagine your home router can be administered from a web browser.
 - It has a form to change the admin password.
 - It has a form to enable access from the public internet.
 - The router always lives at http://192.168.1.1/
 - You visit a cat video on haxxor.fi, and those dasterdly Finnish hackers have
   a hidden form on the page: 

```
<div style="display: none;">
<form id="hax" action="http://192.168.1.1/change_admin_password" method="post">
<input type="hidden" name="new_password" value="haxxor.fi">
</form>
</div>

<script>
  $(function() { $('#hax').submit() });
</script>
```

The page inexplicably reloads. The next page has another form.

```
<div style="display: none;">
<form id="hax" action="http://192.168.1.1/allow_remote_access" method="post">
<input type="hidden" name="allow_remote_access" value="1">
</form>
</div>

<script>
  $(function() { $('#hax').submit() });
</script>
```

And your cat video plays. And now haxxor.fi controls your router. Interestingly,
your bank website now doesn't use HTTPS. They probably should have enabled strict
transport security.

Solution: XSRF tokens. Include a unique token in each form and then verify that
each form submission has a valid token.

Note that AJAX can't be easily used for XSRF attacks. Browsers ban cross-site
AJAX by default.

### Cross Site Scripting (XSS) Attacks

With XSRF tokens and cross-site AJAX restrictions, hijacking someone's session
is inconvenient.

Unless you can run JavaScript that's served as part of a web page on the target
site.

Consider a version of your Microblog app that allows people to type in HTML for
their messages.

If somoene types in a message like:

```
<div id="worm">
<p>Buy discount rolex watches at discountrolx.fi!</p>
<script>
$(function () { $.ajax(... path: "/messages", method: "post", data: $('#worm').html(), ...) });
</script>
</div>
```

Now everyone who views the message posts the message. This happened on MySpace
several times. Bing "myspace worm".

Solution: Any user supplied content needs to be filtered to eliminate anything that
will be treated as special in an HTML document. Most modern web frameworks do this
automatically - it's a bit tricky to do by hand.

Sometimes you *do* want to allow HTML. This is way more annoying. You'll want to
whitelist safe tags an attributes rather than blacklisting unsafe ones, and even
simple links are unsafe.

### SQL Injection Attacks

Imagine a user logs in to your website, and you get "email" and "password"
in your controller.

You then say:

```
  user = SQL.execute("select * from users where email = '#{email}' limit 1");
```

The next thing that will happen is that someone will give you

 email = "'; delete from users;"
 
And now you don't have any users. Don't do that. Use tools like Ecto
for DB queries, and if you must execute custom SQL commands find the
API for "parameterized queries".

### Client Side Input Validation

Consider the rule that a password must be at least 8 characters.

When someone registers a new account, they type in a password. You have two options
for validation when they click the submit button:

 * Check that the password is at least 8 characters in JavaScript, and stop the
   submission with an error indicator if it's not.
 * Check that the password is at least 8 characters on the server, and display
   an error page (or the form with an error indicator) if it's not.

Doing the first provides fast user feedback, and variants can produce a better
user experience.

Doing only the JS validation doesn't guarantee that everyone has an >= 8 character
password. Users can turn off or modify your JS, or submit HTTP requests manually
without a browser.

You want to do input validation server-side. You may *also* want to do client side
validation, but only for UX, not for data consistency.

## The Moral of the Story

Security is about understanding what capabilities your application exposes
to users and the internet in general. Once you know what people can do, you
can decide which of those things you don't want them to do and change the
system so they can't do them.

This is one of the reasons it's important to know about and understand all
the moving parts in a web application. If you know what everything does, then
you can make sure it's doing what you want - and not other stuff you don't want.
