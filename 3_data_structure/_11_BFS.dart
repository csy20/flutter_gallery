// Breadth-First Search (BFS) Implementation in Dart
// BFS is a graph traversal algorithm that explores vertices level by level
// It uses a Queue data structure and follows FIFO (First In, First Out) principle

import 'dart:collection';

// 1. Basic Graph representation for BFS
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
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraphNode && runtimeType == other.runtimeType && data == other.data;
  
  @override
  int get hashCode => data.hashCode;
}

// 2. Graph class with BFS implementation
class Graph<T> {
  Map<T, List<T>> _adjacencyList = {};
  bool isDirected;
  
  Graph({this.isDirected = false});
  
  void addVertex(T vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = [];
    }
  }
  
  void addEdge(T source, T destination) {
    addVertex(source);
    addVertex(destination);
    
    _adjacencyList[source]!.add(destination);
    
    if (!isDirected) {
      _adjacencyList[destination]!.add(source);
    }
  }
  
  List<T> get vertices => _adjacencyList.keys.toList();
  
  List<T> getNeighbors(T vertex) {
    return _adjacencyList[vertex] ?? [];
  }
  
  void display() {
    print('\nGraph Structure:');
    for (var vertex in _adjacencyList.keys) {
      print('$vertex -> ${_adjacencyList[vertex]}');
    }
  }
  
  // Basic BFS Implementation
  List<T> bfs(T startVertex) {
    List<T> visited = [];
    Set<T> visitedSet = {};
    Queue<T> queue = Queue<T>();
    
    // Start with the initial vertex
    queue.add(startVertex);
    visitedSet.add(startVertex);
    
    print('\nBFS Traversal from $startVertex:');
    
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      visited.add(current);
      print('Visited: $current');
      
      // Add all unvisited neighbors to the queue
      for (T neighbor in getNeighbors(current)) {
        if (!visitedSet.contains(neighbor)) {
          visitedSet.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    
    return visited;
  }
  
  // BFS with level tracking
  Map<T, int> bfsWithLevels(T startVertex) {
    Map<T, int> levels = {};
    Set<T> visited = {};
    Queue<MapEntry<T, int>> queue = Queue<MapEntry<T, int>>();
    
    queue.add(MapEntry(startVertex, 0));
    visited.add(startVertex);
    levels[startVertex] = 0;
    
    print('\nBFS with Levels from $startVertex:');
    
    while (queue.isNotEmpty) {
      MapEntry<T, int> current = queue.removeFirst();
      T vertex = current.key;
      int level = current.value;
      
      print('Vertex: $vertex, Level: $level');
      
      for (T neighbor in getNeighbors(vertex)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          levels[neighbor] = level + 1;
          queue.add(MapEntry(neighbor, level + 1));
        }
      }
    }
    
    return levels;
  }
  
  // BFS to find shortest path (unweighted graph)
  List<T>? bfsShortestPath(T start, T end) {
    if (start == end) return [start];
    
    Map<T, T?> parent = {};
    Set<T> visited = {};
    Queue<T> queue = Queue<T>();
    
    queue.add(start);
    visited.add(start);
    parent[start] = null;
    
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      
      for (T neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          parent[neighbor] = current;
          queue.add(neighbor);
          
          // Found the target
          if (neighbor == end) {
            return _reconstructPath(parent, start, end);
          }
        }
      }
    }
    
    return null; // No path found
  }
  
  List<T> _reconstructPath(Map<T, T?> parent, T start, T end) {
    List<T> path = [];
    T? current = end;
    
    while (current != null) {
      path.add(current);
      current = parent[current];
    }
    
    return path.reversed.toList();
  }
  
  // BFS to check if graph is connected (for undirected graphs)
  bool isConnected() {
    if (_adjacencyList.isEmpty) return true;
    
    T startVertex = _adjacencyList.keys.first;
    Set<T> visited = {};
    Queue<T> queue = Queue<T>();
    
    queue.add(startVertex);
    visited.add(startVertex);
    
    while (queue.isNotEmpty) {
      T current = queue.removeFirst();
      
      for (T neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    
    return visited.length == _adjacencyList.length;
  }
  
  // BFS to find all nodes at a specific distance
  List<T> nodesAtDistance(T start, int distance) {
    Map<T, int> levels = bfsWithLevels(start);
    return levels.entries
        .where((entry) => entry.value == distance)
        .map((entry) => entry.key)
        .toList();
  }
}

// 3. Binary Tree BFS (Level Order Traversal)
class TreeNode<T> {
  T data;
  TreeNode<T>? left;
  TreeNode<T>? right;
  
  TreeNode(this.data, [this.left, this.right]);
  
  @override
  String toString() => data.toString();
}

class BinaryTree<T> {
  TreeNode<T>? root;
  
  BinaryTree([this.root]);
  
  // Level order traversal (BFS for trees)
  List<T> levelOrderTraversal() {
    if (root == null) return [];
    
    List<T> result = [];
    Queue<TreeNode<T>> queue = Queue<TreeNode<T>>();
    
    queue.add(root!);
    
    print('\nLevel Order Traversal (BFS):');
    
    while (queue.isNotEmpty) {
      TreeNode<T> current = queue.removeFirst();
      result.add(current.data);
      print('Visited: ${current.data}');
      
      if (current.left != null) {
        queue.add(current.left!);
      }
      
      if (current.right != null) {
        queue.add(current.right!);
      }
    }
    
    return result;
  }
  
  // Level order traversal with level information
  Map<int, List<T>> levelOrderWithLevels() {
    if (root == null) return {};
    
    Map<int, List<T>> levels = {};
    Queue<MapEntry<TreeNode<T>, int>> queue = Queue<MapEntry<TreeNode<T>, int>>();
    
    queue.add(MapEntry(root!, 0));
    
    print('\nLevel Order with Levels:');
    
    while (queue.isNotEmpty) {
      MapEntry<TreeNode<T>, int> current = queue.removeFirst();
      TreeNode<T> node = current.key;
      int level = current.value;
      
      if (!levels.containsKey(level)) {
        levels[level] = [];
      }
      levels[level]!.add(node.data);
      
      if (node.left != null) {
        queue.add(MapEntry(node.left!, level + 1));
      }
      
      if (node.right != null) {
        queue.add(MapEntry(node.right!, level + 1));
      }
    }
    
    // Print levels
    for (int level in levels.keys) {
      print('Level $level: ${levels[level]}');
    }
    
    return levels;
  }
  
  // Find maximum width of the tree
  int maxWidth() {
    if (root == null) return 0;
    
    int maxWidth = 0;
    Queue<TreeNode<T>?> queue = Queue<TreeNode<T>?>();
    
    queue.add(root);
    
    while (queue.isNotEmpty) {
      int levelSize = queue.length;
      maxWidth = maxWidth > levelSize ? maxWidth : levelSize;
      
      // Process all nodes at current level
      for (int i = 0; i < levelSize; i++) {
        TreeNode<T>? current = queue.removeFirst();
        
        if (current != null) {
          queue.add(current.left);
          queue.add(current.right);
        }
      }
      
      // Remove trailing nulls
      while (queue.isNotEmpty && queue.last == null) {
        queue.removeLast();
      }
    }
    
    return maxWidth;
  }
}

// 4. Grid BFS (2D Array traversal)
class GridBFS {
  static final List<List<int>> directions = [
    [-1, 0], // up
    [1, 0],  // down
    [0, -1], // left
    [0, 1]   // right
  ];
  
  // BFS to find shortest path in a grid
  static int? shortestPathInGrid(
      List<List<int>> grid, 
      List<int> start, 
      List<int> end) {
    
    int rows = grid.length;
    int cols = grid[0].length;
    
    if (grid[start[0]][start[1]] == 1 || grid[end[0]][end[1]] == 1) {
      return null; // Start or end is blocked
    }
    
    Set<String> visited = {};
    Queue<List<int>> queue = Queue<List<int>>();
    
    queue.add([start[0], start[1], 0]); // [row, col, distance]
    visited.add('${start[0]},${start[1]}');
    
    while (queue.isNotEmpty) {
      List<int> current = queue.removeFirst();
      int row = current[0];
      int col = current[1];
      int distance = current[2];
      
      if (row == end[0] && col == end[1]) {
        return distance;
      }
      
      for (List<int> direction in directions) {
        int newRow = row + direction[0];
        int newCol = col + direction[1];
        String key = '$newRow,$newCol';
        
        if (newRow >= 0 && newRow < rows &&
            newCol >= 0 && newCol < cols &&
            grid[newRow][newCol] == 0 &&
            !visited.contains(key)) {
          
          visited.add(key);
          queue.add([newRow, newCol, distance + 1]);
        }
      }
    }
    
    return null; // No path found
  }
  
  // BFS to find all connected components in a grid
  static List<List<List<int>>> findConnectedComponents(List<List<int>> grid) {
    int rows = grid.length;
    int cols = grid[0].length;
    Set<String> visited = {};
    List<List<List<int>>> components = [];
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        String key = '$i,$j';
        if (grid[i][j] == 1 && !visited.contains(key)) {
          List<List<int>> component = [];
          Queue<List<int>> queue = Queue<List<int>>();
          
          queue.add([i, j]);
          visited.add(key);
          
          while (queue.isNotEmpty) {
            List<int> current = queue.removeFirst();
            int row = current[0];
            int col = current[1];
            component.add([row, col]);
            
            for (List<int> direction in directions) {
              int newRow = row + direction[0];
              int newCol = col + direction[1];
              String newKey = '$newRow,$newCol';
              
              if (newRow >= 0 && newRow < rows &&
                  newCol >= 0 && newCol < cols &&
                  grid[newRow][newCol] == 1 &&
                  !visited.contains(newKey)) {
                
                visited.add(newKey);
                queue.add([newRow, newCol]);
              }
            }
          }
          
          components.add(component);
        }
      }
    }
    
    return components;
  }
}

// 5. Practical BFS Examples
class BFSExamples {
  
  // Social network: Find degrees of separation
  static void socialNetworkExample() {
    print('\n--- Social Network Example ---');
    Graph<String> socialNetwork = Graph<String>();
    
    // Build social network
    socialNetwork.addEdge('Alice', 'Bob');
    socialNetwork.addEdge('Bob', 'Charlie');
    socialNetwork.addEdge('Charlie', 'Diana');
    socialNetwork.addEdge('Alice', 'Eve');
    socialNetwork.addEdge('Eve', 'Frank');
    socialNetwork.addEdge('Frank', 'Diana');
    
    socialNetwork.display();
    
    // Find shortest path between Alice and Diana
    var path = socialNetwork.bfsShortestPath('Alice', 'Diana');
    print('\nShortest path from Alice to Diana: $path');
    print('Degrees of separation: ${path != null ? path.length - 1 : "No connection"}');
    
    // Find all people at distance 2 from Alice
    var peopleAt2 = socialNetwork.nodesAtDistance('Alice', 2);
    print('People at distance 2 from Alice: $peopleAt2');
  }
  
  // Web crawler simulation
  static void webCrawlerExample() {
    print('\n--- Web Crawler Example ---');
    Graph<String> webPages = Graph<String>(isDirected: true);
    
    webPages.addEdge('homepage.html', 'about.html');
    webPages.addEdge('homepage.html', 'products.html');
    webPages.addEdge('products.html', 'product1.html');
    webPages.addEdge('products.html', 'product2.html');
    webPages.addEdge('about.html', 'contact.html');
    webPages.addEdge('product1.html', 'reviews.html');
    
    print('Web crawling starting from homepage.html:');
    var crawledPages = webPages.bfs('homepage.html');
    print('Total pages crawled: ${crawledPages.length}');
  }
  
  // Maze solving
  static void mazeSolvingExample() {
    print('\n--- Maze Solving Example ---');
    
    // 0 = open path, 1 = wall
    List<List<int>> maze = [
      [0, 1, 0, 0, 0],
      [0, 1, 0, 1, 0],
      [0, 0, 0, 1, 0],
      [1, 1, 0, 0, 0],
      [0, 0, 0, 1, 0]
    ];
    
    print('Maze:');
    for (int i = 0; i < maze.length; i++) {
      print(maze[i].map((cell) => cell == 0 ? '.' : '#').join(' '));
    }
    
    List<int> start = [0, 0];
    List<int> end = [4, 4];
    
    int? shortestPath = GridBFS.shortestPathInGrid(maze, start, end);
    print('\nShortest path from (0,0) to (4,4): ${shortestPath ?? "No path found"}');
  }
  
  // Binary tree level analysis
  static void binaryTreeExample() {
    print('\n--- Binary Tree Example ---');
    
    // Create a sample binary tree
    //       1
    //      / \
    //     2   3
    //    / \ / \
    //   4  5 6  7
    
    TreeNode<int> root = TreeNode(1);
    root.left = TreeNode(2);
    root.right = TreeNode(3);
    root.left!.left = TreeNode(4);
    root.left!.right = TreeNode(5);
    root.right!.left = TreeNode(6);
    root.right!.right = TreeNode(7);
    
    BinaryTree<int> tree = BinaryTree(root);
    
    var traversal = tree.levelOrderTraversal();
    print('Level order traversal result: $traversal');
    
    var levels = tree.levelOrderWithLevels();
    
    int width = tree.maxWidth();
    print('Maximum width of tree: $width');
  }
}

// 6. BFS Performance Analysis
class BFSAnalysis {
  static void performanceComparison() {
    print('\n--- BFS Performance Analysis ---');
    
    // Create a large graph for testing
    Graph<int> largeGraph = Graph<int>();
    
    // Create a grid-like structure
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < 100; j++) {
        int current = i * 100 + j;
        if (j < 99) largeGraph.addEdge(current, current + 1); // right
        if (i < 99) largeGraph.addEdge(current, current + 100); // down
      }
    }
    
    Stopwatch stopwatch = Stopwatch()..start();
    var result = largeGraph.bfs(0);
    stopwatch.stop();
    
    print('BFS on 10,000 node graph:');
    print('Nodes visited: ${result.length}');
    print('Time taken: ${stopwatch.elapsedMilliseconds} ms');
    print('Memory usage: Approximately ${result.length * 4} bytes for visited list');
  }
}

void main() {
  print('=== Breadth-First Search (BFS) Implementation Demo ===\n');
  
  // Demo 1: Basic BFS on a simple graph
  print('1. Basic BFS on Simple Graph:');
  Graph<String> simpleGraph = Graph<String>();
  
  simpleGraph.addEdge('A', 'B');
  simpleGraph.addEdge('A', 'C');
  simpleGraph.addEdge('B', 'D');
  simpleGraph.addEdge('C', 'E');
  simpleGraph.addEdge('D', 'F');
  simpleGraph.addEdge('E', 'F');
  
  simpleGraph.display();
  var bfsResult = simpleGraph.bfs('A');
  print('BFS Result: $bfsResult');
  
  // Demo 2: BFS with levels
  print('\n2. BFS with Level Information:');
  var levels = simpleGraph.bfsWithLevels('A');
  print('Vertices and their levels from A: $levels');
  
  // Demo 3: Shortest path using BFS
  print('\n3. Shortest Path using BFS:');
  var shortestPath = simpleGraph.bfsShortestPath('A', 'F');
  print('Shortest path from A to F: $shortestPath');
  print('Path length: ${shortestPath?.length}');
  
  // Demo 4: Graph connectivity
  print('\n4. Graph Connectivity Check:');
  print('Is the graph connected? ${simpleGraph.isConnected()}');
  
  // Demo 5: Nodes at specific distance
  print('\n5. Nodes at Specific Distance:');
  var nodesAt2 = simpleGraph.nodesAtDistance('A', 2);
  print('Nodes at distance 2 from A: $nodesAt2');
  
  // Demo 6: Practical Examples
  print('\n6. Practical Examples:');
  BFSExamples.socialNetworkExample();
  BFSExamples.webCrawlerExample();
  BFSExamples.mazeSolvingExample();
  BFSExamples.binaryTreeExample();
  
  // Demo 7: Performance Analysis
  print('\n7. Performance Analysis:');
  BFSAnalysis.performanceComparison();
  
  print('\n=== BFS Concepts Summary ===');
  print('• BFS explores vertices level by level');
  print('• Uses Queue data structure (FIFO)');
  print('• Time Complexity: O(V + E) where V = vertices, E = edges');
  print('• Space Complexity: O(V) for queue and visited set');
  print('• Finds shortest path in unweighted graphs');
  print('• Applications: Social networks, web crawling, maze solving');
  print('• Guarantees shortest path in unweighted graphs');
  print('• Level-order traversal in trees');
  print('• Connected component detection');
}