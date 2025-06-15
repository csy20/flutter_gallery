/*
 * DIJKSTRA'S SHORTEST PATH ALGORITHM IN DART
 * 
 * Dijkstra's algorithm finds the shortest paths from a source vertex to all
 * other vertices in a weighted graph with non-negative edge weights.
 * It uses a greedy approach and maintains a set of vertices whose shortest
 * distance from the source is known.
 * 
 * Time Complexity: O((V + E) log V) with priority queue, O(V²) with array
 * Space Complexity: O(V) where V is the number of vertices
 * 
 * Key Properties:
 * - Works only with non-negative edge weights
 * - Finds shortest path from single source to all vertices
 * - Uses greedy approach (always picks minimum distance vertex)
 * - Guarantees optimal solution for non-negative weights
 */

import 'dart:collection';
import 'dart:math';

void main() {
  print("=== DIJKSTRA'S ALGORITHM DEMONSTRATION ===\n");
  
  // Test with different graph representations
  print("--- Adjacency Matrix Representation ---");
  testAdjacencyMatrix();
  
  print("\n--- Adjacency List Representation ---");
  testAdjacencyList();
  
  print("\n--- Real-world Example: City Network ---");
  testCityNetwork();
  
  print("\n--- Step-by-Step Execution ---");
  dijkstraWithSteps();
  
  print("\n--- Path Reconstruction ---");
  testPathReconstruction();
}

/**
 * Graph representation using adjacency list
 */
class Graph {
  int vertices;
  List<List<Edge>> adjList;
  
  Graph(this.vertices) {
    adjList = List.generate(vertices, (_) => <Edge>[]);
  }
  
  void addEdge(int src, int dest, int weight) {
    adjList[src].add(Edge(dest, weight));
    // For undirected graph, add reverse edge
    // adjList[dest].add(Edge(src, weight));
  }
  
  void printGraph() {
    for (int i = 0; i < vertices; i++) {
      print("Vertex $i: ${adjList[i].map((e) => '→${ e.destination}(${e.weight})').join(', ')}");
    }
  }
}

/**
 * Edge class to represent weighted edges
 */
class Edge {
  int destination;
  int weight;
  
  Edge(this.destination, this.weight);
  
  @override
  String toString() => "Edge(dest: $destination, weight: $weight)";
}

/**
 * Node class for priority queue
 */
class Node implements Comparable<Node> {
  int vertex;
  int distance;
  
  Node(this.vertex, this.distance);
  
  @override
  int compareTo(Node other) => distance.compareTo(other.distance);
}

/**
 * Dijkstra's Algorithm using Priority Queue (Efficient Implementation)
 * 
 * @param graph: The graph represented as adjacency list
 * @param source: Starting vertex
 * @return: Array of shortest distances from source to all vertices
 */
List<int> dijkstra(Graph graph, int source) {
  int V = graph.vertices;
  
  // Distance array to store shortest distances
  List<int> dist = List.filled(V, double.maxFinite.toInt());
  
  // Priority queue to store vertices and their distances
  PriorityQueue<Node> pq = PriorityQueue<Node>();
  
  // Distance to source is 0
  dist[source] = 0;
  pq.add(Node(source, 0));
  
  while (pq.isNotEmpty) {
    // Extract vertex with minimum distance
    Node current = pq.removeFirst();
    int u = current.vertex;
    
    // Skip if we've already found a shorter path
    if (current.distance > dist[u]) continue;
    
    // Check all adjacent vertices
    for (Edge edge in graph.adjList[u]) {
      int v = edge.destination;
      int weight = edge.weight;
      
      // Calculate new distance through u
      int newDist = dist[u] + weight;
      
      // If shorter path found, update distance and add to queue
      if (newDist < dist[v]) {
        dist[v] = newDist;
        pq.add(Node(v, newDist));
      }
    }
  }
  
  return dist;
}

/**
 * Dijkstra's Algorithm using Adjacency Matrix (Simple Implementation)
 */
List<int> dijkstraMatrix(List<List<int>> graph, int source) {
  int V = graph.length;
  List<int> dist = List.filled(V, double.maxFinite.toInt());
  List<bool> visited = List.filled(V, false);
  
  dist[source] = 0;
  
  for (int count = 0; count < V - 1; count++) {
    // Find vertex with minimum distance
    int u = minDistance(dist, visited);
    visited[u] = true;
    
    // Update distances of adjacent vertices
    for (int v = 0; v < V; v++) {
      if (!visited[v] && 
          graph[u][v] != 0 && 
          dist[u] != double.maxFinite.toInt() &&
          dist[u] + graph[u][v] < dist[v]) {
        dist[v] = dist[u] + graph[u][v];
      }
    }
  }
  
  return dist;
}

/**
 * Helper function to find vertex with minimum distance
 */
int minDistance(List<int> dist, List<bool> visited) {
  int min = double.maxFinite.toInt();
  int minIndex = -1;
  
  for (int v = 0; v < dist.length; v++) {
    if (!visited[v] && dist[v] <= min) {
      min = dist[v];
      minIndex = v;
    }
  }
  
  return minIndex;
}

/**
 * Dijkstra with Path Reconstruction
 * Returns both distances and the actual shortest paths
 */
class DijkstraResult {
  List<int> distances;
  List<int> previous;
  
  DijkstraResult(this.distances, this.previous);
}

DijkstraResult dijkstraWithPath(Graph graph, int source) {
  int V = graph.vertices;
  List<int> dist = List.filled(V, double.maxFinite.toInt());
  List<int> prev = List.filled(V, -1);
  PriorityQueue<Node> pq = PriorityQueue<Node>();
  
  dist[source] = 0;
  pq.add(Node(source, 0));
  
  while (pq.isNotEmpty) {
    Node current = pq.removeFirst();
    int u = current.vertex;
    
    if (current.distance > dist[u]) continue;
    
    for (Edge edge in graph.adjList[u]) {
      int v = edge.destination;
      int weight = edge.weight;
      int newDist = dist[u] + weight;
      
      if (newDist < dist[v]) {
        dist[v] = newDist;
        prev[v] = u;
        pq.add(Node(v, newDist));
      }
    }
  }
  
  return DijkstraResult(dist, prev);
}

/**
 * Reconstruct path from source to destination
 */
List<int> getPath(List<int> previous, int source, int dest) {
  List<int> path = [];
  int current = dest;
  
  while (current != -1) {
    path.add(current);
    current = previous[current];
  }
  
  return path.reversed.toList();
}

/**
 * Test with adjacency matrix
 */
void testAdjacencyMatrix() {
  // Example graph as adjacency matrix
  List<List<int>> graph = [
    [0, 4, 0, 0, 0, 0, 0, 8, 0],
    [4, 0, 8, 0, 0, 0, 0, 11, 0],
    [0, 8, 0, 7, 0, 4, 0, 0, 2],
    [0, 0, 7, 0, 9, 14, 0, 0, 0],
    [0, 0, 0, 9, 0, 10, 0, 0, 0],
    [0, 0, 4, 14, 10, 0, 2, 0, 0],
    [0, 0, 0, 0, 0, 2, 0, 1, 6],
    [8, 11, 0, 0, 0, 0, 1, 0, 7],
    [0, 0, 2, 0, 0, 0, 6, 7, 0]
  ];
  
  print("Graph (Adjacency Matrix):");
  printMatrix(graph);
  
  int source = 0;
  List<int> distances = dijkstraMatrix(graph, source);
  
  print("\nShortest distances from vertex $source:");
  for (int i = 0; i < distances.length; i++) {
    String dist = distances[i] == double.maxFinite.toInt() ? "∞" : "${distances[i]}";
    print("Vertex $i: $dist");
  }
}

/**
 * Test with adjacency list
 */
void testAdjacencyList() {
  Graph graph = Graph(6);
  
  // Add edges (directed graph)
  graph.addEdge(0, 1, 4);
  graph.addEdge(0, 2, 3);
  graph.addEdge(1, 2, 1);
  graph.addEdge(1, 3, 2);
  graph.addEdge(2, 3, 4);
  graph.addEdge(3, 4, 2);
  graph.addEdge(4, 5, 6);
  
  print("Graph (Adjacency List):");
  graph.printGraph();
  
  int source = 0;
  List<int> distances = dijkstra(graph, source);
  
  print("\nShortest distances from vertex $source:");
  for (int i = 0; i < distances.length; i++) {
    String dist = distances[i] == double.maxFinite.toInt() ? "∞" : "${distances[i]}";
    print("Vertex $i: $dist");
  }
}

/**
 * Real-world example: City network
 */
void testCityNetwork() {
  // Cities: 0=NYC, 1=Boston, 2=Philadelphia, 3=Washington, 4=Atlanta
  List<String> cities = ["NYC", "Boston", "Philadelphia", "Washington", "Atlanta"];
  Graph cityGraph = Graph(5);
  
  // Add roads with distances (in miles)
  cityGraph.addEdge(0, 1, 215);  // NYC to Boston
  cityGraph.addEdge(0, 2, 95);   // NYC to Philadelphia
  cityGraph.addEdge(1, 0, 215);  // Boston to NYC
  cityGraph.addEdge(2, 0, 95);   // Philadelphia to NYC
  cityGraph.addEdge(2, 3, 140);  // Philadelphia to Washington
  cityGraph.addEdge(3, 2, 140);  // Washington to Philadelphia
  cityGraph.addEdge(3, 4, 640);  // Washington to Atlanta
  cityGraph.addEdge(4, 3, 640);  // Atlanta to Washington
  
  print("City Network:");
  for (int i = 0; i < cities.length; i++) {
    List<String> connections = [];
    for (Edge edge in cityGraph.adjList[i]) {
      connections.add("${cities[edge.destination]}(${edge.weight}mi)");
    }
    print("${cities[i]}: ${connections.join(', ')}");
  }
  
  int source = 0; // Start from NYC
  List<int> distances = dijkstra(cityGraph, source);
  
  print("\nShortest distances from ${cities[source]}:");
  for (int i = 0; i < distances.length; i++) {
    if (i != source) {
      String dist = distances[i] == double.maxFinite.toInt() ? "∞" : "${distances[i]} miles";
      print("To ${cities[i]}: $dist");
    }
  }
}

/**
 * Dijkstra with step-by-step execution
 */
void dijkstraWithSteps() {
  Graph graph = Graph(5);
  graph.addEdge(0, 1, 10);
  graph.addEdge(0, 4, 5);
  graph.addEdge(1, 2, 1);
  graph.addEdge(1, 4, 2);
  graph.addEdge(2, 3, 4);
  graph.addEdge(3, 0, 7);
  graph.addEdge(3, 2, 6);
  graph.addEdge(4, 1, 3);
  graph.addEdge(4, 2, 9);
  graph.addEdge(4, 3, 2);
  
  print("Graph for step-by-step execution:");
  graph.printGraph();
  
  int source = 0;
  _dijkstraSteps(graph, source);
}

void _dijkstraSteps(Graph graph, int source) {
  int V = graph.vertices;
  List<int> dist = List.filled(V, double.maxFinite.toInt());
  List<bool> visited = List.filled(V, false);
  
  dist[source] = 0;
  
  print("\nStep-by-step execution:");
  print("Initial distances: ${dist.map((d) => d == double.maxFinite.toInt() ? '∞' : '$d').join(', ')}");
  
  for (int count = 0; count < V; count++) {
    // Find minimum distance vertex
    int u = -1;
    int minDist = double.maxFinite.toInt();
    for (int v = 0; v < V; v++) {
      if (!visited[v] && dist[v] < minDist) {
        minDist = dist[v];
        u = v;
      }
    }
    
    if (u == -1) break;
    
    visited[u] = true;
    print("\nStep ${count + 1}: Processing vertex $u (distance: ${dist[u]})");
    
    // Update distances of adjacent vertices
    for (Edge edge in graph.adjList[u]) {
      int v = edge.destination;
      int weight = edge.weight;
      
      if (!visited[v] && dist[u] + weight < dist[v]) {
        int oldDist = dist[v];
        dist[v] = dist[u] + weight;
        print("  Updated distance to $v: $oldDist → ${dist[v]} (via $u)");
      }
    }
    
    print("  Current distances: ${dist.map((d) => d == double.maxFinite.toInt() ? '∞' : '$d').join(', ')}");
    print("  Visited: ${visited.map((v) => v ? '✓' : '✗').join(', ')}");
  }
}

/**
 * Test path reconstruction
 */
void testPathReconstruction() {
  Graph graph = Graph(6);
  graph.addEdge(0, 1, 4);
  graph.addEdge(0, 2, 3);
  graph.addEdge(1, 2, 1);
  graph.addEdge(1, 3, 2);
  graph.addEdge(2, 3, 4);
  graph.addEdge(3, 4, 2);
  graph.addEdge(4, 5, 6);
  
  int source = 0;
  DijkstraResult result = dijkstraWithPath(graph, source);
  
  print("Shortest paths from vertex $source:");
  for (int dest = 0; dest < graph.vertices; dest++) {
    if (dest != source && result.distances[dest] != double.maxFinite.toInt()) {
      List<int> path = getPath(result.previous, source, dest);
      print("To vertex $dest (distance ${result.distances[dest]}): ${path.join(' → ')}");
    }
  }
}

/**
 * Helper function to print matrix
 */
void printMatrix(List<List<int>> matrix) {
  for (int i = 0; i < matrix.length; i++) {
    String row = matrix[i].map((val) => val.toString().padLeft(3)).join(' ');
    print("  $row");
  }
}

/**
 * Simple Priority Queue implementation using List
 */
class PriorityQueue<T extends Comparable<T>> {
  List<T> _heap = [];
  
  void add(T item) {
    _heap.add(item);
    _bubbleUp(_heap.length - 1);
  }
  
  T removeFirst() {
    if (_heap.isEmpty) throw StateError('Queue is empty');
    
    T result = _heap[0];
    _heap[0] = _heap.last;
    _heap.removeLast();
    
    if (_heap.isNotEmpty) {
      _bubbleDown(0);
    }
    
    return result;
  }
  
  bool get isEmpty => _heap.isEmpty;
  
  void _bubbleUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (_heap[index].compareTo(_heap[parentIndex]) >= 0) break;
      
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }
  
  void _bubbleDown(int index) {
    while (true) {
      int smallest = index;
      int leftChild = 2 * index + 1;
      int rightChild = 2 * index + 2;
      
      if (leftChild < _heap.length && 
          _heap[leftChild].compareTo(_heap[smallest]) < 0) {
        smallest = leftChild;
      }
      
      if (rightChild < _heap.length && 
          _heap[rightChild].compareTo(_heap[smallest]) < 0) {
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

/**
 * APPLICATIONS OF DIJKSTRA'S ALGORITHM:
 * 1. GPS Navigation systems - finding shortest routes
 * 2. Network routing protocols - finding optimal paths
 * 3. Social networks - finding degrees of separation
 * 4. Flight connections - finding cheapest flights
 * 5. Internet packet routing
 * 6. Game pathfinding (with modifications)
 * 7. Telephone networks
 * 8. Supply chain optimization
 * 
 * ADVANTAGES:
 * 1. Guarantees shortest path for non-negative weights
 * 2. Works for both directed and undirected graphs
 * 3. Can find shortest paths to all vertices from single source
 * 4. Well-studied and optimized algorithm
 * 5. Can be adapted for various problems
 * 
 * DISADVANTAGES:
 * 1. Doesn't work with negative edge weights
 * 2. Can be slow for dense graphs with many edges
 * 3. Requires knowing the entire graph structure
 * 4. Memory intensive for large graphs
 * 
 * TIME COMPLEXITY ANALYSIS:
 * - With binary heap: O((V + E) log V)
 * - With Fibonacci heap: O(E + V log V)
 * - With simple array: O(V²)
 * 
 * VARIATIONS:
 * 1. A* Algorithm - uses heuristics for faster pathfinding
 * 2. Bidirectional Dijkstra - searches from both ends
 * 3. Modified for negative weights - Bellman-Ford algorithm
 * 4. All-pairs shortest path - Floyd-Warshall algorithm
 */