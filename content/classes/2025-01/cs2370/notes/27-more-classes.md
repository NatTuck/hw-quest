---
title: "cs2370 Notes: 27 More Inheritence"
date: "2025-03-27"
---


```python
class LibraryItem:
    def __init__(self, title):
        self.title = title
        self.is_checked_out = False
        print(f"LibraryItem initialized: {self.title}")

    def check_out(self):
        if not self.is_checked_out:
            self.is_checked_out = True
            return f"{self.title} has been checked out."
        return f"{self.title} is already checked out."

class Book(LibraryItem):
    def __init__(self, title, author):
        super().__init__(title)
        self.author = author
        print(f"Book initialized: {self.title} by {self.author}")

    def check_out(self):
        return super().check_out() + " (Book)"

class DVD(LibraryItem):
    def __init__(self, title, director):
        super().__init__(title)
        self.director = director
        print(f"DVD initialized: {self.title}, directed by {self.director}")

    def check_out(self):
        return super().check_out() + " (DVD)"

class HybridItem(Book, DVD):  # Diamond inheritance: inherits from Book and DVD
    def __init__(self, title, author, director):
        super().__init__(title, author)  # Calls Book's __init__
        DVD.__init__(self, title, director)  # Explicitly call DVD's __init__
        print(f"HybridItem initialized: {self.title}")


# Usage
book = Book("1984", "George Orwell", "978-0451524935")
dvd = DVD("Inception", "Christopher Nolan", 148)
print(book.check_out())  # "1984 has been checked out."
print(dvd.check_out())  # "Inception (DVD) has been checked out."

# Complications
hybrid = HybridItem("The Making of Star Wars", "George Lucas", "George Lucas")
print(hybrid.check_out())
```

Library:

```python
class Library:
    def __init__(self):
        self.items = []
    
    def add_item(self, item):
        self.items.append(item)
    
    def checkout_by_title(self, title):
        for item in self.items:
            if item.title == title:
                return item.check_out()
        return "Item not found."

# Usage
lib = Library()
lib.add_item(Book("Fahrenheit 451", "Ray Bradbury", "978-1451673319"))
lib.add_item(DVD("Blade Runner", "Ridley Scott", 117))
print(lib.checkout_by_title("Fahrenheit 451"))  # "Fahrenheit 451 has been checked out."
```
