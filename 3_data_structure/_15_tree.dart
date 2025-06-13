// Tree Data Structure Implementation in Dart
// A tree is a hierarchical data structure with nodes connected by edges
// Key characteristics:
// 1. One root node (top-level node)
// 2. Each node can have zero or more child nodes
// 3. No cycles (acyclic graph)
// 4. Connected structure

// Binary Tree Node
class TreeNode<T> {
  T data;
  TreeNode<T>? left;
  TreeNode<T>? right;
  
  TreeNode(this.data, {this.left, this.right});
  
  @override
  String toString() => 'Node($data)';
}

// General Tree Node (can have multiple children)
class GeneralTreeNode<T> {
  T data;
  List<GeneralTreeNode<T>> children;
  
  GeneralTreeNode(this.data) : children = [];
  
  void addChild(GeneralTreeNode<T> child) {
    children.add(child);
  }
  
  @override
  String toString() => 'Node($data)';
}

// Binary Search Tree Implementation
class BinarySearchTree<T extends Comparable<T>> {
  TreeNode<T>? root;
  
  // Insert a value into the BST
  void insert(T value) {
    root = _insertRecursive(root, value);
  }
  
  TreeNode<T> _insertRecursive(TreeNode<T>? node, T value) {
    if (node == null) {
      return TreeNode<T>(value);
    }
    
    if (value.compareTo(node.data) < 0) {
      node.left = _insertRecursive(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _insertRecursive(node.right, value);
    }
    
    return node;
  }
  
  // Search for a value in the BST
  bool search(T value) {
    return _searchRecursive(root, value);
  }
  
  bool _searchRecursive(TreeNode<T>? node, T value) {
    if (node == null) return false;
    
    if (value == node.data) return true;
    
    if (value.compareTo(node.data) < 0) {
      return _searchRecursive(node.left, value);
    } else {
      return _searchRecursive(node.right, value);
    }
  }
  
  // Delete a value from the BST
  void delete(T value) {
    root = _deleteRecursive(root, value);
  }
  
  TreeNode<T>? _deleteRecursive(TreeNode<T>? node, T value) {
    if (node == null) return null;
    
    if (value.compareTo(node.data) < 0) {
      node.left = _deleteRecursive(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _deleteRecursive(node.right, value);
    } else {
      // Node to be deleted found
      if (node.left == null) {
        return node.right;
      } else if (node.right == null) {
        return node.left;
      }
      
      // Node with two children
      T minValue = _findMin(node.right!);
      node.data = minValue;
      node.right = _deleteRecursive(node.right, minValue);
    }
    
    return node;
  }
  
  T _findMin(TreeNode<T> node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node.data;
  }
  
  // Tree Traversal Methods
  
  // In-order traversal (Left, Root, Right) - for BST gives sorted order
  void inOrderTraversal([TreeNode<T>? node]) {
    node ??= root;
    if (node != null) {
      inOrderTraversal(node.left);
      print(node.data);
      inOrderTraversal(node.right);
    }
  }
  
  // Pre-order traversal (Root, Left, Right)
  void preOrderTraversal([TreeNode<T>? node]) {
    node ??= root;
    if (node != null) {
      print(node.data);
      preOrderTraversal(node.left);
      preOrderTraversal(node.right);
    }
  }
  
  // Post-order traversal (Left, Right, Root)
  void postOrderTraversal([TreeNode<T>? node]) {
    node ??= root;
    if (node != null) {
      postOrderTraversal(node.left);
      postOrderTraversal(node.right);
      print(node.data);
    }
  }
  
  // Level-order traversal (Breadth-First Search)
  void levelOrderTraversal() {
    if (root == null) return;
    
    List<TreeNode<T>> queue = [root!];
    
    while (queue.isNotEmpty) {
      TreeNode<T> current = queue.removeAt(0);
      print(current.data);
      
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
  }
  
  // Calculate height of the tree
  int height([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return -1;
    
    int leftHeight = height(node.left);
    int rightHeight = height(node.right);
    
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }
  
  // Count total number of nodes
  int countNodes([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    return 1 + countNodes(node.left) + countNodes(node.right);
  }
  
  // Check if tree is balanced
  bool isBalanced([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return true;
    
    int leftHeight = height(node.left);
    int rightHeight = height(node.right);
    
    return (leftHeight - rightHeight).abs() <= 1 &&
           isBalanced(node.left) &&
           isBalanced(node.right);
  }
}

// General Tree Implementation
class GeneralTree<T> {
  GeneralTreeNode<T>? root;
  
  GeneralTree([T? rootData]) {
    if (rootData != null) {
      root = GeneralTreeNode<T>(rootData);
    }
  }
  
  // Depth-First Search traversal
  void dfsTraversal([GeneralTreeNode<T>? node]) {
    node ??= root;
    if (node != null) {
      print(node.data);
      for (var child in node.children) {
        dfsTraversal(child);
      }
    }
  }
  
  // Breadth-First Search traversal
  void bfsTraversal() {
    if (root == null) return;
    
    List<GeneralTreeNode<T>> queue = [root!];
    
    while (queue.isNotEmpty) {
      GeneralTreeNode<T> current = queue.removeAt(0);
      print(current.data);
      
      queue.addAll(current.children);
    }
  }
  
  // Calculate height of general tree
  int height([GeneralTreeNode<T>? node]) {
    node ??= root;
    if (node == null || node.children.isEmpty) return 0;
    
    int maxChildHeight = 0;
    for (var child in node.children) {
      int childHeight = height(child);
      if (childHeight > maxChildHeight) {
        maxChildHeight = childHeight;
      }
    }
    
    return 1 + maxChildHeight;
  }
}

// Demonstration and Examples
void main() {
  print('=== Tree Data Structure in Dart ===\n');
  
  // Binary Search Tree Example
  print('1. Binary Search Tree Example:');
  var bst = BinarySearchTree<int>();
  
  // Insert values
  [50, 30, 70, 20, 40, 60, 80].forEach(bst.insert);
  
  print('Tree structure (In-order traversal - sorted):');
  bst.inOrderTraversal();
  
  print('\nSearching for 40: ${bst.search(40)}');
  print('Searching for 25: ${bst.search(25)}');
  
  print('\nTree height: ${bst.height()}');
  print('Total nodes: ${bst.countNodes()}');
  print('Is balanced: ${bst.isBalanced()}');
  
  print('\nPre-order traversal:');
  bst.preOrderTraversal();
  
  print('\nLevel-order traversal:');
  bst.levelOrderTraversal();
  
  // Delete a node
  print('\nDeleting 30...');
  bst.delete(30);
  print('In-order after deletion:');
  bst.inOrderTraversal();
  
  print('\n' + '='*50);
  
  // General Tree Example
  print('\n2. General Tree Example:');
  var generalTree = GeneralTree<String>('A');
  
  // Build tree structure
  var nodeB = GeneralTreeNode<String>('B');
  var nodeC = GeneralTreeNode<String>('C');
  var nodeD = GeneralTreeNode<String>('D');
  var nodeE = GeneralTreeNode<String>('E');
  var nodeF = GeneralTreeNode<String>('F');
  var nodeG = GeneralTreeNode<String>('G');
  
  generalTree.root!.addChild(nodeB);
  generalTree.root!.addChild(nodeC);
  generalTree.root!.addChild(nodeD);
  
  nodeB.addChild(nodeE);
  nodeB.addChild(nodeF);
  nodeC.addChild(nodeG);
  
  print('DFS Traversal:');
  generalTree.dfsTraversal();
  
  print('\nBFS Traversal:');
  generalTree.bfsTraversal();
  
  print('\nGeneral tree height: ${generalTree.height()}');
  
  print('\n' + '='*50);
  
  // Tree Concepts Summary
  print('\n3. Tree Concepts Summary:');
  print('''
  Tree Terminology:
  - Root: Top node with no parent
  - Leaf: Node with no children
  - Internal Node: Node with at least one child
  - Parent: Node that has children
  - Child: Node that has a parent
  - Sibling: Nodes with the same parent
  - Depth: Level of a node (root is level 0)
  - Height: Maximum depth in the tree
  
  Tree Types:
  - Binary Tree: Each node has at most 2 children
  - Binary Search Tree: Binary tree with ordering property
  - Balanced Tree: Height difference between subtrees ≤ 1
  - Complete Tree: All levels filled except possibly the last
  - General Tree: Nodes can have any number of children
  
  Common Operations:
  - Insert: Add a new node
  - Delete: Remove a node
  - Search: Find a specific value
  - Traversal: Visit all nodes in specific order
  
  Time Complexities (BST average case):
  - Search: O(log n)
  - Insert: O(log n)
  - Delete: O(log n)
  - Traversal: O(n)
  ''');
}
