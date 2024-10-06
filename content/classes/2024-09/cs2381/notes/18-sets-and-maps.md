---
title: "cs2381 Notes: 18 Sets and Maps"
date: "2024-10-05"
---


**Comparable**

```java
import java.util.Arrays;

    public static void main(String[] args) {
        int[] xs = {3, 2, 5, 4};
        
        for (var xx : xs) {
            System.out.println("" + xx);
        }
        
        Arrays.sort(xs);
        
        for (var xx : xs) {
            System.out.println("" + xx);
        }

        Dog[] ys = {new Dog("Bb"), new Dog("Aa"), new Dog("Cc")};
        
        ...
}

record Dog(String name) implements Comparable<Dog> {
    @Override
    public int compareTo(Dog that) {
        return this.name.compareTo(that.name);
    }
}
```

Now let's actually build the sorted ArraySet.

Let's review adding an iterator (```implements Iterable<T>```).



**Dictionaries / Maps**

Frequently we want to store values associated with keys.

Simple examples:

 - Phone book maps Name to Phone #.
 - DNS servers map domain names to IP addresses 

Interface:


```java
interface Map<K, V> {
    void set(K key, V val);
    V get(K key);
    void del(K key);
    int size();
    
    boolean containsKey(K key);
    Set<K> keySet();
}
```

Implementations:


```java
record Entry<K, V>(K key, V val) {
    // pass
}
    
// An assocation list:
// Immutable, so doesn't match our interface above.
ConsList<Entry<K, V>> alist;

class ConsMap<K, V> implements Map<K, V>{
    ConsList<Entry<K, V>> data;
    
    // Operations create a new ConsList, but we hide that
    // as an implementation detail
}

// Just like set, this could be sorted or unsorted.
ArrayList<Entry<K, V>> array_map;
```
