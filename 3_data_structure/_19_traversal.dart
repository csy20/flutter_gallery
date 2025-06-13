// Tree Traversal Algorithms in Dart
// Traversal means visiting all nodes in a tree data structure
// Different traversal methods visit nodes in different orders

// Tree Node for demonstrations
class TreeNode<T> {
  T data;
  TreeNode<T>? left;
  TreeNode<T>? right;
  
  TreeNode(this.data, {this.left, this.right});
  
  @override
  String toString() => 'Node($data)';
}

// General Tree Node (for n-ary trees)
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

// Tree Traversal Algorithms
class TreeTraversal<T> {
  // ======================== DEPTH-FIRST TRAVERSALS ========================
  
  // 1. IN-ORDER TRAVERSAL (Left, Root, Right)
  // For BST: gives nodes in sorted order
  static List<T> inOrderTraversal<T>(TreeNode<T>? root) {
    List<T> result = [];
    _inOrderHelper(root, result);
    return result;
  }
  
  static void _inOrderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _inOrderHelper(node.left, result);  // Visit left subtree
      result.add(node.data);              // Visit root
      _inOrderHelper(node.right, result); // Visit right subtree
    }
  }
  
  // In-order traversal (Iterative using Stack)
  static List<T> inOrderIterative<T>(TreeNode<T>? root) {
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
      
      // Move to right subtree
      current = current.right;
    }
    
    return result;
  }
  
  // 2. PRE-ORDER TRAVERSAL (Root, Left, Right)
  // Useful for: copying tree, prefix expressions, tree serialization
  static List<T> preOrderTraversal<T>(TreeNode<T>? root) {
    List<T> result = [];
    _preOrderHelper(root, result);
    return result;
  }
  
  static void _preOrderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      result.add(node.data);              // Visit root
      _preOrderHelper(node.left, result); // Visit left subtree
      _preOrderHelper(node.right, result);// Visit right subtree
    }
  }
  
  // Pre-order traversal (Iterative)
  static List<T> preOrderIterative<T>(TreeNode<T>? root) {
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
  
  // 3. POST-ORDER TRAVERSAL (Left, Right, Root)
  // Useful for: deleting tree, postfix expressions, calculating directory size
  static List<T> postOrderTraversal<T>(TreeNode<T>? root) {
    List<T> result = [];
    _postOrderHelper(root, result);
    return result;
  }
  
  static void _postOrderHelper<T>(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _postOrderHelper(node.left, result); // Visit left subtree
      _postOrderHelper(node.right, result);// Visit right subtree
      result.add(node.data);               // Visit root
    }
  }
  
  // Post-order traversal (Iterative using two stacks)
  static List<T> postOrderIterative<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<TreeNode<T>> stack1 = [root];
    List<TreeNode<T>> stack2 = [];
    
    // First stack for traversal, second for result order
    while (stack1.isNotEmpty) {
      TreeNode<T> current = stack1.removeLast();
      stack2.add(current);
      
      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }
    
    // Pop from second stack to get post-order
    while (stack2.isNotEmpty) {
      result.add(stack2.removeLast().data);
    }
    
    return result;
  }
  
  // ======================== BREADTH-FIRST TRAVERSALS ========================
  
  // 4. LEVEL-ORDER TRAVERSAL (Breadth-First Search)
  // Visits nodes level by level from left to right
  static List<T> levelOrderTraversal<T>(TreeNode<T>? root) {
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
  
  // Level-order traversal with level information
  static List<List<T>> levelOrderByLevels<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<List<T>> result = [];
    List<TreeNode<T>> queue = [root];
    
    while (queue.isNotEmpty) {
      int levelSize = queue.length;
      List<T> currentLevel = [];
      
      for (int i = 0; i < levelSize; i++) {
        TreeNode<T> current = queue.removeAt(0);
        currentLevel.add(current.data);
        
        if (current.left != null) queue.add(current.left!);
        if (current.right != null) queue.add(current.right!);
      }
      
      result.add(currentLevel);
    }
    
    return result;
  }
  
  // ======================== SPECIAL TRAVERSALS ========================
  
  // 5. REVERSE LEVEL-ORDER TRAVERSAL (Bottom-up)
  static List<T> reverseLevelOrder<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<TreeNode<T>> queue = [root];
    List<T> temp = [];
    
    while (queue.isNotEmpty) {
      TreeNode<T> current = queue.removeAt(0);
      temp.add(current.data);
      
      if (current.right != null) queue.add(current.right!);
      if (current.left != null) queue.add(current.left!);
    }
    
    // Reverse the result
    return temp.reversed.toList();
  }
  
  // 6. ZIGZAG LEVEL-ORDER TRAVERSAL (Spiral)
  static List<T> zigzagLevelOrder<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<TreeNode<T>> queue = [root];
    bool leftToRight = true;
    
    while (queue.isNotEmpty) {
      int levelSize = queue.length;
      List<T> currentLevel = [];
      
      for (int i = 0; i < levelSize; i++) {
        TreeNode<T> current = queue.removeAt(0);
        
        if (leftToRight) {
          currentLevel.add(current.data);
        } else {
          currentLevel.insert(0, current.data);
        }
        
        if (current.left != null) queue.add(current.left!);
        if (current.right != null) queue.add(current.right!);
      }
      
      result.addAll(currentLevel);
      leftToRight = !leftToRight; // Alternate direction
    }
    
    return result;
  }
  
  // 7. VERTICAL ORDER TRAVERSAL
  static List<List<T>> verticalOrderTraversal<T>(TreeNode<T>? root) {
    if (root == null) return [];
    
    Map<int, List<T>> columnMap = {};
    List<MapEntry<TreeNode<T>, int>> queue = [MapEntry(root, 0)];
    
    while (queue.isNotEmpty) {
      var entry = queue.removeAt(0);
      TreeNode<T> node = entry.key;
      int column = entry.value;
      
      columnMap.putIfAbsent(column, () => []).add(node.data);
      
      if (node.left != null) {
        queue.add(MapEntry(node.left!, column - 1));
      }
      if (node.right != null) {
        queue.add(MapEntry(node.right!, column + 1));
      }
    }
    
    // Sort by column and return values
    var sortedColumns = columnMap.keys.toList()..sort();
    return sortedColumns.map((col) => columnMap[col]!).toList();
  }
  
  // ======================== N-ARY TREE TRAVERSALS ========================
  
  // Pre-order traversal for n-ary trees
  static List<T> naryPreOrder<T>(GeneralTreeNode<T>? root) {
    List<T> result = [];
    _naryPreOrderHelper(root, result);
    return result;
  }
  
  static void _naryPreOrderHelper<T>(GeneralTreeNode<T>? node, List<T> result) {
    if (node != null) {
      result.add(node.data);
      for (var child in node.children) {
        _naryPreOrderHelper(child, result);
      }
    }
  }
  
  // Post-order traversal for n-ary trees
  static List<T> naryPostOrder<T>(GeneralTreeNode<T>? root) {
    List<T> result = [];
    _naryPostOrderHelper(root, result);
    return result;
  }
  
  static void _naryPostOrderHelper<T>(GeneralTreeNode<T>? node, List<T> result) {
    if (node != null) {
      for (var child in node.children) {
        _naryPostOrderHelper(child, result);
      }
      result.add(node.data);
    }
  }
  
  // Level-order traversal for n-ary trees
  static List<T> naryLevelOrder<T>(GeneralTreeNode<T>? root) {
    if (root == null) return [];
    
    List<T> result = [];
    List<GeneralTreeNode<T>> queue = [root];
    
    while (queue.isNotEmpty) {
      GeneralTreeNode<T> current = queue.removeAt(0);
      result.add(current.data);
      queue.addAll(current.children);
    }
    
    return result;
  }
}

// Utility class for tree visualization
class TreeVisualizer {
  static void printTree<T>(TreeNode<T>? root, [String prefix = '', bool isLast = true]) {
    if (root != null) {
      print('$prefix${isLast ? '└── ' : '├── '}${root.data}');
      
      List<TreeNode<T>?> children = [root.left, root.right]
          .where((child) => child != null)
          .toList();
      
      for (int i = 0; i < children.length; i++) {
        bool isLastChild = i == children.length - 1;
        printTree(children[i], '$prefix${isLast ? '    ' : '│   '}', isLastChild);
      }
    }
  }
}

// Demonstration and Examples
void main() {
  print('=== Tree Traversal Algorithms in Dart ===\n');
  
  // Create a sample binary tree
  //        1
  //       / \
  //      2   3
  //     / \   \
  //    4   5   6
  //   /
  //  7
  
  var root = TreeNode<int>(1);
  root.left = TreeNode<int>(2);
  root.right = TreeNode<int>(3);
  root.left!.left = TreeNode<int>(4);
  root.left!.right = TreeNode<int>(5);
  root.right!.right = TreeNode<int>(6);
  root.left!.left!.left = TreeNode<int>(7);
  
  print('Sample Binary Tree:');
  TreeVisualizer.printTree(root);
  
  print('\n' + '='*50);
  
  print('\n1. DEPTH-FIRST TRAVERSALS:');
  
  print('\nIn-Order (Left, Root, Right):');
  var inOrder = TreeTraversal.inOrderTraversal(root);
  print('Recursive: ${inOrder.join(' → ')}');
  var inOrderIter = TreeTraversal.inOrderIterative(root);
  print('Iterative: ${inOrderIter.join(' → ')}');
  print('Use case: Get sorted order in BST\n');
  
  print('Pre-Order (Root, Left, Right):');
  var preOrder = TreeTraversal.preOrderTraversal(root);
  print('Recursive: ${preOrder.join(' → ')}');
  var preOrderIter = TreeTraversal.preOrderIterative(root);
  print('Iterative: ${preOrderIter.join(' → ')}');
  print('Use case: Copy tree, prefix expressions\n');
  
  print('Post-Order (Left, Right, Root):');
  var postOrder = TreeTraversal.postOrderTraversal(root);
  print('Recursive: ${postOrder.join(' → ')}');
  var postOrderIter = TreeTraversal.postOrderIterative(root);
  print('Iterative: ${postOrderIter.join(' → ')}');
  print('Use case: Delete tree, calculate directory size\n');
  
  print('2. BREADTH-FIRST TRAVERSALS:');
  
  print('\nLevel-Order (Breadth-First):');
  var levelOrder = TreeTraversal.levelOrderTraversal(root);
  print('Result: ${levelOrder.join(' → ')}');
  print('Use case: Print tree level by level\n');
  
  print('Level-Order by Levels:');
  var levelsByLevels = TreeTraversal.levelOrderByLevels(root);
  for (int i = 0; i < levelsByLevels.length; i++) {
    print('Level $i: ${levelsByLevels[i].join(' ')}');
  }
  
  print('\n3. SPECIAL TRAVERSALS:');
  
  print('\nReverse Level-Order:');
  var reverseLevelOrder = TreeTraversal.reverseLevelOrder(root);
  print('Result: ${reverseLevelOrder.join(' → ')}');
  
  print('\nZigzag Level-Order:');
  var zigzag = TreeTraversal.zigzagLevelOrder(root);
  print('Result: ${zigzag.join(' → ')}');
  
  print('\nVertical Order:');
  var verticalOrder = TreeTraversal.verticalOrderTraversal(root);
  for (int i = 0; i < verticalOrder.length; i++) {
    print('Column $i: ${verticalOrder[i].join(' ')}');
  }
  
  print('\n' + '='*50);
  
  // N-ary tree example
  print('\n4. N-ARY TREE TRAVERSALS:');
  
  // Create n-ary tree
  //     A
  //   / | \
  //  B  C  D
  // /|  |  |\
  //E F  G  H I
  
  var naryRoot = GeneralTreeNode<String>('A');
  var nodeB = GeneralTreeNode<String>('B');
  var nodeC = GeneralTreeNode<String>('C');
  var nodeD = GeneralTreeNode<String>('D');
  var nodeE = GeneralTreeNode<String>('E');
  var nodeF = GeneralTreeNode<String>('F');
  var nodeG = GeneralTreeNode<String>('G');
  var nodeH = GeneralTreeNode<String>('H');
  var nodeI = GeneralTreeNode<String>('I');
  
  naryRoot.addChild(nodeB);
  naryRoot.addChild(nodeC);
  naryRoot.addChild(nodeD);
  nodeB.addChild(nodeE);
  nodeB.addChild(nodeF);
  nodeC.addChild(nodeG);
  nodeD.addChild(nodeH);
  nodeD.addChild(nodeI);
  
  print('\nN-ary Tree Pre-Order:');
  var naryPreOrder = TreeTraversal.naryPreOrder(naryRoot);
  print('Result: ${naryPreOrder.join(' → ')}');
  
  print('\nN-ary Tree Post-Order:');
  var naryPostOrder = TreeTraversal.naryPostOrder(naryRoot);
  print('Result: ${naryPostOrder.join(' → ')}');
  
  print('\nN-ary Tree Level-Order:');
  var naryLevelOrder = TreeTraversal.naryLevelOrder(naryRoot);
  print('Result: ${naryLevelOrder.join(' → ')}');
  
  print('\n' + '='*50);
  
  print('\n5. TRAVERSAL SUMMARY:');
  print('''
  Traversal Types and Their Uses:
  
  DEPTH-FIRST TRAVERSALS (DFS):
  ╔══════════════╦═══════════════════╦═══════════════════════════════╗
  ║ Traversal    ║ Order             ║ Common Use Cases              ║
  ╠══════════════╬═══════════════════╬═══════════════════════════════╣
  ║ In-Order     ║ Left→Root→Right   ║ BST sorted output, expression ║
  ║              ║                   ║ evaluation                    ║
  ╠══════════════╬═══════════════════╬═══════════════════════════════╣
  ║ Pre-Order    ║ Root→Left→Right   ║ Tree copying, prefix notation,║
  ║              ║                   ║ tree serialization           ║
  ╠══════════════╬═══════════════════╬═══════════════════════════════╣
  ║ Post-Order   ║ Left→Right→Root   ║ Tree deletion, postfix        ║
  ║              ║                   ║ notation, directory size      ║
  ╚══════════════╩═══════════════════╩═══════════════════════════════╝
  
  BREADTH-FIRST TRAVERSALS (BFS):
  ╔══════════════╦═══════════════════╦═══════════════════════════════╗
  ║ Traversal    ║ Order             ║ Common Use Cases              ║
  ╠══════════════╬═══════════════════╬═══════════════════════════════╣
  ║ Level-Order  ║ Level by level    ║ Shortest path, tree printing, ║
  ║              ║ left to right     ║ serialization                 ║
  ╚══════════════╩═══════════════════╩═══════════════════════════════╝
  
  TIME & SPACE COMPLEXITY:
  • All traversals: O(n) time, where n = number of nodes
  • Recursive: O(h) space for call stack, where h = height
  • Iterative: O(h) space for explicit stack/queue
  • Level-order: O(w) space, where w = maximum width
  
  IMPLEMENTATION APPROACHES:
  • Recursive: Clean, intuitive, uses call stack
  • Iterative: Explicit stack/queue, avoids recursion limits
  • Morris: O(1) space using threading (advanced)
  
  CHOOSING THE RIGHT TRAVERSAL:
  • Binary Search Tree operations → In-order
  • Tree copying/cloning → Pre-order
  • Tree deletion/cleanup → Post-order
  • Level-wise processing → Level-order
  • Shortest path algorithms → BFS/Level-order
  ''');
}
