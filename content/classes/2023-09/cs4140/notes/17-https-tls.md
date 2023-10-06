---
title: "cs4140 Notes: 17 HTTPS: Secure HTTP"
date: "2023-10-04"
---

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
