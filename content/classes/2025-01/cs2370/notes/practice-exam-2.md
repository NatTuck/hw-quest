---
title: "cs2370 Practice Exam 2"
date: "2025-05-02"
---

# CS2370 Practice Exam 2

This practice exam covers material from the CS2370 course.

## Questions

**Code Output/Return Value Questions**

1.  What will the following Python code print?
    ```python
    a = 10
    b = 3
    print(f"Result: {a * b - (a % b)}")
    ```

2.  What will the following Python code print?
    ```python
    message = "Hello World"
    print(message[6:].lower())
    ```

3.  What will the following Python code print?
    ```python
    data = [10, 20, 30, 40, 50]
    print(data[1:4])
    ```

4.  What is the return value of the following function call?
    ```python
    def process(x, y):
        if x > y:
            return x - y
        else:
            return y // x

    print(process(4, 22))
    ```

5.  What will the following Python code print?
    ```python
    set_a = {10, 20, 30}
    set_b = {20, 40, 50}
    print(sorted(list(set_a.union(set_b))))
    ```

6.  What will the following Python code print?
    ```python
    inventory = {"apples": 5, "bananas": 0, "cherries": 12}
    print(inventory.get("bananas", -1) + inventory.get("grapes", -1))
    ```

7.  Consider the following class. What will the code print?
    ```python
    class Vehicle:
        def __init__(self, kind):
            self.kind = kind
            self.speed = 0
        def accelerate(self, amount):
            self.speed += amount
        def __str__(self):
            return f"{self.kind} at {self.speed} mph"

    car = Vehicle("Car")
    car.accelerate(50)
    print(car)
    ```

8.  What will the following recursive function return when called with `sum_list([1, 2, 3, 4])`?
    ```python
    def sum_list(nums):
        if not nums: # Base case: empty list
            return 0
        else:
            return nums[0] + sum_list(nums[1:])

    print(sum_list([1, 2, 3, 4]))
    ```

9.  What will the following Python code print?
    ```python
    tuple1 = (10, 20)
    tuple2 = tuple1 + (30,)
    print(tuple2[1])
    ```

10. What will the following Python code print?
    ```python
    def update_dict(data, key, value):
        data[key] = value

    my_dict = {'x': 1, 'y': 2}
    update_dict(my_dict, 'z', 3)
    print(my_dict)
    ```

**Conceptual/Design Questions**

11. What is the difference between a `for` loop and a `while` loop in Python? Give a scenario where each is more appropriate.

12. In the Design Recipe, what is the purpose of writing "Types" (or type hints) for a function?

13. Explain the difference between appending to a list (`.append()`) and extending a list (`.extend()`).

14. What is operator overloading in Python? Give an example of an operator that can be overloaded.

15. Why might a recursive solution be elegant for certain problems, but potentially inefficient for others? (Hint: think about function calls).

16. What is the difference between a class attribute and an instance attribute in Python?

17. Describe the process of reading data line-by-line from a text file in Python using a `with` statement. Why is using `with` recommended?

18. What is the role of HTML in a web page? What is the role of CSS?

19. What does the `bs4.BeautifulSoup` object represent when used in web scraping? What method is commonly used to find specific HTML elements (e.g., by tag name or CSS class)?

20. Explain De Morgan's Laws in the context of boolean logic. Provide one of the laws as an example.

