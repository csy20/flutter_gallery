import 'dart:collection';

// 1. Basic Graph Node/Vertex representation
class GraphNode<T> {
  T data;
  List<GraphNode<T>> neighbors;
  
  GraphNode(this.data) : neighbors = [];
  
  void addNeighbor(GraphNode<T> neighbor) {
    if (!neighbors.contains(neighbor)) {
      neighbors.add(neighbor);
    }
  }
  
  @override
  String toString() => data.toString();
}

// 2. Edge representation for weighted graphs
class Edge<T> {
  GraphNode<T> source;
  GraphNode<T> destination;
  int weight;
  
  Edge(this.source, this.destination, this.weight);
  
  @override
  String toString() => '${source.data} -> ${destination.data} (weight: $weight)';
}

// 3. Adjacency List representation (Most common)
class AdjacencyListGraph<T> {
  Map<T, List<T>> _adjacencyList = {};
  bool isDirected;
  
  AdjacencyListGraph({this.isDirected = false});
  
  // Add vertex to the graph
  void addVertex(T vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
      print('Added vertex: $vertex');
    }
  }
  
  // Add edge between two vertices
  void addEdge(T source, T destination) {
    // Ensure both vertices exist
    addVertex(source);
    addVertex(destination);
    
    // Add edge
    _adjacencyList[source]!.add(destination);
    
    // If undirected, add reverse edge
    if (!isDirected) {
      _adjacencyList[destination]!.add(source);
    }
    
    print('Added edge: $source -> $destination');
  }
  
  // Remove vertex and all its edges
  void removeVertex(T vertex) {
    if (!_adjacencyList.containsKey(vertex)) return;
    
    // Remove all edges to this vertex
    for (var neighbors in _adjacencyList.values) {
      neighbors.remove(vertex);
    }
    
    // Remove the vertex itself
    _adjacencyList.remove(vertex);
    print('Removed vertex: $vertex');
  }
  
  // Remove edge between two vertices
  void removeEdge(T source, T destination) {
    if (_adjacencyList.containsKey(source)) {
      _adjacencyList[source]!.remove(destination);
    }
    
    if (!isDirected && _adjacencyList.containsKey(destination)) {
      _adjacencyList[destination]!.remove(source);
    }
    
    print('Removed edge: $source -> $destination');
  }
  
  // Get all vertices
  List<T> get vertices => _adjacencyList.keys.toList();
  
  // Get neighbors of a vertex
  List<T> getNeighbors(T vertex) {
    return _adjacencyList[vertex] ?? [];
  }
  
  // Check if edge exists
  bool hasEdge(T source, T destination) {
    return _adjacencyList[source]?.contains(destination) ?? false;
  }
  
  // Display the graph
  void display() {
    print('\nGraph (Adjacency List):');
    if (_adjacencyList.isEmpty) {
      print('Graph is empty');
      return;
    }
    
    for (var vertex in _adjacencyList.keys) {
      print('$vertex -> ${_adjacencyList[vertex]}');
    }
  }
  
  // Depth-First Search (DFS)
  void dfs(T startVertex, [Set<T>? visited]) {
    visited ??= <T>{};
    
    if (visited.contains(startVertex)) return;
    
    visited.add(startVertex);
    print('Visited: $startVertex');
    
    for (var neighbor in getNeighbors(startVertex)) {
      dfs(neighbor, visited);
    }
  }
  
  // Breadth-First Search (BFS)
  void bfs(T startVertex) {
    Set<T> visited = <T>{};
    Queue<T> queue = Queue<T>();
    
    queue.add(startVertex);
    visited.add(startVertex);
    
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      print('Visited: $current');
      
      for (var neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
  }
  
  // Find path between two vertices using DFS
  List<T>? findPath(T start, T end, [Set<T>? visited, List<T>? path]) {
    visited ??= <T>{};
    path ??= <T>[];
    
    visited.add(start);
    path.add(start);
    
    if (start == end) {
      return List.from(path);
    }
    
    for (var neighbor in getNeighbors(start)) {
      if (!visited.contains(neighbor)) {
        List<T>? result = findPath(neighbor, end, visited, path);
        if (result != null) return result;
      }
    }
    
    path.removeLast();
    return null;
  }
  
  // Check if graph has cycle (for undirected graph)
  bool hasCycle() {
    Set<T> visited = <T>{};
    
    for (var vertex in vertices) {
      if (!visited.contains(vertex)) {
        if (_hasCycleDFS(vertex, visited, null)) {
          return true;
        }
      }
    }
    return false;
  }
  
  bool _hasCycleDFS(T vertex, Set<T> visited, T? parent) {
    visited.add(vertex);
    
    for (var neighbor in getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        if (_hasCycleDFS(neighbor, visited, vertex)) return true;
      } else if (neighbor != parent) {
        return true;
      }
    }
    return false;
  }
}

// 4. Weighted Graph implementation
class WeightedGraph<T> {
  Map<T, List<Edge<T>>> _adjacencyList = {};
  bool isDirected;
  
  WeightedGraph({this.isDirected = false});
  
  void addVertex(T vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
      print('Added vertex: $vertex');
    }
  }
  
  void addEdge(T source, T destination, int weight) {
    addVertex(source);
    addVertex(destination);
    
    // Create nodes if they don't exist
    var sourceNode = GraphNode(source);
    var destNode = GraphNode(destination);
    
    _adjacencyList[source]!.add(Edge(sourceNode, destNode, weight));
    
    if (!isDirected) {
      _adjacencyList[destination]!.add(Edge(destNode, sourceNode, weight));
    }
    
    print('Added weighted edge: $source -> $destination (weight: $weight)');
  }
  
  void display() {
    print('\nWeighted Graph:');
    for (var vertex in _adjacencyList.keys) {
      print('$vertex -> ${_adjacencyList[vertex]}');
    }
  }
  
  // Dijkstra's shortest path algorithm
  Map<T, int> dijkstra(T start) {
    Map<T, int> distances = {};
    Set<T> visited = {};
    
    // Initialize distances
    for (var vertex in _adjacencyList.keys) {
      distances[vertex] = vertex == start ? 0 : double.maxFinite.toInt();
    }
    
    while (visited.length < _adjacencyList.length) {
      // Find unvisited vertex with minimum distance
      T? current;
      int minDistance = double.maxFinite.toInt();
      
      for (var vertex in _adjacencyList.keys) {
        if (!visited.contains(vertex) && distances[vertex]! < minDistance) {
          minDistance = distances[vertex]!;
          current = vertex;
        }
      }
      
      if (current == null) break;
      visited.add(current);
      
      // Update distances to neighbors
      for (var edge in _adjacencyList[current]!) {
        T neighbor = edge.destination.data;
        int newDistance = distances[current]! + edge.weight;
        
        if (newDistance < distances[neighbor]!) {
          distances[neighbor] = newDistance;
        }
      }
    }
    
    return distances;
  }
}

// 5. Adjacency Matrix representation
class AdjacencyMatrixGraph {
  late List<List<int>> _matrix;
  Map<String, int> _vertexIndex = {};
  List<String> _vertices = [];
  bool isDirected;
  
  AdjacencyMatrixGraph(int size, {this.isDirected = false}) {
    _matrix = List.generate(size, (i) => List.filled(size, 0));
  }
  
  void addVertex(String vertex) {
    if (!_vertexIndex.containsKey(vertex)) {
      _vertexIndex[vertex] = _vertices.length;
      _vertices.add(vertex);
      print('Added vertex: $vertex at index ${_vertices.length - 1}');
    }
  }
  
  void addEdge(String source, String destination, [int weight = 1]) {
    addVertex(source);
    addVertex(destination);
    
    int sourceIndex = _vertexIndex[source]!;
    int destIndex = _vertexIndex[destination]!;
    
    _matrix[sourceIndex][destIndex] = weight;
    
    if (!isDirected) {
      _matrix[destIndex][sourceIndex] = weight;
    }
    
    print('Added edge: $source -> $destination (weight: $weight)');
  }
  
  void display() {
    print('\nAdjacency Matrix:');
    print('   ${_vertices.join(' ')}');
    for (int i = 0; i < _vertices.length; i++) {
      print('${_vertices[i]} ${_matrix[i].join(' ')}');
    }
  }
  
  bool hasEdge(String source, String destination) {
    if (!_vertexIndex.containsKey(source) || !_vertexIndex.containsKey(destination)) {
      return false;
    }
    return _matrix[_vertexIndex[source]!][_vertexIndex[destination]!] != 0;
  }
}

// 6. Practical Graph Examples
class GraphExamples {
  
  // Social Network representation
  static void socialNetwork() {
    print('\n--- Social Network Example ---');
    AdjacencyListGraph<String> socialGraph = AdjacencyListGraph<String>();
    
    // Add people
    socialGraph.addVertex('Alice');
    socialGraph.addVertex('Bob');
    socialGraph.addVertex('Charlie');
    socialGraph.addVertex('Diana');
    
    // Add friendships (undirected)
    socialGraph.addEdge('Alice', 'Bob');
    socialGraph.addEdge('Bob', 'Charlie');
    socialGraph.addEdge('Charlie', 'Diana');
    socialGraph.addEdge('Alice', 'Diana');
    
    socialGraph.display();
    
    print('\nFinding path from Alice to Charlie:');
    var path = socialGraph.findPath('Alice', 'Charlie');
    print('Path: $path');
  }
  
  // City road network
  static void cityRoadNetwork() {
    print('\n--- City Road Network Example ---');
    WeightedGraph<String> cityGraph = WeightedGraph<String>(isDirected: false);
    
    // Add cities and roads with distances
    cityGraph.addEdge('CityA', 'CityB', 5);
    cityGraph.addEdge('CityA', 'CityC', 3);
    cityGraph.addEdge('CityB', 'CityC', 2);
    cityGraph.addEdge('CityB', 'CityD', 4);
    cityGraph.addEdge('CityC', 'CityD', 6);
    
    cityGraph.display();
    
    print('\nShortest distances from CityA:');
    var distances = cityGraph.dijkstra('CityA');
    distances.forEach((city, distance) {
      print('$city: $distance km');
    });
  }
  
  // Web page links
  static void webPageLinks() {
    print('\n--- Web Page Links Example ---');
    AdjacencyListGraph<String> webGraph = AdjacencyListGraph<String>(isDirected: true);
    
    webGraph.addEdge('HomePage', 'AboutUs');
    webGraph.addEdge('HomePage', 'Products');
    webGraph.addEdge('Products', 'ProductA');
    webGraph.addEdge('Products', 'ProductB');
    webGraph.addEdge('AboutUs', 'Contact');
    webGraph.addEdge('ProductA', 'Contact');
    
    webGraph.display();
    
    print('\nBFS traversal from HomePage:');
    webGraph.bfs('HomePage');
  }
  
  // Course prerequisites
  static void coursePrerequisites() {
    print('\n--- Course Prerequisites Example ---');
    AdjacencyListGraph<String> courseGraph = AdjacencyListGraph<String>(isDirected: true);
    
    // Course -> Prerequisite relationship
    courseGraph.addEdge('Math101', 'Algebra');
    courseGraph.addEdge('Physics101', 'Math101');
    courseGraph.addEdge('Chemistry101', 'Math101');
    courseGraph.addEdge('Engineering', 'Physics101');
    courseGraph.addEdge('Engineering', 'Chemistry101');
    
    courseGraph.display();
    
    print('\nDFS traversal from Algebra (prerequisite chain):');
    courseGraph.dfs('Algebra');
  }
}

// 7. Graph Algorithms
class GraphAlgorithms {
  
  // Topological Sort (for DAG - Directed Acyclic Graph)
  static List<T>? topologicalSort<T>(AdjacencyListGraph<T> graph) {
    if (!graph.isDirected) return null;
    
    Map<T, int> inDegree = {};
    Queue<T> queue = Queue<T>();
    List<T> result = [];
    
    // Calculate in-degrees
    for (var vertex in graph.vertices) {
      inDegree[vertex] = 0;
    }
    
    for (var vertex in graph.vertices) {
      for (var neighbor in graph.getNeighbors(vertex)) {
        inDegree[neighbor] = (inDegree[neighbor] ?? 0) + 1;
      }
    }
    
    // Add vertices with 0 in-degree to queue
    for (var vertex in graph.vertices) {
      if (inDegree[vertex] == 0) {
        queue.add(vertex);
      }
    }
    
    // Process vertices
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      result.add(current);
      
      for (var neighbor in graph.getNeighbors(current)) {
        inDegree[neighbor] = inDegree[neighbor]! - 1;
        if (inDegree[neighbor] == 0) {
          queue.add(neighbor);
        }
      }
    }
    
    return result.length == graph.vertices.length ? result : null;
  }
  
  // Check if graph is connected (for undirected graph)
  static bool isConnected<T>(AdjacencyListGraph<T> graph) {
    if (graph.vertices.isEmpty) return true;
    
    Set<T> visited = <T>{};
    Queue<T> queue = Queue<T>();
    
    T start = graph.vertices.first;
    queue.add(start);
    visited.add(start);
    
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      
      for (var neighbor in graph.getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    
    return visited.length == graph.vertices.length;
  }
}

void main() {
  print('=== Graph Implementation Demo ===\n');
  
  // Demo 1: Basic Undirected Graph
  print('1. Basic Undirected Graph:');
  AdjacencyListGraph<String> undirectedGraph = AdjacencyListGraph<String>();
  
  undirectedGraph.addEdge('A', 'B');
  undirectedGraph.addEdge('B', 'C');
  undirectedGraph.addEdge('C', 'D');
  undirectedGraph.addEdge('A', 'D');
  undirectedGraph.display();
  
  print('\nDFS from A:');
  undirectedGraph.dfs('A');
  
  print('\nBFS from A:');
  undirectedGraph.bfs('A');
  
  print('\nPath from A to C: ${undirectedGraph.findPath('A', 'C')}');
  print('Has cycle: ${undirectedGraph.hasCycle()}');
  print('Is connected: ${GraphAlgorithms.isConnected(undirectedGraph)}');
  
  // Demo 2: Directed Graph
  print('\n2. Directed Graph:');
  AdjacencyListGraph<int> directedGraph = AdjacencyListGraph<int>(isDirected: true);
  
  directedGraph.addEdge(1, 2);
  directedGraph.addEdge(2, 3);
  directedGraph.addEdge(3, 4);
  directedGraph.addEdge(1, 4);
  directedGraph.display();
  
  print('\nTopological Sort: ${GraphAlgorithms.topologicalSort(directedGraph)}');
  
  // Demo 3: Weighted Graph
  print('\n3. Weighted Graph:');
  WeightedGraph<String> weightedGraph = WeightedGraph<String>();
  
  weightedGraph.addEdge('A', 'B', 4);
  weightedGraph.addEdge('A', 'C', 2);
  weightedGraph.addEdge('B', 'C', 1);
  weightedGraph.addEdge('B', 'D', 5);
  weightedGraph.addEdge('C', 'D', 8);
  weightedGraph.addEdge('C', 'E', 10);
  weightedGraph.addEdge('D', 'E', 2);
  
  weightedGraph.display();
  
  print('\nShortest paths from A (Dijkstra):');
  var distances = weightedGraph.dijkstra('A');
  distances.forEach((vertex, distance) {
    print('$vertex: $distance');
  });
  
  // Demo 4: Adjacency Matrix
  print('\n4. Adjacency Matrix:');
  AdjacencyMatrixGraph matrixGraph = AdjacencyMatrixGraph(4);
  
  matrixGraph.addVertex('X');
  matrixGraph.addVertex('Y');
  matrixGraph.addVertex('Z');
  matrixGraph.addVertex('W');
  
  matrixGraph.addEdge('X', 'Y');
  matrixGraph.addEdge('Y', 'Z', 3);
  matrixGraph.addEdge('Z', 'W', 2);
  matrixGraph.addEdge('X', 'W', 5);
  
  matrixGraph.display();
  
  // Demo 5: Practical Examples
  print('\n5. Practical Examples:');
  GraphExamples.socialNetwork();
  GraphExamples.cityRoadNetwork();
  GraphExamples.webPageLinks();
  GraphExamples.coursePrerequisites();
  
  print('\n=== Graph Concepts Summary ===');
  print('• Vertex/Node: A point in the graph');
  print('• Edge: Connection between two vertices');
  print('• Directed Graph: Edges have direction');
  print('• Undirected Graph: Edges are bidirectional');
  print('• Weighted Graph: Edges have weights/costs');
  print('• Adjacency List: Most space-efficient representation');
  print('• Adjacency Matrix: Fast edge lookup, more space');
  print('• DFS: Depth-First Search (uses stack/recursion)');
  print('• BFS: Breadth-First Search (uses queue)');
  print('• Applications: Social networks, maps, web pages, etc.');
}