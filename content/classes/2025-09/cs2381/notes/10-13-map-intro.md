---
title: "cs2381 Notes: 10-13 Map Intro"
date: "2025-10-13"
---


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

- ALists
- TreeMap

```java
public record AssocList<K, V>(ConsList<Pair<K, V>> data) {
    // methods
}

record Pair<K, V>(K key, V val) {
    // pass
}
```

Today:

- Finish ConsMap
- Build TreeMap

```java
public record AssocList<K, V>(ConsList<Pair<K, V>> data) {
    // methods
}

record Pair<K, V>(K key, V val) {
    // pass
}
```
