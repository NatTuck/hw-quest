---
title: "cs2370 Notes: 34 Introducing the Web"
date: "2025-04-16"
---

What is the Web?

 - A protocol: HTTP
 - A set of standards for styled, interactive documents: HTML, CSS, JavaScript
   - Plus some standard media formats: gif, png, jpg, mp3, mp4, av1, etc.
 - A standard way to specify the *address* of a document or resource: URLs
   - http[s]://host/path
 - Concepts: Web page, Web site

What's a web page?

 - One HTML document and associated media

What's a web site?

 - Several HTML documents collected together, typically under a shared base URL
 - https://homework.quest/
 - https://turing.plymouth.edu/~zshen/

How does HTTP work?

```bash
$ cd sample-dir
$ python3 -m http.server
```

```bash
$ telnet localhost 8000
```


For https

```bash
$ openssl s_client -connect homework.quest:443
GET / HTTP/1.1
Host: homework.quest
```


Why did I type "homework.quest" twice?

 - The "telnet" command connects to a network server.
 - Network servers have numerical addresses.
 - Since multiple DNS names can map to one IP, multiple web sites
   can be on one server. The host header allows different host names
   to show different sites.

# HTML

HTML is a markup language.

An HTML file is a plain text file that contains HTML tags. These tags
provide document structure and formatting.

```html
<!doctype html>
<html>
  <head>
    <title>My Dog</title>
  </head>
  <body>
    <h1>My Dog</title>
    <p>This is my dog. She eats dog food, and human food, and legos, and bees.</p>
    <img src="dog.jpg">
  </body>
</html>
```

Stuff going on here:

 - The doctype line specifies the version of HTML. In this case, modern html 5.
 - Tags go in angle brackets and come in pairs - an opening tag < foo > is ended by
   a closigng tag </ foo >.
 - There's a top level html tag.
 - Inside that we have the head for metadata and the body for the
   document content.
 - We can specify different types of text: headings, paragraphs.
 - We can include media - in this case an image.


## Web Scraping

 

```python
import requests

resp = requests.get("https://homework.quest/")
resp.status_code
resp.raise_for_status()
resp.text
```


Scraping Wikipedia:

 - Trying to use regex
 - main




```python
import requests
import bs4

resp = requests.get("https://homework.quest/")
resp.status_code
resp.raise_for_status()
resp.text
tree = bs4.BeautifulSoup(resp.text, 'html.parser')
xs = tree.select('a')
for x in xs: print("[", x, "]")
```

 - '#foo'
 - '.foo'
 - ```soup.select('input[type="button"]')```
 - spanElem.get('id')


 - https://en.wikipedia.org/wiki/List_of_Pok%C3%A9mon
