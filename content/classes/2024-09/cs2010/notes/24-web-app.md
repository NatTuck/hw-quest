---
title: "cs2010 Notes: 24 Web App"
date: "2024-11-24"
---


## First Class Functions


```js
// Number -> Number
function add1(xx) {
    return xx + 1;
}

// (Number -> Number), Number -> Number
function doTwice(op, xx) {
    return op(op(xx));
}

// (Number -> Number) -> (Number -> Number)
function twice(op) {
    function inner(xx) {
       return op(op(xx)); 
    }
    return inner;
}

// (Number -> Number) -> (Number -> Number)
function twice(op) {
    return (xx) => op(op(xx));
}


```




## Web App


```bash
$ mkdir edemo; cd edemo
$ pnpm install express
```


```js
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.set('Content-Type', 'text/html')
  
  res.send(`
   <!doctype html>
   <form action="/hello">
   <p><input type="text" name="name"></p>
   <p><button>Submit</button></p>
   </form>
  `)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
```


```bash
$ node app.js
```

Then visit localhost:3000 in browser


**More**

 - https://expressjs.com/en/starter/hello-world.html
 - https://nextjs.org/


## Post Requests

```bash
$ npm install body-parser
```


```js
const express = require('express');
const app = express();
const port = 3000;
const bodyParser = require('body-parser');

function rootPath(req, res) {
  res.set('Content-Type', 'text/html');
  res.send(`
   <!doctype html>
   <form action="/hello" method="post">
   <p><input type="text" name="name"></p>
   <p><button>Submit</button></p>
   </form>
  `);
}

app.get('/', rootPath);

let parser = bodyParser.urlencoded({ extended: false });

function helloPath(req, res) {

  let name = req.body.name;
  
  res.set('Content-Type', 'text/html');
  res.send(`
   <!doctype html>
   <p>Hello, ${name}</p>
  `);
}

app.post('/hello', parser, helloPath);

function startup() {
  console.log(`Example app listening on port ${port}`)
}

app.listen(port, startup);
```


## NextJS

 - Do a NextJS demo, without state or anything.
