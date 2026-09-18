---
title: "cs4250 Notes: 09-16 RISC-V ASM"
date: "2026-09-14"
---

# RISC-V Assembly

## Registers (RV64)

There are 32 general-purpose registers, each 64 bits (8 bytes) wide. We use
**ABI names** rather than hardware names (`x10` is `a0`).

| Category | ABI Names | Description | Preserved? |
| :--- | :--- | :--- | :--- |
| **Zero** | `zero` | Always 0. Writes are ignored. | n/a |
| **Return Address** | `ra` | Holds the return address for calls. | Caller |
| **Stack Pointer** | `sp` | Points to the top of the stack. | Callee |
| **Arguments / Return** | `a0–a1` | Function arguments and return values. | Caller |
| **Arguments** | `a2–a7` | More function arguments. | Caller |
| **Temporaries** | `t0–t6` | "Scratch" registers for intermediate math. | Caller |
| **Saved Registers** | `s0–s11` | Registers that must be restored if used. | Callee |
| **Frame Pointer** | `s0/fp` | Often used to track the stack frame. | Callee |


## Neat Tricks

Some assembly instructions are really pseudo-instructions that the assembler
expands to other instructions, maybe multiple

That includes `call` and `ret`.

```
    // when we do
    call label

    // we want this
    jal ra, label

    // but that only takes a 20 bit immediate, or +- 512kB

    // if the range is more than that
    auipc ra, %pcrel_hi(symbol)
    jalr  ra, %pcrel_lo(label)(ra)


    // ---

    // luckily, ret is easy
    jalr x0, 0(ra)

```




```

Points to notice:

- `add2` is a **leaf function** (it calls nothing), so it needs no stack frame
  and never touches `ra`.
- `main` calls `add2` and `printf`, so it saves `ra` first.
- `li` (load immediate), `mv` (move), `la` (load address), `call`, and `ret`
  are pseudo-instructions the assembler expands for us.
- The argument to `add2` is already in `a0` because we put 5 there.
- `printf`'s second argument is the value in `a1`; the format string address
  goes in `a0`.

Build and run it **natively on the board**:

```bash
gcc -no-pie -o add2 add2.S
./add2
# 7
```

## The Recipe

For anything bigger than `add2`, we want a repeatable process instead of
guessing. That's the **assembly recipe**: a fixed sequence of steps for turning
a C function into working RISC-V assembly.

The full write-up is here: [Design Recipe for RISC-V ASM](../asm/recipe-riscv/).

The six steps:

0. Make sure you have C code or at least pseudocode.
1. **Setup the function** — a `.global` label in `.section .text`.
2. **The prologue** — allocate stack space (rounded to 16 bytes), save `ra` and
   any `s` registers you'll use.
3. **Map your variables** — arguments in `a0–a7`; long-lived values in `s0–s11`;
   short-lived scratch in `t0–t6`.
4. **Translate the body** — line by line. Constants with `li`, moves with `mv`,
   arithmetic with `add`/`sub`/`addi`. Branch *past* an `if` block when its
   condition is false. Loops are just a label plus a conditional branch back.
5. **Function calls** — args in `a0`, `a1`, ...; `call`; result in `a0`. Save
   `t` registers you still need across the call.
6. **The epilogue** — result into `a0`, restore `ra` and the `s` registers,
   deallocate the stack, `ret`.

## Recipe Demo: Collatz

Here's a program with an `if`/`else`, a loop, a helper function, and calls to
`printf` — enough to exercise every step of the recipe.

C version:

```c
long iterate(long x) {
    if (x % 2 == 0) {
        return x / 2;
    } else {
        return x * 3 + 1;
    }
}

int main(int argc, char* argv[]) {
    long x = 27;
    long i = 0;
    while (x > 1) {
        printf("%ld\n", x);
        x = iterate(x);
        i++;
    }
    printf("i = %ld\n", i);
    return 0;
}
```

### Step 1: Setup

```assembly
.global main
.section .text

iterate:
    # ...
```

### Step 2: The prologue

`iterate` calls nothing, so it's a leaf and needs no frame:

```assembly
iterate:
    # (no prologue needed)
```

`main` calls `iterate` and `printf`, and needs `x` and `i` to survive those
calls. Two `s` registers plus `ra` is 24 bytes, rounded up to 32:

```assembly
main:
    addi sp, sp, -32
    sd   ra, 24(sp)
    sd   s0, 16(sp)
    sd   s1, 8(sp)
```

### Step 3: Map the variables and values

**Where can a variable/value go?**

- arg register
- temp register
- safe register
- stack
- memory

For this example:

- `iterate`'s argument `x` arrives in `a0`; its result goes in `a0`.
- `main`'s `x` -> `s0`, `i` -> `s1`. These are callee-saved, so they survive
  the calls to `iterate` and `printf`.

```assembly
    li   s0, 27     # long x = 27;
    li   s1, 0      # long i = 0;
```

### Step 4: Translate the body

The `if`/`else` becomes a branch that skips to the `else` when the condition is
false. `rem` gives us `x % 2`:

```assembly
iterate:
    li   t0, 2
    rem  t1, a0, t0        # t1 = x % 2
    bnez t1, iterate_odd   # if (x % 2 != 0) goto the else branch

    div  a0, a0, t0        # return x / 2;
    ret

iterate_odd:
    li   t0, 3             # return x * 3 + 1;
    mul  a0, a0, t0
    addi a0, a0, 1
    ret
```

The `while` loop is a label at the top and a conditional branch back to it:

```assembly
loop_start:
    li   t0, 1
    ble  s0, t0, loop_end  # while (x > 1): exit if x <= 1
    # ... loop body ...
    j    loop_start
loop_end:
```

### Step 5: Function calls

```assembly
    # printf("%ld\n", x);
    la   a0, long_fmt
    mv   a1, s0
    call printf

    # x = iterate(x);
    mv   a0, s0
    call iterate
    mv   s0, a0            # result comes back in a0
```

### Step 6: The epilogue

```assembly
    li   a0, 0             # return 0;
    ld   s1, 8(sp)
    ld   s0, 16(sp)
    ld   ra, 24(sp)
    addi sp, sp, 32
    ret
```

### Putting it together

Full program: [`collatz.S`](../asm/collatz.S).

```assembly
.global main
.section .text

# long iterate(long x) -- leaf function, no stack frame needed.
#   x in a0, result in a0.
iterate:
    li   t0, 2
    rem  t1, a0, t0        # t1 = x % 2
    bnez t1, iterate_odd

    div  a0, a0, t0        # return x / 2;
    ret

iterate_odd:
    li   t0, 3
    mul  a0, a0, t0        # return x * 3 + 1;
    addi a0, a0, 1
    ret

main:
    addi sp, sp, -32
    sd   ra, 24(sp)
    sd   s0, 16(sp)
    sd   s1, 8(sp)

    li   s0, 27            # long x = 27;
    li   s1, 0             # long i = 0;

loop_start:
    li   t0, 1
    ble  s0, t0, loop_end  # while (x > 1)

    la   a0, long_fmt      # printf("%ld\n", x);
    mv   a1, s0
    call printf

    mv   a0, s0            # x = iterate(x);
    call iterate
    mv   s0, a0

    addi s1, s1, 1         # i++;
    j    loop_start

loop_end:
    la   a0, iter_fmt      # printf("i = %ld\n", i);
    mv   a1, s1
    call printf

    li   a0, 0             # return 0;
    ld   s1, 8(sp)
    ld   s0, 16(sp)
    ld   ra, 24(sp)
    addi sp, sp, 32
    ret

.section .data
long_fmt: .string "%ld\n"
iter_fmt: .string "i = %ld\n"
```

Build and run it on the board:

```bash
gcc -no-pie -o collatz collatz.S
./collatz
```

## Exercise

On the board, starting from `add2.S` and `collatz.S`:

1. Change `collatz.S` so the starting value comes from `argv[1]` (look up
   `atol`; `argc` is in `a0` and `argv` is in `a1` in `main`).
2. Write `long square(long x)` that returns `x * x`, call it from `main`, and
   print the result.
3. Use `gdb` to `break` at `iterate` and inspect `a0` with `p $a0`. Compile
   with `-g` first.

## Refs

- [Design Recipe for RISC-V ASM](../asm/recipe-riscv/)
- [RISCV-64 Cheat Sheet](../asm/cheatsheet-riscv64/)
- [add2.S](../asm/add2.S), [collatz.S](../asm/collatz.S)
- <https://homework.quest/classes/2026-01/cs4310/notes/03-23-riscv-asm/>
