---
title: "Lecture Notes: 04-27 Semester Review"
date: "2026-04-25"
---

## Course Summary

CS2470: Systems Programming in C/C++

**The Plot**: Programs need hardware resources. The OS mediates access via system calls. This course is about writing programs that use system calls on AMD64 Linux.

---

## Part 1: C Fundamentals (Weeks 1-4)

### Types and Memory

- Built-in types: `char`, `short`, `int`, `long`
- `sizeof(type)` gives byte size
- Pointers: variables storing memory addresses with associated type
- Pointer arithmetic: `p + 1` steps by type size, not 1 byte

### Arrays

- Contiguous memory sequence starting at an address
- Array variable = pointer to start
- `arr[i]` equivalent to `*(arr + i)`
- Can't pass arrays to functions - pass pointer + size

### Memory Layout

```
+------------------+ High address
|    Stack         | (local variables, grows down)
+------------------+
|    (free)        |
+------------------+
|    Heap          | (malloc, grows up)
+------------------+
|    Data          | (globals)
+------------------+
|    Text          | (code)
+------------------+ Low address
```

### Dynamic Memory

- `malloc(size)` - allocate on heap
- `free(ptr)` - deallocate
- Use malloc when size unknown at compile time or to return from function
- Caller must free - part of function interface

### Structs

```c
typedef struct goat {
    char* name;
    int age;
} goat;
```

- Stack allocation: `goat g;` - dot access: `g.name`
- Heap allocation: `goat* g = malloc(...)` - arrow access: `g->name`
- Can pass structs by value (copies entire struct)
- Can pass structs by reference (pointer)

### Linked Lists

```c
typedef struct cell {
    int head;
    struct cell* tail;
} cell;
```

- Recursive data structure
- O(1) insertion
- Ownership: who frees?
- Header files, include guards, modules

### Slices

```c
typedef struct slice {
    const char* ptr;
    int len;
} slice;
```

- View into existing memory (no allocation)
- Safe string handling without null terminator dependence
- `printf("%.*s", sl.len, sl.ptr);`

---

## Part 2: System Calls (Weeks 5-6)

### C Stdlib vs Syscalls

| Layer | Example | Description |
|-------|---------|-------------|
| Stdlib | `fopen`, `fread`, `fgets` | Buffered, human-friendly |
| Syscall | `open`, `read` | Unbuffered, kernel interface |

- Stdlib functions are user code that makes syscalls
- Syscalls require kernel privilege (syscall instruction)
- Man pages: section 2 = syscalls, section 3 = stdlib

### File Descriptors

- Integer handle for open file/socket
- 0 = stdin, 1 = stdout, 2 = stderr
- `open(path, flags)` returns new fd
- `read(fd, buf, count)` reads bytes
- `write(fd, buf, count)` writes bytes
- `close(fd)` releases handle

### I/O Patterns

- Line-based: `fgets` - scans for newline, needs buffering
- Block-based: `fread` / `read` - fixed chunks, no buffering needed

---

## Part 3: Parsing and Interpreters (Week 7)

### Calculator Pipeline

1. **Read line**: `fgets` from stdin or file
2. **Tokenize**: Split text into tokens (state machine)
3. **Parse**: Build Abstract Syntax Tree
4. **Evaluate**: Recursive tree traversal

### Tokenizer

```c
list* tokenize(const char* text) {
    // Scan character by character
    // Numbers: accumulate digits
    // Operators: single char tokens
    // Skip whitespace
}
```

### Abstract Syntax Tree

```c
typedef struct calc_ast {
    char op;           // '+', '-', '*', '/', '='
    calc_ast* arg0;    // left subtree
    calc_ast* arg1;    // right subtree
    int value;         // for '=' nodes
} calc_ast;
```

- Numbers are leaf nodes (op = '=')
- Operators are internal nodes
- Order of operations encoded in structure

### Evaluation

```c
int ast_eval(calc_ast* ast) {
    switch (ast->op) {
        case '=': return ast->value;
        case '+': return ast_eval(ast->arg0) + ast_eval(ast->arg1);
        // ...
    }
}
```

---

## Part 4: Networking (Week 8)

### TCP/IP Layers

| Layer | Description |
|-------|-------------|
| IP | Unreliable, unordered packets |
| TCP | Reliable stream (retransmission, buffering) |
| Port | 0-65535, identifies service |

### Socket Client

```c
int sock = socket(AF_INET, SOCK_STREAM, 0);
connect(sock, (struct sockaddr*)&addr, sizeof(addr));
send(sock, msg, len, 0);
recv(sock, buf, size, 0);
close(sock);
```

- `socket()` - create socket fd
- `connect()` - establish connection
- `send()/recv()` - communicate
- HTTP: text protocol over TCP

---

## Part 5: Processes (Weeks 9-10)

### fork()

```c
if ((cpid = fork())) {
    // Parent: cpid = child's PID
    wait(&status);
}
else {
    // Child: cpid = 0
    // Copy of parent's memory
}
```

- Creates child process with copy of memory
- Parent and child run concurrently
- File descriptor table copied (shares open files)

### exec()

```c
execlp("echo", "echo", "hello", NULL);
// Never returns (on success)
// Replaces process memory with new program
```

- Replace current process with new program
- Keeps PID and open file descriptors

### wait()

```c
int status;
waitpid(cpid, &status, 0);
// Blocks until child exits
// status contains exit code
```

- Prevents zombie processes
- Retrieves child exit status

### Pipes

```c
int pp[2];
pipe(pp);
// pp[0] = read end, pp[1] = write end
```

- Unidirectional byte stream
- Used for process communication
- Close unused ends (for EOF detection)

### Prime Sieve Pipeline

- Chain of processes filtering primes
- Each process: receive numbers, filter multiples of first, pass survivors
- Dynamic: spawn next filter on first survivor
- Illustrates: pipes, fork, process coordination

---

## Part 6: C++ (Weeks 11-12)

### C++ = C + Three Things

1. **Templates** (generics)
2. **Classes** (constructors, destructors, methods)
3. **Standard Library** (containers, algorithms, smart pointers)

### Templates

```cpp
template <typename T>
struct cell {
    T head;
    cell<T>* tail;
};

cell<int>* xs = cons(3, cons(4, nullptr));
```

- Compiler generates type-specific code at compile time
- No runtime overhead

### Classes

```cpp
class Cell {
public:
    int head;
    Cell* tail;
    
    Cell(int h, Cell* t) : head(h), tail(t) {}
    ~Cell() { if (tail) delete tail; }
    int len() { return tail ? 1 + tail->len() : 1; }
};
```

- Constructor: initialization
- Destructor: cleanup (called on delete or stack unwind)
- Methods: functions associated with type

### RAII (Resource Acquisition Is Initialization)

- Acquire resource in constructor
- Release in destructor
- Works for: memory, files, locks, sockets
- Exception-safe cleanup

### Smart Pointers

| Type | Ownership | Use Case |
|------|-----------|----------|
| `unique_ptr` | Single owner | Most heap allocations |
| `shared_ptr` | Shared, ref-counted | Multiple owners |
| `weak_ptr` | Non-owning reference | Break cycles |

```cpp
auto p = std::make_unique<int>(42);
// No manual delete needed
```

### Modern C++ Features

- **Range-based for**: `for (auto& x : vec)`
- **Lambdas**: `[capture](args) { body }`
  - `[]` nothing, `[=]` by value, `[&]` by reference
- **Structured bindings**: `auto [a, b] = pair`
- **std::optional**: nullable without pointers
- **constexpr**: compile-time evaluation
- **C++20 Ranges**: `vec | filter | transform`

---

## Part 7: Shell Implementation (Week 13)

### Shell Operators

| Operator | Example | Behavior |
|----------|---------|----------|
| `<` | `cmd < file` | Redirect stdin |
| `>` | `cmd > file` | Redirect stdout |
| `|` | `cmd1 | cmd2` | Pipe output to input |
| `&` | `cmd &` | Background execution |
| `&&` | `cmd1 && cmd2` | Run cmd2 if cmd1 succeeds |
| `||` | `cmd1 || cmd2` | Run cmd2 if cmd1 fails |
| `;` | `cmd1; cmd2` | Run sequentially |

### Shell Evaluation Strategy

1. **Simple command**: fork + exec + wait
2. **Semicolon/And/Or**: split, execute left, conditionally execute right
3. **Background**: fork child, parent doesn't wait immediately
4. **Redirect**: fork, child modifies fd table (`close`, `dup`), exec
5. **Pipe**: fork twice, connect with pipe, each child execs

### Redirect Implementation

```c
int fd = open("output.txt", O_WRONLY);
close(1);    // Close stdout
dup(fd);     // fd becomes new stdout (fd 1)
close(fd);
execlp("cmd", "cmd", NULL);
```

---

## Part 8: Threads and Concurrency (Week 14)

### Threads vs Processes

| Aspect | Process | Thread |
|--------|---------|--------|
| Memory | Separate (copy on fork) | Shared |
| Communication | Pipes, mmap | Direct access |
| Overhead | Higher (copy) | Lower |
| Data races | None by default | Possible on all shared data |

### pthreads

```c
pthread_t tid;
pthread_create(&tid, NULL, thread_func, arg);
pthread_join(tid, &result);
```

### Data Races

- Multiple threads accessing same memory
- At least one write
- No synchronization
- Result: undefined behavior

### Fixing Data Races

**Option 1: Locks**

```c
sem_t lock;
sem_init(&lock, 0, 1);

sem_wait(&lock);   // Acquire
sum += value;      // Critical section
sem_post(&lock);   // Release
```

**Option 2: Local sums**

```c
// Each thread computes local sum
long local_sum = 0;
for (...) { local_sum += ...; }
return local_sum;  // Thread returns result

// Main thread combines results
long total = 0;
for each thread:
    pthread_join(tid, &result);
    total += *(long*)result;
```

### Deadlock

- Two threads, two locks
- Thread A: lock aa, then bb
- Thread B: lock bb, then aa
- Both wait for other - stuck forever
- Prevention: always lock in same order

---

## Key Takeaways

1. **Memory matters**: stack, heap, malloc/free, ownership
2. **System calls**: the boundary between user code and kernel
3. **Processes**: fork/exec/wait for concurrency, pipes for communication
4. **C++**: safer abstractions over C (RAII, smart pointers, containers)
5. **Concurrency**: threads share memory, need synchronization

---

## For Further Study

- Operating Systems (how the kernel works)
- Compilers (parsing, ASTs, optimization)
- Distributed Systems (networking beyond TCP)
- Parallel Computing (locks, barriers, atomics)

