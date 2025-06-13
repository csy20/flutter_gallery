// AVL Tree Implementation in Dart
// AVL Tree is a self-balancing Binary Search Tree
// Named after Adelson-Velsky and Landis (1962)

// Key Properties:
// 1. It's a Binary Search Tree (left < root < right)
// 2. Height difference between left and right subtrees ≤ 1 (balance factor)
// 3. Automatically maintains balance through rotations
// 4. Guarantees O(log n) time complexity for all operations

// AVL Tree Node
class AVLNode<T extends Comparable<T>> {
  T data;
  AVLNode<T>? left;
  AVLNode<T>? right;
  int height;
  
  AVLNode(this.data) : height = 1;
  
  @override
  String toString() => 'Node($data, h:$height)';
}

// AVL Tree Implementation
class AVLTree<T extends Comparable<T>> {
  AVLNode<T>? root;
  
  // Get height of a node (0 for null nodes)
  int getHeight(AVLNode<T>? node) {
    return node?.height ?? 0;
  }
  
  // Calculate balance factor (height difference between left and right subtrees)
  int getBalance(AVLNode<T>? node) {
    if (node == null) return 0;
    return getHeight(node.left) - getHeight(node.right);
  }
  
  // Update height of a node based on its children
  void updateHeight(AVLNode<T> node) {
    node.height = 1 + 
        (getHeight(node.left) > getHeight(node.right) 
         ? getHeight(node.left) 
         : getHeight(node.right));
  }
  
  // Right rotation (used when left subtree is heavier)
  //       y                    x
  //      / \                  / \
  //     x   T3               T1   y
  //    / \         -->           / \
  //   T1  T2                    T2  T3
  AVLNode<T> rotateRight(AVLNode<T> y) {
    AVLNode<T> x = y.left!;
    AVLNode<T>? T2 = x.right;
    
    // Perform rotation
    x.right = y;
    y.left = T2;
    
    // Update heights
    updateHeight(y);
    updateHeight(x);
    
    return x; // New root
  }
  
  // Left rotation (used when right subtree is heavier)
  //     x                      y
  //    / \                    / \
  //   T1   y                 x   T3
  //       / \       -->     / \
  //      T2  T3            T1  T2
  AVLNode<T> rotateLeft(AVLNode<T> x) {
    AVLNode<T> y = x.right!;
    AVLNode<T>? T2 = y.left;
    
    // Perform rotation
    y.left = x;
    x.right = T2;
    
    // Update heights
    updateHeight(x);
    updateHeight(y);
    
    return y; // New root
  }
  
  // Insert a value into the AVL tree
  void insert(T value) {
    root = _insertRecursive(root, value);
  }
  
  AVLNode<T> _insertRecursive(AVLNode<T>? node, T value) {
    // Step 1: Perform normal BST insertion
    if (node == null) {
      return AVLNode<T>(value);
    }
    
    if (value.compareTo(node.data) < 0) {
      node.left = _insertRecursive(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _insertRecursive(node.right, value);
    } else {
      // Duplicate values not allowed
      return node;
    }
    
    // Step 2: Update height of current node
    updateHeight(node);
    
    // Step 3: Get balance factor
    int balance = getBalance(node);
    
    // Step 4: If unbalanced, perform rotations
    
    // Left Heavy (Left-Left case)
    if (balance > 1 && value.compareTo(node.left!.data) < 0) {
      return rotateRight(node);
    }
    
    // Right Heavy (Right-Right case)
    if (balance < -1 && value.compareTo(node.right!.data) > 0) {
      return rotateLeft(node);
    }
    
    // Left-Right case
    if (balance > 1 && value.compareTo(node.left!.data) > 0) {
      node.left = rotateLeft(node.left!);
      return rotateRight(node);
    }
    
    // Right-Left case
    if (balance < -1 && value.compareTo(node.right!.data) < 0) {
      node.right = rotateRight(node.right!);
      return rotateLeft(node);
    }
    
    // Return unchanged node if balanced
    return node;
  }
  
  // Delete a value from the AVL tree
  void delete(T value) {
    root = _deleteRecursive(root, value);
  }
  
  AVLNode<T>? _deleteRecursive(AVLNode<T>? node, T value) {
    // Step 1: Perform standard BST deletion
    if (node == null) return null;
    
    if (value.compareTo(node.data) < 0) {
      node.left = _deleteRecursive(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _deleteRecursive(node.right, value);
    } else {
      // Node to be deleted found
      if (node.left == null || node.right == null) {
        AVLNode<T>? temp = node.left ?? node.right;
        
        if (temp == null) {
          // No child case
          temp = node;
          node = null;
        } else {
          // One child case
          node = temp;
        }
      } else {
        // Two children case
        AVLNode<T> temp = _findMin(node.right!);
        node.data = temp.data;
        node.right = _deleteRecursive(node.right, temp.data);
      }
    }
    
    if (node == null) return node;
    
    // Step 2: Update height
    updateHeight(node);
    
    // Step 3: Get balance factor
    int balance = getBalance(node);
    
    // Step 4: Perform rotations if unbalanced
    
    // Left Heavy
    if (balance > 1 && getBalance(node.left) >= 0) {
      return rotateRight(node);
    }
    
    // Left-Right case
    if (balance > 1 && getBalance(node.left) < 0) {
      node.left = rotateLeft(node.left!);
      return rotateRight(node);
    }
    
    // Right Heavy
    if (balance < -1 && getBalance(node.right) <= 0) {
      return rotateLeft(node);
    }
    
    // Right-Left case
    if (balance < -1 && getBalance(node.right) > 0) {
      node.right = rotateRight(node.right!);
      return rotateLeft(node);
    }
    
    return node;
  }
  
  AVLNode<T> _findMin(AVLNode<T> node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }
  
  // Search for a value
  bool search(T value) {
    return _searchRecursive(root, value);
  }
  
  bool _searchRecursive(AVLNode<T>? node, T value) {
    if (node == null) return false;
    
    if (value == node.data) return true;
    
    if (value.compareTo(node.data) < 0) {
      return _searchRecursive(node.left, value);
    } else {
      return _searchRecursive(node.right, value);
    }
  }
  
  // In-order traversal (gives sorted order)
  void inOrderTraversal([AVLNode<T>? node, List<T>? result]) {
    result ??= [];
    node ??= root;
    
    if (node != null) {
      inOrderTraversal(node.left, result);
      result.add(node.data);
      inOrderTraversal(node.right, result);
    }
    
    if (node == root && result.isNotEmpty) {
      print('In-order: ${result.join(', ')}');
    }
  }
  
  // Pre-order traversal
  void preOrderTraversal([AVLNode<T>? node, List<T>? result]) {
    result ??= [];
    node ??= root;
    
    if (node != null) {
      result.add(node.data);
      preOrderTraversal(node.left, result);
      preOrderTraversal(node.right, result);
    }
    
    if (node == root && result.isNotEmpty) {
      print('Pre-order: ${result.join(', ')}');
    }
  }
  
  // Level-order traversal (shows tree structure better)
  void levelOrderTraversal() {
    if (root == null) return;
    
    List<AVLNode<T>> queue = [root!];
    List<T> result = [];
    
    while (queue.isNotEmpty) {
      AVLNode<T> current = queue.removeAt(0);
      result.add(current.data);
      
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    
    print('Level-order: ${result.join(', ')}');
  }
  
  // Display tree structure with balance factors
  void displayTree([AVLNode<T>? node, String prefix = '', bool isLast = true]) {
    node ??= root;
    if (node != null) {
      print('$prefix${isLast ? '└── ' : '├── '}${node.data} (h:${node.height}, bf:${getBalance(node)})');
      
      List<AVLNode<T>?> children = [node.left, node.right].where((child) => child != null).toList();
      
      for (int i = 0; i < children.length; i++) {
        bool isLastChild = i == children.length - 1;
        displayTree(children[i], '$prefix${isLast ? '    ' : '│   '}', isLastChild);
      }
    }
  }
  
  // Check if tree is balanced (for verification)
  bool isBalanced([AVLNode<T>? node]) {
    node ??= root;
    if (node == null) return true;
    
    int balance = getBalance(node);
    return balance.abs() <= 1 && 
           isBalanced(node.left) && 
           isBalanced(node.right);
  }
  
  // Get tree height
  int getTreeHeight() {
    return getHeight(root);
  }
  
  // Count total nodes
  int countNodes([AVLNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    return 1 + countNodes(node.left) + countNodes(node.right);
  }
}

// Demonstration and Examples
void main() {
  print('=== AVL Tree (Self-Balancing BST) in Dart ===\n');
  
  // Create AVL tree
  var avlTree = AVLTree<int>();
  
  print('1. AVL Tree Concepts:');
  print('''
  AVL Tree Properties:
  • Self-balancing Binary Search Tree
  • Balance Factor = height(left) - height(right)
  • Balance factor must be -1, 0, or 1 for all nodes
  • Automatically rebalances using rotations
  • Guarantees O(log n) operations
  
  Rotation Types:
  • Right Rotation (RR): For Left-Left heavy cases
  • Left Rotation (LL): For Right-Right heavy cases
  • Left-Right (LR): Left rotation then Right rotation
  • Right-Left (RL): Right rotation then Left rotation
  ''');
  
  print('\n2. Building AVL Tree:');
  print('Inserting values: 10, 20, 30, 40, 50, 25');
  
  // Insert values that would make a regular BST unbalanced
  List<int> values = [10, 20, 30, 40, 50, 25];
  
  for (int value in values) {
    print('\nInserting $value...');
    avlTree.insert(value);
    print('Tree structure after inserting $value:');
    avlTree.displayTree();
    print('Is balanced: ${avlTree.isBalanced()}');
    print('Tree height: ${avlTree.getTreeHeight()}');
  }
  
  print('\n' + '='*50);
  
  print('\n3. Tree Traversals:');
  avlTree.inOrderTraversal();
  avlTree.preOrderTraversal();
  avlTree.levelOrderTraversal();
  
  print('\n4. Search Operations:');
  List<int> searchValues = [25, 35, 50];
  for (int value in searchValues) {
    bool found = avlTree.search(value);
    print('Searching for $value: ${found ? 'Found' : 'Not found'}');
  }
  
  print('\n5. Final Tree Statistics:');
  print('Total nodes: ${avlTree.countNodes()}');
  print('Tree height: ${avlTree.getTreeHeight()}');
  print('Is balanced: ${avlTree.isBalanced()}');
  
  print('\n6. Deletion Example:');
  print('Deleting 30...');
  avlTree.delete(30);
  print('Tree after deletion:');
  avlTree.displayTree();
  print('Still balanced: ${avlTree.isBalanced()}');
  
  print('\n' + '='*50);
  
  print('\n7. AVL vs Regular BST Comparison:');
  print('''
  Regular BST (worst case - linear):
  Time Complexity: O(n) for search, insert, delete
  Space Complexity: O(n)
  Can become unbalanced
  
  AVL Tree (guaranteed balanced):
  Time Complexity: O(log n) for all operations
  Space Complexity: O(n)
  Extra space for height information
  Automatic rebalancing
  More rotations during insertion/deletion
  
  When to use AVL Trees:
  • Frequent search operations
  • Need guaranteed O(log n) performance
  • Data is inserted in sorted order
  • Balanced tree structure is critical
  
  AVL Tree Applications:
  • Database indexing
  • Memory management in operating systems
  • Expression parsing
  • Auto-complete features
  • Priority queues with dynamic priorities
  ''');
  
  print('\n8. Rotation Examples:');
  print('''
  Left-Left Case (Right Rotation):
      C              B
     /              / \\
    B      -->     A   C
   /
  A
  
  Right-Right Case (Left Rotation):
  A                  B
   \\                / \\
    B      -->     A   C
     \\
      C
  
  Left-Right Case (Left then Right Rotation):
    C                C              B
   /                /              / \\
  A        -->     B      -->     A   C
   \\              /
    B            A
  
  Right-Left Case (Right then Left Rotation):
  A              A                B
   \\              \\              / \\
    C      -->     B      -->   A   C
   /                \\
  B                  C
  ''');
}
