/*
  BINARY TREE CONCEPT IN DART
  
  A Binary Tree is a hierarchical data structure where each node has at most two children,
  referred to as the left child and the right child.
  
  Key Properties:
  1. Each node has at most 2 children
  2. The topmost node is called the root
  3. Nodes with no children are called leaves
  4. The height of a tree is the longest path from root to leaf
  
  Types of Binary Trees:
  1. Full Binary Tree: Every node has either 0 or 2 children
  2. Complete Binary Tree: All levels are filled except possibly the last level
  3. Perfect Binary Tree: All internal nodes have 2 children and all leaves are at same level
  4. Binary Search Tree (BST): Left child < parent < right child
*/

// Node class representing each element in the binary tree
class TreeNode {
  int data;
  TreeNode? left;
  TreeNode? right;
  
  TreeNode(this.data);
  
  @override
  String toString() => 'TreeNode($data)';
}

// Binary Tree class with various operations
class BinaryTree {
  TreeNode? root;
  
  BinaryTree({this.root});
  
  // Insert a new value into the binary tree (level-order insertion)
  void insert(int value) {
    TreeNode newNode = TreeNode(value);
    
    if (root == null) {
      root = newNode;
      return;
    }
    
    // Use queue for level-order insertion
    List<TreeNode> queue = [root!];
    
    while (queue.isNotEmpty) {
      TreeNode current = queue.removeAt(0);
      
      if (current.left == null) {
        current.left = newNode;
        break;
      } else if (current.right == null) {
        current.right = newNode;
        break;
      } else {
        queue.add(current.left!);
        queue.add(current.right!);
      }
    }
  }
  
  // TREE TRAVERSAL METHODS
  
  // 1. Inorder Traversal (Left -> Root -> Right)
  List<int> inorderTraversal([TreeNode? node]) {
    node ??= root;
    List<int> result = [];
    
    if (node != null) {
      result.addAll(inorderTraversal(node.left));
      result.add(node.data);
      result.addAll(inorderTraversal(node.right));
    }
    
    return result;
  }
  
  // 2. Preorder Traversal (Root -> Left -> Right)
  List<int> preorderTraversal([TreeNode? node]) {
    node ??= root;
    List<int> result = [];
    
    if (node != null) {
      result.add(node.data);
      result.addAll(preorderTraversal(node.left));
      result.addAll(preorderTraversal(node.right));
    }
    
    return result;
  }
  
  // 3. Postorder Traversal (Left -> Right -> Root)
  List<int> postorderTraversal([TreeNode? node]) {
    node ??= root;
    List<int> result = [];
    
    if (node != null) {
      result.addAll(postorderTraversal(node.left));
      result.addAll(postorderTraversal(node.right));
      result.add(node.data);
    }
    
    return result;
  }
  
  // 4. Level Order Traversal (Breadth-First Search)
  List<int> levelOrderTraversal() {
    if (root == null) return [];
    
    List<int> result = [];
    List<TreeNode> queue = [root!];
    
    while (queue.isNotEmpty) {
      TreeNode current = queue.removeAt(0);
      result.add(current.data);
      
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    
    return result;
  }
  
  // Search for a value in the tree
  bool search(int value, [TreeNode? node]) {
    node ??= root;
    
    if (node == null) return false;
    if (node.data == value) return true;
    
    return search(value, node.left) || search(value, node.right);
  }
  
  // Calculate the height of the tree
  int height([TreeNode? node]) {
    node ??= root;
    
    if (node == null) return -1;
    
    int leftHeight = height(node.left);
    int rightHeight = height(node.right);
    
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
  }
  
  // Count total number of nodes
  int countNodes([TreeNode? node]) {
    node ??= root;
    
    if (node == null) return 0;
    
    return 1 + countNodes(node.left) + countNodes(node.right);
  }
  
  // Count leaf nodes (nodes with no children)
  int countLeaves([TreeNode? node]) {
    node ??= root;
    
    if (node == null) return 0;
    if (node.left == null && node.right == null) return 1;
    
    return countLeaves(node.left) + countLeaves(node.right);
  }
  
  // Find the maximum value in the tree
  int? findMax([TreeNode? node]) {
    node ??= root;
    
    if (node == null) return null;
    
    int maxValue = node.data;
    int? leftMax = findMax(node.left);
    int? rightMax = findMax(node.right);
    
    if (leftMax != null && leftMax > maxValue) maxValue = leftMax;
    if (rightMax != null && rightMax > maxValue) maxValue = rightMax;
    
    return maxValue;
  }
  
  // Find the minimum value in the tree
  int? findMin([TreeNode? node]) {
    node ??= root;
    
    if (node == null) return null;
    
    int minValue = node.data;
    int? leftMin = findMin(node.left);
    int? rightMin = findMin(node.right);
    
    if (leftMin != null && leftMin < minValue) minValue = leftMin;
    if (rightMin != null && rightMin < minValue) minValue = rightMin;
    
    return minValue;
  }
  
  // Check if the tree is symmetric (mirror image of itself)
  bool isSymmetric() {
    return _isMirror(root, root);
  }
  
  bool _isMirror(TreeNode? node1, TreeNode? node2) {
    if (node1 == null && node2 == null) return true;
    if (node1 == null || node2 == null) return false;
    
    return (node1.data == node2.data) &&
           _isMirror(node1.left, node2.right) &&
           _isMirror(node1.right, node2.left);
  }
  
  // Print tree structure (simple visualization)
  void printTree([TreeNode? node, String prefix = "", bool isLast = true]) {
    node ??= root;
    
    if (node != null) {
      print(prefix + (isLast ? "└── " : "├── ") + node.data.toString());
      
      List<TreeNode?> children = [node.left, node.right];
      for (int i = 0; i < children.length; i++) {
        TreeNode? child = children[i];
        if (child != null) {
          bool isLastChild = (i == children.length - 1) || 
                           children.skip(i + 1).every((c) => c == null);
          printTree(child, prefix + (isLast ? "    " : "│   "), isLastChild);
        }
      }
    }
  }
}

// Binary Search Tree (BST) - A special type of binary tree
class BinarySearchTree extends BinaryTree {
  
  // Insert maintaining BST property (left < root < right)
  @override
  void insert(int value) {
    root = _insertBST(root, value);
  }
  
  TreeNode _insertBST(TreeNode? node, int value) {
    if (node == null) return TreeNode(value);
    
    if (value < node.data) {
      node.left = _insertBST(node.left, value);
    } else if (value > node.data) {
      node.right = _insertBST(node.right, value);
    }
    // If value equals node.data, we don't insert (no duplicates)
    
    return node;
  }
  
  // Efficient search in BST
  @override
  bool search(int value, [TreeNode? node]) {
    node ??= root;
    
    if (node == null) return false;
    if (node.data == value) return true;
    
    if (value < node.data) {
      return search(value, node.left);
    } else {
      return search(value, node.right);
    }
  }
  
  // Delete a node from BST
  TreeNode? delete(TreeNode? node, int value) {
    if (node == null) return null;
    
    if (value < node.data) {
      node.left = delete(node.left, value);
    } else if (value > node.data) {
      node.right = delete(node.right, value);
    } else {
      // Node to be deleted found
      
      // Case 1: Node has no children (leaf node)
      if (node.left == null && node.right == null) {
        return null;
      }
      
      // Case 2: Node has one child
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;
      
      // Case 3: Node has two children
      // Find inorder successor (smallest in right subtree)
      TreeNode successor = _findMin(node.right!);
      node.data = successor.data;
      node.right = delete(node.right, successor.data);
    }
    
    return node;
  }
  
  TreeNode _findMin(TreeNode node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }
  
  // Check if the tree is a valid BST
  bool isValidBST() {
    return _isValidBSTHelper(root, null, null);
  }
  
  bool _isValidBSTHelper(TreeNode? node, int? min, int? max) {
    if (node == null) return true;
    
    if ((min != null && node.data <= min) || 
        (max != null && node.data >= max)) {
      return false;
    }
    
    return _isValidBSTHelper(node.left, min, node.data) &&
           _isValidBSTHelper(node.right, node.data, max);
  }
}

// Example usage and demonstrations
void main() {
  print("=== BINARY TREE CONCEPTS IN DART ===\n");
  
  // 1. Basic Binary Tree Operations
  print("1. Creating a Basic Binary Tree:");
  BinaryTree tree = BinaryTree();
  
  // Insert values: 1, 2, 3, 4, 5, 6, 7
  List<int> values = [1, 2, 3, 4, 5, 6, 7];
  for (int value in values) {
    tree.insert(value);
  }
  
  print("Tree structure:");
  tree.printTree();
  
  print("\n2. Tree Traversals:");
  print("Inorder (L-Root-R):   ${tree.inorderTraversal()}");
  print("Preorder (Root-L-R):  ${tree.preorderTraversal()}");
  print("Postorder (L-R-Root): ${tree.postorderTraversal()}");
  print("Level Order (BFS):    ${tree.levelOrderTraversal()}");
  
  print("\n3. Tree Properties:");
  print("Height: ${tree.height()}");
  print("Total nodes: ${tree.countNodes()}");
  print("Leaf nodes: ${tree.countLeaves()}");
  print("Maximum value: ${tree.findMax()}");
  print("Minimum value: ${tree.findMin()}");
  print("Contains 5? ${tree.search(5)}");
  print("Contains 10? ${tree.search(10)}");
  print("Is symmetric? ${tree.isSymmetric()}");
  
  print("\n" + "="*50);
  
  // 2. Binary Search Tree Operations
  print("\n4. Binary Search Tree (BST):");
  BinarySearchTree bst = BinarySearchTree();
  
  // Insert values: 50, 30, 70, 20, 40, 60, 80
  List<int> bstValues = [50, 30, 70, 20, 40, 60, 80];
  for (int value in bstValues) {
    bst.insert(value);
  }
  
  print("BST structure:");
  bst.printTree();
  
  print("\nBST Inorder traversal (should be sorted): ${bst.inorderTraversal()}");
  print("Is valid BST? ${bst.isValidBST()}");
  
  print("\nSearching in BST:");
  print("Contains 40? ${bst.search(40)}");
  print("Contains 45? ${bst.search(45)}");
  
  print("\n5. Tree Complexity Analysis:");
  print("Binary Tree Operations:");
  print("  - Search: O(n) - worst case");
  print("  - Insert: O(n) - for level-order insertion");
  print("  - Traversal: O(n)");
  print("  - Space: O(h) where h is height");
  
  print("\nBinary Search Tree Operations:");
  print("  - Search: O(log n) average, O(n) worst case");
  print("  - Insert: O(log n) average, O(n) worst case");
  print("  - Delete: O(log n) average, O(n) worst case");
  print("  - Space: O(h) where h is height");
  
  print("\n6. Applications of Binary Trees:");
  print("  - Expression parsing");
  print("  - Huffman coding");
  print("  - File systems");
  print("  - Database indexing");
  print("  - Decision trees");
  print("  - Game trees");
}