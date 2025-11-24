---
title: "cs2010 Notes: 11-24 Web Server"
date: "2025-11-22"
---

## Web Servers and Web Applications

The traditional web:

- A web page is an HTML document.
- A web site is a collection of HTML documents under
  some shared base URL.
- e.g. <https://homework.quest/> is a website, as is <https://turing.plymouth.edu/~zshen/>
- Web sites are served by static web server programs, which are:
  - Configured with a document_root, the path to a directory containing the
  HTML files, images, etc for the web site.
  - Listen on TCP port 80 (or 443) and send files when requested.
- Web sites are viewed with web browser, programs that:
  - Allow the user to enter the address for a web site.
  - Make HTTP requests to web servers, parse the resulting HTML, and
  render the web page.
  - Follow links when the user clicks them.

For early HTTP, there was one more thing they did: form submissions.

- A page includes some form with a bunch of fields (e.g. credit_card_num,
  expr_date)
- When the user hits a submit button, the browser makes an HTTP POST request
  to the server.
- The server needs to run a custom program to process the form submission.
- This can include uploading a file.

Since HTTP (and HTML, etc) are standards, we don't really need to use either
a web browser or a static web server.

- Custom clients like we wrote last lecture can make HTTP requests,
  process the responses, and do something other than render web pages with that
  data.
- HTTP is a pretty good way to transfer arbitrary files and the data in them.

We also can write custom servers.

- A static server:
  - Accepts a request (e.g. GET /hello.jpg)
  - Reads that path from disk, relative to the document root. (e.g. read a file
    called hello.jpg)
  - Sends the contents.
- But we can replace that sequence with any similar function that
  - Take Input: Some path string
  - Return output: An HTTP response
    - Content-type: (e.g. text/html, image/jpeg)
    - Body: Some bytes of data in the format specified by
      content type.
- The responses don't have to have anything to do with files.
- The responses can be different on subsequent requests.

A web site that's just a bunch of files is a "static website". With a custom
server, you can build an arbitrary web application.

## Web Apps in Lua

We're using Lua:

- Because that's what ComputerCraft uses.
- Because Lua is a well-established and easy to implement embedded language
  for game scripting.

But, even though it's not broadly used for web apps, Lua can be used for
server-side apps and works well in that domain.

- The popular framework is called Lapis <https://leafo.net/lapis/>
- Biggest user is probably the "indy" game store <https://itch.io/>

In order to run Lapis apps we need to install some dependencies like
lua, the luarocks package manager, and the openresty web server.

```bash
sudo luarocks install lapis
sudo luarocks isntall lpeg
sudo luarocks install lrexlib-pcre
```

Then we can create a new project with

```bash
mkdir weather; cd weather; lapis new
```

```lua
-- app.lua
local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

return app
```

When generating HTML, it's useful to have templates.

```bash
mkdir views
```

```etlua
<!-- views/index.etlua -->
<div>
  <h1>Get Weather</h1>
  <form action="/weather" method="post">
    <p>Enter zip: <input type="text" name="zip"></p>
    <p><button>Go</button></p>
  </form>
  <p>Here is a random number: <%= math.random() %></p>
</div>
```

```lua
local lapis = require("lapis")

local app = lapis.Application()
app:enable("etlua")

app:get("/", function(self)
  return { render = "index" }
end)

return app
```

Now what do we do?

First, let's look at <https://forecast.weather.gov/zipcity.php?inputstring=03264>

```bash
sudo luarocks install dkjson
```

```lua
local json = require("dkjson")

-- ...

app:post("/weather", function(self)
	return "weather\n" .. json.encode(self.POST)
end)
```



