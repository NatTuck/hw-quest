---
title: "cs4140 Notes: 11-16 More Security"
date: "2026-11-14"
---

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

# Let's Security Check Grange

- Login
- Request authentication
- Permission authorization
  - What actions are interesting?
- Infrastructure

