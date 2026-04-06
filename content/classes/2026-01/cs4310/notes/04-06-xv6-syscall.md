---
title: "Lecture Notes: 04-06 xv6 Syscall"
date: "2026-04-04"
---

## Today

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
