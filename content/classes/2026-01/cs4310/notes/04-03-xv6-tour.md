---
title: "Lecture Notes: 04-03 xv6 Tour"
date: "2026-04-01"
---

## Today

- Let's take a look at xv6

## xv6: An Operating System

- Clone the xv6 repo: <https://github.com/NatTuck/xv6-riscv.git>
- `sudo apt install gcc-riscv64-linux-gnu qemu-system-misc`

Building and running it:

- open dedicated terminal
- make
- make qemu
- ls
- cat README
- need to kill qemu to exit

## Boot process

- entry.S
- start.c
- main.c
- proc.c: scheduler
  
## Adding a Syscall

The stock xv6 doesn't include an exit system call. We need that for
automated tests, so we're going to add it.

```
git checkout -b add-halt-syscall
```

### Step 1: Add a syscall number

- open syscall.h
- Syscall numbers 1-21 are taken, so we'll make our new syscall # 22

```
#define SYS_halt   22
```

### Step 2: Add syscall to the list in syscall.c

```
extern int sys_halt(void);
...
[SYS_halt]    sys_halt,
```

### Step 3: Implement the syscall

See notes from Gemini below.

### Step 4: Add a userspace wrapper

Add the declaration to user.h:

```
int halt(void);
```

### Step 5: Add a test program

Create halt.c:

```
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int _ac, char *_av[])
{
  halt();
  return 0;
}
```

Add it to the Makefile

```
UPROGS=\
   ...
   _halt\
   ...
```

## New References

Thanks, Gemini.

## Old References

- <https://pdos.csail.mit.edu/6.828/2012/homework/xv6-syscall.html>
- <https://medium.com/@silvamatteus/adding-new-system-calls-to-xv6-217b7daefbe1>
- <https://gitlab.redox-os.org/redox-os/kernel/blob/master/src/arch/x86_64/stop.rs>

## Extra

- Try to figure out existing syscalls.
- Maybe start with "write".

## Gemini Create System Call

In xv6 for RISC-V, QEMU's `virt` machine doesn't use port I/O (like `outw` on x86). Instead, it uses memory-mapped I/O (MMIO).

To shut down QEMU on RISC-V, you need to write a specific magic number to the **SiFive Test device**, which QEMU maps to physical address **`0x100000`**.

Writing **`0x5555`** to this address tells QEMU to halt and exit with a success code (0). Writing `0x3333` tells it to exit with a failure code (1).

Here is exactly how to add this functionality to xv6-riscv:

### Step 1: Define the device address

Open `kernel/memlayout.h` and add the physical address for the test device. You can put this near the top where the other MMIO addresses (like `UART0`) are defined:

```c
// qemu puts the SiFive test device here, which we use to power off
#define VIRT_TEST 0x100000L
```

### Step 2: Map the device in the kernel page table

Because xv6 runs with virtual memory enabled, you cannot write directly to physical address `0x100000` without causing a page fault. You must map it into the kernel's virtual address space.

Open `kernel/vm.c`, find the `kvmmake()` function, and add the mapping right next to where the `UART0` and `VIRTIO0` mappings are:

```c
  // map the SiFive test device (for QEMU poweroff)
  kvmmap(kpgtbl, VIRT_TEST, VIRT_TEST, PGSIZE, PTE_R | PTE_W);
```

### Step 3: Create the halt function

Now you can write a C function to trigger the shutdown. You can put this in `kernel/printf.c`, `kernel/main.c`, or wherever you intend to use it.

```c
void halt(void)
{
  // 0x5555 causes QEMU to exit with code 0
  *(volatile uint32 *)VIRT_TEST = 0x5555;
  
  // Hang here in case the write fails
  while(1)
    ;
}
```

### Optional: Expose it to user-space

If you want to be able to run a command like `$ poweroff` from the xv6 shell, you need to wrap this in a system call.

1. **`kernel/syscall.h`**: Add `#define SYS_halt  22`
2. **`kernel/sysproc.c`**: Add the syscall implementation:

   ```c
   uint64
   sys_halt(void)
   {
     *(volatile uint32 *)VIRT_TEST = 0x5555;
     return 0;
   }
   ```

3. **`kernel/syscall.c`**: Add `sys_halt` to the `syscalls` array.
4. **`user/usys.pl`**: Add `entry("halt");`
5. **`user/user.h`**: Add `int halt(void);`
6. **Create `user/poweroff.c`**:

   ```c
   #include "kernel/types.h"
   #include "user/user.h"

   int main(void) {
     halt();
     return 0;
   }
   ```

7. Add `_poweroff` to `UPROGS` in your **`Makefile`**.

## The exit syscall

Tracing a system call in xv6 for RISC-V is a great way to understand how user-space programs interact with the kernel. Because xv6 uses separate page tables for user space and kernel space, the transition is quite deliberate.

Here is the full, step-by-step sequence of exactly what happens when a user program calls `exit(0)`, and exactly which files contain the code.

---

### Phase 1: User Space (The "Do")

**1. The C Function Call (`user/user.h`)**
In your user program, you call `exit(0)`. The compiler looks at `user/user.h` and sees the declaration: `void exit(int) __attribute__((noreturn));`.

**2. The Assembly Stub (`user/usys.pl` $\to$ `user/usys.S`)**
xv6 doesn't write syscall assembly by hand; it uses a Perl script (`usys.pl`) to generate `usys.S` at build time. For `exit`, it generates this exact RISC-V assembly:

```assembly
.global exit
exit:
 li a7, 2        # Load SYS_exit (2) into register a7
 ecall           # TRAP: Jump to kernel mode
 ret             # (exit never actually returns here)
```

- **`a0`**: Contains the argument `0` (the exit status). According to RISC-V C calling conventions, the first argument to the C function is already in `a0`.
- **`a7`**: Contains the system call number (`SYS_exit` is defined as `2` in `kernel/syscall.h`).
- **`ecall`**: This hardware instruction elevates privileges from User Mode to Supervisor Mode and jumps to the address stored in the `stvec` hardware register.

---

### Phase 2: The Hardware/Trampoline Transition

**3. The Trampoline (`kernel/trampoline.S`)**
When `ecall` fires, the CPU jumps to the address in `stvec`. In xv6, `stvec` always points to `uservec` in the "trampoline" page.

- *Why a trampoline?* User page tables don't contain the kernel's memory mapping. The trampoline is mapped at the exact same virtual address in *both* user and kernel page tables (`MAXVA - PGSIZE`).
- **What it does:**
    1. Saves all 32 user registers into the process's `trapframe`.
    2. Loads the kernel stack pointer, kernel page table (`satp`), and the address of the kernel C trap handler (`usertrap`) from the trapframe.
    3. Executes `jr t0` to jump into the kernel's C code.

---

### Phase 3: The Kernel Trap Handler (The "Handle")

**4. Routing the Trap (`kernel/trap.c`)**
The CPU lands in the C function `usertrap()`.

```c
void usertrap(void) {
  // ... (setup stuff) ...

  if(r_scause() == 8){ // 8 = Environment call from U-mode (Syscall)
    // Advance the program counter so we return to the instruction
    // AFTER the ecall (even though exit won't return, this is standard)
    p->trapframe->epc += 4;

    intr_on(); // Re-enable interrupts
    syscall(); // Route to the syscall dispatcher
  }
  // ...
}
```

---

### Phase 4: System Call Dispatch

**5. Looking up the Syscall (`kernel/syscall.c`)**
The `syscall()` function reads register `a7` to figure out which syscall the user wants.

```c
void syscall(void) {
  int num;
  struct proc *p = myproc();

  num = p->trapframe->a7; // num is 2 (SYS_exit)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    // Call sys_exit() and store the return value in a0.
    p->trapframe->a0 = syscalls[num](); 
  } else {
    // ... handle invalid syscall ...
  }
}
```

---

### Phase 5: The System Call Wrapper

**6. Extracting Arguments (`kernel/sysproc.c`)**
The `syscalls` array points `2` to `sys_exit()`. System call functions in xv6 don't take arguments directly; they have to fetch them from the `trapframe`.

```c
uint64 sys_exit(void) {
  int n;
  argint(0, &n); // Fetch the 0th argument (from trapframe->a0)
  exit(n);       // Call the actual kernel exit logic
  return 0;      // (Never reached)
}
```

---

### Phase 6: The Core Kernel Logic

**7. Tearing Down the Process (`kernel/proc.c`)**
Finally, we arrive at the heavy lifting: `exit(int status)`. This function does the following:

1. Closes all open files (`fileclose()`).
2. Releases the current working directory (`iput()`).
3. Acquires the `wait_lock` to prevent race conditions with the parent process.
4. Wakes up the parent process (in case the parent is sleeping in `wait()`).
5. Reparents any children of the dying process to the `init` process.
6. Sets the process state to `ZOMBIE` and saves the exit status (`p->xstate = status`).
7. Calls `sched()`.

**8. Yielding the CPU forever**

```c
  sched();
  panic("zombie exit"); // This line is never reached
```

`sched()` does a context switch, jumping into the CPU scheduler (`scheduler()`). The process never executes another instruction. Eventually, the parent process will call `wait()`, notice the `ZOMBIE` state, and completely free the dead process's memory and trapframe.

### Summary of Key Files

| Action | File Path | Function/Code |
| :--- | :--- | :--- |
| **Trigger Syscall** | `user/usys.S` | `ecall` instruction |
| **Save Context** | `kernel/trampoline.S` | `uservec` assembly |
| **Catch Trap** | `kernel/trap.c` | `usertrap()` |
| **Dispatch Syscall** | `kernel/syscall.c` | `syscall()` |
| **Unpack Args** | `kernel/sysproc.c`| `sys_exit()` |
| **Process Death** | `kernel/proc.c` | `exit()` |
