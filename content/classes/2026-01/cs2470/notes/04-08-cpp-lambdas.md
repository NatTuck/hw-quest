---
title: "Lecture Notes: 04-08 C++ Lambdas and Modern Syntax"
date: "2026-04-06"
---

## Review

We've covered:

- Templates (generics)
- Classes with constructors/destructors
- Smart pointers (unique_ptr, shared_ptr)
- RAII pattern

Today: Modern C++ syntax that makes code more expressive and concise.

---

## Range-Based For Loops

Instead of the verbose iterator pattern:

```cpp
for (auto it = vec.begin(); it != vec.end(); ++it) {
    std::cout << *it << "\n";
}
```

We can write:

```cpp
for (const auto& item : vec) {
    std::cout << item << "\n";
}
```

**Capture variants:**

- `const auto&` - read-only access, no copies
- `auto&` - modify elements in place
- `auto` - copy each element (modifications don't affect original)
- `auto&&` - forwarding reference (works with temporaries)

Works with any type that has `begin()` and `end()` methods.

---

## Lambda Expressions

Lambdas are anonymous functions - useful for short callbacks and local logic.

### Basic Syntax

```cpp
[ capture_clause ] ( parameters ) -> return_type {
    body
}
```

Example:

```cpp
auto add = [](int a, int b) { return a + b; };
int result = add(3, 4);  // 7
```

### Capture Modes

The capture clause controls what variables from the enclosing scope are available:

| Syntax | Meaning |
|--------|---------|
| `[]` | Capture nothing |
| `[=]` | Capture everything by value |
| `[&]` | Capture everything by reference |
| `[x]` | Capture `x` by value |
| `[&x]` | Capture `x` by reference |
| `[x, &y]` | Capture `x` by value, `y` by reference |
| `[this]` | Capture the current object pointer |

**Example with capture:**

```cpp
int threshold = 10;
auto is_big = [threshold](int n) { return n > threshold; };
```

### Generic Lambdas (C++14)

Use `auto` for parameters:

```cpp
auto add = [](auto a, auto b) { return a + b; };
add(1, 2);        // int
add(1.5, 2.5);    // double
add(std::string("hello"), std::string(" world"));  // string
```

---

## Demo: Filtering with Lambdas

### Using `std::copy_if`

Copy elements matching a predicate to a new container:

```cpp
#include <vector>
#include <algorithm>
#include <iterator>

std::vector<int> numbers = {1, -2, 3, -4, 5, -6, 7};
std::vector<int> positives;

std::copy_if(numbers.begin(), numbers.end(),
             std::back_inserter(positives),
             [](int n) { return n > 0; });
// positives: {1, 3, 5, 7}
```

### The Erase-Remove Idiom

Remove elements from a vector in-place:

```cpp
// Remove all negative numbers
numbers.erase(
    std::remove_if(numbers.begin(), numbers.end(),
                   [](int n) { return n < 0; }),
    numbers.end()
);
// numbers: {1, 3, 5, 7}
```

`std::remove_if` doesn't actually remove - it moves elements to keep to the front and returns an iterator to the new end. `erase` then removes the trailing elements.

### Sorting with Custom Comparator

```cpp
std::vector<std::string> names = {"Alice", "bob", "Charlie", "dave"};

// Case-insensitive sort (capturing nothing)
std::sort(names.begin(), names.end(),
    [](const std::string& a, const std::string& b) {
        return std::lexicographical_compare(
            a.begin(), a.end(), b.begin(), b.end(),
            [](char c1, char c2) { return std::tolower(c1) < std::tolower(c2); }
        );
    });
```

---

## Structured Bindings (C++17)

Unpack multiple values from tuples, pairs, or structs:

```cpp
std::map<std::string, int> scores;
scores["Alice"] = 100;
scores["Bob"] = 85;

// Old way:
for (const auto& pair : scores) {
    std::cout << pair.first << ": " << pair.second << "\n";
}

// With structured bindings:
for (const auto& [name, score] : scores) {
    std::cout << name << ": " << score << "\n";
}
```

Works with:

- `std::pair`
- `std::tuple`
- Arrays (fixed-size)
- Structs with public members

---

## `std::optional<T>` (C++17)

Represents a value that may or may not be present:

```cpp
#include <optional>

std::optional<int> find_index(const std::vector<int>& vec, int target) {
    for (size_t i = 0; i < vec.size(); ++i) {
        if (vec[i] == target) {
            return static_cast<int>(i);
        }
    }
    return std::nullopt;  // No value
}

// Usage:
auto result = find_index(vec, 42);
if (result.has_value()) {
    std::cout << "Found at index " << result.value() << "\n";
}
// Or:
if (result) {
    std::cout << "Found at index " << *result << "\n";
}
```

Safer than returning "magic values" like -1.

---

## `constexpr` (Compile-Time Evaluation)

`constexpr` tells the compiler that an expression can be evaluated at compile time:

```cpp
constexpr int square(int x) { return x * x; }

int arr[square(5)];  // OK: array size is compile-time constant

constexpr int fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

const int x = fib(10);  // Computed at compile time
```

**Why use it?**

- Performance: computation happens at compile time, not runtime
- Can be used in contexts requiring compile-time constants (array sizes, template args)

C++11: `constexpr` functions limited to single return statement
C++14: Relaxed constraints (loops, local variables allowed)
C++17: `constexpr if`, more stdlib functions constexpr
C++20: `constexpr` virtual functions, `constexpr` dynamic allocation

---

## C++20 Ranges

The ranges library provides a composable way to work with sequences:

```cpp
#include <ranges>
#include <vector>
#include <iostream>

std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

// Pipeline syntax with | operator
auto result = numbers
    | std::views::filter([](int n) { return n % 2 == 0; })
    | std::views::transform([](int n) { return n * n; })
    | std::views::take(3);

// result: 4, 16, 36 (squares of first 3 even numbers)

// Ranges are lazy - nothing computed until we iterate
for (int n : result) {
    std::cout << n << " ";
}
```

**Key features:**

- **Lazy evaluation**: transformations don't happen until needed
- **Composability**: chain operations with `|`
- **Views**: lightweight, non-owning references to data
- No more `begin()/end()` boilerplate:

```cpp
// C++17: std::sort(vec.begin(), vec.end())
// C++20: std::ranges::sort(vec)
```

---

## Summary

| Feature | Version | Purpose |
|---------|---------|---------|
| Range-based for | C++11 | Cleaner iteration |
| Lambdas | C++11 | Anonymous functions, callbacks |
| Generic lambdas | C++14 | `auto` parameters in lambdas |
| Structured bindings | C++17 | Unpack tuples/pairs |
| `std::optional` | C++17 | Nullable values without pointers |
| `constexpr` | C++11/14/17/20 | Compile-time evaluation |
| Ranges | C++20 | Composable, lazy sequence operations |

---

## References

- [cppreference: Lambda expressions](https://en.cppreference.com/w/cpp/language/lambda)
- [cppreference: Structured binding declaration](https://en.cppreference.com/w/cpp/language/structured_binding)
- [cppreference: std::optional](https://en.cppreference.com/w/cpp/utility/optional)
- [cppreference: Ranges library](https://en.cppreference.com/w/cpp/ranges)
