---
title: "Lecture Notes: 17 Intro to C++"
date: "2025-04-05"
---

## Introducing C++

As a language, C++ is basically just C with three things added:

- Classes
- Generics, in the form of templates
- A larger standard library, including a bunch of abstract data types.

### Generics

```C++
template <typename T>
struct cell {
  T head;
  cell<T>* tail;
};

template <typename T>
cell<T>* cons(T hd, cell<T>* tl) {
  // ...
}
```

That lets us do stuff like:

```C++
    cell<int> xs = cons(3, cons(4, 0));
    auto ys = cons("foo", cons("bar", 0));
```

This causes the compiler to create two instances of the cell struct at
compile time, one where the template is instantiated with T = int, the
other with T = char*, as well as two instances of the cons function.

### Classes

```C++
typedef <typename T>
class Cell {
  public:
    T head;
    Cell<T> tail;

    Cell(T hd, Cell<T> tl)
    {
      this.head = hd;
      this.tail = tl;
    }

    ~Cell()
    {
      if (this.tail) {
        delete this.tail;
      }
    }

    int len()
    {
      if (tail) {
        return 1;
      }
      else {
        return 1 + len(tail);
      }
    }
}

auto xs = new Cell(10, new Cell(20, new Cell(30, 0)));
```

### Standard Library

A better string type:

- std::string

Common data structures:

- std::vector
- std::deque
- std::map
- std::unordered_map
- ...

Algorithms:

- std::sort
- std::stable_sort
- std::binary_search
- std::next_permutation
- ...

Memory:

- std::unique_ptr
- std::shared_ptr

## Demo: ConsList with std::shared_ptr
