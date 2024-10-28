---
title: "cs2381 Notes: 26 Implement Hashmap"
date: "2024-10-27"
---

## This is just the same code from last time

Here's a HashMap with Linear Probing:

```java
package demo;

import java.util.ArrayList;
import java.lang.reflect.Array;

public class HashMap<K, V> {
    Entry<K, V>[] data;
    int size;

    Entry<K, V> empty;
    Entry<K, V> tomb;

    public HashMap() {
        this.empty = new Empty<K, V>();
        this.tomb = new Tomb<K, V>();

        this.data = newArray(4);
        this.size = 0;
        for (int ii = 0; ii < this.data.length; ++ii) {
            this.data[ii] = empty;
        }
    }

    void grow() {
        var prevData = this.data;
        this.data = newArray(2*prevData.length);
        this.size = 0;

        for (int ii = 0; ii < this.data.length; ++ii) {
            this.data[ii] = empty;
        }

        for (int ii = 0; ii < prevData.length; ++ii) {
            var ent = prevData[ii];
            if (ent.isPair()) {
                put(ent.key(), ent.val());
            }
        }
    }

    @SuppressWarnings("unchecked")
    Entry<K, V>[] newArray(int size) {
        return (Entry<K, V>[]) Array.newInstance(Entry.class, size);
    }

    public void put(K key, V val) {
        if (loadFactor() > 0.55) {
            grow();
        }

        Entry<K, V> ent = new Pair<K, V>(key, val);
        int code = key.hashCode();

        for (int ii = 0; ii < capacity(); ++ii) {
            int jj = modn(code + ii);

            if (this.data[jj].isEmpty() || this.data[jj].isTomb()) {
                System.out.println("inserted " + key + " at index " + jj);
                this.data[jj] = ent;
                this.size += 1;
                return;
            }

            if (this.data[jj].isPair()) {
                if (this.data[jj].key().equals(key)) {
                    this.data[jj] = ent;
                    return;
                }
            }
        }

        throw new RuntimeException("can't happen");
    }

    public boolean hasKey(K key) {
        return getOrNull(key) != null;
    }

    public V get(K key) {
        V yy = getOrNull(key);
        if (yy == null) {
            throw new RuntimeException("key not found");
        }
        return yy;
    }

    public V getOrNull(K key) {
        int code = key.hashCode();
        
        for (int ii = 0; ii < capacity(); ++ii) {
            int jj = modn(code + ii);

            var ent = this.data[jj];

            if (ent.isEmpty()) {
                return null;
            }

            if (ent.isPair()) {
                if (ent.key().equals(key)) {
                    return ent.val();
                }
            }
        }

        return null;
    }

    public void del(K key) {
        int code = key.hashCode();

        for (int ii = 0; ii < capacity(); ++ii) {
            int jj = modn(code + ii);

            var ent = this.data[jj];

            if (ent.isEmpty()) {
                return;
            }

            if (ent.isPair()) {
                if (ent.key().equals(key)) {
                    this.data[jj] = tomb;
                    this.size -= 1;
                }
            }
        }
    }

    ArrayList<K> keys() {
        var ys = new ArrayList<K>();
        for (int ii = 0; ii < capacity(); ++ii) {
            if(this.data[ii].isPair()) {
                ys.add(this.data[ii].key());
            }
        }
        return ys;
    }

    double loadFactor() {
        return ((double) size()) / ((double) capacity());
    }

    int capacity() {
        return this.data.length;
    }

    int size() {
        return size;
    }

    int modn(int xx) {
        return Math.floorMod(xx, this.data.length);
    }
}

interface Entry<K, V> {
    default boolean isEmpty() { return false; }
    default boolean isTomb() { return false; } // Leave off Tomb to start
    default boolean isPair() { return false; }
    default K key() { throw new RuntimeException("not pair"); }
    default V val() { throw new RuntimeException("not pair"); }
}

record Empty<K, V>() implements Entry<K, V> {
    @Override
    public boolean isEmpty() {
        return true;
    }
}

record Tomb<K, V>() implements Entry<K, V> {
    @Override
    public boolean isTomb() {
        return true;
    }
}

record Pair<K, V>(K key, V val) implements Entry<K, V> {
    @Override
    public boolean isPair() {
        return true;
    }
}
```



Demo code:

```java
        var sounds = new HashMap<String, String>();
        sounds.put("cow", "moo");
        sounds.put("dog", "arf");
        System.out.println("size " + sounds.size());
        System.out.println("keys " + sounds.keys());
        System.out.println("cow says " + sounds.get("cow"));
        sounds.del("cow");
        System.out.println("size " + sounds.size());
        System.out.println("keys " + sounds.keys());

        var squares = new HashMap<Integer, Integer>();
        for (int ii = 0; ii < 100; ii += 5) {
            squares.put(ii, ii*ii);
        }

        System.out.println("20*20 = " + squares.get(20));
        System.out.println("size " + squares.size());
        System.out.println("capacity " + squares.capacity());
        System.out.println("keys " + squares.keys());
```
