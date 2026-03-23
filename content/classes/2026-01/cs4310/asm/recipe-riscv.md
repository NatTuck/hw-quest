---
title: "Design Recipe for an RISCV-64 ASM Program"
date: "2026-01-20"
---

# The RISC-V 64-bit Assembly Recipe

This is a step-by-step process for translating a C-style function into working RISC-V assembly.

## 1. Setup the Function

Start with the boilerplate. Every function needs a label and needs to be made visible to the linker.

```assembly
.section .text
.global my_function

my_function:
    # (Prologue goes here)
```

## 2. The Prologue (The Stack)

In RISC-V, there is no `push` or `pop`. You must manually move the stack pointer (`sp`).

* **The 16-Byte Rule:** The stack pointer **must** stay aligned to 16 bytes.
* **Saving `ra`:** If your function calls another function, you **must** save the return address (`ra`).

**The Recipe:**

1. Calculate how much space you need (Local variables + saved registers).
2. Round that up to the nearest multiple of 16.
3. Subtract that from `sp`.
4. Store `ra` and any `s` registers you plan to use.

```assembly
    addi sp, sp, -32     # Allocate 32 bytes of stack space
    sd ra, 24(sp)        # Save return address at the top
    sd s0, 16(sp)        # Save s0 (if we plan to use it)
```

## 3. Map Your Variables

Decide where every C variable will live.

* **Arguments:** The first 8 arguments come in `a0` through `a7`.
* **Long-lived variables:** Use "Saved" registers (`s0–s11`). These stay the same even after you call another function. (Remember: if you use an `s` register, you must save/restore it in the prologue/epilogue).
* **Temporary/Short-lived:** Use `t0–t6`. These are "Caller-saved," meaning if you call another function, their values might be destroyed.

## 4. Translate the Body

Translate the logic line-by-line.

### Constants and Moving

* **Load Immediate:** `li t0, 42` (Put 42 into `t0`)
* **Move:** `mv t1, a0` (Copy argument 0 into `t1`)

### Arithmetic

Unlike x86, RISC-V cannot do math on memory. You must load values into registers first.

* `add t0, t1, t2`  ($t0 = t1 + t2$)
* `addi t0, t1, 10` ($t0 = t1 + 10$)
* `sub t0, t1, t2`  ($t0 = t1 - t2$)

### If-Statements

To do an `if (a == b) { ... }`, you usually write the branch to **skip** the block if the condition is **false**.

```assembly
    # if (a0 != a1) skip the if-block
    bne a0, a1, end_if 
    
    # ... body of if statement ...

end_if:
```

### Loops

```assembly
loop_start:
    # ... loop logic ...
    
    # if (t0 < t1) goto loop_start
    blt t0, t1, loop_start 
```

## 5. Function Calls

To call a function (e.g., `printf` or `some_other_func`):

1. Put the arguments into `a0`, `a1`, etc.
2. Use the `call` instruction.
3. The return value will be in `a0`.

**Note:** If you have values in `t` registers that you need *after* the call, you must save them to the stack before the call and reload them after. This is why using `s` registers for important variables is easier!

```assembly
    mv a0, s0        # Move our saved variable into argument 0
    call other_func  # ra is overwritten here, luckily we saved it in Step 2
    mv s1, a0        # Move the result of the function into s1
```

## 6. The Epilogue (The Return)

Before returning, you must undo everything you did in the Prologue.

1. Load the result you want to return into `a0`.
2. Restore `ra` and any `s` registers from the stack.
3. Add the space back to `sp`.
4. Use `ret`.

```assembly
    # (Assuming result is already in a0)
    ld s0, 16(sp)    # Restore s0
    ld ra, 24(sp)    # Restore ra
    addi sp, sp, 32  # Deallocate stack space
    ret              # Jump back to caller
```

---

### Comparison Summary

| Feature | AMD64 (x86_64) | RISC-V (RV64) |
| :--- | :--- | :--- |
| **Math** | `add rax, rbx` (Dest is Source) | `add a0, a1, a2` (Three operands) |
| **Memory** | Can do math on memory | **Load/Store only** (must `ld` first) |
| **Registers** | `rax, rdi, rsi...` | `a0-a7, t0-t6, s0-s11` |
| **Stack** | `push`/`pop` | `addi sp, sp, -16` then `sd` |
| **Return Addr** | Automatically pushed by `call` | Stored in `ra` register |
| **Alignment** | 16-byte (at `call`) | 16-byte (always) |
