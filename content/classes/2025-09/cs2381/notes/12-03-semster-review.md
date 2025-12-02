---
title: "CS2381 Fall 2025 Semester Review"
date: "2025-12-03"
---

# CS2381: Data Structures & Intermediate Programming - Semester Review

## Course Goals
- Master data structures: efficient storage & operations (O(1), O(log n), O(n)).
- Java proficiency: OOP (records, interfaces), Maven, testing (JUnit).
- Algorithm analysis: Big O, amortized time, growth functions.
- Design: Design recipe, immutable/persistent structures.
- Performance: Optimization, concurrency, bits.
- Modern: LLMs integration.

## Java Essentials
```
- Programs: public class App { public static void main(String[] args) { ... } }
- Types: primitives (int, double), String, wrappers (Integer), generics <T>.
- Records: immutable data (record Point(double x, y) {}).
- Interfaces: contracts (interface List<T> { T get(int i); }).
- Maven: pom.xml, mvn compile test exec:java package.
- JUnit: @Test void should_foo() { assertEquals(...); }
```

**Design Recipe** (for methods):
1. Javadoc (@param, @return).
2. Stub (static Type name(Type arg)).
3. Tests (happy path, edges).
4. Body (pattern match primary arg).
5. Refine tests.

## Complexity & Growth
```
f(n):
- O(1): constant (array access).
- O(log n): binary search, balanced trees.
- O(n): linear scan, insert/delete lists.
- O(n log n): sort, scapegoat rebuild.
- O(n²): bubble sort.
- Amortized: ArrayList grow (double capacity).

Growth: drop constants/low terms → 1 < log n < n < n log n < n² < 2ⁿ.
```

## Sequences: Lists
```
- ArrayList: O(1) get/set amortized add, poor delete front.
- LinkedList: O(1) add/remove ends, O(n) random access.
- ConsList: immutable singly-linked, O(n) access, persistent.

Bubble Sort: O(n²), reveals list perf differences.
ListIterator: bidirectional traversal w/ modify.
```

## Stacks, Queues, Deques
```
Stack<T> (LIFO): push/pop/peek/empty → ConsList O(1).
Queue<T> (FIFO): push(shift)/shift/first → RingBuffer (circular array).
Deque<T>: push/pop + unshift/shift/first/last → RingBuffer O(1) amortized.

Apps: undo (stack), BFS (queue), job scheduling.
Two-list queue: amortized O(1) w/ reverse on empty front.
```

## Maps & Sets
```
Map<K,V>: put/get/del/contains/size.
- AssocList: O(n) all ops.
- TreeMap: O(log n) balanced BST.
- HashMap: O(1) expected (linear probe, tombstone, grow @55% load).

Set<T>: add/remove/contains/union/intersect/subset.
- ConsSet/ArraySet/TreeSet/SkipList.
SkipList: probabilistic O(log n) w/ multi-level links (p=0.5).
```

## Trees
```
Binary Search Tree (BST): left < data < right.
- insert/contains/remove: O(h), h=log n balanced → O(log n).
- each/inorder: Consumer<T>.
- merge: recursive insert.

Imbalance: insert sorted → O(n) chain.
Scapegoat: rebuild subtree if depth > 2 log n, α=0.7 imbalance.
  - Collect inorder → build balanced (mid root, recurse).
```

## Graphs
```
Graph: V vertices, E⊆V×V edges.
Reps:
- Map<K,Set<K>> adj (directed), prereqs/postreqs.
- Node{children/parents} (DAG).

Undirected/weighted: Map<K,Map<K,Weight>>.
Shortest Path:
- BFS/DFS: explore (visited set).
- Dijkstra: priority queue (dist, prev), relax edges.
- A*: heuristic (dist + est to goal).
```

## Bits & Space Efficiency
```
BitVec: byte[] bits → get/set/add O(1) amortized.
BitSet: fixed N → union/intersect/diff = bitwise OR/AND/XOR.
Bloom Filter: k hashes → bit array, approx set (false pos, no false neg).
  - Space: m bits >> n items, low fp rate.
```

## Concurrency
```
Threads: new Thread(Runnable).start()/join().
Race: shared sum → wrong (ThreadLocal?).
Lock: synchronized(mutex) { critical } → sequential.
Deadlock: A locks1 wants2, B locks2 wants1 → order locks.

Primes: sieve + threads + BitSet → 1e9 in <10s.
```

## LLMs Integration
```
- llama.cpp: GGUF models (Qwen-VL), OpenAI API.
- LangChain4J: AiServices.builder(model).create(Tool.class).
@UserMessage("Count {{what}}") int count(@V("what") String, ImageContent).
VL: base64 image → (text,img) → structured out.
```

## Final Exam Prep
- Practice: last sem's final on site.
- Know: complexities, implement stack/queue/map/tree/graph algos.
- Code: design recipe, tests, Java syntax.
- Draw: trees/graphs, Big O proofs (amortized).

Review notes, labs, homeworks. Good luck!
