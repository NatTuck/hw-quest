---
title: "cs4140 Notes: 24 Next and CORS"
date: "2024-10-22"
---


Today:

 - Cross-site auth with Phoenix.Token


From the docs:

https://hexdocs.pm/phoenix/Phoenix.Token.html

```
user_id = 1

token = Phoenix.Token.sign(MyAppWeb.Endpoint, "user auth", user_id)

Phoenix.Token.verify(MyAppWeb.Endpoint, "user auth", token, max_age: 86400)
{:ok, 1}
```


Then let's plumb that through the two apps.
