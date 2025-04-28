---
title: "cs2370 Notes: 37 Data Structures Preview"
date: "2025-04-27"
---

This course is part 1 of a two-part sequence.



## Java

```java
public class Hello {
  public static void main(String[] args) {
    System.out.println("Hello");
  }
}
```

## Computational Complexity

```java
import java.util.Arrays;

public class CompactBigOCatDemo {
    record Cat(String n, int a) {} // Java 14+ Record for concise Cat class

    public static void main(String[] args) {
        Cat[] cats = { new Cat("W", 3), new Cat("S", 5), new Cat("M", 2), new Cat("L", 7)};
        int n = cats.length; // Array size
        System.out.println("Cats: " + Arrays.toString(cats) + ", n=" + n);

        // O(1): Constant time - Accessing one element (e.g., the first)
        System.out.println("O(1): " + (n > 0 ? cats[0] : "N/A")); 

        // O(n): Linear time - Iterating through all elements once
        System.out.print("O(n): ");
        for (Cat cat : cats) System.out.print(cat.n() + " "); // Print name
        System.out.println();

        // O(n^2): Quadratic time - Nested loop (e.g., simple pair interaction/count)
        long oN2Ops = 0; // Counter for operations in nested loops
        for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) oN2Ops++; // Increment counter n*n times
        System.out.println("O(n^2) ops: " + oN2Ops); // Display n*n count
    }
}
```

## Show linked list in Python

```python
from collections import namedtuple
import sys

# Increase recursion depth limit for potentially deep recursive sum (though iterative is safer)
# sys.setrecursionlimit(2000) # Usually not needed for small examples

# 1. Define the Node structure using namedtuple
# A 'ConsCell' holds a 'value' and a reference ('next') to the rest of the list.
ConsCell = namedtuple('ConsCell', ['value', 'next'])

# The end of the list is represented by None

# 2. Helper function to create a list from a Python iterable (like a list or range)
def create_linked_list(items):
    """Creates a singly-linked list from an iterable."""
    head = None
    # Iterate backwards to build the list from tail to head
    for item in reversed(items):
        head = ConsCell(value=item, next=head)
    return head

# 3. Helper function to print the linked list (for visualization)
def print_linked_list(node):
    """Prints the values in the linked list."""
    elements = []
    current = node
    while current is not None:
        elements.append(str(current.value))
        current = current.next
        if current is node: # Basic cycle detection
            elements.append("... CYCLE DETECTED ...")
            break
    print("LinkedList: -> " + " -> ".join(elements) + " -> None")

# 4. Function to sum the values in the linked list (Iterative approach)
def sum_linked_list_iterative(node):
    """Calculates the sum of values in the linked list iteratively."""
    total = 0
    current = node
    while current is not None:
        # Ensure value is summable (e.g., a number)
        if isinstance(current.value, (int, float)):
            total += current.value
        else:
            print(f"Warning: Skipping non-numeric value '{current.value}'")
        current = current.next
    return total

# --- Demonstration ---

# Create a sample list: 1 -> 2 -> 3 -> 4 -> None
my_list_head = create_linked_list([1, 2, 3, 4])

print("Created a Linked List:")
print_linked_list(my_list_head)

# Calculate the sum
list_sum = sum_linked_list_iterative(my_list_head)
print(f"\nSum of the list values: {list_sum}")

# Demonstrate with an empty list
empty_list = create_linked_list([])
print("\nCreated an empty Linked List:")
print_linked_list(empty_list)
empty_sum = sum_linked_list_iterative(empty_list)
print(f"Sum of the empty list values: {empty_sum}")

# Demonstrate with non-numeric data (optional)
mixed_list = create_linked_list([10, "apple", 20, 30])
print("\nCreated a mixed-data Linked List:")
print_linked_list(mixed_list)
mixed_sum = sum_linked_list_iterative(mixed_list)
print(f"Sum of numeric values in mixed list: {mixed_sum}")
```

## Now let's do a binary tree.

- Set
- O(log n)
