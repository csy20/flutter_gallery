
import 'dart:collection';
import 'dart:math' as math;

// 1. Basic Tree Node
class TreeNode<T> {
  T data;
  List<TreeNode<T>> children;
  TreeNode<T>? parent;
  
  TreeNode(this.data, {this.parent}) : children = [];
  
  // Add a child node
  void addChild(TreeNode<T> child) {
    child.parent = this;
    children.add(child);
  }
  
  // Remove a child node
  bool removeChild(TreeNode<T> child) {
    if (children.remove(child)) {
      child.parent = null;
      return true;
    }
    return false;
  }
  
  // Check if this node is a leaf (has no children)
  bool get isLeaf => children.isEmpty;
  
  // Check if this node is the root (has no parent)
  bool get isRoot => parent == null;
  
  // Get the level/depth of this node
  int get level {
    int depth = 0;
    TreeNode<T>? current = parent;
    while (current != null) {
      depth++;
      current = current.parent;
    }
    return depth;
  }
  
  @override
  String toString() => data.toString();
}

// 2. General Tree Implementation
class Tree<T> {
  TreeNode<T>? root;
  
  Tree([this.root]);
  
  // Add root node
  void setRoot(T data) {
    root = TreeNode<T>(data);
  }
  
  // Find a node with specific data
  TreeNode<T>? find(T data, [TreeNode<T>? startNode]) {
    startNode ??= root;
    if (startNode == null) return null;
    
    if (startNode.data == data) return startNode;
    
    for (TreeNode<T> child in startNode.children) {
      TreeNode<T>? found = find(data, child);
      if (found != null) return found;
    }
    
    return null;
  }
  
  // Depth-First Search (DFS) traversal
  List<T> dfsTraversal([TreeNode<T>? startNode]) {
    startNode ??= root;
    if (startNode == null) return [];
    
    List<T> result = [];
    _dfsHelper(startNode, result);
    return result;
  }
  
  void _dfsHelper(TreeNode<T> node, List<T> result) {
    result.add(node.data);
    print('DFS visited: ${node.data}');
    
    for (TreeNode<T> child in node.children) {
      _dfsHelper(child, result);
    }
  }
  
  // Breadth-First Search (BFS) traversal
  List<T> bfsTraversal() {
    if (root == null) return [];
    
    List<T> result = [];
    Queue<TreeNode<T>> queue = Queue<TreeNode<T>>();
    
    queue.add(root!);
    
    while (queue.isNotEmpty) {
      TreeNode<T> current = queue.removeFirst();
      result.add(current.data);
      print('BFS visited: ${current.data}');
      
      for (TreeNode<T> child in current.children) {
        queue.add(child);
      }
    }
    
    return result;
  }
  
  // Level-order traversal with level information
  Map<int, List<T>> levelOrderTraversal() {
    if (root == null) return {};
    
    Map<int, List<T>> levels = {};
    Queue<MapEntry<TreeNode<T>, int>> queue = Queue<MapEntry<TreeNode<T>, int>>();
    
    queue.add(MapEntry(root!, 0));
    
    while (queue.isNotEmpty) {
      MapEntry<TreeNode<T>, int> current = queue.removeFirst();
      TreeNode<T> node = current.key;
      int level = current.value;
      
      if (!levels.containsKey(level)) {
        levels[level] = [];
      }
      levels[level]!.add(node.data);
      
      for (TreeNode<T> child in node.children) {
        queue.add(MapEntry(child, level + 1));
      }
    }
    
    return levels;
  }
  
  // Calculate tree height
  int height([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return -1;
    
    if (node.children.isEmpty) return 0;
    
    int maxChildHeight = 0;
    for (TreeNode<T> child in node.children) {
      maxChildHeight = math.max(maxChildHeight, height(child));
    }
    
    return maxChildHeight + 1;
  }
  
  // Count total number of nodes
  int size([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    int count = 1;
    for (TreeNode<T> child in node.children) {
      count += size(child);
    }
    
    return count;
  }
  
  // Count leaf nodes
  int countLeaves([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    if (node.children.isEmpty) return 1;
    
    int leafCount = 0;
    for (TreeNode<T> child in node.children) {
      leafCount += countLeaves(child);
    }
    
    return leafCount;
  }
  
  // Display tree structure
  void display([TreeNode<T>? node, String prefix = '', bool isLast = true]) {
    node ??= root;
    if (node == null) return;
    
    print('$prefix${isLast ? '└── ' : '├── '}${node.data}');
    
    for (int i = 0; i < node.children.length; i++) {
      bool isLastChild = i == node.children.length - 1;
      String newPrefix = prefix + (isLast ? '    ' : '│   ');
      display(node.children[i], newPrefix, isLastChild);
    }
  }
}

// 3. Binary Tree Node
class BinaryTreeNode<T> {
  T data;
  BinaryTreeNode<T>? left;
  BinaryTreeNode<T>? right;
  BinaryTreeNode<T>? parent;
  
  BinaryTreeNode(this.data, {this.left, this.right, this.parent});
  
  bool get isLeaf => left == null && right == null;
  bool get hasLeftChild => left != null;
  bool get hasRightChild => right != null;
  
  @override
  String toString() => data.toString();
}

// 4. Binary Tree Implementation
class BinaryTree<T> {
  BinaryTreeNode<T>? root;
  
  BinaryTree([this.root]);
  
  // Preorder traversal (Root, Left, Right)
  List<T> preorderTraversal([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return [];
    
    List<T> result = [];
    result.add(node.data);
    print('Preorder: ${node.data}');
    result.addAll(preorderTraversal(node.left));
    result.addAll(preorderTraversal(node.right));
    
    return result;
  }
  
  // Inorder traversal (Left, Root, Right)
  List<T> inorderTraversal([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return [];
    
    List<T> result = [];
    result.addAll(inorderTraversal(node.left));
    result.add(node.data);
    print('Inorder: ${node.data}');
    result.addAll(inorderTraversal(node.right));
    
    return result;
  }
  
  // Postorder traversal (Left, Right, Root)
  List<T> postorderTraversal([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return [];
    
    List<T> result = [];
    result.addAll(postorderTraversal(node.left));
    result.addAll(postorderTraversal(node.right));
    result.add(node.data);
    print('Postorder: ${node.data}');
    
    return result;
  }
  
  // Level order traversal
  List<T> levelOrderTraversal() {
    if (root == null) return [];
    
    List<T> result = [];
    Queue<BinaryTreeNode<T>> queue = Queue<BinaryTreeNode<T>>();
    
    queue.add(root!);
    
    while (queue.isNotEmpty) {
      BinaryTreeNode<T> current = queue.removeFirst();
      result.add(current.data);
      print('Level order: ${current.data}');
      
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    
    return result;
  }
  
  // Find a node
  BinaryTreeNode<T>? find(T data, [BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return null;
    
    if (node.data == data) return node;
    
    BinaryTreeNode<T>? leftResult = find(data, node.left);
    if (leftResult != null) return leftResult;
    
    return find(data, node.right);
  }
  
  // Calculate height
  int height([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return -1;
    
    return 1 + math.max(height(node.left), height(node.right));
  }
  
  // Check if tree is balanced
  bool isBalanced([BinaryTreeNode<T>? node]) {
    node ??= root;
    return _checkBalance(node) != -1;
  }
  
  int _checkBalance(BinaryTreeNode<T>? node) {
    if (node == null) return 0;
    
    int leftHeight = _checkBalance(node.left);
    if (leftHeight == -1) return -1;
    
    int rightHeight = _checkBalance(node.right);
    if (rightHeight == -1) return -1;
    
    if ((leftHeight - rightHeight).abs() > 1) return -1;
    
    return 1 + math.max(leftHeight, rightHeight);
  }
  
  // Count nodes
  int size([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    return 1 + size(node.left) + size(node.right);
  }
  
  // Display tree structure
  void display([BinaryTreeNode<T>? node, String prefix = '', bool isLeft = true]) {
    node ??= root;
    if (node == null) return;
    
    if (node.right != null) {
      display(node.right, prefix + (isLeft ? '│   ' : '    '), false);
    }
    
    print('$prefix${isLeft ? '└── ' : '┌── '}${node.data}');
    
    if (node.left != null) {
      display(node.left, prefix + (isLeft ? '    ' : '│   '), true);
    }
  }
}

// 5. Binary Search Tree (BST)
class BST<T extends Comparable<T>> {
  BinaryTreeNode<T>? root;
  
  BST([this.root]);
  
  // Insert a new value
  void insert(T data) {
    root = _insertHelper(root, data);
  }
  
  BinaryTreeNode<T> _insertHelper(BinaryTreeNode<T>? node, T data) {
    if (node == null) {
      print('Inserted: $data');
      return BinaryTreeNode<T>(data);
    }
    
    if (data.compareTo(node.data) < 0) {
      node.left = _insertHelper(node.left, data);
      node.left!.parent = node;
    } else if (data.compareTo(node.data) > 0) {
      node.right = _insertHelper(node.right, data);
      node.right!.parent = node;
    }
    
    return node;
  }
  
  // Search for a value
  bool search(T data) {
    return _searchHelper(root, data) != null;
  }
  
  BinaryTreeNode<T>? _searchHelper(BinaryTreeNode<T>? node, T data) {
    if (node == null || node.data == data) {
      return node;
    }
    
    if (data.compareTo(node.data) < 0) {
      return _searchHelper(node.left, data);
    }
    
    return _searchHelper(node.right, data);
  }
  
  // Delete a value
  void delete(T data) {
    root = _deleteHelper(root, data);
  }
  
  BinaryTreeNode<T>? _deleteHelper(BinaryTreeNode<T>? node, T data) {
    if (node == null) return null;
    
    if (data.compareTo(node.data) < 0) {
      node.left = _deleteHelper(node.left, data);
    } else if (data.compareTo(node.data) > 0) {
      node.right = _deleteHelper(node.right, data);
    } else {
      print('Deleted: $data');
      
      // Node to delete found
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;
      
      // Node has two children
      BinaryTreeNode<T> successor = _findMin(node.right!);
      node.data = successor.data;
      node.right = _deleteHelper(node.right, successor.data);
    }
    
    return node;
  }
  
  BinaryTreeNode<T> _findMin(BinaryTreeNode<T> node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }
  
  // Find minimum value
  T? findMin() {
    if (root == null) return null;
    BinaryTreeNode<T> min = _findMin(root!);
    return min.data;
  }
  
  // Find maximum value
  T? findMax() {
    if (root == null) return null;
    BinaryTreeNode<T> current = root!;
    while (current.right != null) {
      current = current.right!;
    }
    return current.data;
  }
  
  // Inorder traversal (gives sorted order)
  List<T> inorderTraversal([BinaryTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return [];
    
    List<T> result = [];
    result.addAll(inorderTraversal(node.left));
    result.add(node.data);
    result.addAll(inorderTraversal(node.right));
    
    return result;
  }
  
  // Validate BST property
  bool isValidBST([BinaryTreeNode<T>? node, T? min, T? max]) {
    node ??= root;
    if (node == null) return true;
    
    if ((min != null && node.data.compareTo(min) <= 0) ||
        (max != null && node.data.compareTo(max) >= 0)) {
      return false;
    }
    
    return isValidBST(node.left, min, node.data) &&
           isValidBST(node.right, node.data, max);
  }
  
  // Display BST
  void display([BinaryTreeNode<T>? node, String prefix = '', bool isLeft = true]) {
    node ??= root;
    if (node == null) return;
    
    if (node.right != null) {
      display(node.right, prefix + (isLeft ? '│   ' : '    '), false);
    }
    
    print('$prefix${isLeft ? '└── ' : '┌── '}${node.data}');
    
    if (node.left != null) {
      display(node.left, prefix + (isLeft ? '    ' : '│   '), true);
    }
  }
}

// 6. AVL Tree (Self-balancing BST)
class AVLTreeNode<T extends Comparable<T>> {
  T data;
  AVLTreeNode<T>? left;
  AVLTreeNode<T>? right;
  int height;
  
  AVLTreeNode(this.data, {this.left, this.right, this.height = 0});
  
  @override
  String toString() => data.toString();
}

class AVLTree<T extends Comparable<T>> {
  AVLTreeNode<T>? root;
  
  // Get height of node
  int _getHeight(AVLTreeNode<T>? node) {
    return node?.height ?? -1;
  }
  
  // Update height of node
  void _updateHeight(AVLTreeNode<T> node) {
    node.height = 1 + math.max(_getHeight(node.left), _getHeight(node.right));
  }
  
  // Get balance factor
  int _getBalance(AVLTreeNode<T>? node) {
    return node == null ? 0 : _getHeight(node.left) - _getHeight(node.right);
  }
  
  // Right rotation
  AVLTreeNode<T> _rotateRight(AVLTreeNode<T> y) {
    AVLTreeNode<T> x = y.left!;
    y.left = x.right;
    x.right = y;
    
    _updateHeight(y);
    _updateHeight(x);
    
    return x;
  }
  
  // Left rotation
  AVLTreeNode<T> _rotateLeft(AVLTreeNode<T> x) {
    AVLTreeNode<T> y = x.right!;
    x.right = y.left;
    y.left = x;
    
    _updateHeight(x);
    _updateHeight(y);
    
    return y;
  }
  
  // Insert with balancing
  void insert(T data) {
    root = _insertHelper(root, data);
  }
  
  AVLTreeNode<T> _insertHelper(AVLTreeNode<T>? node, T data) {
    // Normal BST insertion
    if (node == null) {
      print('AVL Inserted: $data');
      return AVLTreeNode<T>(data);
    }
    
    if (data.compareTo(node.data) < 0) {
      node.left = _insertHelper(node.left, data);
    } else if (data.compareTo(node.data) > 0) {
      node.right = _insertHelper(node.right, data);
    } else {
      return node; // Duplicate values not allowed
    }
    
    // Update height
    _updateHeight(node);
    
    // Get balance factor
    int balance = _getBalance(node);
    
    // Left Left Case
    if (balance > 1 && data.compareTo(node.left!.data) < 0) {
      print('Performing right rotation at ${node.data}');
      return _rotateRight(node);
    }
    
    // Right Right Case
    if (balance < -1 && data.compareTo(node.right!.data) > 0) {
      print('Performing left rotation at ${node.data}');
      return _rotateLeft(node);
    }
    
    // Left Right Case
    if (balance > 1 && data.compareTo(node.left!.data) > 0) {
      print('Performing left-right rotation at ${node.data}');
      node.left = _rotateLeft(node.left!);
      return _rotateRight(node);
    }
    
    // Right Left Case
    if (balance < -1 && data.compareTo(node.right!.data) < 0) {
      print('Performing right-left rotation at ${node.data}');
      node.right = _rotateRight(node.right!);
      return _rotateLeft(node);
    }
    
    return node;
  }
  
  // Inorder traversal
  List<T> inorderTraversal([AVLTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return [];
    
    List<T> result = [];
    result.addAll(inorderTraversal(node.left));
    result.add(node.data);
    result.addAll(inorderTraversal(node.right));
    
    return result;
  }
  
  // Check if tree is balanced
  bool isBalanced([AVLTreeNode<T>? node]) {
    node ??= root;
    if (node == null) return true;
    
    int balance = _getBalance(node);
    return balance.abs() <= 1 && 
           isBalanced(node.left) && 
           isBalanced(node.right);
  }
  
  // Display AVL tree
  void display([AVLTreeNode<T>? node, String prefix = '', bool isLeft = true]) {
    node ??= root;
    if (node == null) return;
    
    if (node.right != null) {
      display(node.right, prefix + (isLeft ? '│   ' : '    '), false);
    }
    
    int balance = _getBalance(node);
    print('$prefix${isLeft ? '└── ' : '┌── '}${node.data}(h:${node.height}, b:$balance)');
    
    if (node.left != null) {
      display(node.left, prefix + (isLeft ? '    ' : '│   '), true);
    }
  }
}

// 7. Tree Examples and Applications
class TreeExamples {
  
  // File System representation
  static void fileSystemExample() {
    print('\n=== File System Example ===');
    Tree<String> fileSystem = Tree<String>();
    
    // Create file system structure
    fileSystem.setRoot('root');
    TreeNode<String> rootNode = fileSystem.root!;
    
    TreeNode<String> home = TreeNode<String>('home');
    TreeNode<String> usr = TreeNode<String>('usr');
    TreeNode<String> var = TreeNode<String>('var');
    
    rootNode.addChild(home);
    rootNode.addChild(usr);
    rootNode.addChild(var);
    
    // Add subdirectories
    TreeNode<String> user1 = TreeNode<String>('user1');
    TreeNode<String> user2 = TreeNode<String>('user2');
    home.addChild(user1);
    home.addChild(user2);
    
    TreeNode<String> documents = TreeNode<String>('Documents');
    TreeNode<String> downloads = TreeNode<String>('Downloads');
    user1.addChild(documents);
    user1.addChild(downloads);
    
    print('File System Structure:');
    fileSystem.display();
    
    print('\nBFS Traversal (Level by level):');
    fileSystem.bfsTraversal();
    
    print('\nLevel Order with Levels:');
    var levels = fileSystem.levelOrderTraversal();
    levels.forEach((level, nodes) {
      print('Level $level: ${nodes.join(', ')}');
    });
  }
  
  // Organization Chart
  static void organizationChartExample() {
    print('\n=== Organization Chart Example ===');
    Tree<String> orgChart = Tree<String>();
    
    orgChart.setRoot('CEO');
    TreeNode<String> ceo = orgChart.root!;
    
    TreeNode<String> cto = TreeNode<String>('CTO');
    TreeNode<String> cfo = TreeNode<String>('CFO');
    TreeNode<String> coo = TreeNode<String>('COO');
    
    ceo.addChild(cto);
    ceo.addChild(cfo);
    ceo.addChild(coo);
    
    // CTO's team
    TreeNode<String> devManager = TreeNode<String>('Dev Manager');
    TreeNode<String> qaManager = TreeNode<String>('QA Manager');
    cto.addChild(devManager);
    cto.addChild(qaManager);
    
    TreeNode<String> dev1 = TreeNode<String>('Developer 1');
    TreeNode<String> dev2 = TreeNode<String>('Developer 2');
    devManager.addChild(dev1);
    devManager.addChild(dev2);
    
    print('Organization Chart:');
    orgChart.display();
    
    print('\nTree Statistics:');
    print('Total employees: ${orgChart.size()}');
    print('Management levels: ${orgChart.height() + 1}');
    print('Direct reports to CEO: ${ceo.children.length}');
  }
  
  // Expression Tree
  static void expressionTreeExample() {
    print('\n=== Expression Tree Example ===');
    // Expression: (3 + 5) * (2 - 1)
    
    BinaryTree<String> expressionTree = BinaryTree<String>();
    
    // Build expression tree
    BinaryTreeNode<String> multiply = BinaryTreeNode<String>('*');
    
    BinaryTreeNode<String> add = BinaryTreeNode<String>('+');
    BinaryTreeNode<String> subtract = BinaryTreeNode<String>('-');
    
    BinaryTreeNode<String> three = BinaryTreeNode<String>('3');
    BinaryTreeNode<String> five = BinaryTreeNode<String>('5');
    BinaryTreeNode<String> two = BinaryTreeNode<String>('2');
    BinaryTreeNode<String> one = BinaryTreeNode<String>('1');
    
    multiply.left = add;
    multiply.right = subtract;
    
    add.left = three;
    add.right = five;
    
    subtract.left = two;
    subtract.right = one;
    
    expressionTree.root = multiply;
    
    print('Expression Tree: (3 + 5) * (2 - 1)');
    expressionTree.display();
    
    print('\nTraversals:');
    print('Infix (Inorder): ${expressionTree.inorderTraversal().join(' ')}');
    print('Prefix (Preorder): ${expressionTree.preorderTraversal().join(' ')}');
    print('Postfix (Postorder): ${expressionTree.postorderTraversal().join(' ')}');
  }
  
  // Decision Tree
  static void decisionTreeExample() {
    print('\n=== Decision Tree Example ===');
    Tree<String> decisionTree = Tree<String>();
    
    decisionTree.setRoot('Is it raining?');
    TreeNode<String> root = decisionTree.root!;
    
    TreeNode<String> yes = TreeNode<String>('Yes');
    TreeNode<String> no = TreeNode<String>('No');
    
    root.addChild(yes);
    root.addChild(no);
    
    // If yes (raining)
    TreeNode<String> umbrella = TreeNode<String>('Do you have umbrella?');
    yes.addChild(umbrella);
    
    TreeNode<String> hasUmbrella = TreeNode<String>('Yes - Go outside');
    TreeNode<String> noUmbrella = TreeNode<String>('No - Stay inside');
    umbrella.addChild(hasUmbrella);
    umbrella.addChild(noUmbrella);
    
    // If no (not raining)
    TreeNode<String> goOut = TreeNode<String>('Go outside and enjoy!');
    no.addChild(goOut);
    
    print('Decision Tree: Should I go outside?');
    decisionTree.display();
    
    print('\nDFS Traversal (All possible decisions):');
    decisionTree.dfsTraversal();
  }
}

void main() {
  print('=== Tree Data Structure Implementation in Dart ===\n');
  
  // Demo 1: General Tree
  print('1. General Tree Demo:');
  Tree<String> generalTree = Tree<String>();
  generalTree.setRoot('A');
  
  TreeNode<String> rootNode = generalTree.root!;
  TreeNode<String> b = TreeNode<String>('B');
  TreeNode<String> c = TreeNode<String>('C');
  TreeNode<String> d = TreeNode<String>('D');
  
  rootNode.addChild(b);
  rootNode.addChild(c);
  rootNode.addChild(d);
  
  TreeNode<String> e = TreeNode<String>('E');
  TreeNode<String> f = TreeNode<String>('F');
  b.addChild(e);
  b.addChild(f);
  
  TreeNode<String> g = TreeNode<String>('G');
  c.addChild(g);
  
  print('Tree Structure:');
  generalTree.display();
  
  print('\nTree Statistics:');
  print('Height: ${generalTree.height()}');
  print('Size: ${generalTree.size()}');
  print('Leaves: ${generalTree.countLeaves()}');
  
  print('\nDFS Traversal:');
  generalTree.dfsTraversal();
  
  print('\nBFS Traversal:');
  generalTree.bfsTraversal();
  
  // Demo 2: Binary Tree
  print('\n2. Binary Tree Demo:');
  BinaryTree<int> binaryTree = BinaryTree<int>();
  
  binaryTree.root = BinaryTreeNode<int>(1);
  binaryTree.root!.left = BinaryTreeNode<int>(2);
  binaryTree.root!.right = BinaryTreeNode<int>(3);
  binaryTree.root!.left!.left = BinaryTreeNode<int>(4);
  binaryTree.root!.left!.right = BinaryTreeNode<int>(5);
  binaryTree.root!.right!.left = BinaryTreeNode<int>(6);
  binaryTree.root!.right!.right = BinaryTreeNode<int>(7);
  
  print('Binary Tree Structure:');
  binaryTree.display();
  
  print('\nTraversals:');
  print('Preorder: ${binaryTree.preorderTraversal()}');
  print('Inorder: ${binaryTree.inorderTraversal()}');
  print('Postorder: ${binaryTree.postorderTraversal()}');
  print('Level order: ${binaryTree.levelOrderTraversal()}');
  
  print('Height: ${binaryTree.height()}');
  print('Size: ${binaryTree.size()}');
  print('Is balanced: ${binaryTree.isBalanced()}');
  
  // Demo 3: Binary Search Tree
  print('\n3. Binary Search Tree Demo:');
  BST<int> bst = BST<int>();
  
  List<int> values = [50, 30, 70, 20, 40, 60, 80, 10, 25, 35, 65];
  print('Inserting values: $values');
  
  for (int value in values) {
    bst.insert(value);
  }
  
  print('\nBST Structure:');
  bst.display();
  
  print('\nInorder traversal (sorted): ${bst.inorderTraversal()}');
  print('Minimum value: ${bst.findMin()}');
  print('Maximum value: ${bst.findMax()}');
  print('Is valid BST: ${bst.isValidBST()}');
  
  print('\nSearching for values:');
  print('Search 40: ${bst.search(40)}');
  print('Search 90: ${bst.search(90)}');
  
  print('\nDeleting 30...');
  bst.delete(30);
  print('Inorder after deletion: ${bst.inorderTraversal()}');
  
  // Demo 4: AVL Tree
  print('\n4. AVL Tree Demo:');
  AVLTree<int> avl = AVLTree<int>();
  
  List<int> avlValues = [10, 20, 30, 40, 50, 25];
  print('Inserting values into AVL tree: $avlValues');
  
  for (int value in avlValues) {
    avl.insert(value);
  }
  
  print('\nAVL Tree Structure (with heights and balance factors):');
  avl.display();
  
  print('\nInorder traversal: ${avl.inorderTraversal()}');
  print('Is balanced: ${avl.isBalanced()}');
  
  // Demo 5: Practical Examples
  print('\n5. Practical Examples:');
  TreeExamples.fileSystemExample();
  TreeExamples.organizationChartExample();
  TreeExamples.expressionTreeExample();
  TreeExamples.decisionTreeExample();
  
  print('\n=== Tree Concepts Summary ===');
  print('• Tree: Hierarchical data structure with nodes and edges');
  print('• Root: Top node with no parent');
  print('• Leaf: Node with no children');
  print('• Height: Longest path from root to leaf');
  print('• Binary Tree: Each node has at most 2 children');
  print('• BST: Binary tree with ordering property');
  print('• AVL Tree: Self-balancing BST');
  print('• Traversals: DFS (Pre/In/Post-order), BFS (Level-order)');
  print('• Applications: File systems, databases, expression parsing, decision making');
}