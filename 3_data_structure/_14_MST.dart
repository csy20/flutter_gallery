// Minimum Spanning Tree (MST) Implementation in Dart
// A Minimum Spanning Tree is a subset of edges in a weighted, connected, undirected graph
// that connects all vertices with the minimum total edge weight and no cycles

import 'dart:math' as math;

// 1. Edge representation for MST algorithms
class Edge implements Comparable<Edge> {
  int source;
  int destination;
  int weight;
  
  Edge(this.source, this.destination, this.weight);
  
  @override
  int compareTo(Edge other) {
    return weight.compareTo(other.weight);
  }
  
  @override
  String toString() => '$source -- $destination (weight: $weight)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Edge &&
      runtimeType == other.runtimeType &&
      ((source == other.source && destination == other.destination) ||
       (source == other.destination && destination == other.source)) &&
      weight == other.weight;
  
  @override
  int get hashCode => source.hashCode ^ destination.hashCode ^ weight.hashCode;
}

// 2. Union-Find (Disjoint Set) data structure for Kruskal's algorithm
class UnionFind {
  List<int> parent;
  List<int> rank;
  int components;
  
  UnionFind(int n) : parent = List.generate(n, (i) => i), 
                    rank = List.filled(n, 0),
                    components = n;
  
  // Find with path compression
  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]); // Path compression
    }
    return parent[x];
  }
  
  // Union by rank
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
    
    components--;
    return true;
  }
  
  bool connected(int x, int y) {
    return find(x) == find(y);
  }
  
  bool isConnected() {
    return components == 1;
  }
}

// 3. Weighted Graph class for MST algorithms
class WeightedGraph {
  Map<int, List<Edge>> _adjacencyList = {};
  List<Edge> _edges = [];
  Set<int> _vertices = {};
  
  void addVertex(int vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
      _vertices.add(vertex);
    }
  }
  
  void addEdge(int source, int destination, int weight) {
    addVertex(source);
    addVertex(destination);
    
    Edge edge = Edge(source, destination, weight);
    
    _adjacencyList[source]!.add(edge);
    _adjacencyList[destination]!.add(Edge(destination, source, weight));
    
    // Add to edge list (only once for undirected graph)
    if (!_edges.contains(edge)) {
      _edges.add(edge);
    }
  }
  
  List<int> get vertices => _vertices.toList();
  List<Edge> get edges => _edges;
  int get vertexCount => _vertices.length;
  int get edgeCount => _edges.length;
  
  List<Edge> getNeighbors(int vertex) {
    return _adjacencyList[vertex] ?? [];
  }
  
  void display() {
    print('\nWeighted Graph:');
    print('Vertices: ${vertices.length}');
    print('Edges: ${edges.length}');
    for (var vertex in _adjacencyList.keys) {
      print('$vertex: ${_adjacencyList[vertex]}');
    }
  }
  
  // 1. Kruskal's Algorithm - Uses Union-Find and sorts edges
  MST? kruskalMST() {
    if (vertices.isEmpty) return null;
    
    print('\n=== Kruskal\'s Algorithm ===');
    
    // Sort all edges by weight
    List<Edge> sortedEdges = List.from(_edges);
    sortedEdges.sort();
    
    print('Sorted edges: ${sortedEdges.map((e) => '${e.source}-${e.destination}(${e.weight})').join(', ')}');
    
    UnionFind uf = UnionFind(vertices.length);
    Map<int, int> vertexToIndex = {};
    int index = 0;
    for (int vertex in vertices) {
      vertexToIndex[vertex] = index++;
    }
    
    List<Edge> mstEdges = [];
    int totalWeight = 0;
    
    print('\nProcessing edges:');
    
    for (Edge edge in sortedEdges) {
      int sourceIndex = vertexToIndex[edge.source]!;
      int destIndex = vertexToIndex[edge.destination]!;
      
      if (!uf.connected(sourceIndex, destIndex)) {
        uf.union(sourceIndex, destIndex);
        mstEdges.add(edge);
        totalWeight += edge.weight;
        print('Added: ${edge.source} -- ${edge.destination} (weight: ${edge.weight})');
        
        // MST is complete when we have V-1 edges
        if (mstEdges.length == vertices.length - 1) {
          break;
        }
      } else {
        print('Rejected: ${edge.source} -- ${edge.destination} (would create cycle)');
      }
    }
    
    if (mstEdges.length == vertices.length - 1) {
      return MST(mstEdges, totalWeight, 'Kruskal');
    }
    
    return null; // Graph is not connected
  }
  
  // 2. Prim's Algorithm - Grows MST from a starting vertex
  MST? primMST([int? startVertex]) {
    if (vertices.isEmpty) return null;
    
    startVertex ??= vertices.first;
    
    print('\n=== Prim\'s Algorithm (starting from vertex $startVertex) ===');
    
    Set<int> inMST = {startVertex};
    List<Edge> mstEdges = [];
    int totalWeight = 0;
    
    // Priority queue to store edges (using list and manual sorting for simplicity)
    List<Edge> edgeQueue = [];
    
    // Add all edges from starting vertex
    for (Edge edge in getNeighbors(startVertex)) {
      if (!inMST.contains(edge.destination)) {
        edgeQueue.add(edge);
      }
    }
    
    print('Starting from vertex $startVertex');
    
    while (edgeQueue.isNotEmpty && inMST.length < vertices.length) {
      // Find minimum weight edge
      edgeQueue.sort();
      Edge minEdge = edgeQueue.removeAt(0);
      
      // If destination is already in MST, skip this edge
      if (inMST.contains(minEdge.destination)) {
        continue;
      }
      
      // Add edge to MST
      mstEdges.add(minEdge);
      totalWeight += minEdge.weight;
      inMST.add(minEdge.destination);
      
      print('Added: ${minEdge.source} -- ${minEdge.destination} (weight: ${minEdge.weight})');
      
      // Add all edges from newly added vertex
      for (Edge edge in getNeighbors(minEdge.destination)) {
        if (!inMST.contains(edge.destination)) {
          edgeQueue.add(edge);
        }
      }
    }
    
    if (mstEdges.length == vertices.length - 1) {
      return MST(mstEdges, totalWeight, 'Prim');
    }
    
    return null; // Graph is not connected
  }
  
  // 3. Borůvka's Algorithm - Parallel-friendly MST algorithm
  MST? boruvkaMST() {
    if (vertices.isEmpty) return null;
    
    print('\n=== Borůvka\'s Algorithm ===');
    
    UnionFind uf = UnionFind(vertices.length);
    Map<int, int> vertexToIndex = {};
    int index = 0;
    for (int vertex in vertices) {
      vertexToIndex[vertex] = index++;
    }
    
    List<Edge> mstEdges = [];
    int totalWeight = 0;
    int iteration = 1;
    
    while (uf.components > 1) {
      print('\nIteration $iteration:');
      
      // Find cheapest edge for each component
      Map<int, Edge?> cheapestEdge = {};
      
      for (Edge edge in _edges) {
        int sourceComponent = uf.find(vertexToIndex[edge.source]!);
        int destComponent = uf.find(vertexToIndex[edge.destination]!);
        
        if (sourceComponent != destComponent) {
          // Update cheapest edge for source component
          if (cheapestEdge[sourceComponent] == null || 
              edge.weight < cheapestEdge[sourceComponent]!.weight) {
            cheapestEdge[sourceComponent] = edge;
          }
          
          // Update cheapest edge for destination component
          if (cheapestEdge[destComponent] == null || 
              edge.weight < cheapestEdge[destComponent]!.weight) {
            cheapestEdge[destComponent] = edge;
          }
        }
      }
      
      // Add cheapest edges to MST
      Set<Edge> edgesToAdd = {};
      for (Edge? edge in cheapestEdge.values) {
        if (edge != null) {
          edgesToAdd.add(edge);
        }
      }
      
      for (Edge edge in edgesToAdd) {
        int sourceIndex = vertexToIndex[edge.source]!;
        int destIndex = vertexToIndex[edge.destination]!;
        
        if (uf.union(sourceIndex, destIndex)) {
          mstEdges.add(edge);
          totalWeight += edge.weight;
          print('Added: ${edge.source} -- ${edge.destination} (weight: ${edge.weight})');
        }
      }
      
      iteration++;
    }
    
    if (mstEdges.length == vertices.length - 1) {
      return MST(mstEdges, totalWeight, 'Borůvka');
    }
    
    return null;
  }
  
  // Check if graph is connected
  bool isConnected() {
    if (vertices.isEmpty) return true;
    
    Set<int> visited = {};
    List<int> stack = [vertices.first];
    
    while (stack.isNotEmpty) {
      int current = stack.removeLast();
      if (visited.contains(current)) continue;
      
      visited.add(current);
      
      for (Edge edge in getNeighbors(current)) {
        if (!visited.contains(edge.destination)) {
          stack.add(edge.destination);
        }
      }
    }
    
    return visited.length == vertices.length;
  }
}

// 4. MST result class
class MST {
  List<Edge> edges;
  int totalWeight;
  String algorithm;
  
  MST(this.edges, this.totalWeight, this.algorithm);
  
  void display() {
    print('\n--- MST Result ($algorithm\'s Algorithm) ---');
    print('Total weight: $totalWeight');
    print('Edges in MST:');
    for (Edge edge in edges) {
      print('  $edge');
    }
    print('Number of edges: ${edges.length}');
  }
  
  // Verify MST properties
  bool verify(WeightedGraph graph) {
    // Check if number of edges is correct (V-1)
    if (edges.length != graph.vertexCount - 1) {
      print('Error: MST should have ${graph.vertexCount - 1} edges, but has ${edges.length}');
      return false;
    }
    
    // Check if MST is connected using Union-Find
    UnionFind uf = UnionFind(graph.vertexCount);
    Map<int, int> vertexToIndex = {};
    int index = 0;
    for (int vertex in graph.vertices) {
      vertexToIndex[vertex] = index++;
    }
    
    for (Edge edge in edges) {
      int sourceIndex = vertexToIndex[edge.source]!;
      int destIndex = vertexToIndex[edge.destination]!;
      
      if (!uf.union(sourceIndex, destIndex)) {
        print('Error: MST contains a cycle');
        return false;
      }
    }
    
    if (!uf.isConnected()) {
      print('Error: MST is not connected');
      return false;
    }
    
    print('MST verification passed!');
    return true;
  }
  
  // Calculate savings compared to using all edges
  double calculateSavings(WeightedGraph graph) {
    int totalGraphWeight = graph.edges.fold(0, (sum, edge) => sum + edge.weight);
    double savings = ((totalGraphWeight - totalWeight) / totalGraphWeight) * 100;
    return savings;
  }
}

// 5. Practical MST Examples
class MSTExamples {
  
  // Network Infrastructure Planning
  static void networkInfrastructureExample() {
    print('\n=== Network Infrastructure Planning ===');
    WeightedGraph network = WeightedGraph();
    
    // Cities: 0=CityA, 1=CityB, 2=CityC, 3=CityD, 4=CityE
    // Edge weights represent cable installation costs in thousands
    network.addEdge(0, 1, 10); // CityA to CityB
    network.addEdge(0, 2, 6);  // CityA to CityC
    network.addEdge(0, 3, 5);  // CityA to CityD
    network.addEdge(1, 3, 15); // CityB to CityD
    network.addEdge(1, 4, 20); // CityB to CityE
    network.addEdge(2, 3, 4);  // CityC to CityD
    network.addEdge(3, 4, 10); // CityD to CityE
    
    Map<String, String> cities = {
      '0': 'CityA', '1': 'CityB', '2': 'CityC', '3': 'CityD', '4': 'CityE'
    };
    
    print('Planning network infrastructure to connect all cities:');
    network.display();
    
    MST? mst = network.kruskalMST();
    if (mst != null) {
      mst.display();
      print('\nNetwork cables needed:');
      for (Edge edge in mst.edges) {
        print('${cities[edge.source.toString()]} -- ${cities[edge.destination.toString()]}: \$${edge.weight}k');
      }
      print('Total installation cost: \$${mst.totalWeight}k');
      
      double savings = mst.calculateSavings(network);
      print('Savings compared to connecting all cities: ${savings.toStringAsFixed(1)}%');
    }
  }
  
  // Circuit Board Design
  static void circuitBoardExample() {
    print('\n=== Circuit Board Design ===');
    WeightedGraph circuit = WeightedGraph();
    
    // Components: 0=CPU, 1=RAM, 2=GPU, 3=Storage, 4=PowerSupply
    // Edge weights represent wire lengths in mm
    circuit.addEdge(0, 1, 15); // CPU to RAM
    circuit.addEdge(0, 2, 25); // CPU to GPU
    circuit.addEdge(0, 3, 30); // CPU to Storage
    circuit.addEdge(0, 4, 20); // CPU to Power
    circuit.addEdge(1, 2, 35); // RAM to GPU
    circuit.addEdge(1, 4, 18); // RAM to Power
    circuit.addEdge(2, 4, 22); // GPU to Power
    circuit.addEdge(3, 4, 12); // Storage to Power
    
    Map<String, String> components = {
      '0': 'CPU', '1': 'RAM', '2': 'GPU', '3': 'Storage', '4': 'Power'
    };
    
    print('Designing minimal wire connections for circuit board:');
    
    MST? mst = circuit.primMST(0); // Start from CPU
    if (mst != null) {
      mst.display();
      print('\nWire connections needed:');
      for (Edge edge in mst.edges) {
        print('${components[edge.source.toString()]} -- ${components[edge.destination.toString()]}: ${edge.weight}mm');
      }
      print('Total wire length: ${mst.totalWeight}mm');
    }
  }
  
  // Road Network Planning
  static void roadNetworkExample() {
    print('\n=== Road Network Planning ===');
    WeightedGraph roads = WeightedGraph();
    
    // Towns: 0-6 representing different towns
    // Edge weights represent construction costs in millions
    roads.addEdge(0, 1, 7);
    roads.addEdge(0, 3, 5);
    roads.addEdge(1, 2, 8);
    roads.addEdge(1, 3, 9);
    roads.addEdge(1, 4, 7);
    roads.addEdge(2, 4, 5);
    roads.addEdge(3, 4, 15);
    roads.addEdge(3, 5, 6);
    roads.addEdge(4, 5, 8);
    roads.addEdge(4, 6, 9);
    roads.addEdge(5, 6, 11);
    
    print('Planning road network to connect all towns:');
    
    // Compare different algorithms
    MST? kruskalResult = roads.kruskalMST();
    MST? primResult = roads.primMST();
    MST? boruvkaResult = roads.boruvkaMST();
    
    print('\n--- Algorithm Comparison ---');
    if (kruskalResult != null) {
      print('Kruskal\'s result: Total cost = \$${kruskalResult.totalWeight}M');
    }
    if (primResult != null) {
      print('Prim\'s result: Total cost = \$${primResult.totalWeight}M');
    }
    if (boruvkaResult != null) {
      print('Borůvka\'s result: Total cost = \$${boruvkaResult.totalWeight}M');
    }
    
    // All algorithms should produce the same total weight (though edge order may differ)
    if (kruskalResult != null && primResult != null && boruvkaResult != null) {
      bool allEqual = kruskalResult.totalWeight == primResult.totalWeight && 
                     primResult.totalWeight == boruvkaResult.totalWeight;
      print('All algorithms produce same total cost: $allEqual');
    }
  }
  
  // Cluster Analysis (Graph-based clustering)
  static void clusterAnalysisExample() {
    print('\n=== Cluster Analysis Example ===');
    WeightedGraph dataPoints = WeightedGraph();
    
    // Data points with similarity weights (higher weight = less similar)
    // We'll find MST and then remove heaviest edges to form clusters
    dataPoints.addEdge(0, 1, 2);  // Points 0,1 very similar
    dataPoints.addEdge(0, 2, 3);
    dataPoints.addEdge(1, 2, 2);  // Points 1,2 very similar
    dataPoints.addEdge(2, 3, 8);  // Large gap (different cluster)
    dataPoints.addEdge(3, 4, 3);  // Points 3,4 similar
    dataPoints.addEdge(3, 5, 2);
    dataPoints.addEdge(4, 5, 3);  // Points 4,5 similar
    dataPoints.addEdge(0, 3, 12); // Large gaps between clusters
    dataPoints.addEdge(1, 4, 10);
    dataPoints.addEdge(2, 5, 9);
    
    MST? mst = dataPoints.kruskalMST();
    if (mst != null) {
      print('MST for clustering:');
      mst.display();
      
      // Remove heaviest edges to form clusters
      List<Edge> sortedMSTEdges = List.from(mst.edges);
      sortedMSTEdges.sort((a, b) => b.weight.compareTo(a.weight)); // Sort descending
      
      print('\nForming 2 clusters by removing heaviest edge:');
      print('Removed edge: ${sortedMSTEdges.first}');
      print('This separates the data into clusters.');
    }
  }
}

// 6. Performance Analysis
class MSTPerformanceAnalysis {
  static void compareAlgorithms() {
    print('\n=== MST Algorithm Performance Analysis ===');
    
    // Create a larger test graph
    WeightedGraph testGraph = WeightedGraph();
    int numVertices = 10;
    
    // Create a dense graph
    for (int i = 0; i < numVertices; i++) {
      for (int j = i + 1; j < numVertices; j++) {
        int weight = (i * j + 1) % 20 + 1; // Random-like weights
        testGraph.addEdge(i, j, weight);
      }
    }
    
    print('Test graph: $numVertices vertices, ${testGraph.edgeCount} edges');
    
    // Time each algorithm
    Stopwatch stopwatch = Stopwatch();
    
    // Kruskal's
    stopwatch.start();
    MST? kruskalResult = testGraph.kruskalMST();
    stopwatch.stop();
    int kruskalTime = stopwatch.elapsedMicroseconds;
    
    // Prim's
    stopwatch.reset();
    stopwatch.start();
    MST? primResult = testGraph.primMST();
    stopwatch.stop();
    int primTime = stopwatch.elapsedMicroseconds;
    
    // Borůvka's
    stopwatch.reset();
    stopwatch.start();
    MST? boruvkaResult = testGraph.boruvkaMST();
    stopwatch.stop();
    int boruvkaTime = stopwatch.elapsedMicroseconds;
    
    print('\nPerformance Results:');
    print('Kruskal\'s Algorithm: ${kruskalTime} microseconds');
    print('Prim\'s Algorithm: ${primTime} microseconds');
    print('Borůvka\'s Algorithm: ${boruvkaTime} microseconds');
    
    // Verify all produce same result
    if (kruskalResult != null && primResult != null && boruvkaResult != null) {
      print('\nResults verification:');
      print('Kruskal total weight: ${kruskalResult.totalWeight}');
      print('Prim total weight: ${primResult.totalWeight}');
      print('Borůvka total weight: ${boruvkaResult.totalWeight}');
      
      bool allEqual = kruskalResult.totalWeight == primResult.totalWeight && 
                     primResult.totalWeight == boruvkaResult.totalWeight;
      print('All algorithms produce same total weight: $allEqual');
    }
    
    print('\nTime Complexity Analysis:');
    print('Kruskal\'s: O(E log E) - Good for sparse graphs');
    print('Prim\'s: O(E log V) - Good for dense graphs');
    print('Borůvka\'s: O(E log V) - Parallelizable');
  }
}

void main() {
  print('=== Minimum Spanning Tree (MST) Algorithms in Dart ===\n');
  
  // Demo 1: Basic MST example
  print('1. Basic MST Example:');
  WeightedGraph graph = WeightedGraph();
  
  graph.addEdge(0, 1, 4);
  graph.addEdge(0, 7, 8);
  graph.addEdge(1, 2, 8);
  graph.addEdge(1, 7, 11);
  graph.addEdge(2, 3, 7);
  graph.addEdge(2, 8, 2);
  graph.addEdge(2, 5, 4);
  graph.addEdge(3, 4, 9);
  graph.addEdge(3, 5, 14);
  graph.addEdge(4, 5, 10);
  graph.addEdge(5, 6, 2);
  graph.addEdge(6, 7, 1);
  graph.addEdge(6, 8, 6);
  graph.addEdge(7, 8, 7);
  
  graph.display();
  
  // Test connectivity
  print('\nGraph connectivity check: ${graph.isConnected()}');
  
  // Demo 2: Kruskal's Algorithm
  MST? kruskalMST = graph.kruskalMST();
  if (kruskalMST != null) {
    kruskalMST.display();
    kruskalMST.verify(graph);
  }
  
  // Demo 3: Prim's Algorithm
  MST? primMST = graph.primMST();
  if (primMST != null) {
    primMST.display();
    primMST.verify(graph);
  }
  
  // Demo 4: Borůvka's Algorithm
  MST? boruvkaMST = graph.boruvkaMST();
  if (boruvkaMST != null) {
    boruvkaMST.display();
    boruvkaMST.verify(graph);
  }
  
  // Demo 5: Comparison of results
  if (kruskalMST != null && primMST != null && boruvkaMST != null) {
    print('\n--- Algorithm Comparison ---');
    print('Kruskal total weight: ${kruskalMST.totalWeight}');
    print('Prim total weight: ${primMST.totalWeight}');
    print('Borůvka total weight: ${boruvkaMST.totalWeight}');
    
    bool allEqual = kruskalMST.totalWeight == primMST.totalWeight && 
                   primMST.totalWeight == boruvkaMST.totalWeight;
    print('All algorithms produce same total weight: $allEqual');
  }
  
  // Demo 6: Practical Examples
  print('\n--- Practical Applications ---');
  MSTExamples.networkInfrastructureExample();
  MSTExamples.circuitBoardExample();
  MSTExamples.roadNetworkExample();
  MSTExamples.clusterAnalysisExample();
  
  // Demo 7: Performance Analysis
  MSTPerformanceAnalysis.compareAlgorithms();
  
  print('\n=== MST Concepts Summary ===');
  print('• MST: Minimum weight tree connecting all vertices');
  print('• Properties: V-1 edges, no cycles, connects all vertices');
  print('• Kruskal\'s: Sort edges, use Union-Find, O(E log E)');
  print('• Prim\'s: Grow tree from vertex, use priority queue, O(E log V)');
  print('• Borůvka\'s: Parallel-friendly, find cheapest edge per component');
  print('• Applications: Network design, clustering, circuit design');
  print('• All algorithms produce same total weight (optimal solution)');
}