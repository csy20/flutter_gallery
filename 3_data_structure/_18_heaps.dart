// Heap Data Structure Implementation in Dart
// A heap is a complete binary tree that satisfies the heap property
// Heap Property:
// - Max Heap: Parent >= Children (root is maximum)
// - Min Heap: Parent <= Children (root is minimum)

// Complete Binary Tree: All levels are filled except possibly the last level,
// which is filled from left to right

import 'dart:math';

// Generic Heap Implementation
class Heap<T extends Comparable<T>> {
  List<T> _heap = [];
  final bool _isMaxHeap;
  
  // Constructor: true for max heap, false for min heap
  Heap({bool isMaxHeap = true}) : _isMaxHeap = isMaxHeap;
  
  // Create heap from existing list
  Heap.fromList(List<T> list, {bool isMaxHeap = true}) : _isMaxHeap = isMaxHeap {
    _heap = List.from(list);
    _buildHeap();
  }
  
  // Getters
  int get size => _heap.length;
  bool get isEmpty => _heap.isEmpty;
  bool get isNotEmpty => _heap.isNotEmpty;
  T? get peek => isEmpty ? null : _heap[0]; // Get root without removing
  
  // Helper methods for array-based heap representation
  int _parent(int index) => (index - 1) ~/ 2;
  int _leftChild(int index) => 2 * index + 1;
  int _rightChild(int index) => 2 * index + 2;
  
  // Check if parent should come before child based on heap type
  bool _shouldSwap(T parent, T child) {
    if (_isMaxHeap) {
      return parent.compareTo(child) < 0; // parent < child in max heap
    } else {
      return parent.compareTo(child) > 0; // parent > child in min heap
    }
  }
  
  // Insert element into heap
  void insert(T element) {
    _heap.add(element);
    _heapifyUp(_heap.length - 1);
  }
  
  // Remove and return root element (max/min)
  T? extract() {
    if (isEmpty) return null;
    
    T root = _heap[0];
    
    // Move last element to root and remove last
    _heap[0] = _heap.last;
    _heap.removeLast();
    
    // Restore heap property from root
    if (isNotEmpty) {
      _heapifyDown(0);
    }
    
    return root;
  }
  
  // Remove specific element
  bool remove(T element) {
    int index = _heap.indexOf(element);
    if (index == -1) return false;
    
    // Replace with last element
    _heap[index] = _heap.last;
    _heap.removeLast();
    
    if (index < _heap.length) {
      // Try both directions to maintain heap property
      _heapifyUp(index);
      _heapifyDown(index);
    }
    
    return true;
  }
  
  // Heapify up (bubble up) - restore heap property upward
  void _heapifyUp(int index) {
    while (index > 0) {
      int parentIndex = _parent(index);
      
      if (!_shouldSwap(_heap[parentIndex], _heap[index])) {
        break; // Heap property satisfied
      }
      
      _swap(parentIndex, index);
      index = parentIndex;
    }
  }
  
  // Heapify down (bubble down) - restore heap property downward
  void _heapifyDown(int index) {
    while (true) {
      int targetIndex = index;
      int leftIndex = _leftChild(index);
      int rightIndex = _rightChild(index);
      
      // Find the appropriate child to swap with
      if (leftIndex < _heap.length && 
          _shouldSwap(_heap[targetIndex], _heap[leftIndex])) {
        targetIndex = leftIndex;
      }
      
      if (rightIndex < _heap.length && 
          _shouldSwap(_heap[targetIndex], _heap[rightIndex])) {
        targetIndex = rightIndex;
      }
      
      if (targetIndex == index) {
        break; // Heap property satisfied
      }
      
      _swap(index, targetIndex);
      index = targetIndex;
    }
  }
  
  // Build heap from existing array (heapify)
  void _buildHeap() {
    // Start from last non-leaf node and heapify down
    for (int i = (_heap.length ~/ 2) - 1; i >= 0; i--) {
      _heapifyDown(i);
    }
  }
  
  // Swap elements at two indices
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
  
  // Convert heap to sorted list (heap sort)
  List<T> heapSort() {
    List<T> originalHeap = List.from(_heap);
    List<T> sorted = [];
    
    while (isNotEmpty) {
      T? element = extract();
      if (element != null) sorted.add(element);
    }
    
    // Restore original heap
    _heap = originalHeap;
    _buildHeap();
    
    return sorted;
  }
  
  // Check if heap property is satisfied
  bool isValidHeap() {
    for (int i = 0; i < _heap.length; i++) {
      int leftIndex = _leftChild(i);
      int rightIndex = _rightChild(i);
      
      if (leftIndex < _heap.length && 
          _shouldSwap(_heap[i], _heap[leftIndex])) {
        return false;
      }
      
      if (rightIndex < _heap.length && 
          _shouldSwap(_heap[i], _heap[rightIndex])) {
        return false;
      }
    }
    return true;
  }
  
  // Display heap as tree structure
  void displayTree() {
    if (isEmpty) {
      print('Heap is empty');
      return;
    }
    
    int height = (log(_heap.length) / log(2)).floor() + 1;
    int maxWidth = (1 << height) - 1;
    
    for (int level = 0; level < height; level++) {
      int levelStart = (1 << level) - 1;
      int levelEnd = min((1 << (level + 1)) - 1, _heap.length);
      
      // Calculate spacing
      int spacing = maxWidth ~/ (1 << level);
      int padding = spacing ~/ 2;
      
      // Print leading spaces
      print(' ' * padding, end: '');
      
      // Print elements at current level
      for (int i = levelStart; i < levelEnd; i++) {
        print('${_heap[i]}', end: '');
        if (i < levelEnd - 1) {
          print(' ' * spacing, end: '');
        }
      }
      print(''); // New line
    }
  }
  
  // Get heap as list (for debugging)
  List<T> toList() => List.from(_heap);
  
  @override
  String toString() => _heap.toString();
}

// Priority Queue implementation using heap
class PriorityQueue<T extends Comparable<T>> {
  final Heap<T> _heap;
  
  PriorityQueue({bool isMaxPriority = true}) : _heap = Heap<T>(isMaxHeap: isMaxPriority);
  
  void enqueue(T element) => _heap.insert(element);
  T? dequeue() => _heap.extract();
  T? peek() => _heap.peek;
  bool get isEmpty => _heap.isEmpty;
  int get size => _heap.size;
}

// Custom object for priority queue example
class Task implements Comparable<Task> {
  final String name;
  final int priority;
  
  Task(this.name, this.priority);
  
  @override
  int compareTo(Task other) => priority.compareTo(other.priority);
  
  @override
  String toString() => '$name(P:$priority)';
}

// Demonstration and Examples
void main() {
  print('=== Heap Data Structure in Dart ===\n');
  
  // Max Heap Example
  print('1. Max Heap Example:');
  var maxHeap = Heap<int>(isMaxHeap: true);
  
  // Insert elements
  [10, 20, 15, 30, 40].forEach(maxHeap.insert);
  
  print('Max heap after insertions: ${maxHeap.toList()}');
  print('Max element (peek): ${maxHeap.peek}');
  print('Is valid heap: ${maxHeap.isValidHeap()}');
  
  print('\nExtracting elements from max heap:');
  while (maxHeap.isNotEmpty) {
    print('Extracted: ${maxHeap.extract()}');
  }
  
  print('\n' + '='*50);
  
  // Min Heap Example
  print('\n2. Min Heap Example:');
  var minHeap = Heap<int>(isMaxHeap: false);
  
  [30, 10, 20, 40, 15].forEach(minHeap.insert);
  
  print('Min heap after insertions: ${minHeap.toList()}');
  print('Min element (peek): ${minHeap.peek}');
  
  print('\nExtracting elements from min heap:');
  while (minHeap.isNotEmpty) {
    print('Extracted: ${minHeap.extract()}');
  }
  
  print('\n' + '='*50);
  
  // Build heap from existing list
  print('\n3. Building Heap from List:');
  var listHeap = Heap<int>.fromList([50, 30, 20, 15, 10, 8, 16], isMaxHeap: true);
  
  print('Original list: [50, 30, 20, 15, 10, 8, 16]');
  print('Max heap built: ${listHeap.toList()}');
  print('Is valid heap: ${listHeap.isValidHeap()}');
  
  print('\n' + '='*50);
  
  // Heap Sort Example
  print('\n4. Heap Sort Example:');
  var sortHeap = Heap<int>.fromList([64, 34, 25, 12, 22, 11, 90], isMaxHeap: true);
  
  print('Original array: [64, 34, 25, 12, 22, 11, 90]');
  var sorted = sortHeap.heapSort();
  print('Sorted (descending): $sorted');
  
  // For ascending order, use min heap
  var minSortHeap = Heap<int>.fromList([64, 34, 25, 12, 22, 11, 90], isMaxHeap: false);
  var ascendingSorted = minSortHeap.heapSort();
  print('Sorted (ascending): $ascendingSorted');
  
  print('\n' + '='*50);
  
  // Priority Queue Example
  print('\n5. Priority Queue Example:');
  var taskQueue = PriorityQueue<Task>(isMaxPriority: true);
  
  // Add tasks with different priorities
  taskQueue.enqueue(Task('Low Priority Task', 1));
  taskQueue.enqueue(Task('High Priority Task', 5));
  taskQueue.enqueue(Task('Medium Priority Task', 3));
  taskQueue.enqueue(Task('Critical Task', 10));
  taskQueue.enqueue(Task('Normal Task', 2));
  
  print('Processing tasks by priority:');
  while (taskQueue.isNotEmpty) {
    var task = taskQueue.dequeue();
    print('Processing: $task');
  }
  
  print('\n' + '='*50);
  
  // Tree visualization example
  print('\n6. Heap Tree Visualization:');
  var visualHeap = Heap<int>(isMaxHeap: true);
  [50, 30, 40, 10, 20, 35, 25].forEach(visualHeap.insert);
  
  print('Heap array representation: ${visualHeap.toList()}');
  print('Tree structure:');
  visualHeap.displayTree();
  
  print('\n' + '='*50);
  
  // Heap Concepts Summary
  print('\n7. Heap Concepts Summary:');
  print('''
  Heap Properties:
  - Complete binary tree structure
  - Heap property: parent-child relationship maintained
  - Efficient array representation
  - Root contains max/min element
  
  Types of Heaps:
  - Max Heap: Parent >= Children
  - Min Heap: Parent <= Children
  - Binary Heap: Each node has at most 2 children
  
  Array Representation:
  - Root at index 0
  - For node at index i:
    * Left child: 2*i + 1
    * Right child: 2*i + 2
    * Parent: (i-1)/2
  
  Time Complexities:
  - Insert: O(log n)
  - Extract Max/Min: O(log n)
  - Peek: O(1)
  - Build Heap: O(n)
  - Heap Sort: O(n log n)
  
  Applications:
  - Priority Queues
  - Heap Sort algorithm
  - Dijkstra's shortest path
  - Huffman coding
  - Memory management
  - Job scheduling systems
  
  Space Complexity: O(n)
  ''');
}
