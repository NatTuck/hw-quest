---
title: "cs2010 Notes: 11-21 HTTP Client"
date: "2025-11-19"
---

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

TODO: Finish this client
