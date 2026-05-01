---
title: "Notes: 05-01 Semester Review"
date: "2026-04-29"
---

## CS3221: What Did We Learn This Semester?

*A 40-minute tour through Analysis of Algorithms*

---

## Part 1: The Big Picture (2 minutes)

**Why this course matters:**

- **Practical**: You will write code to solve problems. Is there an easy, efficient algorithm? Is it basically impossible? Is it possible but worth optimizing?
- **Curriculum**: Sets you up for Comp Theory next semester
- **Future Study**: Grad school algorithms, or recognizing graph algorithms and reductions in the wild

**Three fundamental questions we now know how to answer:**

1. How do we analyze how long an algorithm takes?
2. How do we design algorithms for hard problems?
3. How do we know when a problem is *too* hard?

---

## Part 2: Analysis Fundamentals (5 minutes)

### From Counting to Big-O

We started with simple counting: How many words in the 99 Bottles song? How about 12 Days of Christmas?

**Key insight**: For large inputs, we care about growth rates, not exact counts.

### Asymptotic Notation

| Notation | Meaning | Intuition |
|----------|---------|-----------|
| $O(g(n))$ | Upper bound | $f$ grows no faster than $g$ |
| $\Omega(g(n))$ | Lower bound | $f$ grows at least as fast as $g$ |
| $\Theta(g(n))$ | Tight bound | $f$ grows exactly like $g$ |

**Complexity Hierarchy:**
$$O(1) \subset O(\log n) \subset O(\sqrt{n}) \subset O(n) \subset O(n \log n) \subset O(n^2) \subset O(2^n) \subset O(n!)$$

### Recursion Trees

For recursive algorithms, draw the tree:

- **Level 0**: Root does non-recursive work
- **Level i**: $b^i$ nodes, each doing work on input size $n/b^i$
- **Sum across all levels** for total work

**Merge Sort example**: $T(n) = 2T(n/2) + O(n) = O(n \log n)$

Let's do:

- binary search.
- counting ways to make change with coin list and target

---

## Part 3: Algorithm Design Paradigms (10 minutes)

### Three Problem Categories

We learned to recognize problem structure and match it to the right approach:

| Paradigm | Problem Structure | Time Complexity | Examples |
|----------|------------------|-----------------|----------|
| **Backtracking** | Must try all sequences of choices | Exponential ($O(2^n)$) | Subset Sum, game trees |
| **Dynamic Programming** | Overlapping subproblems, optimal substructure | Polynomial ($O(n), O(n^2)$) | Robber problem, LIS, Min Path Sum |
| **Greedy** | Local optimal = Global optimal | Polynomial ($O(n \log n)$) | Most Meetings, MST |

### Dynamic Programming Recipe

1. **Define subproblems**: What's the recurrence?
2. **Base cases**: Where does the recursion stop?
3. **Table/Memoization**: Store results to avoid recomputation
4. **Build solution**: Combine subproblem answers

**Example - House Robber**:

- Either rob house $i$ (get value + best from $i+2$) or don't (best from $i+1$)
- $dp[i] = \max(values[i] + dp[i+2], dp[i+1])$

### Greedy Algorithms Require Proof

**Most Meetings Problem**: Sort by finish time, greedily take earliest-finishing compatible meeting.

**Why it works** (greedy stays ahead):

- Let $F$ be the meeting that finishes first
- Any optimal schedule can be modified to include $F$ (exchange argument)
- Repeat on remaining compatible meetings

**Important**: Not all problems work with greedy! Minimum Path Sum requires DP.

---

## Part 4: Graph Algorithms (10 minutes)

### Graph Basics

- **Representations**: Adjacency matrix vs. adjacency list
- **DFS**: Pre-order, post-order, topological sort (reverse post-order)
- **Edge types**: Tree edges, back edges (cycles!), forward edges, cross edges

### Minimum Spanning Tree

Given: Connected, undirected, weighted graph  
Find: Tree connecting all vertices with minimum total weight

**Key Lemma**: The MST contains every safe edge (minimum weight edge crossing a cut).

| Algorithm | Approach | Time Complexity |
|-----------|----------|-----------------|
| **Boruvka's** | Add safe edges for all components in parallel | $O(|E| \log |V|)$ |
| **Prim's** | Grow tree from start, add min edge | $O(|E| \log |V|)$ with heap |
| **Kruskal's** | Sort edges, add if no cycle (union-find) | $O(|E| \log |E|)$ |

**Union-Find**: Path compression + union by rank for nearly constant time.

### Shortest Paths

| Algorithm | Graph Type | Time Complexity | Key Idea |
|-----------|------------|-----------------|----------|
| **BFS** | Unweighted | $O(|V| + |E|)$ | Level-order traversal |
| **Dijkstra's** | Weighted, non-negative | $O(|E| \log |V|)$ | Best-first (greedy) |
| **Bellman-Ford** | Weighted (allows negative) | $O(|V||E|)$ | Relax all edges $|V|-1$ times |
| **Floyd-Warshall** | All-pairs | $O(|V|^3)$ | DP: gradually allow more intermediate vertices |

**Relaxation**: If $dist[u] + w(u,v) < dist[v]$, update $dist[v]$.

### Max Flow / Min Cut

**Flow**: Assignment of values to edges respecting capacity constraints  
**Cut**: Partition $(S, T)$ with $s \in S, t \in T$; capacity = sum of edges $S \to T$

**Max-Flow Min-Cut Theorem**: Maximum flow value = Minimum cut capacity

**Ford-Fulkerson Algorithm**:

1. Find augmenting path in residual graph
2. Push flow equal to bottleneck capacity
3. Update residual capacities
4. Repeat until no augmenting path exists

**Applications**:

- Edge-disjoint paths (unit capacities)
- Bipartite matching
- Scheduling/resource allocation problems

---

## Part 5: Complexity Theory (10 minutes)

### Decision Problems & Complexity Classes

**P**: Problems solvable in polynomial time  
**NP**: Problems where "yes" answers can be verified in polynomial time  
**co-NP**: Problems where "no" answers can be verified in polynomial time

**The $P = NP$ Question**: Can every efficiently-verifiable problem be efficiently solved? (Most think no, unproven.)

### NP-Hard and NP-Complete

- **NP-Hard**: At least as hard as every problem in NP (polynomial reduction from any NP problem)
- **NP-Complete**: NP-Hard AND in NP

**Reductions**: Problem $A$ reduces to Problem $B$ if we can transform instances of $A$ into instances of $B$ in polynomial time.

**If you can solve $B$, you can solve $A$!**

### The NP-Complete Problems We Studied

**CircuitSAT** → **SAT** → **3SAT** → **Maximum Independent Set** → **Max Clique** / **Min Vertex Cover**

**3SAT to MIS Reduction**:

- Each clause becomes a triangle (3 vertices for 3 literals)
- Connect every literal to its negation across all clauses
- A satisfying assignment corresponds to an independent set of size = #clauses

### Why This Matters

**Cryptography**: If $P = NP$, SAT solvers could break hash functions (SHA-256), digital signatures, cryptocurrency.

**Problem classification**:

- If your problem is in P: Great, solve it efficiently!
- If your problem is NP-complete: Probably need approximation, heuristics, or accept exponential time

### P-Complete (Beyond NP)

**P-Complete**: "Hardest problems in P" — inherently sequential, difficult to parallelize.

**Examples**:

- **Circuit Value Problem (CVP)**: Evaluate a boolean circuit
- **Horn-SAT**: SAT with at most one positive literal per clause

**Log-Space Reductions**: Weaker than polynomial-time reductions (needed to distinguish problems within P).

---

## Part 6: Computability (3 minutes)

### The Limits of Computation

Not all problems are solvable, even with unlimited time!

**The Halting Problem**:

- Input: Program $P$ and input $x$
- Question: Does $P$ halt on $x$?
- **Undecidable**: No algorithm can solve this for all inputs

**Proof by contradiction**:

```
def troll():
    if halts(troll):
        loop_forever()
```

What does `halts(troll)` return?

**Post Correspondence Problem**: Another undecidable problem (string matching puzzle).

**The Hierarchy**:

- Very efficient: $O(1), O(\log n)$
- Efficient: $O(n), O(n \log n)$  
- Polynomial: $O(n^k)$
- Exponential: $O(2^n)$
- **Undecidable**: No algorithm exists

---

## Part 7: Takeaways (2 minutes)

### What You Should Remember

1. **Analysis**: Big-O describes growth rates. Recursion trees solve recurrences.

2. **Design**: Match problem structure to paradigm:
   - Try all options → Backtracking
   - Overlapping subproblems → Dynamic Programming  
   - Greedy choice works → Prove it, use Greedy

3. **Graphs**: DFS for connectivity/cycles, Dijkstra/Bellman-Ford for shortest paths, Flow for matching/assignment.

4. **Hardness**: P vs NP. Reductions prove hardness. NP-complete problems likely require exponential time.

5. **Limits**: Some problems are undecidable (Halting Problem).

### For the Final Exam

- Determine complexity: Recursion trees, inductive arguments
- Proofs: Greedy by contradiction, inductive proofs
- Graphs: DFS, BFS, Dijkstra, MST, Max Flow
- NP Reductions: Be comfortable with 3-SAT to MIS, 3-SAT to 3-color

---

## References

- [Exam 1](../exam1.pdf)
- [Exam 2](../exam2.pdf)
- Jeff Erickson, *Algorithms* (our textbook)
