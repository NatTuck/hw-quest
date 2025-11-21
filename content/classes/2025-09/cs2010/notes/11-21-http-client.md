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

Plan:

- Create an "image" text file on Github. Two colors to start.
- Make code that downloads that file and then
  uses it as instructions to draw the image with two block colors.
- Parameterize it on file name.
- Make another image.
- Show both file names working.
