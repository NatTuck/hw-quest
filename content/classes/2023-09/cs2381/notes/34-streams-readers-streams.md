---
title: "Notes: 34 Streams, Readers, and Streams"
date: "2023-11-19"
---

## Final Exam

Final Exam in Syllabus confirmed: Mon Dec 11th, 11am-1:30pm in D&M 442


## Lab 12

Errata: Some valid approaches run out of memory on 1B primes on
Inkfish. You may, optionally, change the ```PrimesCcShould#find_1b_primes```
test to use 2 threads instead of 8.

Problem: You want to find primes up to 10B, but BitSet only takes "int" args.

Solution: LongBitSet

 - http://home.apache.org/~rmuir/jacoco-core/org.apache.lucene.util/LongBitSet.java.html
 - https://mvnrepository.com/artifact/org.apache.lucene/lucene-core/9.8.0

Show adding LongBitSet to lab12.


## Sequences

Last time we talked about collections, which can be viewed as a
sequence of items (explictly, with a for-each loop).

There are a couple other kinds of sequence that anyone who is writing
Java programs should know about.

Show the readWords method in the demo app.

```java
    Stream<String> readWords() {
        var raw = WordCount.class.getResourceAsStream("/words.txt.gz");
        var unz = new GZIPInputStream(raw);
        var rdr = new InputStreamReader(unz);
        var buf = new BufferedReader(rdr);
        return buf.lines();
    }
```

There are a couple different things going on in that method:

 - When you open a file or network socket, you get an InputStream.
   This is a single-use sequence of bytes.
 - Java makes a strong distinction between bytes and text characters, so
   bytes need to be decoded to get text.
   - Talk about ASCII, latin-1, Uncode, ucs2, utf16, utf8
   - InputStreamReader adapts our InputStream to a Reader.
 - BufferedReader adds some methods that require looking forward in
   the stream - specifically, readLine()
 - The buf.lines() method returns a ```Stream<String>```, where the
   word "stream" is unrelated to InputStream.

InputStream has:

 - read, which reads one byte
 - read(array), which reads a full fixed size array worth of bytes
 
Reader has:

 - read, which reads one character
 - read(array), which reads a full array

BufferedReader has:

 - an internal buffer (think ```ArrayList<Char>```) so it can internally store however
   many characters it needs to find the end of a line
 - readLine, which reads a full line of text

Stream is a completely new way to deal with arbitrary sequences of
objects. It's like a Collection, except:

 - You can only go through a Stream once
   - This makes sense in the example - lines are produced one at a time by
     reading the InputStream.
 - Streams are lazy - operations on streams don't happen until they
   have to: either something happens to the values, or they are collected
   into a List or array.
 - Streams provide a bunch of traditionally functional stuff like filter, map,
   etc.
 - Streams can sometimes execute in parallel.
 
Let's use our stream and collections to:

 - Count the words
 - Find the longest words
 - Count words longer than 5 characters
 - Count words of each length
 - Find longest word starting with each letter
