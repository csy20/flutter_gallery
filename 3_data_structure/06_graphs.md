# Graphs: Complete Guide with Algorithms

## Table of Contents
1. [Introduction to Graphs](#introduction-to-graphs)
2. [Graph Representations](#graph-representations)
3. [Breadth-First Search (BFS)](#breadth-first-search-bfs)
4. [Depth-First Search (DFS)](#depth-first-search-dfs)
5. [Shortest Path Algorithms](#shortest-path-algorithms)
6. [Minimum Spanning Tree (MST)](#minimum-spanning-tree-mst)
7. [Advanced Concepts](#advanced-concepts)

---

## Introduction to Graphs

### What is a Graph?

A **graph** is a non-linear data structure consisting of:
- **Vertices (V)**: Also called nodes, represent entities
- **Edges (E)**: Connections between vertices representing relationships

**Formal Definition**: G = (V, E) where V is a set of vertices and E is a set of edges.

### Types of Graphs

#### 1. Based on Direction
- **Undirected Graph**: Edges have no direction (bidirectional)
  ```
  A ---- B
  |      |
  C ---- D
  ```

- **Directed Graph (Digraph)**: Edges have direction
  ```
  A ---> B
  ^      |
  |      v
  C <--- D
  ```

#### 2. Based on Weights
- **Weighted Graph**: Edges have associated costs/weights
- **Unweighted Graph**: All edges are considered equal

#### 3. Based on Connectivity
- **Connected Graph**: Path exists between every pair of vertices
- **Disconnected Graph**: Some vertices are unreachable from others
- **Strongly Connected**: In directed graphs, every vertex is reachable from every other vertex

#### 4. Special Types
- **Complete Graph**: Every vertex is connected to every other vertex
- **Bipartite Graph**: Vertices can be divided into two disjoint sets
- **Tree**: Connected acyclic graph with V-1 edges
- **DAG (Directed Acyclic Graph)**: Directed graph with no cycles

### Real-World Applications
- **Social Networks**: Users as vertices, friendships as edges
- **Transportation**: Cities as vertices, roads/flights as edges
- **Computer Networks**: Devices as vertices, connections as edges
- **Web Pages**: Pages as vertices, hyperlinks as edges
- **Dependencies**: Tasks as vertices, prerequisites as edges

---

## Graph Representations

### 1. Adjacency Matrix
A 2D array where `matrix[i][j] = 1` if edge exists between vertex i and j.

**Example:**
```
Graph:    A---B
          |   |
          C---D

Matrix:   A B C D
       A [0 1 1 0]
       B [1 0 0 1]
       C [1 0 0 1]
       D [0 1 1 0]
```

**Pros:**
- O(1) edge lookup
- Simple implementation
- Good for dense graphs

**Cons:**
- O(V²) space complexity
- Inefficient for sparse graphs

### 2. Adjacency List
Array of lists where each list contains neighbors of a vertex.

**Example:**
```
A: [B, C]
B: [A, D]
C: [A, D]
D: [B, C]
```

**Pros:**
- O(V + E) space complexity
- Efficient for sparse graphs
- Easy to iterate through neighbors

**Cons:**
- O(degree) time for edge lookup
- More complex implementation

### 3. Edge List
Simple list of all edges in the graph.

**Example:**
```
[(A,B), (A,C), (B,D), (C,D)]
```

---

## Breadth-First Search (BFS)

### Concept
BFS explores vertices level by level, visiting all vertices at distance k before visiting vertices at distance k+1 from the source.

### Algorithm Steps
1. Start from source vertex, mark as visited
2. Add source to queue
3. While queue is not empty:
   - Dequeue a vertex
   - Visit all unvisited neighbors
   - Mark neighbors as visited and enqueue them

### Detailed Example

**Graph:**
```
    1
   / \
  2   3
 /   / \
4   5   6
```

**BFS from vertex 1:**

**Step 1:** Start with 1
- Queue: [1]
- Visited: {1}
- Output: 1

**Step 2:** Process 1, add neighbors 2, 3
- Queue: [2, 3]
- Visited: {1, 2, 3}
- Output: 1

**Step 3:** Process 2, add neighbor 4
- Queue: [3, 4]
- Visited: {1, 2, 3, 4}
- Output: 1, 2

**Step 4:** Process 3, add neighbors 5, 6
- Queue: [4, 5, 6]
- Visited: {1, 2, 3, 4, 5, 6}
- Output: 1, 2, 3

**Final Output:** 1 → 2 → 3 → 4 → 5 → 6

### BFS Properties
- **Time Complexity:** O(V + E)
- **Space Complexity:** O(V) for queue and visited array
- **Shortest Path:** Guarantees shortest path in unweighted graphs
- **Level Order:** Visits vertices level by level

### Applications
1. **Shortest Path in Unweighted Graphs**
2. **Web Crawling**: Systematically explore web pages
3. **Social Networking**: Find connections within N degrees
4. **Broadcasting**: Efficient message propagation
5. **Bipartite Graph Detection**: Check if graph is 2-colorable
6. **Puzzle Solving**: Find minimum moves (like sliding puzzles)

---

## Depth-First Search (DFS)

### Concept
DFS explores as deep as possible along each branch before backtracking. It uses a stack (implicitly through recursion or explicitly).

### Algorithm Steps
1. Start from source vertex, mark as visited
2. For each unvisited neighbor:
   - Recursively apply DFS
3. Backtrack when no unvisited neighbors remain

### Detailed Example

**Graph:**
```
    1
   / \
  2   3
 /   / \
4   5   6
```

**DFS from vertex 1 (visiting left first):**

**Step 1:** Visit 1, go to first neighbor 2
- Stack: [1, 2]
- Visited: {1, 2}
- Output: 1, 2

**Step 2:** From 2, go to neighbor 4
- Stack: [1, 2, 4]
- Visited: {1, 2, 4}
- Output: 1, 2, 4

**Step 3:** 4 has no unvisited neighbors, backtrack to 2
- Stack: [1, 2]
- 2 has no more unvisited neighbors, backtrack to 1

**Step 4:** From 1, go to next neighbor 3
- Stack: [1, 3]
- Visited: {1, 2, 4, 3}
- Output: 1, 2, 4, 3

**Step 5:** From 3, go to neighbor 5
- Stack: [1, 3, 5]
- Visited: {1, 2, 4, 3, 5}
- Output: 1, 2, 4, 3, 5

**Final Output:** 1 → 2 → 4 → 3 → 5 → 6

### DFS Variants
1. **Pre-order DFS**: Process vertex before visiting children
2. **Post-order DFS**: Process vertex after visiting children
3. **Iterative DFS**: Use explicit stack instead of recursion

### DFS Properties
- **Time Complexity:** O(V + E)
- **Space Complexity:** O(V) for recursion stack
- **Memory Efficient:** Generally uses less memory than BFS

### Applications
1. **Topological Sorting**: Order vertices with dependencies
2. **Cycle Detection**: Detect cycles in directed/undirected graphs
3. **Strongly Connected Components**: Find SCCs in directed graphs
4. **Path Finding**: Find any path between two vertices
5. **Maze Solving**: Navigate through mazes
6. **Compiler Design**: Parse trees, dependency analysis

---

## Shortest Path Algorithms

### 1. Dijkstra's Algorithm

#### Purpose
Find shortest paths from a single source to all vertices in a **weighted graph with non-negative weights**.

#### Algorithm Steps
1. Initialize distances: source = 0, others = ∞
2. Use priority queue (min-heap) with source vertex
3. While queue is not empty:
   - Extract vertex with minimum distance
   - Update distances of all neighbors if shorter path found
   - Add updated neighbors to queue

#### Detailed Example

**Graph with weights:**
```
    A --2-- B --1-- C
    |       |       |
    6       3       2
    |       |       |
    D --1-- E --4-- F
```

**Finding shortest paths from A:**

**Initialization:**
- Distances: A=0, B=∞, C=∞, D=∞, E=∞, F=∞
- Priority Queue: [(0,A)]

**Step 1:** Process A
- Update B: dist[B] = min(∞, 0+2) = 2
- Update D: dist[D] = min(∞, 0+6) = 6
- Queue: [(2,B), (6,D)]

**Step 2:** Process B
- Update C: dist[C] = min(∞, 2+1) = 3
- Update E: dist[E] = min(∞, 2+3) = 5
- Queue: [(3,C), (5,E), (6,D)]

**Step 3:** Process C
- Update F: dist[F] = min(∞, 3+2) = 5
- Queue: [(5,E), (5,F), (6,D)]

**Continue until all vertices processed...**

**Final shortest distances from A:**
- A: 0, B: 2, C: 3, D: 4, E: 5, F: 5

#### Properties
- **Time Complexity:** O((V + E) log V) with binary heap
- **Space Complexity:** O(V)
- **Limitation:** Cannot handle negative weights

### 2. Bellman-Ford Algorithm

#### Purpose
Find shortest paths from single source, can handle **negative weights** and detect **negative cycles**.

#### Algorithm Steps
1. Initialize distances: source = 0, others = ∞
2. Relax all edges V-1 times:
   - For each edge (u,v) with weight w:
     - If dist[u] + w < dist[v], update dist[v]
3. Check for negative cycles in Vth iteration

#### Example with Negative Weights

**Graph:**
```
A --1--> B
|        |
2       -3
|        |
v        v
C --1--> D
```

**Bellman-Ford from A:**

**Iteration 1:**
- A→B: dist[B] = min(∞, 0+1) = 1
- A→C: dist[C] = min(∞, 0+2) = 2
- B→D: dist[D] = min(∞, 1-3) = -2
- C→D: dist[D] = min(-2, 2+1) = -2

**Iteration 2:**
- No further improvements

**Negative Cycle Check:**
- If any distance improves in iteration V, negative cycle exists

#### Properties
- **Time Complexity:** O(VE)
- **Space Complexity:** O(V)
- **Advantage:** Handles negative weights and detects negative cycles

### 3. Floyd-Warshall Algorithm

#### Purpose
Find shortest paths between **all pairs of vertices**.

#### Algorithm Steps
Use dynamic programming with intermediate vertices:
```
for k from 1 to V:
    for i from 1 to V:
        for j from 1 to V:
            if dist[i][k] + dist[k][j] < dist[i][j]:
                dist[i][j] = dist[i][k] + dist[k][j]
```

#### Properties
- **Time Complexity:** O(V³)
- **Space Complexity:** O(V²)
- **Use Case:** Dense graphs, all-pairs shortest paths

---

## Minimum Spanning Tree (MST)

### Definition
A **spanning tree** of a connected graph is a subgraph that:
- Includes all vertices
- Is connected (no isolated vertices)
- Is acyclic (no cycles)
- Has exactly V-1 edges

An **MST** is a spanning tree with minimum total edge weight.

### Properties of MST
- **Unique**: If all edge weights are distinct, MST is unique
- **Cut Property**: For any cut, minimum weight edge crossing cut is in some MST
- **Cycle Property**: For any cycle, maximum weight edge is not in any MST

### 1. Kruskal's Algorithm

#### Concept
Greedy algorithm that builds MST by adding edges in order of increasing weight, avoiding cycles.

#### Algorithm Steps
1. Sort all edges by weight in ascending order
2. Initialize each vertex as separate component (Union-Find)
3. For each edge in sorted order:
   - If edge connects different components:
     - Add edge to MST
     - Union the components
4. Stop when MST has V-1 edges

#### Detailed Example

**Graph with edges:**
```
Vertices: A, B, C, D
Edges with weights:
(A,B,1), (A,C,3), (B,C,2), (B,D,4), (C,D,5)
```

**Step-by-Step Execution:**

**Step 1:** Sort edges by weight
- Sorted: (A,B,1), (B,C,2), (A,C,3), (B,D,4), (C,D,5)

**Step 2:** Process edges
- (A,B,1): Add to MST (connects different components)
  - Components: {A,B}, {C}, {D}
- (B,C,2): Add to MST (connects different components)
  - Components: {A,B,C}, {D}
- (A,C,3): Skip (A and C already connected)
- (B,D,4): Add to MST (connects different components)
  - Components: {A,B,C,D}

**Final MST:** (A,B,1), (B,C,2), (B,D,4)
**Total Weight:** 1 + 2 + 4 = 7

#### Properties
- **Time Complexity:** O(E log E) due to sorting
- **Space Complexity:** O(V) for Union-Find
- **Best for:** Sparse graphs

### 2. Prim's Algorithm

#### Concept
Greedy algorithm that grows MST one vertex at a time, always adding minimum weight edge to unvisited vertex.

#### Algorithm Steps
1. Start with arbitrary vertex, add to MST set
2. Use priority queue for edges from MST to non-MST vertices
3. While MST doesn't include all vertices:
   - Extract minimum weight edge from queue
   - If edge leads to unvisited vertex, add to MST
   - Add new edges from new vertex to queue

#### Detailed Example

**Using same graph, starting from A:**

**Step 1:** MST = {A}
- Available edges: (A,B,1), (A,C,3)
- Choose minimum: (A,B,1)

**Step 2:** MST = {A,B}
- Available edges: (A,C,3), (B,C,2), (B,D,4)
- Choose minimum: (B,C,2)

**Step 3:** MST = {A,B,C}
- Available edges: (B,D,4), (C,D,5)
- Choose minimum: (B,D,4)

**Final MST:** Same as Kruskal's result

#### Properties
- **Time Complexity:** O((V + E) log V) with binary heap
- **Space Complexity:** O(V)
- **Best for:** Dense graphs

---

## Advanced Concepts

### Graph Coloring
Assign colors to vertices such that no adjacent vertices have same color.
- **Chromatic Number**: Minimum colors needed
- **Applications**: Scheduling, register allocation

### Strongly Connected Components (SCCs)
In directed graphs, maximal sets where every vertex reaches every other vertex.
- **Tarjan's Algorithm**: O(V + E) using DFS
- **Kosaraju's Algorithm**: Two DFS passes

### Topological Sorting
Linear ordering of vertices in DAG where for every edge (u,v), u comes before v.
- **Applications**: Task scheduling, course prerequisites
- **Algorithms**: DFS-based, Kahn's algorithm

### Network Flow
Maximum flow from source to sink in flow network.
- **Ford-Fulkerson Algorithm**: Augmenting paths
- **Applications**: Traffic flow, bipartite matching

### Bipartite Graphs
Vertices divisible into two disjoint sets with edges only between sets.
- **Detection**: BFS/DFS with 2-coloring
- **Applications**: Matching problems, resource allocation

This comprehensive guide covers the fundamental concepts and algorithms for graphs, providing the foundation for solving complex computational problems in various domains.
