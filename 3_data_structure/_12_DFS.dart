import 'dart:collection';

// 1. Basic Graph representation for DFS
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

// 2. Graph class with DFS implementations
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
  
  // 1. Recursive DFS Implementation
  List<T> dfsRecursive(T startVertex, [Set<T>? visited]) {
    visited ??= <T>{};
    List<T> result = [];
    
    _dfsRecursiveHelper(startVertex, visited, result);
    return result;
  }
  
  void _dfsRecursiveHelper(T vertex, Set<T> visited, List<T> result) {
    visited.add(vertex);
    result.add(vertex);
    print('Visited (Recursive): $vertex');
    
    for (T neighbor in getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        _dfsRecursiveHelper(neighbor, visited, result);
      }
    }
  }
  
  // 2. Iterative DFS Implementation using Stack
  List<T> dfsIterative(T startVertex) {
    List<T> result = [];
    Set<T> visited = {};
    Stack<T> stack = Stack<T>();
    
    stack.push(startVertex);
    
    print('\nDFS Iterative Traversal from $startVertex:');
    
    while (stack.isNotEmpty) {
      T current = stack.pop();
      
      if (!visited.contains(current)) {
        visited.add(current);
        result.add(current);
        print('Visited (Iterative): $current');
        
        // Add neighbors to stack in reverse order to maintain left-to-right traversal
        List<T> neighbors = getNeighbors(current);
        for (int i = neighbors.length - 1; i >= 0; i--) {
          if (!visited.contains(neighbors[i])) {
            stack.push(neighbors[i]);
          }
        }
      }
    }
    
    return result;
  }
  
  // 3. DFS to find a path between two vertices
  List<T>? dfsPath(T start, T end, [Set<T>? visited, List<T>? path]) {
    visited ??= <T>{};
    path ??= <T>[];
    
    visited.add(start);
    path.add(start);
    
    if (start == end) {
      return List.from(path);
    }
    
    for (T neighbor in getNeighbors(start)) {
      if (!visited.contains(neighbor)) {
        List<T>? result = dfsPath(neighbor, end, visited, path);
        if (result != null) return result;
      }
    }
    
    path.removeLast();
    return null;
  }
  
  // 4. DFS to find all paths between two vertices
  List<List<T>> dfsAllPaths(T start, T end, [Set<T>? visited, List<T>? path]) {
    visited ??= <T>{};
    path ??= <T>[];
    List<List<T>> allPaths = [];
    
    visited.add(start);
    path.add(start);
    
    if (start == end) {
      allPaths.add(List.from(path));
    } else {
      for (T neighbor in getNeighbors(start)) {
        if (!visited.contains(neighbor)) {
          allPaths.addAll(dfsAllPaths(neighbor, end, visited, path));
        }
      }
    }
    
    path.removeLast();
    visited.remove(start);
    
    return allPaths;
  }
  
  // 5. DFS Cycle Detection (for undirected graph)
  bool hasCycleDFS() {
    Set<T> visited = {};
    
    for (T vertex in vertices) {
      if (!visited.contains(vertex)) {
        if (_hasCycleDFSHelper(vertex, visited, null)) {
          return true;
        }
      }
    }
    return false;
  }
  
  bool _hasCycleDFSHelper(T vertex, Set<T> visited, T? parent) {
    visited.add(vertex);
    
    for (T neighbor in getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        if (_hasCycleDFSHelper(neighbor, visited, vertex)) {
          return true;
        }
      } else if (neighbor != parent) {
        return true; // Back edge found
      }
    }
    return false;
  }
  
  // 6. DFS Cycle Detection (for directed graph)
  bool hasCycleDirected() {
    Set<T> visited = {};
    Set<T> recursionStack = {};
    
    for (T vertex in vertices) {
      if (!visited.contains(vertex)) {
        if (_hasCycleDirectedHelper(vertex, visited, recursionStack)) {
          return true;
        }
      }
    }
    return false;
  }
  
  bool _hasCycleDirectedHelper(T vertex, Set<T> visited, Set<T> recursionStack) {
    visited.add(vertex);
    recursionStack.add(vertex);
    
    for (T neighbor in getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        if (_hasCycleDirectedHelper(neighbor, visited, recursionStack)) {
          return true;
        }
      } else if (recursionStack.contains(neighbor)) {
        return true; // Back edge in directed graph
      }
    }
    
    recursionStack.remove(vertex);
    return false;
  }
  
  // 7. Topological Sort using DFS
  List<T>? topologicalSort() {
    if (!isDirected) return null;
    
    Set<T> visited = {};
    Stack<T> stack = Stack<T>();
    
    for (T vertex in vertices) {
      if (!visited.contains(vertex)) {
        _topologicalSortHelper(vertex, visited, stack);
      }
    }
    
    List<T> result = [];
    while (stack.isNotEmpty) {
      result.add(stack.pop());
    }
    
    return result;
  }
  
  void _topologicalSortHelper(T vertex, Set<T> visited, Stack<T> stack) {
    visited.add(vertex);
    
    for (T neighbor in getNeighbors(vertex)) {
      if (!visited.contains(vertex)) {
        _topologicalSortHelper(neighbor, visited, stack);
      }
    }
    
    stack.push(vertex);
  }
  
  // 8. Connected Components using DFS
  List<List<T>> getConnectedComponents() {
    if (isDirected) return []; // For undirected graphs only
    
    Set<T> visited = {};
    List<List<T>> components = [];
    
    for (T vertex in vertices) {
      if (!visited.contains(vertex)) {
        List<T> component = [];
        _dfsConnectedComponents(vertex, visited, component);
        components.add(component);
      }
    }
    
    return components;
  }
  
  void _dfsConnectedComponents(T vertex, Set<T> visited, List<T> component) {
    visited.add(vertex);
    component.add(vertex);
    
    for (T neighbor in getNeighbors(vertex)) {
      if (!visited.contains(neighbor)) {
        _dfsConnectedComponents(neighbor, visited, component);
      }
    }
  }
}

// 3. Stack implementation for iterative DFS
class Stack<T> {
  final List<T> _items = [];
  
  void push(T item) {
    _items.add(item);
  }
  
  T pop() {
    if (isEmpty) {
      throw StateError('Stack is empty');
    }
    return _items.removeLast();
  }
  
  T peek() {
    if (isEmpty) {
      throw StateError('Stack is empty');
    }
    return _items.last;
  }
  
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;
  int get length => _items.length;
}

// 4. Binary Tree DFS Traversals
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
  
  // Preorder traversal (Root, Left, Right)
  List<T> preorderTraversal() {
    List<T> result = [];
    _preorderHelper(root, result);
    return result;
  }
  
  void _preorderHelper(TreeNode<T>? node, List<T> result) {
    if (node == null) return;
    
    result.add(node.data);
    print('Preorder visited: ${node.data}');
    _preorderHelper(node.left, result);
    _preorderHelper(node.right, result);
  }
  
  // Inorder traversal (Left, Root, Right)
  List<T> inorderTraversal() {
    List<T> result = [];
    _inorderHelper(root, result);
    return result;
  }
  
  void _inorderHelper(TreeNode<T>? node, List<T> result) {
    if (node == null) return;
    
    _inorderHelper(node.left, result);
    result.add(node.data);
    print('Inorder visited: ${node.data}');
    _inorderHelper(node.right, result);
  }
  
  // Postorder traversal (Left, Right, Root)
  List<T> postorderTraversal() {
    List<T> result = [];
    _postorderHelper(root, result);
    return result;
  }
  
  void _postorderHelper(TreeNode<T>? node, List<T> result) {
    if (node == null) return;
    
    _postorderHelper(node.left, result);
    _postorderHelper(node.right, result);
    result.add(node.data);
    print('Postorder visited: ${node.data}');
  }
  
  // Iterative Preorder using Stack
  List<T> preorderIterative() {
    if (root == null) return [];
    
    List<T> result = [];
    Stack<TreeNode<T>> stack = Stack<TreeNode<T>>();
    
    stack.push(root!);
    
    while (stack.isNotEmpty) {
      TreeNode<T> current = stack.pop();
      result.add(current.data);
      print('Iterative preorder visited: ${current.data}');
      
      // Push right first, then left (so left is processed first)
      if (current.right != null) {
        stack.push(current.right!);
      }
      if (current.left != null) {
        stack.push(current.left!);
      }
    }
    
    return result;
  }
  
  // Find maximum depth using DFS
  int maxDepth() {
    return _maxDepthHelper(root);
  }
  
  int _maxDepthHelper(TreeNode<T>? node) {
    if (node == null) return 0;
    
    int leftDepth = _maxDepthHelper(node.left);
    int rightDepth = _maxDepthHelper(node.right);
    
    return 1 + (leftDepth > rightDepth ? leftDepth : rightDepth);
  }
  
  // Check if tree is balanced
  bool isBalanced() {
    return _isBalancedHelper(root) != -1;
  }
  
  int _isBalancedHelper(TreeNode<T>? node) {
    if (node == null) return 0;
    
    int leftHeight = _isBalancedHelper(node.left);
    if (leftHeight == -1) return -1;
    
    int rightHeight = _isBalancedHelper(node.right);
    if (rightHeight == -1) return -1;
    
    if ((leftHeight - rightHeight).abs() > 1) return -1;
    
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }
}

// 5. Maze solving using DFS
class MazeSolver {
  static final List<List<int>> directions = [
    [-1, 0], // up
    [1, 0],  // down
    [0, -1], // left
    [0, 1]   // right
  ];
  
  static List<List<int>>? solveMaze(
      List<List<int>> maze, 
      List<int> start, 
      List<int> end) {
    
    int rows = maze.length;
    int cols = maze[0].length;
    Set<String> visited = {};
    List<List<int>> path = [];
    
    if (_solveMazeHelper(maze, start[0], start[1], end[0], end[1], 
                        visited, path, rows, cols)) {
      return path;
    }
    
    return null;
  }
  
  static bool _solveMazeHelper(
      List<List<int>> maze,
      int row, int col,
      int endRow, int endCol,
      Set<String> visited,
      List<List<int>> path,
      int rows, int cols) {
    
    // Check bounds and if cell is valid
    if (row < 0 || row >= rows || col < 0 || col >= cols ||
        maze[row][col] == 1 || visited.contains('$row,$col')) {
      return false;
    }
    
    // Add current position to path
    path.add([row, col]);
    visited.add('$row,$col');
    
    // Check if we reached the destination
    if (row == endRow && col == endCol) {
      return true;
    }
    
    // Try all four directions
    for (List<int> direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];
      
      if (_solveMazeHelper(maze, newRow, newCol, endRow, endCol,
                          visited, path, rows, cols)) {
        return true;
      }
    }
    
    // Backtrack
    path.removeLast();
    return false;
  }
}

// 6. Practical DFS Examples
class DFSExamples {
  
  // File system traversal
  static void fileSystemExample() {
    print('\n--- File System Traversal Example ---');
    Graph<String> fileSystem = Graph<String>(isDirected: true);
    
    fileSystem.addEdge('/', 'home');
    fileSystem.addEdge('/', 'usr');
    fileSystem.addEdge('/', 'var');
    fileSystem.addEdge('home', 'user1');
    fileSystem.addEdge('home', 'user2');
    fileSystem.addEdge('user1', 'documents');
    fileSystem.addEdge('user1', 'downloads');
    fileSystem.addEdge('usr', 'bin');
    fileSystem.addEdge('usr', 'lib');
    
    fileSystem.display();
    
    print('\nDFS traversal of file system from root:');
    var traversal = fileSystem.dfsRecursive('/');
    print('Files and directories visited: $traversal');
  }
  
  // Dependency resolution
  static void dependencyResolutionExample() {
    print('\n--- Dependency Resolution Example ---');
    Graph<String> dependencies = Graph<String>(isDirected: true);
    
    dependencies.addEdge('AppModule', 'DatabaseModule');
    dependencies.addEdge('AppModule', 'UIModule');
    dependencies.addEdge('DatabaseModule', 'ConnectionModule');
    dependencies.addEdge('UIModule', 'ComponentsModule');
    dependencies.addEdge('ComponentsModule', 'UtilsModule');
    
    dependencies.display();
    
    print('\nTopological sort (build order):');
    var buildOrder = dependencies.topologicalSort();
    print('Modules should be built in this order: $buildOrder');
    
    print('\nChecking for circular dependencies:');
    print('Has circular dependency: ${dependencies.hasCycleDirected()}');
  }
  
  // Social network analysis
  static void socialNetworkExample() {
    print('\n--- Social Network Analysis Example ---');
    Graph<String> socialNetwork = Graph<String>();
    
    socialNetwork.addEdge('Alice', 'Bob');
    socialNetwork.addEdge('Alice', 'Charlie');
    socialNetwork.addEdge('Bob', 'Diana');
    socialNetwork.addEdge('Charlie', 'Eve');
    socialNetwork.addEdge('Diana', 'Frank');
    socialNetwork.addEdge('Eve', 'Frank');
    socialNetwork.addEdge('Grace', 'Henry'); // Separate component
    
    socialNetwork.display();
    
    print('\nConnected components (friend groups):');
    var components = socialNetwork.getConnectedComponents();
    for (int i = 0; i < components.length; i++) {
      print('Group ${i + 1}: ${components[i]}');
    }
    
    print('\nAll paths from Alice to Frank:');
    var allPaths = socialNetwork.dfsAllPaths('Alice', 'Frank');
    for (int i = 0; i < allPaths.length; i++) {
      print('Path ${i + 1}: ${allPaths[i]}');
    }
  }
  
  // Puzzle solving (N-Queens problem conceptual)
  static void puzzleSolvingExample() {
    print('\n--- Puzzle Solving (Backtracking) Example ---');
    
    // Simple example: Find path in a small maze
    List<List<int>> maze = [
      [0, 1, 0, 0],
      [0, 1, 0, 1],
      [0, 0, 0, 1],
      [1, 0, 0, 0]
    ];
    
    print('Maze (0 = path, 1 = wall):');
    for (var row in maze) {
      print(row.map((cell) => cell == 0 ? '.' : '#').join(' '));
    }
    
    var solution = MazeSolver.solveMaze(maze, [0, 0], [3, 3]);
    
    if (solution != null) {
      print('\nSolution path found:');
      for (var step in solution) {
        print('Step: (${step[0]}, ${step[1]})');
      }
    } else {
      print('\nNo solution found!');
    }
  }
}

// 7. DFS Performance Analysis
class DFSAnalysis {
  static void performanceComparison() {
    print('\n--- DFS Performance Analysis ---');
    
    // Create a deep graph for testing recursion limits
    Graph<int> deepGraph = Graph<int>(isDirected: true);
    
    // Create a linear chain
    for (int i = 0; i < 1000; i++) {
      deepGraph.addEdge(i, i + 1);
    }
    
    print('Testing DFS on a deep graph (1000 nodes in chain):');
    
    // Test recursive DFS
    Stopwatch stopwatch1 = Stopwatch()..start();
    try {
      var recursiveResult = deepGraph.dfsRecursive(0);
      stopwatch1.stop();
      print('Recursive DFS: ${recursiveResult.length} nodes visited');
      print('Time: ${stopwatch1.elapsedMilliseconds} ms');
    } catch (e) {
      stopwatch1.stop();
      print('Recursive DFS failed: $e');
    }
    
    // Test iterative DFS
    Stopwatch stopwatch2 = Stopwatch()..start();
    var iterativeResult = deepGraph.dfsIterative(0);
    stopwatch2.stop();
    print('Iterative DFS: ${iterativeResult.length} nodes visited');
    print('Time: ${stopwatch2.elapsedMilliseconds} ms');
    
    print('\nMemory usage comparison:');
    print('Recursive: O(V) stack space for recursion');
    print('Iterative: O(V) stack space for explicit stack');
  }
}

void main() {
  print('=== Depth-First Search (DFS) Implementation Demo ===\n');
  
  // Demo 1: Basic DFS on a simple graph
  print('1. Basic DFS on Simple Graph:');
  Graph<String> simpleGraph = Graph<String>();
  
  simpleGraph.addEdge('A', 'B');
  simpleGraph.addEdge('A', 'C');
  simpleGraph.addEdge('B', 'D');
  simpleGraph.addEdge('C', 'E');
  simpleGraph.addEdge('D', 'F');
  simpleGraph.addEdge('E', 'F');
  
  simpleGraph.display();
  
  print('\nRecursive DFS from A:');
  var recursiveResult = simpleGraph.dfsRecursive('A');
  print('Result: $recursiveResult');
  
  var iterativeResult = simpleGraph.dfsIterative('A');
  print('Result: $iterativeResult');
  
  // Demo 2: Path finding
  print('\n2. Path Finding using DFS:');
  var path = simpleGraph.dfsPath('A', 'F');
  print('Path from A to F: $path');
  
  var allPaths = simpleGraph.dfsAllPaths('A', 'F');
  print('All paths from A to F:');
  for (int i = 0; i < allPaths.length; i++) {
    print('  Path ${i + 1}: ${allPaths[i]}');
  }
  
  // Demo 3: Cycle detection
  print('\n3. Cycle Detection:');
  print('Has cycle (undirected): ${simpleGraph.hasCycleDFS()}');
  
  Graph<String> directedGraph = Graph<String>(isDirected: true);
  directedGraph.addEdge('X', 'Y');
  directedGraph.addEdge('Y', 'Z');
  directedGraph.addEdge('Z', 'X'); // Creates a cycle
  
  print('Has cycle (directed): ${directedGraph.hasCycleDirected()}');
  
  // Demo 4: Connected components
  print('\n4. Connected Components:');
  var components = simpleGraph.getConnectedComponents();
  print('Connected components: $components');
  
  // Demo 5: Binary Tree DFS
  print('\n5. Binary Tree DFS Traversals:');
  
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
  
  print('\nPreorder traversal:');
  var preorder = tree.preorderTraversal();
  print('Result: $preorder');
  
  print('\nInorder traversal:');
  var inorder = tree.inorderTraversal();
  print('Result: $inorder');
  
  print('\nPostorder traversal:');
  var postorder = tree.postorderTraversal();
  print('Result: $postorder');
  
  print('\nIterative preorder:');
  var iterativePreorder = tree.preorderIterative();
  print('Result: $iterativePreorder');
  
  print('\nTree properties:');
  print('Max depth: ${tree.maxDepth()}');
  print('Is balanced: ${tree.isBalanced()}');
  
  // Demo 6: Practical Examples
  print('\n6. Practical Examples:');
  DFSExamples.fileSystemExample();
  DFSExamples.dependencyResolutionExample();
  DFSExamples.socialNetworkExample();
  DFSExamples.puzzleSolvingExample();
  
  // Demo 7: Performance Analysis
  print('\n7. Performance Analysis:');
  DFSAnalysis.performanceComparison();
  
  print('\n=== DFS Concepts Summary ===');
  print('• DFS explores as far as possible along each branch');
  print('• Uses Stack data structure (or recursion)');
  print('• Time Complexity: O(V + E) where V = vertices, E = edges');
  print('• Space Complexity: O(V) for visited set and stack');
  print('• Can find paths but not necessarily shortest paths');
  print('• Excellent for: cycle detection, topological sort, backtracking');
  print('• Tree traversals: preorder, inorder, postorder');
  print('• Applications: maze solving, dependency resolution, file systems');
  print('• Recursive vs Iterative: same time complexity, different space usage');
}