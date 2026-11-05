---
title: "cs4140 Notes: 11-06 Application Security"
date: "2026-11-04"
---

## What is security? When is security a concern?

A computer program - especially one accessible over the network or by multiple
people - has functionality: People need to be able to complete their workflows.

But we don't want people to be able to do *unintended* actions, especially when
it would negatively impact other users or the system in general.

A system is useful if it lets people do what they need / want to do.

A system is secure if it doesn't let people do stuff that they shouldn't be
able to do.

In a single player game should you be able to give yourself extra loot?

Should you be able to play a movie on your computer? Would being able to
play it or not being able to play it be a security failure?

## HTTPS / TLS

**What is HTTPS?**

When we connect to a website, we can do so either via HTTP or HTTPS.

HTTPS is like HTTP except:

 - The URL starts with https://
 - The default TCP port is 443 rather than 80
 - The connection is encrypted and authenticated with TLS
 
TLS (old versions were SSL) is a protocal for doing encrypted and
authenticated TCP connections.

In addition to encryption and authentication, there's one more reason
to set up HTTPS for web sites. Some web browsers block some
functionality on sites served without HTTPS; an example would be the
HTML5 location API. This is just trying to encourage HTTPS usage, it
doesn't provide any significant security benefit.


**How does the cryptography work? What does it do?**

Shared key encryption:

 - Alice and Bob share a cryptographic key (~ 32 bytes).
 - Alice uses the key to encrypt a message.
 - The encrypted message is the same length, but completely
   random looking contents.
 - Alice sends the encrypted message to Bob.
 - Bob can decrypt the messge with the key, producing the
   same message Alice started with.
 - Nobody without the key can go from the encrypted message
   to the decrypted message.

Message authentication:

 - Alice and Bob share a cryptographic key (~ 32 bytes).
 - Alice uses the key to generate a Message Authentication Code
   for the message (~ 32 bytes).
 - Alice sends the message and the MAC to Bob.
 - Bob can use the shared key and MAC to determine if the message
   he got is exactly the same as the one Alice sent.
 - Nobody without the key can generate a valid MAC and trick Bob
   into thinking a fake or altered message came from Alice.

Public Key Encryption / Key Exchange:

 - Alice and Bob don't share any cryptographic key.
 - Bob has generated a cryptographic key pair (a private key and
   associated public key), and published the public key (1kB).
 - Alice generates a secret shared key (~ 32B).
 - Alice uses Bob's public key to encrypt it (encrypted message ~ 1kB).
 - Alice sends the encrypted message to Bob.
 - Bob can use his private key to decrypt the message.
 - Now they have a shared key for encryption and MAC.
 - Nobody can decrypt a message encrypted with Bob's public key unless
   they have Bob's private key.

Public Key Signatures:

 - Alice and Bob don't share any cryptographic key.
 - Alice has generated a cryptographic key pair (a private key and
   associated public key), and published the public key (1kB).
 - Alice uses her private key to sign a message, creating a signature
   (~ 1kB).
 - Alice sends the message and signature to Bob.
 - Bob uses Alice's public key to verify the signature.
 - Nobody can generate a signature that can be verified with Alice's
   public key unless they have Alice's private key.

**Encryption**

If a connection is encrypted, no observer can read the content of the
messages sent over the connection.

Note that metadata is not hidden, this includes:

 - The IP address of the two parties to the connection.
 - When messages are sent.
 - How large messages are.
 - The pattern of messages.

Encryption by itself doesn't guarantee that you're communicating with
who you think you are, nor does it guarantee that the message hasn't
been changed in transit.

Changes to messages in transit can be detected with message
autentication codes or authenticated encryption, which generally are used
in TLS connections.

But that still doesn't guarantee that you're connected to the right
person, for that you need authentication.

**Authentication**

For authentication, HTTPS uses centrally issued digital certificates.

Let's look at an example:

 - We visit https://plymouth.edu/
 - Clicking the lock and clicking through to the certificate shows:
   - Organization: University System of New Hampshire
   - Verified by: Internet2, Incommon Server CA
   - Verified by: The USERTRUST Network
   - And they are in the certificate store for the browser I'm using.

What attacks is it intended to defend against?

 - Spoofing
   - You try to connect to https://plymouth.edu but the network you're connecting
     to gives you bad DNS info and sends you to my web server instead.
   - I send you whatever response I want, including a modified version of what
     you're expecting to see.
 - "Man in the Middle"
   - You try to connect to https://plymouth.edu but the network you're connecting
     to gives you bad DNS info and sends you to my web server instead.
   - My webserver sends a request on to https://plymouth.edu and sends you back the
     (possibly modified) response.
   - You're talking to the intended server, but I can see and modify the whole
     session.

Note that either of those attacks make encryption irrelevent, but both
require the ability to control network traffic at least somewhat in
the data path.

How secure is it?

 - The cryptography is pretty secure.
   - No evidence that anyone has ever cracked modern common crypto algorithms.
   - Would require mathematical attacks not currently known.
 - There are hundreds of certificate authorities that could issue a certificate
   for an arbitrary web site.
 - If any of them do and get caught, they'll probably be delisted by web browsers.
 - Becoming a new CA is possible but expensive. We were looking at for
   a project I was on a while back and estimated $50k or more in
   initial expenses (e.g. a security audit).
 - So nobody's going to issue a fake certificate from a real CA to
   steal $500, but they very well might to steal $500k.
 - This is very much primarily intended to protect your credit card
   for online shopping and maybe your retirement account.
 - Any application with higher security requirements than that should
   use more secure mechanisms.

Client certificates.

 - HTTPS is almost always used with only server certificates.
 - Client certificates can be used - authenticating the user to the
   server - which can provide excellent user authentication especially
   if the application issues them itself rather than trying to use the
   CA mechanism.

**HTTP Strict-Transport-Security**

Problem: HTTP downgrade attack:

 - User visits website by typing in "website.com"
 - Browser tries HTTP URL first, which redirects to HTTPS
 - Attacker intercepts HTTP request and doesn't do an HTTPS redirect,
   so neither encryption nor authentication occurs.
 - User session has been hijacked.
 
Solution: HSTS header

 - Send Strict-Transport-Security with HTTPS responses.
 - Browser will mark that hostname as being HTTPS only, and will
   auto-redirect HTTP requests to HTTPS in the future

Complication: You can't easily decide to downgrade to HTTP later,
because every user would need to manually reset their browser.

Suggestion: HSTS is good in serious stable production environments,
and should be avoided like the plague anywhere else.

**Certbot**

Most CAs charge a fee for issuing a TLS certificate. This can be a
good thing, because it gives them the resources to do some level of
verification that a site belongs to a given organization - like having
a human make a phone call.

But frequently it's sufficient to just confirm that the server is
controlled by the same organization who controlled the DNS records in
the recent past as observed from a reasonably trustworthy internet
connection.

Let's Encrypt is a non-profit certificate authority that issues
domain-verified certificates. Example:

 - go to https://homework.quest/
 - This site is verified as being homework.quest, but not any specific
   organization.
 - By Let's Encrypt
 - Who are verified by the ISRG

Let's Encrypt provides a tool called Certbot which makes setting up
HTTPS for a server really easy. 

On Debian-based Linux:

 - ```sudo apt install certbot python3-certbot-nginx```
 - ```sudo certbot```

Demo this for http://jokes-rails.homework.quest/

In this case Certbot sets up Nginx to terminate the HTTPS connection.
The local reverse proxy connection from Nginx to the application
server is unencrypted HTTP. This setup is good practice and can
provide better peformance and otherwise better behavior than trying to
have your application server terminate HTTPS.

There are potential privacy and gatekeeping concerns with any
certificate authority in edge cases, but in the common case for
low-budget web sites Let's Encrypt is an easy way to get slightly
better security, functionaly, and user experience.
---
title: "Notes: 29 Passwords"
date: "2023-11-05"
---

# Authentication

## Problem: User Authentication

 - Lots of apps have user accounts.
 - We'd like our user accounts to correspond to actual people.
 - Specifically, if Alice makes an account, then some other user - Mallory -
   shouldn't be able to control that account.
 - When a user logs in - creating a session - we want to authenticate that
   they're the same person who created the account.
 - Sadly, that's impossible.
 - But we can do some stuff that's kind of similar.

Authentication ideas:

 - Link to an already authenticated account - e.g. Google, Facebook, GitHub.
   - Still not identifying a person.
   - But we can transfer most of the identity properties the alice123 Google
     account had to our Alice account.
 - Link to an email address or phone number
   - Same as above.
   - Note that any system with password recovery is really doing this,
     possibly in addition to something else, and that two options is
     as secure as the weaker option.
 - Use a cryptographic public key.
   - Still not a person.
   - But we can guarantee that only a person or machine with access to the 
     appropriate private key can authenticate as the linked user.
 - Use a password.
   - Like cryptographic keys, but way worse.

## Solution: Passwords

 - Users select a password when they register.
 - We assume anyone who knows the password is that person.
 - How long a password do we need to require?

### Threat 1: Online Attacks

A person (or program) guesses passwords and tries to log in to the website with
them.

 - Attacker might be able to try a thousand passwords per second.
 - Assuming a password has random lowercase letters, how long does
   it take to guess a 4 character password? (5 minutes)
 - A 6 character password? (2 days)
 - An 8 character password? (3 years)

Solving online attacks is simple: Limit users to 20 login attempts per hour.

### Threat 2: Offline Attacks

The user sends us a password when they register, and we need to be able to
check for that same password when they later log in.

Bad Plan A: Store the password in our database.

What happens when the attacker has a copy of our database?

 - They have all the passwords and can log in as anyone.
 - People tend to reuse passwords on different sites, so the attacker can
   probably log into everyone's steam accounts and steal all their trading
   cards.

Bad Plan B: Store a cryptographic hash (e.g. SHA256) in the DB.

 - Now the attacker needs to brute force the hashes before they
   have any passwords.
 - This is basically the same problem as mining Bitcoin - a GPU
   can test about a billion hashes per second.
 - Assuming passwords are random lowercase letters:
 - An 8 character password? (2 minutes)
 - A 10 character password? (17 hours)
 - A 12 character password? (1 year)
 
 12 character passwords look OK here, but unfortunately real passwords don't
 tend to be random lowercase letters. They tend to be words, maybe with the
 first letter capitalized and numbers tacked on the end.
 
Bad Plan C: Store hashes from a password hashing function (e.g. argon2)

 - This makes time to test a password tunable.
 - You can get back to the 100/second rate for an online attack.
 - Except: The attacker can pre-calculate the hashes.
   - This is called building a "rainbow table".
   - They hash all their guesses up front, and then can compare
     the hashes with the ones in your DB.

Good Plan: Password hashing function + salt

 - Hash the password + a random number (the salt)
 - Store the salt with the hash
 - Now rainbow tables don't work - you'd need to hash every password
   for every possible salt.
   
## Password Requirements?

 - You've all seen web sites with password rules:
   - You must have an uppercase letter, a lowercase letter, a number, an arabic character.
   - Your password must be at least six letters long.
   - You must change your password every week.
   - You can't reuse passwords.
 - These rules reliabiliy produce a specific form of password: "p4ssW0rd17", where 17
   is the number of times this password has been changed.

Don't do this. Instead, password requirements should look like this:

 - Your password must be at least 10 characters.
 - You'll never need to change it unless the password DB leaks.
 - Your password can't contain a common password, like "p4ssW0rd".
 - Remember to limit login attempts per time; a high-ish limit is fine.
   
NIST password guidelines: https://pages.nist.gov/800-63-3/sp800-63b.html


## Two-Factor Authentication

Require a password *and* something else:

 - Email a code
 - SMS a code
 - Mobile app
   - Standard
   - Proprietary
 - Hardware token
 

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
