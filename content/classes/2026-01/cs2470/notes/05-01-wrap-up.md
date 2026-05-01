---
title: "Lecture Notes: 05-01 Wrap-Up"
date: "2026-04-29"
---

## First Thing: Course Evals

- Everyone log into a workstation or pull out a device.
- Go ahead and do your course eval for this class.
- What worked well in this class?
- What could be improved to help students in the future?
- Does this class need a mandatory textbook?
- Is AI-assisted grading better or worse than multiple choice quizzes on Canvas?
- I'll step out of the room and be back in a few minutes.

## Signals

Signals are asynchronous notifications sent to a process. They're like interrupts delivered by the kernel.

### Common Signals

| Signal | Meaning | Default Action |
|--------|---------|----------------|
| SIGINT (2) | Interrupt (Ctrl+C) | Terminate |
| SIGSEGV (11) | Segmentation fault | Terminate + core dump |
| SIGALRM (14) | Timer expired | Terminate |
| SIGCHLD (17) | Child process stopped/terminated | Ignore |

### Example: Catching Ctrl+C

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

volatile int should_quit = 0;

void handle_sigint(int sig) {
    (void)sig;  // suppress unused warning
    should_quit = 1;
    write(STDOUT_FILENO, "\nCaught SIGINT, shutting down...\n", 33);
}

int main() {
    signal(SIGINT, handle_sigint);
    
    int count = 0;
    while (!should_quit) {
        printf("Working... %d\n", count++);
        sleep(1);
    }
    
    printf("Clean exit!\n");
    return 0;
}
```

### Example: Setting a Timer with SIGALRM

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

void alarm_handler(int sig) {
    (void)sig;
    write(STDOUT_FILENO, "\nTIME'S UP!\n", 12);
    exit(0);
}

int main() {
    signal(SIGALRM, alarm_handler);
    alarm(5);  // SIGALRM in 5 seconds
    
    printf("You have 5 seconds to solve: 2 + 2 = ?\n");
    int answer;
    scanf("%d", &answer);
    
    if (answer == 4) {
        printf("Correct!\n");
    } else {
        printf("Wrong!\n");
    }
    return 0;
}
```

**Note:** `signal()` is simple but has portability quirks. For serious code, use `sigaction()`.

## Stack Switching

The `ucontext` functions (makecontext, swapcontext, getcontext) let us manually save and restore execution contexts. This is how user-level threading libraries implement cooperative multitasking.

### Key Functions

```c
#include <ucontext.h>

int getcontext(ucontext_t *ucp);     // Save current context
int setcontext(const ucontext_t *ucp); // Restore context (no return)
void makecontext(ucontext_t *ucp, void (*func)(), int argc, ...); // Set up new context
int swapcontext(ucontext_t *oucp, const ucontext_t *ucp); // Save and switch
```

### Example: Two "Threads" Yielding to Each Other

```c
#include <stdio.h>
#include <ucontext.h>
#include <stdlib.h>

static ucontext_t main_ctx, f1_ctx, f2_ctx;

void function1(void) {
    for (int i = 0; i < 3; i++) {
        printf("Function 1, iteration %d\n", i);
        swapcontext(&f1_ctx, &f2_ctx);  // Yield to function2
    }
    printf("Function 1 done\n");
    swapcontext(&f1_ctx, &main_ctx);   // Return to main
}

void function2(void) {
    for (int i = 0; i < 3; i++) {
        printf("Function 2, iteration %d\n", i);
        swapcontext(&f2_ctx, &f1_ctx);  // Yield to function1
    }
    printf("Function 2 done\n");
    swapcontext(&f2_ctx, &main_ctx);   // Return to main
}

int main() {
    // Allocate stacks for the two functions
    char *stack1 = malloc(8192);
    char *stack2 = malloc(8192);
    
    getcontext(&f1_ctx);
    f1_ctx.uc_stack.ss_sp = stack1;
    f1_ctx.uc_stack.ss_size = 8192;
    f1_ctx.uc_link = &main_ctx;  // Where to go when f1 finishes
    makecontext(&f1_ctx, function1, 0);
    
    getcontext(&f2_ctx);
    f2_ctx.uc_stack.ss_sp = stack2;
    f2_ctx.uc_stack.ss_size = 8192;
    f2_ctx.uc_link = &main_ctx;
    makecontext(&f2_ctx, function2, 0);
    
    printf("Starting cooperative multitasking...\n");
    swapcontext(&main_ctx, &f1_ctx);
    
    printf("Back in main!\n");
    free(stack1);
    free(stack2);
    return 0;
}
```

### How It Works

1. `getcontext()` saves the current state (registers, stack pointer, instruction pointer) into a `ucontext_t` struct
2. `makecontext()` sets up a new context with its own stack and entry function
3. `swapcontext()` saves the current context and jumps to another

**Output:**

```
Starting cooperative multitasking...
Function 1, iteration 0
Function 2, iteration 0
Function 1, iteration 1
Function 2, iteration 1
Function 1, iteration 2
Function 2, iteration 2
Function 1 done
Function 2 done
Back in main!
```

### Why This Matters

This is the basis for:

- **Green threads / coroutines**: User-space scheduling without kernel involvement
- **Generators**: Like Python's `yield`
- **Async I/O**: Non-blocking operations with manual context switching

**Note:** `ucontext` is deprecated in POSIX (removed in POSIX.1-2008) because better alternatives exist (setcontext is more portable), but it's still widely available on Linux and perfect for learning. For production code, look at `setcontext()` or use a proper threading library.

### Also See

- setjmp / longjmp

### Next Week's Lab

You'll implement a simple cooperative scheduler using these concepts, handling signals to trigger context switches between multiple "threads" of execution.
