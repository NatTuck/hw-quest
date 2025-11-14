---
title: "cs2010 Notes: Environments"
date: "2025-11-14"
---

## Notional Machine

Real machine:

- RAM
- Memory addresses
- Instructions

Lua Notional Machine:

- Lines of code
- Variables
- Environments ("scopes")

## Environments / Variable Scope

Simple examples

- File local
- Function local
- Masking
- Nested functions
- Lexical closures (e.g. counter)

```lua
local aa = 5
print(aa)

local function zz()
        local aa = 7
        print(aa)
end

zz()

print(aa)
```
