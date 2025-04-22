---
title: "cs2370 Notes: 35 Web Apps"
date: "2025-04-21"
---

## Concept: Web App

- A web page is an HTML document.
- A static web server responds to an HTTP web request by reading
  a file from disk and sending the contents.
- But a server program that speaks HTTP doesn't need to do that;
  it can do whatever it wants.
- It could even return a different HTML document each time it gets
  a request. It could dynamically generate the document.
- That's how modern (server-side) web apps work. They're programs
  that listen on the HTTP(S) port, speak HTTP, and send generated
  HTML documents in response to requests. 


## Demo

```python
from http.server import HTTPServer, BaseHTTPRequestHandler
from pathlib import Path

class Page:
    def html(self):
        return f'''
        <!doctype html>
        <html>
          <head>
            <title>{self.title}</title>
          </head>
          <body>
            <h1>{self.title}</h1>
            {self.body}
          </body>
        </html>
        '''

    def bytes(self):
        return self.html().encode('utf-8')

class Welcome(Page):
    title = "Welcome!"
    body = '''
    <p>Welcome to our web site.</p>
    <p>We have <a href="/page2">another page</a>.</p>
    '''

class Page2(Page):
    title = "Page 2"
    body = '''
    <p>This is the second page.</p>
    <p>Back to the <a href="/">welcome</a> page?</p>
    '''
    
class Handler(BaseHTTPRequestHandler):
    routes = {
        "/": Welcome,
        "/page2": Page2,
    }
    
    def do_HEAD(self):
        if self.path in self.routes:
            self.send_response(200)
        else:
            self.send_response(404)
    
    def do_GET(self):
        if not self.path in self.routes:
            self.send_response(404)
            return
        
        self.close_connection = True        
        print("path =", self.path)

        self.send_response(200)
        self.send_header("content-type", "text/html; charset=UTF-8")
        self.end_headers()

        page = self.routes[self.path]()
        self.wfile.write(page.bytes())



if __name__ == '__main__':
    server = HTTPServer(('', 8081), Handler)
    server.serve_forever()
```
