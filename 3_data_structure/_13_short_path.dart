import 'dart:collection';
import 'dart:math' as math;

// 1. Edge representation for weighted graphs
class Edge {
  int source;
  int destination;
  int weight;
  
  Edge(this.source, this.destination, this.weight);
  
  @override
  String toString() => '$source -> $destination (weight: $weight)';
}

// 2. Priority Queue for Dijkstra's algorithm
class PriorityQueueItem {
  int vertex;
  int distance;
  
  PriorityQueueItem(this.vertex, this.distance);
  
  @override
  String toString() => '($vertex, dist: $distance)';
}

class MinPriorityQueue {
  List<PriorityQueueItem> _heap = [];
  
  bool get isEmpty => _heap.isEmpty;
  int get size => _heap.length;
  
  int _parent(int index) => (index - 1) ~/ 2;
  int _leftChild(int index) => 2 * index + 1;
  int _rightChild(int index) => 2 * index + 2;
  
  void _swap(int i, int j) {
    PriorityQueueItem temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
  
  void _heapifyUp(int index) {
    while (index > 0) {
      int parentIndex = _parent(index);
      if (_heap[index].distance >= _heap[parentIndex].distance) break;
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }
  
  void _heapifyDown(int index) {
    while (_leftChild(index) < _heap.length) {
      int minChildIndex = _leftChild(index);
      
      if (_rightChild(index) < _heap.length &&
          _heap[_rightChild(index)].distance < _heap[minChildIndex].distance) {
        minChildIndex = _rightChild(index);
      }
      
      if (_heap[index].distance <= _heap[minChildIndex].distance) break;
      
      _swap(index, minChildIndex);
      index = minChildIndex;
    }
  }
  
  void insert(int vertex, int distance) {
    _heap.add(PriorityQueueItem(vertex, distance));
    _heapifyUp(_heap.length - 1);
  }
  
  PriorityQueueItem extractMin() {
    if (isEmpty) throw StateError('Priority queue is empty');
    
    if (_heap.length == 1) {
      return _heap.removeAt(0);
    }
    
    PriorityQueueItem min = _heap[0];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    
    return min;
  }
  
  void decreaseKey(int vertex, int newDistance) {
    int index = -1;
    for (int i = 0; i < _heap.length; i++) {
      if (_heap[i].vertex == vertex) {
        index = i;
        break;
      }
    }
    
    if (index != -1 && newDistance < _heap[index].distance) {
      _heap[index].distance = newDistance;
      _heapifyUp(index);
    }
  }
}

// 3. Weighted Graph class for shortest path algorithms
class WeightedGraph {
  Map<int, List<Edge>> _adjacencyList = {};
  int _vertexCount = 0;
  bool isDirected;
  
  WeightedGraph({this.isDirected = true});
  
  void addVertex(int vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
      _vertexCount = math.max(_vertexCount, vertex + 1);
    }
  }
  
  void addEdge(int source, int destination, int weight) {
    addVertex(source);
    addVertex(destination);
    
    _adjacencyList[source]!.add(Edge(source, destination, weight));
    
    if (!isDirected) {
      _adjacencyList[destination]!.add(Edge(destination, source, weight));
    }
  }
  
  List<int> get vertices => _adjacencyList.keys.toList();
  
  List<Edge> getNeighbors(int vertex) {
    return _adjacencyList[vertex] ?? [];
  }
  
  void display() {
    print('\nWeighted Graph:');
    for (var vertex in _adjacencyList.keys) {
      print('$vertex -> ${_adjacencyList[vertex]}');
    }
  }
  
  // 1. Dijkstra's Algorithm - Single Source Shortest Path (Non-negative weights)
  Map<String, dynamic> dijkstra(int source) {
    Map<int, int> distances = {};
    Map<int, int?> previous = {};
    Set<int> visited = {};
    MinPriorityQueue pq = MinPriorityQueue();
    
    // Initialize distances
    for (int vertex in vertices) {
      distances[vertex] = vertex == source ? 0 : double.maxFinite.toInt();
      previous[vertex] = null;
    }
    
    pq.insert(source, 0);
    
    print('\nDijkstra\'s Algorithm from vertex $source:');
    
    while (pq.isNotEmpty) {
      PriorityQueueItem current = pq.extractMin();
      int currentVertex = current.vertex;
      
      if (visited.contains(currentVertex)) continue;
      visited.add(currentVertex);
      
      print('Processing vertex $currentVertex (distance: ${distances[currentVertex]})');
      
      for (Edge edge in getNeighbors(currentVertex)) {
        int neighbor = edge.destination;
        int newDistance = distances[currentVertex]! + edge.weight;
        
        if (newDistance < distances[neighbor]!) {
          distances[neighbor] = newDistance;
          previous[neighbor] = currentVertex;
          pq.insert(neighbor, newDistance);
          print('  Updated distance to $neighbor: $newDistance');
        }
      }
    }
    
    return {
      'distances': distances,
      'previous': previous,
    };
  }
  
  // 2. Bellman-Ford Algorithm - Single Source (Handles negative weights)
  Map<String, dynamic>? bellmanFord(int source) {
    Map<int, int> distances = {};
    Map<int, int?> previous = {};
    
    // Initialize distances
    for (int vertex in vertices) {
      distances[vertex] = vertex == source ? 0 : double.maxFinite.toInt();
      previous[vertex] = null;
    }
    
    print('\nBellman-Ford Algorithm from vertex $source:');
    
    // Relax edges V-1 times
    for (int i = 0; i < vertices.length - 1; i++) {
      bool updated = false;
      
      for (int vertex in vertices) {
        if (distances[vertex] == double.maxFinite.toInt()) continue;
        
        for (Edge edge in getNeighbors(vertex)) {
          int newDistance = distances[vertex]! + edge.weight;
          
          if (newDistance < distances[edge.destination]!) {
            distances[edge.destination] = newDistance;
            previous[edge.destination] = vertex;
            updated = true;
            print('Iteration ${i + 1}: Updated distance to ${edge.destination}: $newDistance');
          }
        }
      }
      
      if (!updated) {
        print('No updates in iteration ${i + 1}, algorithm can terminate early');
        break;
      }
    }
    
    // Check for negative cycles
    for (int vertex in vertices) {
      if (distances[vertex] == double.maxFinite.toInt()) continue;
      
      for (Edge edge in getNeighbors(vertex)) {
        int newDistance = distances[vertex]! + edge.weight;
        
        if (newDistance < distances[edge.destination]!) {
          print('Negative cycle detected!');
          return null;
        }
      }
    }
    
    return {
      'distances': distances,
      'previous': previous,
    };
  }
  
  // 3. Floyd-Warshall Algorithm - All Pairs Shortest Path
  List<List<int>>? floydWarshall() {
    int n = vertices.length;
    if (n == 0) return null;
    
    // Create vertex index mapping
    Map<int, int> vertexToIndex = {};
    List<int> indexToVertex = [];
    int index = 0;
    for (int vertex in vertices) {
      vertexToIndex[vertex] = index++;
      indexToVertex.add(vertex);
    }
    
    // Initialize distance matrix
    List<List<int>> dist = List.generate(n, (i) => 
        List.generate(n, (j) => 
            i == j ? 0 : double.maxFinite.toInt()));
    
    // Fill initial distances from edges
    for (int vertex in vertices) {
      int i = vertexToIndex[vertex]!;
      for (Edge edge in getNeighbors(vertex)) {
        int j = vertexToIndex[edge.destination]!;
        dist[i][j] = edge.weight;
      }
    }
    
    print('\nFloyd-Warshall Algorithm:');
    print('Initial distance matrix:');
    _printMatrix(dist, indexToVertex);
    
    // Floyd-Warshall main algorithm
    for (int k = 0; k < n; k++) {
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
          if (dist[i][k] != double.maxFinite.toInt() && 
              dist[k][j] != double.maxFinite.toInt() &&
              dist[i][k] + dist[k][j] < dist[i][j]) {
            dist[i][j] = dist[i][k] + dist[k][j];
          }
        }
      }
      
      print('\nAfter considering vertex ${indexToVertex[k]} as intermediate:');
      _printMatrix(dist, indexToVertex);
    }
    
    // Check for negative cycles
    for (int i = 0; i < n; i++) {
      if (dist[i][i] < 0) {
        print('Negative cycle detected!');
        return null;
      }
    }
    
    return dist;
  }
  
  void _printMatrix(List<List<int>> matrix, List<int> labels) {
    print('     ${labels.map((v) => v.toString().padLeft(3)).join(' ')}');
    for (int i = 0; i < matrix.length; i++) {
      String row = '${labels[i].toString().padLeft(3)}: ';
      for (int j = 0; j < matrix[i].length; j++) {
        String value = matrix[i][j] == double.maxFinite.toInt() ? '∞' : matrix[i][j].toString();
        row += value.padLeft(3) + ' ';
      }
      print(row);
    }
  }
  
  // 4. A* Algorithm (requires heuristic function)
  List<int>? aStar(int start, int goal, Map<int, double> Function(int) heuristic) {
    Set<int> closedSet = {};
    Set<int> openSet = {start};
    Map<int, int?> cameFrom = {};
    Map<int, double> gScore = {for (int v in vertices) v: double.infinity};
    Map<int, double> fScore = {for (int v in vertices) v: double.infinity};
    
    gScore[start] = 0;
    fScore[start] = heuristic(start)[goal] ?? double.infinity;
    
    print('\nA* Algorithm from $start to $goal:');
    
    while (openSet.isNotEmpty) {
      // Find node in openSet with lowest fScore
      int current = openSet.reduce((a, b) => 
          (fScore[a] ?? double.infinity) < (fScore[b] ?? double.infinity) ? a : b);
      
      if (current == goal) {
        return _reconstructPath(cameFrom, current);
      }
      
      openSet.remove(current);
      closedSet.add(current);
      
      print('Processing vertex $current (f-score: ${fScore[current]})');
      
      for (Edge edge in getNeighbors(current)) {
        int neighbor = edge.destination;
        
        if (closedSet.contains(neighbor)) continue;
        
        double tentativeGScore = gScore[current]! + edge.weight;
        
        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
        } else if (tentativeGScore >= gScore[neighbor]!) {
          continue;
        }
        
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentativeGScore;
        fScore[neighbor] = gScore[neighbor]! + (heuristic(neighbor)[goal] ?? double.infinity);
        
        print('  Updated neighbor $neighbor: g=${gScore[neighbor]}, f=${fScore[neighbor]}');
      }
    }
    
    return null; // No path found
  }
  
  List<int> _reconstructPath(Map<int, int?> cameFrom, int current) {
    List<int> path = [current];
    
    while (cameFrom[current] != null) {
      current = cameFrom[current]!;
      path.insert(0, current);
    }
    
    return path;
  }
  
  // Helper method to reconstruct path from previous array
  List<int> getPath(Map<int, int?> previous, int source, int destination) {
    List<int> path = [];
    int? current = destination;
    
    while (current != null) {
      path.insert(0, current);
      current = previous[current];
    }
    
    return path.isEmpty || path.first != source ? [] : path;
  }
}

// 4. Unweighted Graph for BFS shortest path
class UnweightedGraph {
  Map<int, List<int>> _adjacencyList = {};
  bool isDirected;
  
  UnweightedGraph({this.isDirected = false});
  
  void addVertex(int vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
    }
  }
  
  void addEdge(int source, int destination) {
    addVertex(source);
    addVertex(destination);
    
    _adjacencyList[source]!.add(destination);
    
    if (!isDirected) {
      _adjacencyList[destination]!.add(source);
    }
  }
  
  List<int> getNeighbors(int vertex) {
    return _adjacencyList[vertex] ?? [];
  }
  
  // BFS for shortest path in unweighted graph
  Map<String, dynamic> bfsShortestPath(int source) {
    Map<int, int> distances = {};
    Map<int, int?> previous = {};
    Set<int> visited = {};
    Queue<int> queue = Queue<int>();
    
    // Initialize
    for (int vertex in _adjacencyList.keys) {
      distances[vertex] = vertex == source ? 0 : -1;
      previous[vertex] = null;
    }
    
    queue.add(source);
    visited.add(source);
    
    print('\nBFS Shortest Path from vertex $source:');
    
    while (queue.isNotEmpty) {
      int current = queue.removeFirst();
      print('Processing vertex $current (distance: ${distances[current]})');
      
      for (int neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          distances[neighbor] = distances[current]! + 1;
          previous[neighbor] = current;
          queue.add(neighbor);
          print('  Found vertex $neighbor at distance ${distances[neighbor]}');
        }
      }
    }
    
    return {
      'distances': distances,
      'previous': previous,
    };
  }
}

// 5. Practical Examples
class ShortestPathExamples {
  
  // GPS Navigation System
  static void gpsNavigationExample() {
    print('\n=== GPS Navigation System Example ===');
    WeightedGraph cityMap = WeightedGraph(isDirected: false);
    
    // Cities: 0=Home, 1=Mall, 2=School, 3=Hospital, 4=Park, 5=Office
    cityMap.addEdge(0, 1, 5);  // Home to Mall (5 min)
    cityMap.addEdge(0, 2, 10); // Home to School (10 min)
    cityMap.addEdge(1, 2, 3);  // Mall to School (3 min)
    cityMap.addEdge(1, 3, 8);  // Mall to Hospital (8 min)
    cityMap.addEdge(2, 4, 4);  // School to Park (4 min)
    cityMap.addEdge(3, 4, 2);  // Hospital to Park (2 min)
    cityMap.addEdge(3, 5, 6);  // Hospital to Office (6 min)
    cityMap.addEdge(4, 5, 7);  // Park to Office (7 min)
    
    Map<String, String> locations = {
      '0': 'Home', '1': 'Mall', '2': 'School',
      '3': 'Hospital', '4': 'Park', '5': 'Office'
    };
    
    print('Finding shortest routes from Home to all locations:');
    var result = cityMap.dijkstra(0);
    Map<int, int> distances = result['distances'];
    Map<int, int?> previous = result['previous'];
    
    for (int destination in [1, 2, 3, 4, 5]) {
      List<int> path = cityMap.getPath(previous, 0, destination);
      String pathStr = path.map((v) => locations[v.toString()]!).join(' -> ');
      print('To ${locations[destination.toString()]}: $pathStr (${distances[destination]} min)');
    }
  }
  
  // Network Routing
  static void networkRoutingExample() {
    print('\n=== Network Routing Example ===');
    WeightedGraph network = WeightedGraph(isDirected: true);
    
    // Routers: 0=Source, 1=Router1, 2=Router2, 3=Router3, 4=Destination
    network.addEdge(0, 1, 4);  // Latency in ms
    network.addEdge(0, 2, 2);
    network.addEdge(1, 2, 1);
    network.addEdge(1, 3, 5);
    network.addEdge(2, 3, 8);
    network.addEdge(2, 4, 10);
    network.addEdge(3, 4, 2);
    
    print('Network topology with latencies (ms):');
    network.display();
    
    var result = network.dijkstra(0);
    Map<int, int> distances = result['distances'];
    Map<int, int?> previous = result['previous'];
    
    List<int> path = network.getPath(previous, 0, 4);
    print('\nOptimal route from Source to Destination:');
    print('Path: ${path.join(' -> ')} (Total latency: ${distances[4]} ms)');
  }
  
  // Social Network - Degrees of Separation
  static void socialNetworkExample() {
    print('\n=== Social Network - Degrees of Separation ===');
    UnweightedGraph socialNetwork = UnweightedGraph();
    
    // People: 0=Alice, 1=Bob, 2=Charlie, 3=Diana, 4=Eve, 5=Frank
    socialNetwork.addEdge(0, 1); // Alice-Bob
    socialNetwork.addEdge(1, 2); // Bob-Charlie
    socialNetwork.addEdge(2, 3); // Charlie-Diana
    socialNetwork.addEdge(0, 4); // Alice-Eve
    socialNetwork.addEdge(4, 5); // Eve-Frank
    socialNetwork.addEdge(3, 5); // Diana-Frank
    
    Map<String, String> people = {
      '0': 'Alice', '1': 'Bob', '2': 'Charlie',
      '3': 'Diana', '4': 'Eve', '5': 'Frank'
    };
    
    var result = socialNetwork.bfsShortestPath(0); // From Alice
    Map<int, int> distances = result['distances'];
    
    print('Degrees of separation from Alice:');
    for (int person in [1, 2, 3, 4, 5]) {
      int separation = distances[person]!;
      print('${people[person.toString()]}: $separation degree(s) of separation');
    }
  }
  
  // Currency Exchange (Detecting negative cycles)
  static void currencyExchangeExample() {
    print('\n=== Currency Exchange Example ===');
    WeightedGraph currencyGraph = WeightedGraph(isDirected: true);
    
    // Currencies: 0=USD, 1=EUR, 2=GBP, 3=JPY
    // Edges represent -log(exchange_rate) to detect arbitrage
    currencyGraph.addEdge(0, 1, -1);  // USD to EUR
    currencyGraph.addEdge(1, 2, -2);  // EUR to GBP
    currencyGraph.addEdge(2, 3, -1);  // GBP to JPY
    currencyGraph.addEdge(3, 0, 3);   // JPY to USD (creates potential arbitrage)
    currencyGraph.addEdge(0, 2, -2);  // Direct USD to GBP
    currencyGraph.addEdge(1, 3, -2);  // Direct EUR to JPY
    
    Map<String, String> currencies = {
      '0': 'USD', '1': 'EUR', '2': 'GBP', '3': 'JPY'
    };
    
    print('Checking for arbitrage opportunities using Bellman-Ford:');
    var result = currencyGraph.bellmanFord(0);
    
    if (result == null) {
      print('Arbitrage opportunity detected! (Negative cycle found)');
    } else {
      print('No arbitrage opportunities found.');
      Map<int, int> distances = result['distances'];
      print('Exchange rates from USD:');
      for (int currency in [1, 2, 3]) {
        print('To ${currencies[currency.toString()]}: ${distances[currency]}');
      }
    }
  }
  
  // Game pathfinding with A*
  static void gamePathfindingExample() {
    print('\n=== Game Pathfinding Example ===');
    WeightedGraph gameMap = WeightedGraph(isDirected: false);
    
    // Game map: 0=Start, 1-8=Waypoints, 9=Goal
    gameMap.addEdge(0, 1, 4);
    gameMap.addEdge(0, 2, 3);
    gameMap.addEdge(1, 3, 2);
    gameMap.addEdge(2, 3, 5);
    gameMap.addEdge(3, 9, 8);
    gameMap.addEdge(1, 4, 6);
    gameMap.addEdge(4, 9, 3);
    
    // Simple heuristic: Manhattan distance estimate
    Map<int, double> simpleHeuristic(int vertex) {
      Map<int, double> h = {};
      // Simplified heuristic values for demonstration
      Map<int, double> heuristicValues = {
        0: 10, 1: 8, 2: 9, 3: 6, 4: 4, 9: 0
      };
      
      for (int v in gameMap.vertices) {
        h[v] = heuristicValues[vertex] ?? double.infinity;
      }
      return h;
    }
    
    print('Finding path from Start (0) to Goal (9) using A*:');
    List<int>? path = gameMap.aStar(0, 9, simpleHeuristic);
    
    if (path != null) {
      print('Optimal path found: ${path.join(' -> ')}');
    } else {
      print('No path found!');
    }
  }
}

// 6. Performance Comparison
class ShortestPathComparison {
  static void compareAlgorithms() {
    print('\n=== Algorithm Performance Comparison ===');
    
    // Create test graph
    WeightedGraph testGraph = WeightedGraph(isDirected: false);
    
    // Add edges for testing
    for (int i = 0; i < 10; i++) {
      for (int j = i + 1; j < 10; j++) {
        if ((i + j) % 3 == 0) { // Add some edges
          testGraph.addEdge(i, j, (i + j) % 5 + 1);
        }
      }
    }
    
    print('Test graph created with ${testGraph.vertices.length} vertices');
    
    // Time Dijkstra's
    Stopwatch stopwatch = Stopwatch()..start();
    testGraph.dijkstra(0);
    stopwatch.stop();
    int dijkstraTime = stopwatch.elapsedMicroseconds;
    
    // Time Floyd-Warshall
    stopwatch.reset();
    stopwatch.start();
    testGraph.floydWarshall();
    stopwatch.stop();
    int floydTime = stopwatch.elapsedMicroseconds;
    
    print('\nPerformance Results:');
    print('Dijkstra\'s Algorithm: ${dijkstraTime} microseconds');
    print('Floyd-Warshall Algorithm: ${floydTime} microseconds');
    
    print('\nAlgorithm Characteristics:');
    print('Dijkstra\'s: O((V + E) log V), single-source, non-negative weights');
    print('Bellman-Ford: O(VE), single-source, handles negative weights');
    print('Floyd-Warshall: O(V³), all-pairs, handles negative weights');
    print('A*: O(b^d), uses heuristic, optimal with admissible heuristic');
  }
}

void main() {
  print('=== Shortest Path Algorithms in Dart ===\n');
  
  // Demo 1: Dijkstra's Algorithm
  print('1. Dijkstra\'s Algorithm Demo:');
  WeightedGraph graph1 = WeightedGraph(isDirected: false);
  
  graph1.addEdge(0, 1, 4);
  graph1.addEdge(0, 2, 1);
  graph1.addEdge(1, 3, 1);
  graph1.addEdge(2, 1, 2);
  graph1.addEdge(2, 3, 5);
  graph1.addEdge(3, 4, 3);
  
  var dijkstraResult = graph1.dijkstra(0);
  Map<int, int> distances = dijkstraResult['distances'];
  Map<int, int?> previous = dijkstraResult['previous'];
  
  print('\nShortest distances from vertex 0:');
  for (int vertex in graph1.vertices) {
    if (vertex != 0) {
      List<int> path = graph1.getPath(previous, 0, vertex);
      print('To vertex $vertex: distance = ${distances[vertex]}, path = ${path.join(' -> ')}');
    }
  }
  
  // Demo 2: Bellman-Ford Algorithm
  print('\n2. Bellman-Ford Algorithm Demo:');
  WeightedGraph graph2 = WeightedGraph(isDirected: true);
  
  graph2.addEdge(0, 1, -1);
  graph2.addEdge(0, 2, 4);
  graph2.addEdge(1, 2, 3);
  graph2.addEdge(1, 3, 2);
  graph2.addEdge(3, 2, 5);
  graph2.addEdge(3, 1, 1);
  
  var bellmanResult = graph2.bellmanFord(0);
  if (bellmanResult != null) {
    Map<int, int> bfDistances = bellmanResult['distances'];
    print('\nBellman-Ford distances from vertex 0:');
    for (int vertex in graph2.vertices) {
      if (vertex != 0) {
        print('To vertex $vertex: ${bfDistances[vertex]}');
      }
    }
  }
  
  // Demo 3: Floyd-Warshall Algorithm
  print('\n3. Floyd-Warshall Algorithm Demo:');
  WeightedGraph graph3 = WeightedGraph(isDirected: true);
  
  graph3.addEdge(0, 1, 3);
  graph3.addEdge(0, 3, 7);
  graph3.addEdge(1, 0, 8);
  graph3.addEdge(1, 2, 2);
  graph3.addEdge(2, 0, 5);
  graph3.addEdge(2, 3, 1);
  graph3.addEdge(3, 0, 2);
  
  var floydResult = graph3.floydWarshall();
  if (floydResult != null) {
    print('\nAll-pairs shortest distances computed successfully!');
  }
  
  // Demo 4: BFS for unweighted graphs
  print('\n4. BFS Shortest Path (Unweighted) Demo:');
  UnweightedGraph graph4 = UnweightedGraph();
  
  graph4.addEdge(0, 1);
  graph4.addEdge(0, 2);
  graph4.addEdge(1, 3);
  graph4.addEdge(2, 3);
  graph4.addEdge(3, 4);
  
  var bfsResult = graph4.bfsShortestPath(0);
  Map<int, int> bfsDistances = bfsResult['distances'];
  
  print('\nBFS shortest distances from vertex 0:');
  for (int vertex in [1, 2, 3, 4]) {
    print('To vertex $vertex: ${bfsDistances[vertex]} hops');
  }
  
  // Demo 5: Practical Examples
  print('\n5. Practical Examples:');
  ShortestPathExamples.gpsNavigationExample();
  ShortestPathExamples.networkRoutingExample();
  ShortestPathExamples.socialNetworkExample();
  ShortestPathExamples.currencyExchangeExample();
  ShortestPathExamples.gamePathfindingExample();
  
  // Demo 6: Performance Comparison
  ShortestPathComparison.compareAlgorithms();
  
  print('\n=== Shortest Path Concepts Summary ===');
  print('• Shortest Path: Find minimum cost/distance path between vertices');
  print('• Dijkstra\'s: Single-source, non-negative weights, O((V+E)logV)');
  print('• Bellman-Ford: Single-source, handles negative weights, O(VE)');
  print('• Floyd-Warshall: All-pairs, handles negative weights, O(V³)');
  print('• BFS: Unweighted graphs, single-source, O(V+E)');
  print('• A*: Heuristic-based, optimal with admissible heuristic');
  print('• Applications: GPS navigation, network routing, game AI, arbitrage detection');
}