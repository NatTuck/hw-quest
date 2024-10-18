---
title: "cs2381 Notes: 23 Some Immutable Maps"
date: "2024-10-17"
---

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
