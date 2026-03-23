---
title: "RISCV-64 Assembly Quick Reference"
date: "2026-01-21"
---

Here is the updated cheat sheet, assuming you are compiling and running natively on a RISC-V machine.

# RISC-V 64-bit Assembly Quick Reference

This cheat sheet is adapted for 64-bit RISC-V (RV64G). It uses the standard RISC-V assembly syntax, where the destination register typically comes first, followed by the source registers (e.g., `add rd, rs1, rs2`).

## Registers

In RISC-V (RV64), there are 32 general-purpose registers that can each hold 64-bits (8 bytes). We almost always use their ABI (Application Binary Interface) names rather than their hardware names (`x0`–`x31`).

| Register | ABI Name | Description | Preserved across calls? |
| --- | --- | --- | --- |
| `x0` | `zero` | Hard-wired to `0`. Writes are ignored. | n/a |
| `x1` | `ra` | Return address. | Caller-saved |
| `x2` | `sp` | Stack pointer. | Callee-saved |
| `x3` | `gp` | Global pointer. | Unallocatable |
| `x4` | `tp` | Thread pointer. | Unallocatable |
| `x5–x7` | `t0–t2` | Temporary registers. | Caller-saved |
| `x8` | `s0`/`fp` | Saved register / Frame pointer. | Callee-saved |
| `x9` | `s1` | Saved register. | Callee-saved |
| `x10–x11` | `a0–a1` | Function arguments / Return values. | Caller-saved |
| `x12–x17` | `a2–a7` | Function arguments. | Caller-saved |
| `x18–x27` | `s2–s11` | Saved registers. | Callee-saved |
| `x28–x31` | `t3–t6` | Temporary registers. | Caller-saved |

There is one other special register worth remembering:

* **`pc`** - Program Counter. Points to the next instruction to execute. Not directly readable/writable by most normal instructions.

*Note: RISC-V does not have a `%flags` register like x86.*

## Instructions

### Arithmetic Instructions

| Instruction | Description |
| --- | --- |
| `mv rd, rs` | Pseudo-op: Copy data from register `rs` to `rd` |
| `li rd, imm` | Pseudo-op: Load immediate constant into `rd` |
| --- | --- |
| `add rd, rs1, rs2` | `rd = rs1 + rs2` |
| `sub rd, rs1, rs2` | `rd = rs1 - rs2` |
| `neg rd, rs` | Pseudo-op: Negate `rs` (`rd = -rs`) |
| `not rd, rs` | Pseudo-op: Bitwise NOT `rs` |
| --- | --- |
| `addi rd, rs1, imm` | `rd = rs1 + imm` |
| `or rd, rs1, rs2` | `rd = rs1 OR rs2` (bitwise) |
| `and rd, rs1, rs2` | `rd = rs1 AND rs2` (bitwise) |
| --- | --- |
| `mul rd, rs1, rs2` | `rd = rs1 * rs2` |
| `div rd, rs1, rs2` | `rd = rs1 / rs2` (Quotient) |
| `rem rd, rs1, rs2` | `rd = rs1 % rs2` (Remainder) |

**Word-sized variants (32-bit):** Instructions like `add`, `sub`, `mul`, and `addi` have an equivalent ending in `w` (e.g., `addw`, `subw`, `addiw`). These operate on the lower 32-bits of the registers and sign-extend the result to 64 bits.

### Flow Control and Logic

RISC-V doesn't use condition codes/flags. Instead, conditional branches compare two registers directly and jump if the condition is met.

| Instruction | Description |
| --- | --- |
| `beq rs1, rs2, label` | Jump to `label` if `rs1 == rs2` |
| `bne rs1, rs2, label` | Jump to `label` if `rs1 != rs2` |
| `blt rs1, rs2, label` | Jump to `label` if `rs1 < rs2` (signed) |
| `bge rs1, rs2, label` | Jump to `label` if `rs1 >= rs2` (signed) |
| `bltu rs1, rs2, label` | Jump to `label` if `rs1 < rs2` (unsigned) |
| `bgeu rs1, rs2, label` | Jump to `label` if `rs1 >= rs2` (unsigned) |
| --- | --- |
| `j label` | Pseudo-op: Unconditional jump to `label` |
| --- | --- |
| `slt rd, rs1, rs2` | Set Less Than: `rd = 1` if `rs1 < rs2`, else `0` |
| `seqz rd, rs` | Pseudo-op: Set `rd = 1` if `rs == 0`, else `0` |

### Function Call and Stack

RISC-V is a Load/Store architecture. There are no built-in `push` or `pop` instructions. Stack allocation is done by doing math on the stack pointer (`sp`).

| Instruction | Description |
| --- | --- |
| `addi sp, sp, -NN` | Allocate a stack frame with `NN` bytes of space |
| `addi sp, sp, NN` | Deallocate a stack frame |
| `sd rs, OFFSET(sp)` | Store (Push) register `rs` to the stack |
| `ld rd, OFFSET(sp)` | Load (Pop) from the stack into register `rd` |
| `call label` | Push `pc` to `ra` and jump to the "label" function |
| `ret` | Return from a function (jump to address in `ra`) |

### Memory and Immediate Arguments

Unlike AMD64, RISC-V arithmetic instructions **cannot** operate on memory directly. You must first load the value from memory into a register, do the math, and store it back.

| Example Instruction | Description |
| --- | --- |
| `ld a0, 0(t0)` | `a0 =` value at the memory address in `t0` |
| `sd a0, 8(t0)` | Store the value of `a0` to the address `t0 + 8` |
| `addi t0, t0, 10` | `t0 = t0 + 10` (Notice: memory offsets use parentheses; `addi` uses constants) |

There is a special pseudo-instruction, `la`, that calculates an address (similar to AMD64's `lea`) and loads it into a register.

| Example Instruction | Description |
| --- | --- |
| `la t0, my_var` | `t0 =` the memory address of the symbol `my_var` |

**Instruction Sizes:** Load and store instructions change size based on the suffix: `b` (1 byte), `h` (2 bytes), `w` (4 bytes), and `d` (8 bytes).

| Example Instruction | Description |
| --- | --- |
| `sb a0, 0(t0)` | Store the lowest 8 bits (byte) of `a0` into memory at `t0` |
| `lw t1, 0(t0)` | Load a 32-bit (word) int from `t0`, **sign-extending** into `t1` |
| `lwu t1, 0(t0)` | Load a 32-bit (word) int from `t0`, **zero-extending** into `t1` |
| `ld t1, 0(t0)` | Load a full 64-bit (doubleword) from `t0` |

## Calling a Function

To call a function with the `call` instruction, you must first:

1. **Put arguments in the appropriate registers / stack.**
   `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`, then onto the stack.

2. **Think about "caller save" / "temporary" registers.**
   That's all the `t0-t6` registers, `a0-a7`, and `ra` (Return Address). Assume calling any function corrupts them. You can save them to the stack before the call and restore them after, but using safe (callee-saved) registers for long-lived values works better.

3. **Make sure `%sp` points to an address divisible by 16 bytes.**
   RISC-V mandates a 16-byte aligned stack when `call` is executed.

4. Once the function returns, your result will be in `a0`. An optional second result is returned in `a1`.

## Writing a Function

These registers are callee-saved. If you want to use them, save them to the stack in your prologue and restore them in your epilogue:

* `s0–s11`

The `ra` (return address) register must also be saved to the stack if your function calls *another* function, because the `call` instruction will overwrite it.

**Example Prologue & Epilogue:**

```assembly
my_function:
    # Prologue: allocate 16 bytes, save ra and s0
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    
    # ... function body ...

    # Epilogue: restore s0 and ra, deallocate 16 bytes
    ld s0, 0(sp)
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
```

## Register Allocation

* **Function arguments:** `a0–a7`
* **Temporary registers:** `t0–t6`, `a0–a7`
* **Safe registers:** `s0–s11`

How to map variables / values to locations:

* Local variables that get their address taken should go on the stack.
* Local variables that get used *before and after* a function call should go in a **safe** (callee-saved) register.
* Local variables that don't need to survive a function call can go in **temporary** registers.
* Temporary values should go in **temporary** registers.

## Compiling ASM with GCC

```bash
gcc -no-pie -o foo foo.s
```

* By default, the program starts at `_start`.
* If you declare `.global main`, the C runtime will start your code at `main`.
* The `-no-pie` flag may be necessary depending on your distro to disable Position Independent Executable linking.

## Compiling ASM without libc

```bash
gcc -nostdlib -no-pie -o foo foo.s
```

OR

```bash
as -o foo.o foo.s
ld -o foo foo.o
```

## Using GDB with ASM

* Compile with `-g` to include debug symbols (e.g., `gcc -g -o foo foo.s`).
* Start GDB using `$ gdb ./foo`.
* Use `break` to set breakpoints on labels or line numbers (e.g., `break main`).
* Step through instructions using `stepi` (or `si`) and `nexti` (or `ni`).
* Print registers with `p $a0` or `p/x $a0`.
* Print all registers with `info reg`.

---

## Note on Cross-Compiling

If you are not running natively on a RISC-V machine (e.g., you are on an x86_64 Mac or Linux machine), you will need a cross-compiler toolchain and an emulator to build and run your code.

* **Toolchain:** Replace `gcc`, `as`, and `ld` with their cross-compiler equivalents, usually prefixed with the target architecture, such as `riscv64-linux-gnu-gcc`.
* **Execution:** You cannot run the resulting binary natively. You must execute it through an emulator like QEMU:

  ```bash
  qemu-riscv64 -L /usr/riscv64-linux-gnu ./foo
  ```

* **Debugging:** Use `gdb-multiarch` or `riscv64-linux-gnu-gdb` instead of the standard `gdb`. You will need to start QEMU with the `-g` flag to expose a debug port, then attach your cross-architecture GDB to that port remotely.
