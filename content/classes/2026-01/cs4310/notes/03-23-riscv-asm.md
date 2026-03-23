---
title: "Lecture Notes: 03-23 RISCV-64 Assembly"
date: "2026-03-21"
---

## RISC-V: The Architecture

While AMD64 is an **CISC** (Complex Instruction Set Computer) architecture evolved from the 1970s, RISC-V is a modern **RISC** (Reduced Instruction Set Computer) architecture.

* **Design:** Clean-slate, open-standard ISA.
* **Load/Store Architecture:** Unlike AMD64, which can perform math directly on memory (e.g., `addq $1, (%rdi)`), RISC-V *only* performs math on registers. You must explicitly `ld` (load) from memory to a register and `sd` (store) back.

## Registers (RV64)

In RISC-V, we have 32 general-purpose registers, each 64 bits wide. We use **ABI names** (like `a0`, `t1`) rather than hardware names (`x10`, `x6`).

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

## Calling Convention (System V vs. RISC-V ABI)

In the lecture's AMD64 examples, we used `%rdi`, `%rsi`, etc. Here is the mapping:

| Purpose | AMD64 (AT&T) | RISC-V (RV64) |
| :--- | :--- | :--- |
| **1st Argument** | `%rdi` | `a0` |
| **2nd Argument** | `%rsi` | `a1` |
| **3rd Argument** | `%rdx` | `a2` |
| **Return Value** | `%rax` | `a0` |
| **Stack Pointer** | `%rsp` | `sp` |
| **Return Address** | (on stack) | `ra` |

## Basic Patterns

### 1. Function Prologue and Epilogue

AMD64 uses `enter` and `leave` (or `push %rbp`). RISC-V requires manual stack adjustment.

**AMD64:**

```assembly
my_func:
    enter $0, $0
    # ... body ...
    leave
    ret
```

**RISC-V:**

```assembly
my_func:
    # Prologue: Move sp down, save ra and s0 (fp)
    addi sp, sp, -16
    sd   ra, 8(sp)
    sd   s0, 0(sp)
    mv   s0, sp        # Set frame pointer

    # ... body ...

    # Epilogue: Restore ra and s0, move sp up
    ld   s0, 0(sp)
    ld   ra, 8(sp)
    addi sp, sp, 16
    ret
```

### 2. Simple Function Example (`add2`)

C code: `long add2(long x) { return x + 2; }`

**AMD64 (AT&T):**

```assembly
add2:
    enter $0, $0
    mov %rdi, %rax
    add $2, %rax
    leave
    ret
```

**RISC-V:**

```assembly
add2:
    # No stack needed (leaf function)
    addi a0, a0, 2    # a0 = a0 + 2 (Result goes in a0)
    ret
```

### 3. Conditional Branching

In AMD64, you use `cmp` followed by a jump. In RISC-V, comparison and jumping are often one instruction.

**AMD64:**

```assembly
    cmp $10, %rax
    jle smaller_than_ten
```

**RISC-V:**

```assembly
    li  t0, 10
    ble a0, t0, smaller_than_ten
```

## Example: `main` with `printf`

C code:

```c
long x = 5;
long y = add2(x);
printf("%ld\n", y);
```

**RISC-V Assembly:**

```assembly
.global main
.text
main:
    # Prologue
    addi sp, sp, -16
    sd   ra, 8(sp)

    # long x = 5;
    li   a0, 5        # Argument 1 for add2
    call add2         # result in a0

    # printf("%ld\n", y)
    mv   a1, a0       # Move result to 2nd arg for printf
    la   a0, long_fmt # Load address of format string into 1st arg
    call printf

    # Epilogue
    ld   ra, 8(sp)
    addi sp, sp, 16
    li   a0, 0        # Return 0
    ret

.data
long_fmt: .string "%ld\n"
```

## Compiling and Running

On a native RISC-V Linux system:

```bash
# Compile
$ gcc -o my_prog my_prog.s

# Run
$ ./my_prog
```

*(Note: If you are on x86, you would use `riscv64-linux-gnu-gcc` and run with `qemu-riscv64`.)*

## MilkV-64

The upcoming homework is:

* Get Linux running on a risc-v board.
* Write some assembly code for it.
