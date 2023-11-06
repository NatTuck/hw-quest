---
title: "cs2381 Notes: 28 Representing Graphs"
date: "2023-11-05"
---

**First, Scapegoat Tree**

Let's go ahead and complete that portion of Lab 09.

Notes:

 - Starting from starter-lab09
 - Print solution/TreeMap.java
 
**Graphs**

Formally, a Graph is:

 - A set of Vertices, v ∈ V
 - A set of Edges, e ∈ E, (E subset V×V), (e ∈ V×V).

Cartesian Product (×) of sets is every pair of one element from the
first set and one from the second.

So {1, 2}×{a, b, c} is {(1,a), (1,b), (1,c), (2,a), (2,b), (2,c)}.

Draw example:

![course sequence](../images/course-seq-2023.svg)

That's not a tree because there isn't one root, but it is a directed
acyclic graph.

Representing that graph:

 - We can just use integers for courses.
 - We could have two sets:
   - A set of vertices (course numbers)
   - A set of edges (pairs of course numbers)

Is that a good representation? Why?

With any data structure representation, we need to figure out
what we want to do.

For the course graph, we want to ask questions like:

 - What are the prereqs of a course.
 - How many courses do you need to take before you can take
   a course.
 - How many courses require this course, directly or indirectly.

The two sets representation isn't great.

 - Is 2370 a prereq of 2381? Fast: we can just ask E.contains((2370, 2381)).
 - What are the prereqs of 3720? Slow.
   - We can do a contains check for each pair (x, 3721).
   - We can traverse the full set of edges and check each for a destination
     of 3721.

If we want to look up prereqs fast, we could instead have:

```java
Map<CourseNumber, Set<CourseNumber>> prereqs;
```

If we also want to look up postreqs fast, we also need:

```java
Map<CourseNumber, Set<CourseNumber>> postreqs;
```

And so maybe a good graph representation would both of those maps.

How to count transitive prereqs?

**Why not just do it like a tree?**

For trees, we've been using node objects with fields for children.
This graph has some key differences from that:

 - There's no single root, so a single reference isn't enough to
   start any useful traversal.
 - We want to traverse in both directions, so just having child refs
   wouldn't be enough.

But we could usefully represent a DAG like:

```java
class Dag {
    // A "root" here is a node with no parents.
    Node[] roots;
}

class Node {
    Node[] parents;
    Node[] children;
}
```

Draw second example:

![nh map](../images/new-hampshire-road-map.gif)

This is an undirected graph.

We can think of an undirected graph as simply being a directed graph
with a back edge for every forward edge, or we can come up with a
dedicate representation for it.

For this graph, we want to ask questions like:

 - What's the fastest way to drive from Plymouth to Portsmouth?
 - What cities are closest to Keene?

For those questions, counting edges isn't sufficient. We'd like to
know distances in miles or minutes or something.

For that, we want edge weights. We'll label each edge with a value -
traversal time in minutes. That'll let us calculate fastest paths,
which is useful.

So how can we represent this?

 - Set of Vertices + Map of (Edge -> Weight)?
   - Two edges for each undirected edge?
   - Sort edges so they have a canonical order?
 - A map ```City -> Neighbors```?
 - A structure where each node has a list of its neighbors?

```java
class Node {
    String name;
    double latitude;
    double logitude;
    Node[] neighbors;
}

TreeMap<String, Node> cities;
```

Note that because this graph has cycles, there's no way to make this
an immutable data structure. You can't fill in all the neighbors
arrays until after all of the Nodes are allocated.

If we want an immutable data structure:

 - ```Map<Name, NodeMeta>```
 - ```Map<Name, Set<NeighborName>>```


## Shortest Path on Graph

 - Given a graph.
 - And a source vertex.
 - And a destination vertex.
 - What's the shortest path from source to destination on the graph.

Plan A:

 - Pick an edge from the current node and follow it.
 - Repeat with the next node
 - Problem: Cycles

Plan B:

 - Mark the current node (mutate the node, keep a set of marked nodes, etc).
 - Pick an edge from the current node to an unmarked node.
 - Repeat with the next node
 - Problem: Dead ends

Plan C:

 - If we pick the wrong edge, we need to be able to go back and try another
   choice. This is called "backtracking".
 - We can handle this recursively:

```
function findPath(Node current, Node dest, List pathSoFar):
    if current.equals(dest):
       return cons(current, pathSoFar).reverse()
    for (edge : current.outEdges()):
       if edge not in pathSoFar:
          return findPath(edge, cons(current, dest, pathSoFar))
```
  
 - Now we will find a path if there is one.
 - Problem: Inefficient paths

Plan D:

 - For each node, track the following info in a single mutable map:
   - Estimated distance.
     - Intially zero for starting node, +inf for others.
   - Best previous node.
     - Initially null.
   - Fully Explored.
     - Initially false.
 - Keep a priority queue of next nodes to explore.
 - For the current node:
   - Check each neighboring node that isn't fully explored.
   - If the path through the current node is shorter, update
     the best previous and distance to use that and add that
     node to the priority queue with distance as priority.
   - Once all neighbors have been checked, mark this node as
     fully explored.
 - Pull next node from the priority queue. If this one's already
   explored, pull another one.
 - Once the dest is reached, traverse previouses.

That's Dijkstra's Algorithm

Plan E:

 - Use estimated distance - including distance to goal - to order
   priority queue.
   
That's A*


Links:

 - NH map from https://www.state-maps.org/
