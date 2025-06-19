# Tree Data Structures - Complete Guide

A **Tree** is a hierarchical data structure consisting of nodes connected by edges. It's a non-linear data structure that resembles an inverted tree with a root at the top and leaves at the bottom. Trees are fundamental in computer science and have numerous applications.

## Table of Contents
1. [Basic Tree Concepts](#basic-tree-concepts)
2. [Binary Trees](#binary-trees)
3. [Binary Search Trees (BST)](#binary-search-trees-bst)
4. [Tree Traversal Methods](#tree-traversal-methods)
5. [AVL Trees (Self-Balancing BST)](#avl-trees-self-balancing-bst)
6. [Heaps](#heaps)
7. [Applications](#applications)
8. [Practice Problems](#practice-problems)

---

## Basic Tree Concepts

### Key Terminology:
- **Node**: Each element in a tree
- **Root**: The topmost node (no parent)
- **Leaf**: Node with no children
- **Parent**: Node that has children
- **Child**: Node that has a parent
- **Siblings**: Nodes with the same parent
- **Subtree**: Tree formed by a node and its descendants
- **Height**: Length of longest path from node to leaf
- **Depth**: Length of path from root to node
- **Level**: Depth + 1

### Visual Representation:
```
       A (Root, Level 1)
      / \
     B   C (Level 2)
    / \   \
   D   E   F (Level 3, Leaves)
```

### Tree Properties:
- **Height of tree**: Maximum depth of any node
- **Degree**: Maximum number of children any node has
- **Binary Tree**: Each node has at most 2 children

---

## Binary Trees

### Binary Tree Node

```dart
class TreeNode<T> {
  T data;
  TreeNode<T>? left;
  TreeNode<T>? right;
  
  TreeNode(this.data, [this.left, this.right]);
  
  @override
  String toString() => data.toString();
}
```

### Binary Tree Implementation

```dart
class BinaryTree<T> {
  TreeNode<T>? root;
  
  BinaryTree([this.root]);
  
  // Check if tree is empty
  bool get isEmpty => root == null;
  
  // Get height of tree - O(n)
  int height([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return -1;
    
    int leftHeight = height(node.left);
    int rightHeight = height(node.right);
    
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }
  
  // Count total nodes - O(n)
  int countNodes([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    return 1 + countNodes(node.left) + countNodes(node.right);
  }
  
  // Count leaf nodes - O(n)
  int countLeaves([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return 0;
    
    if (node.left == null && node.right == null) return 1;
    
    return countLeaves(node.left) + countLeaves(node.right);
  }
  
  // Find maximum element - O(n)
  T? findMax([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return null;
    
    T maxValue = node.data;
    T? leftMax = findMax(node.left);
    T? rightMax = findMax(node.right);
    
    if (leftMax != null && (leftMax as Comparable).compareTo(maxValue) > 0) {
      maxValue = leftMax;
    }
    if (rightMax != null && (rightMax as Comparable).compareTo(maxValue) > 0) {
      maxValue = rightMax;
    }
    
    return maxValue;
  }
  
  // Find minimum element - O(n)
  T? findMin([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return null;
    
    T minValue = node.data;
    T? leftMin = findMin(node.left);
    T? rightMin = findMin(node.right);
    
    if (leftMin != null && (leftMin as Comparable).compareTo(minValue) < 0) {
      minValue = leftMin;
    }
    if (rightMin != null && (rightMin as Comparable).compareTo(minValue) < 0) {
      minValue = rightMin;
    }
    
    return minValue;
  }
  
  // Search for a value - O(n)
  bool search(T value, [TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return false;
    
    if (node.data == value) return true;
    
    return search(value, node.left) || search(value, node.right);
  }
  
  // Check if tree is balanced - O(n²)
  bool isBalanced([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return true;
    
    int leftHeight = height(node.left);
    int rightHeight = height(node.right);
    
    return (leftHeight - rightHeight).abs() <= 1 && 
           isBalanced(node.left) && 
           isBalanced(node.right);
  }
  
  // Mirror the tree - O(n)
  void mirror([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return;
    
    // Swap left and right children
    TreeNode<T>? temp = node.left;
    node.left = node.right;
    node.right = temp;
    
    mirror(node.left);
    mirror(node.right);
  }
  
  // Check if two trees are identical - O(n)
  bool isIdentical(BinaryTree<T> other) {
    return _areIdentical(root, other.root);
  }
  
  bool _areIdentical(TreeNode<T>? node1, TreeNode<T>? node2) {
    if (node1 == null && node2 == null) return true;
    if (node1 == null || node2 == null) return false;
    
    return node1.data == node2.data &&
           _areIdentical(node1.left, node2.left) &&
           _areIdentical(node1.right, node2.right);
  }
}
```

---

## Binary Search Trees (BST)

### BST Properties:
- Left subtree contains values less than root
- Right subtree contains values greater than root
- Both subtrees are also BSTs

### BST Implementation

```dart
class BinarySearchTree<T extends Comparable<T>> extends BinaryTree<T> {
  
  // Insert a value - O(log n) average, O(n) worst
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
    // Equal values are ignored
    
    return node;
  }
  
  // Search for a value - O(log n) average, O(n) worst
  @override
  bool search(T value, [TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return false;
    
    if (value == node.data) return true;
    
    if (value.compareTo(node.data) < 0) {
      return search(value, node.left);
    } else {
      return search(value, node.right);
    }
  }
  
  // Delete a value - O(log n) average, O(n) worst
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
      
      // Case 1: No children (leaf node)
      if (node.left == null && node.right == null) {
        return null;
      }
      
      // Case 2: One child
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;
      
      // Case 3: Two children
      // Find inorder successor (smallest in right subtree)
      T successor = _findMin(node.right!);
      node.data = successor;
      node.right = _deleteRecursive(node.right, successor);
    }
    
    return node;
  }
  
  T _findMin(TreeNode<T> node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node.data;
  }
  
  T _findMax(TreeNode<T> node) {
    while (node.right != null) {
      node = node.right!;
    }
    return node.data;
  }
  
  // Find minimum value - O(log n)
  @override
  T? findMin([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return null;
    
    while (node!.left != null) {
      node = node.left;
    }
    return node.data;
  }
  
  // Find maximum value - O(log n)
  @override
  T? findMax([TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return null;
    
    while (node!.right != null) {
      node = node.right;
    }
    return node.data;
  }
  
  // Find kth smallest element - O(n)
  T? kthSmallest(int k) {
    List<T> inorderList = [];
    _inorderTraversal(root, inorderList);
    
    if (k > 0 && k <= inorderList.length) {
      return inorderList[k - 1];
    }
    return null;
  }
  
  void _inorderTraversal(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _inorderTraversal(node.left, result);
      result.add(node.data);
      _inorderTraversal(node.right, result);
    }
  }
  
  // Validate if tree is a valid BST
  bool isValidBST() {
    return _isValidBSTHelper(root, null, null);
  }
  
  bool _isValidBSTHelper(TreeNode<T>? node, T? min, T? max) {
    if (node == null) return true;
    
    if ((min != null && node.data.compareTo(min) <= 0) ||
        (max != null && node.data.compareTo(max) >= 0)) {
      return false;
    }
    
    return _isValidBSTHelper(node.left, min, node.data) &&
           _isValidBSTHelper(node.right, node.data, max);
  }
}
```

---

## Tree Traversal Methods

### Traversal Implementations

```dart
class TreeTraversal<T> {
  
  // Preorder Traversal: Root -> Left -> Right
  static List<T> preorder<T>(TreeNode<T>? node) {
    List<T> result = [];
    _preorderHelper(node, result);
    return result;
  }
  
  static void _preorderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      result.add(node.data);           // Visit root
      _preorderHelper(node.left, result);  // Visit left subtree
      _preorderHelper(node.right, result); // Visit right subtree
    }
  }
  
  // Inorder Traversal: Left -> Root -> Right
  static List<T> inorder<T>(TreeNode<T>? node) {
    List<T> result = [];
    _inorderHelper(node, result);
    return result;
  }
  
  static void _inorderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _inorderHelper(node.left, result);   // Visit left subtree
      result.add(node.data);               // Visit root
      _inorderHelper(node.right, result);  // Visit right subtree
    }
  }
  
  // Postorder Traversal: Left -> Right -> Root
  static List<T> postorder<T>(TreeNode<T>? node) {
    List<T> result = [];
    _postorderHelper(node, result);
    return result;
  }
  
  static void _postorderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _postorderHelper(node.left, result);  // Visit left subtree
      _postorderHelper(node.right, result); // Visit right subtree
      result.add(node.data);                // Visit root
    }
  }
  
  // Level Order Traversal (BFS): Level by level
  static List<T> levelOrder<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<TreeNode<T>> queue = [root];
    
    while (queue.isNotEmpty) {
      TreeNode<T> current = queue.removeAt(0);
      result.add(current.data);
      
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    
    return result;
  }
  
  // Iterative Preorder using Stack
  static List<T> preorderIterative<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<TreeNode<T>> stack = [root];
    
    while (stack.isNotEmpty) {
      TreeNode<T> current = stack.removeLast();
      result.add(current.data);
      
      // Push right first, then left (stack is LIFO)
      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
    
    return result;
  }
  
  // Iterative Inorder using Stack
  static List<T> inorderIterative<T>(TreeNode<T>? root) {
    List<T> result = [];
    List<TreeNode<T>> stack = [];
    TreeNode<T>? current = root;
    
    while (current != null || stack.isNotEmpty) {
      // Go to leftmost node
      while (current != null) {
        stack.add(current);
        current = current.left;
      }
      
      // Current is null, pop from stack
      current = stack.removeLast();
      result.add(current.data);
      
      // Visit right subtree
      current = current.right;
    }
    
    return result;
  }
  
  // Print tree structure
  static void printTree<T>(TreeNode<T>? node, [String prefix = '', bool isLast = true]) {
    if (node != null) {
      print(prefix + (isLast ? '└── ' : '├── ') + node.data.toString());
      
      List<TreeNode<T>?> children = [node.left, node.right].where((child) => child != null).toList();
      
      for (int i = 0; i < children.length; i++) {
        bool childIsLast = i == children.length - 1;
        printTree(children[i], prefix + (isLast ? '    ' : '│   '), childIsLast);
      }
    }
  }
  
  // Level order with level information
  static List<List<T>> levelOrderByLevels<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<List<T>> result = [];
    List<TreeNode<T>> currentLevel = [root];
    
    while (currentLevel.isNotEmpty) {
      List<T> levelValues = [];
      List<TreeNode<T>> nextLevel = [];
      
      for (TreeNode<T> node in currentLevel) {
        levelValues.add(node.data);
        
        if (node.left != null) nextLevel.add(node.left!);
        if (node.right != null) nextLevel.add(node.right!);
      }
      
      result.add(levelValues);
      currentLevel = nextLevel;
    }
    
    return result;
  }
}
```

---

## AVL Trees (Self-Balancing BST)

### AVL Tree Properties:
- Height difference between left and right subtrees ≤ 1
- Automatically balances itself after insertions/deletions
- Guarantees O(log n) operations

### AVL Node

```dart
class AVLNode<T extends Comparable<T>> {
  T data;
  AVLNode<T>? left;
  AVLNode<T>? right;
  int height;
  
  AVLNode(this.data) : height = 1;
  
  @override
  String toString() => '$data(h:$height)';
}
```

### AVL Tree Implementation

```dart
class AVLTree<T extends Comparable<T>> {
  AVLNode<T>? root;
  
  // Get height of node
  int _height(AVLNode<T>? node) {
    return node?.height ?? 0;
  }
  
  // Get balance factor
  int _getBalance(AVLNode<T>? node) {
    return node == null ? 0 : _height(node.left) - _height(node.right);
  }
  
  // Update height of node
  void _updateHeight(AVLNode<T> node) {
    node.height = 1 + [_height(node.left), _height(node.right)].reduce((a, b) => a > b ? a : b);
  }
  
  // Right rotate
  AVLNode<T> _rotateRight(AVLNode<T> y) {
    AVLNode<T> x = y.left!;
    AVLNode<T>? T2 = x.right;
    
    // Perform rotation
    x.right = y;
    y.left = T2;
    
    // Update heights
    _updateHeight(y);
    _updateHeight(x);
    
    return x;
  }
  
  // Left rotate
  AVLNode<T> _rotateLeft(AVLNode<T> x) {
    AVLNode<T> y = x.right!;
    AVLNode<T>? T2 = y.left;
    
    // Perform rotation
    y.left = x;
    x.right = T2;
    
    // Update heights
    _updateHeight(x);
    _updateHeight(y);
    
    return y;
  }
  
  // Insert a value - O(log n)
  void insert(T value) {
    root = _insertHelper(root, value);
  }
  
  AVLNode<T> _insertHelper(AVLNode<T>? node, T value) {
    // Standard BST insertion
    if (node == null) {
      return AVLNode<T>(value);
    }
    
    if (value.compareTo(node.data) < 0) {
      node.left = _insertHelper(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _insertHelper(node.right, value);
    } else {
      // Equal values not allowed
      return node;
    }
    
    // Update height
    _updateHeight(node);
    
    // Get balance factor
    int balance = _getBalance(node);
    
    // Left Left Case
    if (balance > 1 && value.compareTo(node.left!.data) < 0) {
      return _rotateRight(node);
    }
    
    // Right Right Case
    if (balance < -1 && value.compareTo(node.right!.data) > 0) {
      return _rotateLeft(node);
    }
    
    // Left Right Case
    if (balance > 1 && value.compareTo(node.left!.data) > 0) {
      node.left = _rotateLeft(node.left!);
      return _rotateRight(node);
    }
    
    // Right Left Case
    if (balance < -1 && value.compareTo(node.right!.data) < 0) {
      node.right = _rotateRight(node.right!);
      return _rotateLeft(node);
    }
    
    return node;
  }
  
  // Delete a value - O(log n)
  void delete(T value) {
    root = _deleteHelper(root, value);
  }
  
  AVLNode<T>? _deleteHelper(AVLNode<T>? node, T value) {
    // Standard BST deletion
    if (node == null) return null;
    
    if (value.compareTo(node.data) < 0) {
      node.left = _deleteHelper(node.left, value);
    } else if (value.compareTo(node.data) > 0) {
      node.right = _deleteHelper(node.right, value);
    } else {
      // Node to be deleted
      if (node.left == null || node.right == null) {
        AVLNode<T>? temp = node.left ?? node.right;
        if (temp == null) {
          node = null;
        } else {
          node = temp;
        }
      } else {
        // Node with two children
        AVLNode<T> temp = _getMinValueNode(node.right!);
        node.data = temp.data;
        node.right = _deleteHelper(node.right, temp.data);
      }
    }
    
    if (node == null) return node;
    
    // Update height
    _updateHeight(node);
    
    // Get balance factor
    int balance = _getBalance(node);
    
    // Left Left Case
    if (balance > 1 && _getBalance(node.left) >= 0) {
      return _rotateRight(node);
    }
    
    // Left Right Case
    if (balance > 1 && _getBalance(node.left) < 0) {
      node.left = _rotateLeft(node.left!);
      return _rotateRight(node);
    }
    
    // Right Right Case
    if (balance < -1 && _getBalance(node.right) <= 0) {
      return _rotateLeft(node);
    }
    
    // Right Left Case
    if (balance < -1 && _getBalance(node.right) > 0) {
      node.right = _rotateRight(node.right!);
      return _rotateLeft(node);
    }
    
    return node;
  }
  
  AVLNode<T> _getMinValueNode(AVLNode<T> node) {
    AVLNode<T> current = node;
    while (current.left != null) {
      current = current.left!;
    }
    return current;
  }
  
  // Search for a value - O(log n)
  bool search(T value) {
    return _searchHelper(root, value);
  }
  
  bool _searchHelper(AVLNode<T>? node, T value) {
    if (node == null) return false;
    
    if (value == node.data) return true;
    
    if (value.compareTo(node.data) < 0) {
      return _searchHelper(node.left, value);
    } else {
      return _searchHelper(node.right, value);
    }
  }
  
  // Get inorder traversal
  List<T> inorderTraversal() {
    List<T> result = [];
    _inorderHelper(root, result);
    return result;
  }
  
  void _inorderHelper(AVLNode<T>? node, List<T> result) {
    if (node != null) {
      _inorderHelper(node.left, result);
      result.add(node.data);
      _inorderHelper(node.right, result);
    }
  }
  
  // Check if tree is balanced
  bool isBalanced() {
    return _isBalancedHelper(root);
  }
  
  bool _isBalancedHelper(AVLNode<T>? node) {
    if (node == null) return true;
    
    int balance = _getBalance(node);
    return balance.abs() <= 1 && 
           _isBalancedHelper(node.left) && 
           _isBalancedHelper(node.right);
  }
  
  // Print tree structure
  void printTree() {
    _printTreeHelper(root, '', true);
  }
  
  void _printTreeHelper(AVLNode<T>? node, String prefix, bool isLast) {
    if (node != null) {
      print(prefix + (isLast ? '└── ' : '├── ') + node.toString());
      
      if (node.left != null || node.right != null) {
        if (node.left != null) {
          _printTreeHelper(node.left, prefix + (isLast ? '    ' : '│   '), node.right == null);
        }
        if (node.right != null) {
          _printTreeHelper(node.right, prefix + (isLast ? '    ' : '│   '), true);
        }
      }
    }
  }
}
```

---

## Heaps

### Heap Properties:
- **Max Heap**: Parent ≥ children
- **Min Heap**: Parent ≤ children
- Complete binary tree (filled level by level)
- Root contains maximum (max heap) or minimum (min heap)

### Min Heap Implementation

```dart
class MinHeap<T extends Comparable<T>> {
  List<T> _heap = [];
  
  // Get parent index
  int _parent(int index) => (index - 1) ~/ 2;
  
  // Get left child index
  int _leftChild(int index) => 2 * index + 1;
  
  // Get right child index
  int _rightChild(int index) => 2 * index + 2;
  
  // Check if heap is empty
  bool get isEmpty => _heap.isEmpty;
  
  // Get size of heap
  int get size => _heap.length;
  
  // Get minimum element (root) - O(1)
  T? peek() {
    return _heap.isEmpty ? null : _heap[0];
  }
  
  // Swap two elements
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
  
  // Heapify up (bubble up) - O(log n)
  void _heapifyUp(int index) {
    if (index == 0) return;
    
    int parentIndex = _parent(index);
    if (_heap[index].compareTo(_heap[parentIndex]) < 0) {
      _swap(index, parentIndex);
      _heapifyUp(parentIndex);
    }
  }
  
  // Heapify down (bubble down) - O(log n)
  void _heapifyDown(int index) {
    int smallest = index;
    int left = _leftChild(index);
    int right = _rightChild(index);
    
    // Find smallest among node and its children
    if (left < _heap.length && _heap[left].compareTo(_heap[smallest]) < 0) {
      smallest = left;
    }
    
    if (right < _heap.length && _heap[right].compareTo(_heap[smallest]) < 0) {
      smallest = right;
    }
    
    // If smallest is not the current node
    if (smallest != index) {
      _swap(index, smallest);
      _heapifyDown(smallest);
    }
  }
  
  // Insert element - O(log n)
  void insert(T element) {
    _heap.add(element);
    _heapifyUp(_heap.length - 1);
  }
  
  // Extract minimum element - O(log n)
  T? extractMin() {
    if (_heap.isEmpty) {
      print('Heap is empty');
      return null;
    }
    
    if (_heap.length == 1) {
      return _heap.removeLast();
    }
    
    T min = _heap[0];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    
    return min;
  }
  
  // Delete specific element - O(n + log n)
  bool delete(T element) {
    int index = _heap.indexOf(element);
    if (index == -1) return false;
    
    if (index == _heap.length - 1) {
      _heap.removeLast();
      return true;
    }
    
    _heap[index] = _heap.removeLast();
    
    // Check if we need to bubble up or down
    if (index > 0 && _heap[index].compareTo(_heap[_parent(index)]) < 0) {
      _heapifyUp(index);
    } else {
      _heapifyDown(index);
    }
    
    return true;
  }
  
  // Build heap from array - O(n)
  void buildHeap(List<T> array) {
    _heap = List.from(array);
    
    // Start from last non-leaf node and heapify down
    for (int i = _parent(_heap.length - 1); i >= 0; i--) {
      _heapifyDown(i);
    }
  }
  
  // Heap sort - O(n log n)
  List<T> heapSort() {
    List<T> sorted = [];
    List<T> originalHeap = List.from(_heap);
    
    while (!isEmpty) {
      sorted.add(extractMin()!);
    }
    
    _heap = originalHeap; // Restore original heap
    return sorted;
  }
  
  // Check if array represents a valid min heap
  bool isValidHeap() {
    for (int i = 0; i < _heap.length; i++) {
      int left = _leftChild(i);
      int right = _rightChild(i);
      
      if (left < _heap.length && _heap[i].compareTo(_heap[left]) > 0) {
        return false;
      }
      
      if (right < _heap.length && _heap[i].compareTo(_heap[right]) > 0) {
        return false;
      }
    }
    return true;
  }
  
  // Display heap as array
  void display() {
    if (_heap.isEmpty) {
      print('Heap is empty');
      return;
    }
    
    print('Heap: $_heap');
    _printHeapStructure();
  }
  
  // Print heap structure
  void _printHeapStructure() {
    if (_heap.isEmpty) return;
    
    int level = 0;
    int levelSize = 1;
    int index = 0;
    
    print('\nHeap Structure:');
    while (index < _heap.length) {
      String levelStr = '';
      int elementsInLevel = 0;
      
      while (elementsInLevel < levelSize && index < _heap.length) {
        levelStr += '${_heap[index]} ';
        index++;
        elementsInLevel++;
      }
      
      print('Level $level: $levelStr');
      level++;
      levelSize *= 2;
    }
  }
  
  @override
  String toString() => 'MinHeap: $_heap';
}
```

### Max Heap Implementation

```dart
class MaxHeap<T extends Comparable<T>> {
  List<T> _heap = [];
  
  // Get parent index
  int _parent(int index) => (index - 1) ~/ 2;
  
  // Get left child index
  int _leftChild(int index) => 2 * index + 1;
  
  // Get right child index
  int _rightChild(int index) => 2 * index + 2;
  
  // Check if heap is empty
  bool get isEmpty => _heap.isEmpty;
  
  // Get size of heap
  int get size => _heap.length;
  
  // Get maximum element (root) - O(1)
  T? peek() => _heap.isEmpty ? null : _heap[0];
  
  // Swap two elements
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
  
  // Heapify up - O(log n)
  void _heapifyUp(int index) {
    if (index == 0) return;
    
    int parentIndex = _parent(index);
    if (_heap[index].compareTo(_heap[parentIndex]) > 0) {
      _swap(index, parentIndex);
      _heapifyUp(parentIndex);
    }
  }
  
  // Heapify down - O(log n)
  void _heapifyDown(int index) {
    int largest = index;
    int left = _leftChild(index);
    int right = _rightChild(index);
    
    // Find largest among node and its children
    if (left < _heap.length && _heap[left].compareTo(_heap[largest]) > 0) {
      largest = left;
    }
    
    if (right < _heap.length && _heap[right].compareTo(_heap[largest]) > 0) {
      largest = right;
    }
    
    // If largest is not the current node
    if (largest != index) {
      _swap(index, largest);
      _heapifyDown(largest);
    }
  }
  
  // Insert element - O(log n)
  void insert(T element) {
    _heap.add(element);
    _heapifyUp(_heap.length - 1);
  }
  
  // Extract maximum element - O(log n)
  T? extractMax() {
    if (_heap.isEmpty) {
      print('Heap is empty');
      return null;
    }
    
    if (_heap.length == 1) {
      return _heap.removeLast();
    }
    
    T max = _heap[0];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    
    return max;
  }
  
  // Build heap from array - O(n)
  void buildHeap(List<T> array) {
    _heap = List.from(array);
    
    for (int i = _parent(_heap.length - 1); i >= 0; i--) {
      _heapifyDown(i);
    }
  }
  
  @override
  String toString() => 'MaxHeap: $_heap';
}
```

---

## Applications

### 1. Expression Tree

```dart
class ExpressionTree {
  TreeNode<String> root;
  
  ExpressionTree(this.root);
  
  // Evaluate expression tree
  double evaluate() {
    return _evaluateHelper(root);
  }
  
  double _evaluateHelper(TreeNode<String> node) {
    // If leaf node (operand)
    if (node.left == null && node.right == null) {
      return double.parse(node.data);
    }
    
    // Evaluate left and right subtrees
    double left = _evaluateHelper(node.left!);
    double right = _evaluateHelper(node.right!);
    
    // Apply operator
    switch (node.data) {
      case '+': return left + right;
      case '-': return left - right;
      case '*': return left * right;
      case '/': return left / right;
      default: throw ArgumentError('Unknown operator: ${node.data}');
    }
  }
  
  // Build expression tree from postfix
  static ExpressionTree fromPostfix(List<String> postfix) {
    List<TreeNode<String>> stack = [];
    
    for (String token in postfix) {
      TreeNode<String> node = TreeNode<String>(token);
      
      if (_isOperator(token)) {
        node.right = stack.removeLast();
        node.left = stack.removeLast();
      }
      
      stack.add(node);
    }
    
    return ExpressionTree(stack.last);
  }
  
  static bool _isOperator(String token) {
    return ['+', '-', '*', '/'].contains(token);
  }
}
```

### 2. Huffman Coding Tree

```dart
class HuffmanNode implements Comparable<HuffmanNode> {
  String? character;
  int frequency;
  HuffmanNode? left;
  HuffmanNode? right;
  
  HuffmanNode(this.frequency, {this.character, this.left, this.right});
  
  bool get isLeaf => left == null && right == null;
  
  @override
  int compareTo(HuffmanNode other) => frequency.compareTo(other.frequency);
  
  @override
  String toString() => character ?? 'Internal($frequency)';
}

class HuffmanCoding {
  HuffmanNode? root;
  Map<String, String> codes = {};
  
  // Build Huffman tree
  void buildTree(Map<String, int> frequencies) {
    MinHeap<HuffmanNode> heap = MinHeap<HuffmanNode>();
    
    // Create leaf nodes
    for (String char in frequencies.keys) {
      heap.insert(HuffmanNode(frequencies[char]!, character: char));
    }
    
    // Build tree
    while (heap.size > 1) {
      HuffmanNode left = heap.extractMin()!;
      HuffmanNode right = heap.extractMin()!;
      
      HuffmanNode internal = HuffmanNode(
        left.frequency + right.frequency,
        left: left,
        right: right
      );
      
      heap.insert(internal);
    }
    
    root = heap.extractMin();
    _generateCodes(root, '');
  }
  
  // Generate Huffman codes
  void _generateCodes(HuffmanNode? node, String code) {
    if (node == null) return;
    
    if (node.isLeaf) {
      codes[node.character!] = code.isEmpty ? '0' : code;
      return;
    }
    
    _generateCodes(node.left, code + '0');
    _generateCodes(node.right, code + '1');
  }
  
  // Encode text
  String encode(String text) {
    String encoded = '';
    for (int i = 0; i < text.length; i++) {
      encoded += codes[text[i]] ?? '';
    }
    return encoded;
  }
  
  // Decode text
  String decode(String encoded) {
    String decoded = '';
    HuffmanNode? current = root;
    
    for (int i = 0; i < encoded.length; i++) {
      current = encoded[i] == '0' ? current!.left : current!.right;
      
      if (current!.isLeaf) {
        decoded += current.character!;
        current = root;
      }
    }
    
    return decoded;
  }
}
```

### 3. Trie (Prefix Tree)

```dart
class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  
  @override
  String toString() => 'TrieNode(isEnd: $isEndOfWord, children: ${children.keys})';
}

class Trie {
  TrieNode root = TrieNode();
  
  // Insert word - O(m) where m is word length
  void insert(String word) {
    TrieNode current = root;
    
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      
      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();
      }
      
      current = current.children[char]!;
    }
    
    current.isEndOfWord = true;
  }
  
  // Search word - O(m)
  bool search(String word) {
    TrieNode current = root;
    
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      
      if (!current.children.containsKey(char)) {
        return false;
      }
      
      current = current.children[char]!;
    }
    
    return current.isEndOfWord;
  }
  
  // Check if prefix exists - O(m)
  bool startsWith(String prefix) {
    TrieNode current = root;
    
    for (int i = 0; i < prefix.length; i++) {
      String char = prefix[i];
      
      if (!current.children.containsKey(char)) {
        return false;
      }
      
      current = current.children[char]!;
    }
    
    return true;
  }
  
  // Get all words with given prefix
  List<String> getWordsWithPrefix(String prefix) {
    List<String> result = [];
    TrieNode current = root;
    
    // Navigate to prefix
    for (int i = 0; i < prefix.length; i++) {
      String char = prefix[i];
      
      if (!current.children.containsKey(char)) {
        return result;
      }
      
      current = current.children[char]!;
    }
    
    // Collect all words from this point
    _collectWords(current, prefix, result);
    return result;
  }
  
  void _collectWords(TrieNode node, String prefix, List<String> result) {
    if (node.isEndOfWord) {
      result.add(prefix);
    }
    
    for (String char in node.children.keys) {
      _collectWords(node.children[char]!, prefix + char, result);
    }
  }
  
  // Delete word
  bool delete(String word) {
    return _deleteHelper(root, word, 0);
  }
  
  bool _deleteHelper(TrieNode node, String word, int index) {
    if (index == word.length) {
      if (!node.isEndOfWord) return false;
      
      node.isEndOfWord = false;
      return node.children.isEmpty;
    }
    
    String char = word[index];
    TrieNode? child = node.children[char];
    
    if (child == null) return false;
    
    bool shouldDeleteChild = _deleteHelper(child, word, index + 1);
    
    if (shouldDeleteChild) {
      node.children.remove(char);
      return !node.isEndOfWord && node.children.isEmpty;
    }
    
    return false;
  }
}
```

---

## Practice Problems

### 1. Lowest Common Ancestor

```dart
class LCAFinder {
  // Find LCA in BST - O(log n)
  static TreeNode<int>? findLCAInBST(TreeNode<int>? root, int p, int q) {
    if (root == null) return null;
    
    if (root.data > p && root.data > q) {
      return findLCAInBST(root.left, p, q);
    }
    
    if (root.data < p && root.data < q) {
      return findLCAInBST(root.right, p, q);
    }
    
    return root;
  }
  
  // Find LCA in binary tree - O(n)
  static TreeNode<int>? findLCA(TreeNode<int>? root, int p, int q) {
    if (root == null || root.data == p || root.data == q) {
      return root;
    }
    
    TreeNode<int>? left = findLCA(root.left, p, q);
    TreeNode<int>? right = findLCA(root.right, p, q);
    
    if (left != null && right != null) return root;
    
    return left ?? right;
  }
}
```

### 2. Tree Serialization

```dart
class TreeSerializer {
  // Serialize tree to string
  static String serialize(TreeNode<int>? root) {
    List<String> result = [];
    _serializeHelper(root, result);
    return result.join(',');
  }
  
  static void _serializeHelper(TreeNode<int>? node, List<String> result) {
    if (node == null) {
      result.add('null');
      return;
    }
    
    result.add(node.data.toString());
    _serializeHelper(node.left, result);
    _serializeHelper(node.right, result);
  }
  
  // Deserialize string to tree
  static TreeNode<int>? deserialize(String data) {
    List<String> nodes = data.split(',');
    int index = 0;
    return _deserializeHelper(nodes, index);
  }
  
  static TreeNode<int>? _deserializeHelper(List<String> nodes, int index) {
    if (index >= nodes.length || nodes[index] == 'null') {
      return null;
    }
    
    TreeNode<int> root = TreeNode<int>(int.parse(nodes[index]));
    root.left = _deserializeHelper(nodes, index + 1);
    root.right = _deserializeHelper(nodes, index + 1);
    
    return root;
  }
}
```

### 3. Path Sum Problems

```dart
class PathSum {
  // Check if path with given sum exists
  static bool hasPathSum(TreeNode<int>? root, int targetSum) {
    if (root == null) return false;
    
    if (root.left == null && root.right == null) {
      return root.data == targetSum;
    }
    
    int remainingSum = targetSum - root.data;
    return hasPathSum(root.left, remainingSum) || 
           hasPathSum(root.right, remainingSum);
  }
  
  // Find all paths with given sum
  static List<List<int>> findAllPaths(TreeNode<int>? root, int targetSum) {
    List<List<int>> result = [];
    List<int> currentPath = [];
    _findPathsHelper(root, targetSum, currentPath, result);
    return result;
  }
  
  static void _findPathsHelper(TreeNode<int>? node, int remainingSum, 
                              List<int> currentPath, List<List<int>> result) {
    if (node == null) return;
    
    currentPath.add(node.data);
    
    if (node.left == null && node.right == null && remainingSum == node.data) {
      result.add(List.from(currentPath));
    } else {
      _findPathsHelper(node.left, remainingSum - node.data, currentPath, result);
      _findPathsHelper(node.right, remainingSum - node.data, currentPath, result);
    }
    
    currentPath.removeLast(); // Backtrack
  }
}
```

---

## Complete Example Usage

```dart
void main() {
  print('=== Tree Data Structures Demo ===\n');
  
  // Binary Tree
  print('1. Binary Tree:');
  BinaryTree<int> binaryTree = BinaryTree<int>();
  binaryTree.root = TreeNode<int>(1);
  binaryTree.root!.left = TreeNode<int>(2);
  binaryTree.root!.right = TreeNode<int>(3);
  binaryTree.root!.left!.left = TreeNode<int>(4);
  binaryTree.root!.left!.right = TreeNode<int>(5);
  
  print('Height: ${binaryTree.height()}');
  print('Node count: ${binaryTree.countNodes()}');
  print('Leaf count: ${binaryTree.countLeaves()}');
  print('Max value: ${binaryTree.findMax()}');
  print('Is balanced: ${binaryTree.isBalanced()}');
  print();
  
  // Tree Traversals
  print('2. Tree Traversals:');
  print('Preorder: ${TreeTraversal.preorder(binaryTree.root)}');
  print('Inorder: ${TreeTraversal.inorder(binaryTree.root)}');
  print('Postorder: ${TreeTraversal.postorder(binaryTree.root)}');
  print('Level order: ${TreeTraversal.levelOrder(binaryTree.root)}');
  print('Level order by levels: ${TreeTraversal.levelOrderByLevels(binaryTree.root)}');
  print();
  
  // Binary Search Tree
  print('3. Binary Search Tree:');
  BinarySearchTree<int> bst = BinarySearchTree<int>();
  [50, 30, 70, 20, 40, 60, 80].forEach(bst.insert);
  
  print('BST Inorder: ${TreeTraversal.inorder(bst.root)}');
  print('Search 40: ${bst.search(40)}');
  print('Search 90: ${bst.search(90)}');
  print('Min value: ${bst.findMin()}');
  print('Max value: ${bst.findMax()}');
  print('3rd smallest: ${bst.kthSmallest(3)}');
  print('Is valid BST: ${bst.isValidBST()}');
  
  bst.delete(30);
  print('After deleting 30: ${TreeTraversal.inorder(bst.root)}');
  print();
  
  // AVL Tree
  print('4. AVL Tree:');
  AVLTree<int> avl = AVLTree<int>();
  [10, 20, 30, 40, 50, 25].forEach(avl.insert);
  
  print('AVL Inorder: ${avl.inorderTraversal()}');
  print('Is balanced: ${avl.isBalanced()}');
  
  print('AVL Tree structure:');
  avl.printTree();
  print();
  
  // Min Heap
  print('5. Min Heap:');
  MinHeap<int> minHeap = MinHeap<int>();
  [20, 15, 8, 10, 5, 7, 25, 30].forEach(minHeap.insert);
  
  minHeap.display();
  print('Min element: ${minHeap.peek()}');
  print('Extract min: ${minHeap.extractMin()}');
  print('After extraction: $minHeap');
  
  List<int> sorted = minHeap.heapSort();
  print('Heap sort result: $sorted');
  print();
  
  // Max Heap
  print('6. Max Heap:');
  MaxHeap<int> maxHeap = MaxHeap<int>();
  maxHeap.buildHeap([4, 10, 3, 5, 1, 15, 9, 2]);
  
  print('Max heap: $maxHeap');
  print('Max element: ${maxHeap.peek()}');
  print('Extract max: ${maxHeap.extractMax()}');
  print('After extraction: $maxHeap');
  print();
  
  // Expression Tree
  print('7. Expression Tree:');
  List<String> postfix = ['2', '3', '+', '4', '*'];
  ExpressionTree expTree = ExpressionTree.fromPostfix(postfix);
  print('Expression: (2 + 3) * 4');
  print('Result: ${expTree.evaluate()}');
  print();
  
  // Huffman Coding
  print('8. Huffman Coding:');
  Map<String, int> frequencies = {'a': 5, 'b': 9, 'c': 12, 'd': 13, 'e': 16, 'f': 45};
  HuffmanCoding huffman = HuffmanCoding();
  huffman.buildTree(frequencies);
  
  print('Huffman codes: ${huffman.codes}');
  String text = 'abcdef';
  String encoded = huffman.encode(text);
  print('Encoded "$text": $encoded');
  print('Decoded: ${huffman.decode(encoded)}');
  print();
  
  // Trie
  print('9. Trie (Prefix Tree):');
  Trie trie = Trie();
  ['apple', 'app', 'apricot', 'banana', 'band', 'bandana'].forEach(trie.insert);
  
  print('Search "app": ${trie.search("app")}');
  print('Search "appl": ${trie.search("appl")}');
  print('Starts with "app": ${trie.startsWith("app")}');
  print('Words with prefix "app": ${trie.getWordsWithPrefix("app")}');
  print('Words with prefix "ban": ${trie.getWordsWithPrefix("ban")}');
  print();
  
  // Problem Solutions
  print('10. Problem Solutions:');
  
  // LCA
  TreeNode<int> lcaRoot = TreeNode<int>(3);
  lcaRoot.left = TreeNode<int>(5);
  lcaRoot.right = TreeNode<int>(1);
  lcaRoot.left!.left = TreeNode<int>(6);
  lcaRoot.left!.right = TreeNode<int>(2);
  lcaRoot.right!.left = TreeNode<int>(0);
  lcaRoot.right!.right = TreeNode<int>(8);
  
  TreeNode<int>? lca = LCAFinder.findLCA(lcaRoot, 5, 1);
  print('LCA of 5 and 1: ${lca?.data}');
  
  // Path Sum
  bool hasPath = PathSum.hasPathSum(lcaRoot, 8); // 3 + 5
  print('Has path with sum 8: $hasPath');
  
  List<List<int>> allPaths = PathSum.findAllPaths(lcaRoot, 14); // 3 + 5 + 6
  print('All paths with sum 14: $allPaths');
}
```

---

## Time and Space Complexities

### Tree Operations Comparison

| Operation | Binary Tree | BST (Balanced) | BST (Skewed) | AVL Tree | Heap |
|-----------|-------------|----------------|--------------|----------|------|
| Search | O(n) | O(log n) | O(n) | O(log n) | O(n) |
| Insert | O(1) | O(log n) | O(n) | O(log n) | O(log n) |
| Delete | O(n) | O(log n) | O(n) | O(log n) | O(log n) |
| Find Min/Max | O(n) | O(log n) | O(n) | O(log n) | O(1) |
| Traversal | O(n) | O(n) | O(n) | O(n) | O(n) |

### Space Complexity

| Data Structure | Space Complexity | Notes |
|----------------|------------------|-------|
| Binary Tree | O(n) | For n nodes |
| BST | O(n) | Plus O(log n) for recursion stack |
| AVL Tree | O(n) | Extra height information |
| Heap | O(n) | Array-based implementation |
| Trie | O(ALPHABET_SIZE * N * M) | N = number of words, M = average length |

---

## Key Takeaways

1. **Trees are hierarchical** - Non-linear data structures with parent-child relationships
2. **Binary Search Trees** provide efficient searching in O(log n) when balanced
3. **AVL Trees** maintain balance automatically through rotations
4. **Heaps** are complete binary trees optimized for priority operations
5. **Tree traversals** have different applications: inorder for BST gives sorted order
6. **Self-balancing trees** prevent worst-case O(n) operations
7. **Applications are diverse** - from expression evaluation to data compression

This comprehensive guide covers all essential tree concepts with practical implementations in Dart!
