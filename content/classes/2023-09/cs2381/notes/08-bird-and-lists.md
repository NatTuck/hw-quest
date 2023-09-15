---
title: "cs2381 Notes: 08 Bird and More List"
date: "2023-09-14"
---

**Bird**

From the lab02 starter code, we're going to build the Bird.


**List Operations**


```java
    @Override
    public List<T> reverse() {
        var ys = new Empty<T>();
        return reverseConcat(ys);
    }

    @Override
    public List<T> reverseConcat(List<T> ys) {
        return this.rest.reverseConcat(new Cell<T>(this.first, ys));
    }
```

```java
    record Pet(String species, String name, double weight) {}

    List<Pet> xs = new Empty<Pet>();
    xs = new Cell<Pet>(new Pet("cat", "Fluffy", 3.5));
    xs = new Cell<Pet>(new Pet("dog", "Spot", 6.5));
    xs = new Cell<Pet>(new Pet("cat", "Simba", 6.7));
    xs = new Cell<Pet>(new Pet("dog", "Buddy", 4.5));
    
    // heavier species total (cat or dog)
  
    // totalSpeciesWeight
    // Recursive version
    // for (curr; !curr.empty(); curr = curr.rest()) version
    
    // now implement heavier species
    
    // heaviest animal
    
    // any duplicates? O(n^2)
    // recursive
    // double for loop
    
    // introduce alists if we get this far
```
