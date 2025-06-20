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

**Dart Implementation:**
```dart
class GraphMatrix {
  List<List<int>> matrix;
  int vertices;
  
  GraphMatrix(this.vertices) {
    matrix = List.generate(vertices, (i) => List.filled(vertices, 0));
  }
  
  // Add edge between vertices u and v
  void addEdge(int u, int v, {bool directed = false}) {
    matrix[u][v] = 1;
    if (!directed) {
      matrix[v][u] = 1; // For undirected graph
    }
  }
  
  // Remove edge between vertices u and v
  void removeEdge(int u, int v, {bool directed = false}) {
    matrix[u][v] = 0;
    if (!directed) {
      matrix[v][u] = 0;
    }
  }
  
  // Check if edge exists
  bool hasEdge(int u, int v) {
    return matrix[u][v] == 1;
  }
  
  // Get all neighbors of vertex u
  List<int> getNeighbors(int u) {
    List<int> neighbors = [];
    for (int v = 0; v < vertices; v++) {
      if (matrix[u][v] == 1) {
        neighbors.add(v);
      }
    }
    return neighbors;
  }
  
  // Print the matrix
  void printMatrix() {
    print('Adjacency Matrix:');
    for (int i = 0; i < vertices; i++) {
      print(matrix[i]);
    }
  }
}

// Example usage
void demonstrateAdjacencyMatrix() {
  GraphMatrix graph = GraphMatrix(4);
  
  // Add edges: 0-1, 0-2, 1-3, 2-3
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 3);
  
  graph.printMatrix();
  
  print('Neighbors of vertex 0: ${graph.getNeighbors(0)}');
  print('Edge exists between 0 and 1: ${graph.hasEdge(0, 1)}');
  print('Edge exists between 0 and 3: ${graph.hasEdge(0, 3)}');
}
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

**Dart Implementation:**
```dart
class GraphList {
  Map<int, List<int>> adjacencyList;
  int vertices;
  
  GraphList(this.vertices) {
    adjacencyList = {};
    for (int i = 0; i < vertices; i++) {
      adjacencyList[i] = [];
    }
  }
  
  // Add edge between vertices u and v
  void addEdge(int u, int v, {bool directed = false}) {
    adjacencyList[u]!.add(v);
    if (!directed) {
      adjacencyList[v]!.add(u); // For undirected graph
    }
  }
  
  // Remove edge between vertices u and v
  void removeEdge(int u, int v, {bool directed = false}) {
    adjacencyList[u]!.remove(v);
    if (!directed) {
      adjacencyList[v]!.remove(u);
    }
  }
  
  // Check if edge exists
  bool hasEdge(int u, int v) {
    return adjacencyList[u]!.contains(v);
  }
  
  // Get all neighbors of vertex u
  List<int> getNeighbors(int u) {
    return List.from(adjacencyList[u]!);
  }
  
  // Print the adjacency list
  void printList() {
    print('Adjacency List:');
    adjacencyList.forEach((vertex, neighbors) {
      print('$vertex: $neighbors');
    });
  }
  
  // Get degree of a vertex
  int getDegree(int u) {
    return adjacencyList[u]!.length;
  }
}

// Example usage
void demonstrateAdjacencyList() {
  GraphList graph = GraphList(4);
  
  // Add edges: 0-1, 0-2, 1-3, 2-3
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 3);
  
  graph.printList();
  
  print('Neighbors of vertex 0: ${graph.getNeighbors(0)}');
  print('Degree of vertex 0: ${graph.getDegree(0)}');
  print('Edge exists between 0 and 1: ${graph.hasEdge(0, 1)}');
}
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

**Dart Implementation:**
```dart
class Edge {
  int u, v;
  int? weight;
  
  Edge(this.u, this.v, [this.weight]);
  
  @override
  String toString() {
    return weight != null ? '($u,$v,$weight)' : '($u,$v)';
  }
}

class GraphEdgeList {
  List<Edge> edges;
  int vertices;
  
  GraphEdgeList(this.vertices) : edges = [];
  
  // Add edge between vertices u and v
  void addEdge(int u, int v, {int? weight, bool directed = false}) {
    edges.add(Edge(u, v, weight));
    if (!directed) {
      edges.add(Edge(v, u, weight)); // For undirected graph
    }
  }
  
  // Remove edge between vertices u and v
  void removeEdge(int u, int v) {
    edges.removeWhere((edge) => 
      (edge.u == u && edge.v == v) || (edge.u == v && edge.v == u));
  }
  
  // Check if edge exists
  bool hasEdge(int u, int v) {
    return edges.any((edge) => 
      (edge.u == u && edge.v == v) || (edge.u == v && edge.v == u));
  }
  
  // Get all neighbors of vertex u
  List<int> getNeighbors(int u) {
    List<int> neighbors = [];
    for (Edge edge in edges) {
      if (edge.u == u) neighbors.add(edge.v);
      if (edge.v == u) neighbors.add(edge.u);
    }
    return neighbors.toSet().toList(); // Remove duplicates
  }
  
  // Print all edges
  void printEdges() {
    print('Edge List:');
    for (Edge edge in edges) {
      print(edge);
    }
  }
  
  // Sort edges by weight (useful for MST algorithms)
  void sortByWeight() {
    edges.sort((a, b) => (a.weight ?? 0).compareTo(b.weight ?? 0));
  }
}

// Example usage
void demonstrateEdgeList() {
  GraphEdgeList graph = GraphEdgeList(4);
  
  // Add weighted edges
  graph.addEdge(0, 1, weight: 2);
  graph.addEdge(0, 2, weight: 1);
  graph.addEdge(1, 3, weight: 3);
  graph.addEdge(2, 3, weight: 4);
  
  graph.printEdges();
  
  print('Neighbors of vertex 0: ${graph.getNeighbors(0)}');
  
  // Sort edges by weight
  graph.sortByWeight();
  print('\nSorted by weight:');
  graph.printEdges();
}
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

### BFS Implementation

```dart
import 'dart:collection';

class BFS {
  static List<int> breadthFirstSearch(GraphList graph, int startVertex) {
    List<int> visited = [];
    Set<int> visitedSet = {};
    Queue<int> queue = Queue<int>();
    
    // Start with the source vertex
    queue.add(startVertex);
    visitedSet.add(startVertex);
    
    while (queue.isNotEmpty) {
      int currentVertex = queue.removeFirst();
      visited.add(currentVertex);
      
      // Visit all neighbors
      for (int neighbor in graph.getNeighbors(currentVertex)) {
        if (!visitedSet.contains(neighbor)) {
          visitedSet.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    
    return visited;
  }
  
  // BFS to find shortest path in unweighted graph
  static List<int>? shortestPath(GraphList graph, int start, int target) {
    if (start == target) return [start];
    
    Set<int> visited = {};
    Queue<List<int>> queue = Queue<List<int>>();
    
    queue.add([start]);
    visited.add(start);
    
    while (queue.isNotEmpty) {
      List<int> path = queue.removeFirst();
      int currentVertex = path.last;
      
      for (int neighbor in graph.getNeighbors(currentVertex)) {
        if (neighbor == target) {
          return [...path, neighbor];
        }
        
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add([...path, neighbor]);
        }
      }
    }
    
    return null; // No path found
  }
  
  // Level-wise BFS (returns vertices grouped by levels)
  static List<List<int>> levelOrderTraversal(GraphList graph, int startVertex) {
    List<List<int>> levels = [];
    Set<int> visited = {};
    Queue<int> queue = Queue<int>();
    
    queue.add(startVertex);
    visited.add(startVertex);
    
    while (queue.isNotEmpty) {
      int levelSize = queue.length;
      List<int> currentLevel = [];
      
      for (int i = 0; i < levelSize; i++) {
        int currentVertex = queue.removeFirst();
        currentLevel.add(currentVertex);
        
        for (int neighbor in graph.getNeighbors(currentVertex)) {
          if (!visited.contains(neighbor)) {
            visited.add(neighbor);
            queue.add(neighbor);
          }
        }
      }
      
      levels.add(currentLevel);
    }
    
    return levels;
  }
}

// Example usage
void demonstrateBFS() {
  GraphList graph = GraphList(6);
  
  // Create the example graph: 0-1-2 and 0-3, 2-4, 2-5
  //     0
  //    / \
  //   1   3
  //   |
  //   2
  //  / \
  // 4   5
  
  graph.addEdge(0, 1);
  graph.addEdge(0, 3);
  graph.addEdge(1, 2);
  graph.addEdge(2, 4);
  graph.addEdge(2, 5);
  
  print('Graph structure:');
  graph.printList();
  
  print('\nBFS traversal from vertex 0:');
  List<int> bfsResult = BFS.breadthFirstSearch(graph, 0);
  print(bfsResult);
  
  print('\nLevel-wise traversal from vertex 0:');
  List<List<int>> levels = BFS.levelOrderTraversal(graph, 0);
  for (int i = 0; i < levels.length; i++) {
    print('Level $i: ${levels[i]}');
  }
  
  print('\nShortest path from 0 to 5:');
  List<int>? path = BFS.shortestPath(graph, 0, 5);
  print(path ?? 'No path found');
}
```

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

### DFS Implementation

```dart
class DFS {
  // Recursive DFS
  static List<int> depthFirstSearch(GraphList graph, int startVertex) {
    List<int> visited = [];
    Set<int> visitedSet = {};
    
    _dfsRecursive(graph, startVertex, visited, visitedSet);
    return visited;
  }
  
  static void _dfsRecursive(GraphList graph, int vertex, List<int> visited, Set<int> visitedSet) {
    visited.add(vertex);
    visitedSet.add(vertex);
    
    for (int neighbor in graph.getNeighbors(vertex)) {
      if (!visitedSet.contains(neighbor)) {
        _dfsRecursive(graph, neighbor, visited, visitedSet);
      }
    }
  }
  
  // Iterative DFS using stack
  static List<int> depthFirstSearchIterative(GraphList graph, int startVertex) {
    List<int> visited = [];
    Set<int> visitedSet = {};
    List<int> stack = [startVertex];
    
    while (stack.isNotEmpty) {
      int currentVertex = stack.removeLast();
      
      if (!visitedSet.contains(currentVertex)) {
        visited.add(currentVertex);
        visitedSet.add(currentVertex);
        
        // Add neighbors to stack (in reverse order to maintain left-first traversal)
        List<int> neighbors = graph.getNeighbors(currentVertex);
        for (int i = neighbors.length - 1; i >= 0; i--) {
          if (!visitedSet.contains(neighbors[i])) {
            stack.add(neighbors[i]);
          }
        }
      }
    }
    
    return visited;
  }
  
  // DFS to detect cycle in undirected graph
  static bool hasCycle(GraphList graph) {
    Set<int> visited = {};
    
    for (int vertex = 0; vertex < graph.vertices; vertex++) {
      if (!visited.contains(vertex)) {
        if (_hasCycleDFS(graph, vertex, -1, visited)) {
          return true;
        }
      }
    }
    return false;
  }
  
  static bool _hasCycleDFS(GraphList graph, int vertex, int parent, Set<int> visited) {
    visited.add(vertex);
    
    for (int neighbor in graph.getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        if (_hasCycleDFS(graph, neighbor, vertex, visited)) {
          return true;
        }
      } else if (neighbor != parent) {
        return true; // Back edge found, cycle detected
      }
    }
    return false;
  }
  
  // DFS to find all paths between two vertices
  static List<List<int>> findAllPaths(GraphList graph, int start, int target) {
    List<List<int>> allPaths = [];
    List<int> currentPath = [];
    Set<int> visited = {};
    
    _findPathsDFS(graph, start, target, currentPath, visited, allPaths);
    return allPaths;
  }
  
  static void _findPathsDFS(GraphList graph, int current, int target, 
      List<int> currentPath, Set<int> visited, List<List<int>> allPaths) {
    currentPath.add(current);
    visited.add(current);
    
    if (current == target) {
      allPaths.add(List.from(currentPath));
    } else {
      for (int neighbor in graph.getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          _findPathsDFS(graph, neighbor, target, currentPath, visited, allPaths);
        }
      }
    }
    
    // Backtrack
    currentPath.removeLast();
    visited.remove(current);
  }
  
  // DFS to check if graph is connected
  static bool isConnected(GraphList graph) {
    if (graph.vertices == 0) return true;
    
    Set<int> visited = {};
    _dfsRecursive(graph, 0, [], visited);
    
    return visited.length == graph.vertices;
  }
}

// Example usage
void demonstrateDFS() {
  GraphList graph = GraphList(6);
  
  // Create the example graph: 0-1-2 and 0-3, 2-4, 2-5
  graph.addEdge(0, 1);
  graph.addEdge(0, 3);
  graph.addEdge(1, 2);
  graph.addEdge(2, 4);
  graph.addEdge(2, 5);
  
  print('Graph structure:');
  graph.printList();
  
  print('\nDFS traversal (recursive) from vertex 0:');
  List<int> dfsResult = DFS.depthFirstSearch(graph, 0);
  print(dfsResult);
  
  print('\nDFS traversal (iterative) from vertex 0:');
  List<int> dfsIterative = DFS.depthFirstSearchIterative(graph, 0);
  print(dfsIterative);
  
  print('\nAll paths from 0 to 5:');
  List<List<int>> allPaths = DFS.findAllPaths(graph, 0, 5);
  for (int i = 0; i < allPaths.length; i++) {
    print('Path ${i + 1}: ${allPaths[i]}');
  }
  
  print('\nIs graph connected? ${DFS.isConnected(graph)}');
  print('Does graph have cycle? ${DFS.hasCycle(graph)}');
  
  // Add a cycle
  graph.addEdge(3, 4);
  print('After adding edge 3-4, does graph have cycle? ${DFS.hasCycle(graph)}');
}
```

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

### Dijkstra's Algorithm Implementation

```dart
import 'dart:collection';

class WeightedEdge {
  int to;
  int weight;
  
  WeightedEdge(this.to, this.weight);
  
  @override
  String toString() => '($to, $weight)';
}

class WeightedGraph {
  Map<int, List<WeightedEdge>> adjacencyList;
  int vertices;
  
  WeightedGraph(this.vertices) {
    adjacencyList = {};
    for (int i = 0; i < vertices; i++) {
      adjacencyList[i] = [];
    }
  }
  
  void addEdge(int u, int v, int weight, {bool directed = false}) {
    adjacencyList[u]!.add(WeightedEdge(v, weight));
    if (!directed) {
      adjacencyList[v]!.add(WeightedEdge(u, weight));
    }
  }
  
  List<WeightedEdge> getNeighbors(int u) {
    return adjacencyList[u]!;
  }
  
  void printGraph() {
    adjacencyList.forEach((vertex, neighbors) {
      print('$vertex: $neighbors');
    });
  }
}

class DijkstraResult {
  Map<int, int> distances;
  Map<int, int?> previous;
  
  DijkstraResult(this.distances, this.previous);
  
  List<int> getPath(int target) {
    List<int> path = [];
    int? current = target;
    
    while (current != null) {
      path.insert(0, current);
      current = previous[current];
    }
    
    return path;
  }
}

class Dijkstra {
  static DijkstraResult dijkstra(WeightedGraph graph, int source) {
    Map<int, int> distances = {};
    Map<int, int?> previous = {};
    Set<int> visited = {};
    
    // Priority queue: [distance, vertex]
    PriorityQueue<List<int>> pq = PriorityQueue<List<int>>((a, b) => a[0].compareTo(b[0]));
    
    // Initialize distances
    for (int i = 0; i < graph.vertices; i++) {
      distances[i] = double.maxFinite.toInt();
      previous[i] = null;
    }
    distances[source] = 0;
    
    pq.add([0, source]);
    
    while (pq.isNotEmpty) {
      List<int> current = pq.removeFirst();
      int currentDistance = current[0];
      int currentVertex = current[1];
      
      if (visited.contains(currentVertex)) continue;
      visited.add(currentVertex);
      
      // Check all neighbors
      for (WeightedEdge edge in graph.getNeighbors(currentVertex)) {
        int neighbor = edge.to;
        int weight = edge.weight;
        int newDistance = currentDistance + weight;
        
        if (newDistance < distances[neighbor]!) {
          distances[neighbor] = newDistance;
          previous[neighbor] = currentVertex;
          pq.add([newDistance, neighbor]);
        }
      }
    }
    
    return DijkstraResult(distances, previous);
  }
}

// Priority Queue implementation
class PriorityQueue<T> {
  List<T> _heap = [];
  final Comparator<T> _compare;
  
  PriorityQueue(this._compare);
  
  void add(T item) {
    _heap.add(item);
    _bubbleUp(_heap.length - 1);
  }
  
  T removeFirst() {
    if (_heap.isEmpty) throw StateError('Queue is empty');
    
    T result = _heap[0];
    T last = _heap.removeLast();
    
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    
    return result;
  }
  
  bool get isNotEmpty => _heap.isNotEmpty;
  
  void _bubbleUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (_compare(_heap[index], _heap[parentIndex]) >= 0) break;
      
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }
  
  void _bubbleDown(int index) {
    while (true) {
      int leftChild = 2 * index + 1;
      int rightChild = 2 * index + 2;
      int smallest = index;
      
      if (leftChild < _heap.length && _compare(_heap[leftChild], _heap[smallest]) < 0) {
        smallest = leftChild;
      }
      
      if (rightChild < _heap.length && _compare(_heap[rightChild], _heap[smallest]) < 0) {
        smallest = rightChild;
      }
      
      if (smallest == index) break;
      
      _swap(index, smallest);
      index = smallest;
    }
  }
  
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
}

// Example usage
void demonstrateDijkstra() {
  WeightedGraph graph = WeightedGraph(6);
  
  // Create the example graph from the explanation
  graph.addEdge(0, 1, 2);  // A-B: 2
  graph.addEdge(0, 3, 6);  // A-D: 6
  graph.addEdge(1, 2, 1);  // B-C: 1
  graph.addEdge(1, 4, 3);  // B-E: 3
  graph.addEdge(2, 5, 2);  // C-F: 2
  graph.addEdge(3, 4, 1);  // D-E: 1
  graph.addEdge(4, 5, 4);  // E-F: 4
  
  print('Weighted Graph:');
  graph.printGraph();
  
  print('\nRunning Dijkstra from vertex 0:');
  DijkstraResult result = Dijkstra.dijkstra(graph, 0);
  
  print('\nShortest distances from vertex 0:');
  result.distances.forEach((vertex, distance) {
    print('To vertex $vertex: $distance');
  });
  
  print('\nShortest paths from vertex 0:');
  for (int i = 0; i < graph.vertices; i++) {
    if (i != 0) {
      List<int> path = result.getPath(i);
      print('To vertex $i: $path (distance: ${result.distances[i]})');
    }
  }
}
```

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

### Kruskal's Algorithm Implementation

```dart
class UnionFind {
  List<int> parent;
  List<int> rank;
  
  UnionFind(int n) : parent = List.generate(n, (i) => i), rank = List.filled(n, 0);
  
  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]); // Path compression
    }
    return parent[x];
  }
  
  bool union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    
    if (rootX == rootY) return false; // Already in same set
    
    // Union by rank
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      parent[rootY] = rootX;
      rank[rootX]++;
    }
    
    return true;
  }
}

class MSTEdge {
  int u, v, weight;
  
  MSTEdge(this.u, this.v, this.weight);
  
  @override
  String toString() => '($u-$v: $weight)';
}

class Kruskal {
  static List<MSTEdge> kruskalMST(int vertices, List<MSTEdge> edges) {
    List<MSTEdge> mst = [];
    UnionFind uf = UnionFind(vertices);
    
    // Sort edges by weight
    edges.sort((a, b) => a.weight.compareTo(b.weight));
    
    print('Sorted edges: $edges');
    
    for (MSTEdge edge in edges) {
      if (uf.union(edge.u, edge.v)) {
        mst.add(edge);
        print('Added edge: $edge');
        
        if (mst.length == vertices - 1) break; // MST complete
      } else {
        print('Skipped edge: $edge (would create cycle)');
      }
    }
    
    return mst;
  }
  
  static int getMSTWeight(List<MSTEdge> mst) {
    return mst.fold(0, (sum, edge) => sum + edge.weight);
  }
}

// Example usage
void demonstrateKruskal() {
  List<MSTEdge> edges = [
    MSTEdge(0, 1, 1),  // A-B: 1
    MSTEdge(0, 2, 3),  // A-C: 3
    MSTEdge(1, 2, 2),  // B-C: 2
    MSTEdge(1, 3, 4),  // B-D: 4
    MSTEdge(2, 3, 5),  // C-D: 5
  ];
  
  print('Input edges: $edges');
  print('\nRunning Kruskal\'s Algorithm:');
  
  List<MSTEdge> mst = Kruskal.kruskalMST(4, edges);
  
  print('\nMinimum Spanning Tree:');
  for (MSTEdge edge in mst) {
    print(edge);
  }
  
  print('\nTotal MST weight: ${Kruskal.getMSTWeight(mst)}');
}
```

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

### Prim's Algorithm Implementation

```dart
class Prim {
  static List<MSTEdge> primMST(WeightedGraph graph, int startVertex) {
    List<MSTEdge> mst = [];
    Set<int> inMST = {startVertex};
    
    // Priority queue for edges: [weight, u, v]
    PriorityQueue<List<int>> pq = PriorityQueue<List<int>>((a, b) => a[0].compareTo(b[0]));
    
    // Add all edges from start vertex
    for (WeightedEdge edge in graph.getNeighbors(startVertex)) {
      pq.add([edge.weight, startVertex, edge.to]);
    }
    
    print('Starting from vertex $startVertex');
    
    while (pq.isNotEmpty && mst.length < graph.vertices - 1) {
      List<int> current = pq.removeFirst();
      int weight = current[0];
      int u = current[1];
      int v = current[2];
      
      // Skip if both vertices are already in MST
      if (inMST.contains(v)) {
        print('Skipped edge ($u-$v: $weight) - both vertices in MST');
        continue;
      }
      
      // Add edge to MST
      mst.add(MSTEdge(u, v, weight));
      inMST.add(v);
      print('Added edge: ($u-$v: $weight)');
      
      // Add all edges from new vertex
      for (WeightedEdge edge in graph.getNeighbors(v)) {
        if (!inMST.contains(edge.to)) {
          pq.add([edge.weight, v, edge.to]);
        }
      }
    }
    
    return mst;
  }
}

// Example usage
void demonstratePrim() {
  WeightedGraph graph = WeightedGraph(4);
  
  // Create the same graph as Kruskal example
  graph.addEdge(0, 1, 1);  // A-B: 1
  graph.addEdge(0, 2, 3);  // A-C: 3
  graph.addEdge(1, 2, 2);  // B-C: 2
  graph.addEdge(1, 3, 4);  // B-D: 4
  graph.addEdge(2, 3, 5);  // C-D: 5
  
  print('Weighted Graph:');
  graph.printGraph();
  
  print('\nRunning Prim\'s Algorithm from vertex 0:');
  List<MSTEdge> mst = Prim.primMST(graph, 0);
  
  print('\nMinimum Spanning Tree (Prim\'s):');
  for (MSTEdge edge in mst) {
    print(edge);
  }
  
  print('\nTotal MST weight: ${Kruskal.getMSTWeight(mst)}');
}
```

### Complete Example: Graph Operations Demo

```dart
void completeGraphDemo() {
  print('=== GRAPH OPERATIONS DEMONSTRATION ===\n');
  
  // 1. Graph Representations
  print('1. GRAPH REPRESENTATIONS:');
  print('------------------------');
  demonstrateAdjacencyMatrix();
  print('');
  demonstrateAdjacencyList();
  print('');
  demonstrateEdgeList();
  
  print('\n' + '='*50 + '\n');
  
  // 2. Graph Traversals
  print('2. GRAPH TRAVERSALS:');
  print('-------------------');
  demonstrateBFS();
  print('');
  demonstrateDFS();
  
  print('\n' + '='*50 + '\n');
  
  // 3. Shortest Path
  print('3. SHORTEST PATH (Dijkstra):');
  print('---------------------------');
  demonstrateDijkstra();
  
  print('\n' + '='*50 + '\n');
  
  // 4. Minimum Spanning Tree
  print('4. MINIMUM SPANNING TREE:');
  print('-------------------------');
  print('Kruskal\'s Algorithm:');
  demonstrateKruskal();
  print('\nPrim\'s Algorithm:');
  demonstratePrim();
}
```

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
