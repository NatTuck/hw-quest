---
title: "cs2010 Notes: 23 Security and HTTP"
date: "2024-11-21"
---

## Layers

 - Physical (wire / radio)
 - Data (ethernet / wifi)
 - Network (IP)
 - Transport (TCP)
 - Security (TLS)
 - Application (HTTPS)

## TLS

 - Cryptography
   - Public key
     - Encryption
     - Signatures
   - Secret key 
     - Encryption
     - Authentication Codes
 - How do we trust a website?
   - The messages are signed, but by who?
   - The certificate is signed, but by who?
   - Certificate authorities
   - Threat model: Great for buying stuff with a credit card,
     not good enough for very serious threats.
   - Letsencrypt

## HTTP

Do the simple demo with telnet against homework.quest.


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
  console.log(req);
  res.send('Hello World!')
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
