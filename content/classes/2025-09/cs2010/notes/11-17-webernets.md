---
title: "cs2010 Notes: 11-17 The Webernets"
date: "2025-11-15"
---

## The Internet and The Web

- Browser
- Address bar
- Host name
- DNS lookup
- IP address
- IP packets; unreliable, unordered
- TCP port
- TCP connection
- How reliable and ordered?
- HTTP request / response
- HTTPs - Digital signatures, just like with SSH

## ComputerCraft HTTP Client

```lua
local args = { ... }
if #args ~= 1 then
 print("Needs an argument")
 return
end

local req = http.get(args[1])
-- readLine returns a line or nil
print(req.readAll())
req.close()
```

Now let's build a program that follows instructions from a file online.
