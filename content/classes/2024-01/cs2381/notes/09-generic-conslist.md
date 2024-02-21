---
title: "cs2381 Notes: 09 Generic ConsList"
date: "2024-02-20"
---

Last time we got to something like this:

```java
interface IntList {
    boolean isEmpty();
    int first();
    IntList rest();
    int length();
}

record IntEmpty implements IntList {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public int first() {
       throw new RuntimeError("empty list");
    }
    
    @Override
    public IntList rest() {
       throw new RuntimeError("empty list");
    }

    @Override
    public int size() {
       return 0; 
    }
}

record IntCell(int first, IntList rest) implements IntList {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public int size() {
       return 1 + rest.size(); 
    }
}
```

One key problem here: This list is specific to "int".

Let's take this opportunity to formally introduce generic types.

```java
record IntPair(int left, int right) {

}

record StringPair(String left, String right) {

}

record IntStringPair(int left, String right) {

}
```

That's silly. Those are all the same. Let's abstract over the minor
differences:

```java
record Pair<L, R> (L left, R right) {

}
```

Here's some relevent points about this:

 - This is a generic type.
 - It has type parameters: L, R
 - The constructor has method parameters: left, right
 - We can't actually request a Pair<int, int>, which would be
   exactly the same as IntPair. We must use Pair<Integer, Integer>.
   
Draw the memory diagrams for:

 - IntPair
 - Pair<Integer, Integer>

So IntPair is more compact in memory, which may also make it faster.
But using the Generic pair type makes code easier to maintain.

So when is it worth writing IntPair instead of the generic version
for performance reasons?

Wait, let's consider a broader question:

**When is it worth optimizing?**

Two considerations:

 - Does the performance difference matter?
 - How much code complexity does this add?

Frequently the performance difference doesn't matter. Computers are
fast, and most code isn't performance critical.

There's usually a way to write a program that seems like it should be
just a little bit faster, and it's easy to get distracted by chasing
thsoe options even when they don't matter. Further, optimized code
tends to be more complex and therefore harder to work - so it's not
just time now you're potentially wasting, it's maintence time for the
entire lifespan of the program.

So the general rule for optimizing is this: Don't do it yet.

There's one exception to that:

As we've seen, code in a different complexity class can result in
*drastically* different capabilities. For an extreme example, a O(n^2)
operation can handle a N=50 problem in a fraction of a second, while
an O(2^n) algorithm wouldn't finish on a problem that size before the
computer broke.

If the slower solution is in a slow complexity class (e.g. worse than
O(n^2)), the fast solution is in a significantly better class, and the
fast solution isn't really complex, then it's reasonable to go for the
fast solution to begin with.

So back to our question: When would we consider writing IntPair for
performance?

This only provides a constant factor improvement; the complexity class
won't change. In the most extreme case, it might speed up our program
by something like 10 times.

So:

 - First we write the program with Pair<Integer, Integer>
 - Then we try it on test data and see that it's slow
 - Then we use a tool to profile the code and figure out what part is slow
 - Then we try to come up with a change that would change the computational
   complexity instead.
 - Then we rewrite using IntPair.
 - Then we re-profile.
 - And if that didn't provide a measurable and valuable peformance
   boost, we undo it.

And with that, let's do the thing I wanted to do before:

```java
interface ConsList<T> {
    boolean isEmpty();
    T first();
    ConsList<T> rest();
    int length();
}

record ConsCell<T> implements ConsList<T> {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public T first() {
       throw new RuntimeError("empty list");
    }
    
    @Override
    public ConsList<T> rest() {
       throw new RuntimeError("empty list");
    }

    @Override
    public int size() {
       return 0; 
    }
}

record ConsCell<T>(int first, ConsList<T> rest) implements ConsList<T> {
    @Override
    public boolean isEmpty() {
        return false;
    }
    
    @Override
    public int size() {
       return 1 + rest.size(); 
    }
}
```

Why "ConsList"?

 - Singly linked lists were popularized in the LISP language.
 - The function to create a cell was called CONS for "construct".
 - So a cell created with CONS was a cons cell.


One more thing to add:


```java
interface ConsList<T> {
    ...
    @SafeVarargs
    public static <T> ConsList<T> of(T... args) {
        ConsList<T> ys = new Empty<T>();
        for (int ii = args.length - 1; ii >= 0; --ii) {
            ys = new Cell<T>(args[ii], ys);
        }
        return ys;
    }
```

And that's the singly linked list we're going to be seeing a lot of
this semester.

Stuff to design, including tests.

 - get(int ii)
   - What complexity?
 - maxBy(BiPredicate<T, T> cmp)
   - that's java.util.function.BiPredicate
   - Throw on empty or add default argument
 - insertion sort by
