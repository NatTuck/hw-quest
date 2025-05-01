---
title: "cs2370 Practice Exam"
date: "2025-05-01"
---

# CS2370 Practice Exam

This practice exam covers material from the CS2370 course.

## Questions

**Code Output/Return Value Questions**

1.  What will the following Python code print?
    ```python
    x = 5
    y = 2
    print(x // y + x % y)
    ```

2.  What will the following Python code print?
    ```python
    word = "banana"
    count = 0
    for letter in word:
        if letter == 'a':
            count += 1
    print(count)
    ```

3.  What will the following Python code print?
    ```python
    nums = [1, 2, 3]
    nums.append(4)
    nums.insert(1, 5)
    print(nums[2])
    ```

4.  What is the return value of the following function call?
    ```python
    def calculate(a, b=3):
        return a * b + 1

    print(calculate(4))
    ```

5.  What will the following Python code print?
    ```python
    set1 = {1, 2, 3, 4}
    set2 = {3, 4, 5, 6}
    print(len(set1.intersection(set2)))
    ```

6.  What will the following Python code print?
    ```python
    data = {'a': 1, 'b': 2, 'c': 3}
    print(data.get('d', 0) + data.get('a', 0))
    ```

7.  Consider the following class. What will the code print?
    ```python
    class Counter:
        def __init__(self):
            self.count = 0
        def increment(self):
            self.count += 1
        def get_value(self):
            return self.count

    c = Counter()
    c.increment()
    c.increment()
    print(c.get_value())
    ```

8.  What will the following recursive function return when called with `factorial(3)`?
    ```python
    def factorial(n):
        if n == 0:
            return 1
        else:
            return n * factorial(n-1)

    print(factorial(3))
    ```

9.  What will the following Python code print?
    ```python
    list1 = [1, 2]
    list2 = list1
    list1.append(3)
    print(list2)
    ```

10. What will the following Python code print?
    ```python
    def modify_list(items):
        items[0] = 'changed'

    my_list = [10, 20, 30]
    modify_list(my_list)
    print(my_list)
    ```

**Conceptual/Design Questions**

11. Briefly explain the difference between mutable and immutable data types in Python. Give an example of each.

12. What are the five main steps of the Design Recipe for creating functions, as discussed in class?

13. When would you choose to use a dictionary over a list in Python? What is the primary advantage of a dictionary for lookups?

14. What is the purpose of the `self` parameter in Python class methods?

15. What is the base case in a recursive function? Why is it essential?

16. Explain the concept of inheritance in Object-Oriented Programming. What does the `super()` function typically do?

17. What is the difference between `O(n)` and `O(n^2)` complexity? Which one is generally preferred for large inputs?

18. What is the purpose of the `requests` library in Python, in the context of web programming?

19. What does it mean to "scrape" a web page? Which Python library is commonly used for parsing HTML during web scraping?

20. What are the three fundamental boolean operations used in boolean algebra and logic circuits?

---

## Answer Key

1.  `3` (Integer division `5 // 2` is 2. Modulus `5 % 2` is 1. `2 + 1 = 3`)
2.  `3` (The loop counts the occurrences of 'a' in "banana")
3.  `2` (After `append(4)`, `nums` is `[1, 2, 3, 4]`. After `insert(1, 5)`, `nums` is `[1, 5, 2, 3, 4]`. `nums[2]` is `2`)
4.  `13` (The function uses the default value `b=3`. `4 * 3 + 1 = 13`)
5.  `2` (The intersection of `{1, 2, 3, 4}` and `{3, 4, 5, 6}` is `{3, 4}`. The length is 2)
6.  `1` (`data.get('d', 0)` returns `0`. `data.get('a', 0)` returns `1`. `0 + 1 = 1`)
7.  `2` (The `increment` method is called twice, increasing `self.count` from 0 to 2)
8.  `6` (`factorial(3)` calls `3 * factorial(2)`, which calls `2 * factorial(1)`, which calls `1 * factorial(0)`. `factorial(0)` returns `1`. So, `1 * 1 = 1`, then `2 * 1 = 2`, then `3 * 2 = 6`)
9.  `[1, 2, 3]` (`list2` refers to the *same* list object as `list1`. Modifying `list1` also modifies `list2`)
10. `['changed', 20, 30]` (Lists are mutable, so the function modifies the original list passed to it)
11. **Mutable** objects can be changed after creation (e.g., lists, dictionaries, sets). **Immutable** objects cannot be changed after creation (e.g., integers, floats, strings, tuples).
12. 1. Stub with Names and Purpose statement, 2. Types, 3. Tests, 4. Standard pattern, 5. Function body.
13. Use a dictionary when you need efficient lookups based on a unique key. The advantage is typically O(1) (constant time) lookup, whereas list lookup is O(n) (linear time).
14. `self` refers to the instance of the class on which the method is being called. It allows the method to access and modify the instance's attributes.
15. The base case is the condition under which the recursion stops. It's essential to prevent infinite recursion.
16. Inheritance allows a new class (subclass/derived class) to inherit attributes and methods from an existing class (superclass/base class). `super()` is often used in the subclass's `__init__` method to call the superclass's `__init__` method, ensuring proper initialization.
17. `O(n)` (linear time) means the execution time grows proportionally to the input size `n`. `O(n^2)` (quadratic time) means the execution time grows proportionally to the square of the input size. `O(n)` is generally preferred for large inputs as it scales much better.
18. The `requests` library is used to send HTTP requests (like GET, POST) to web servers and receive their responses.
19. Web scraping is the process of automatically extracting data from HTML web pages. BeautifulSoup is commonly used for parsing the HTML structure.
20. AND, OR, NOT.
