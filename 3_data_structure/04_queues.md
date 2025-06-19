# Queue Data Structure - Complete Guide

A **Queue** is a linear data structure that follows the **FIFO (First In, First Out)** principle. The element that is inserted first is the first one to be removed. Think of it like a line of people waiting - the first person in line is the first to be served.

## Table of Contents
1. [Basic Concepts](#basic-concepts)
2. [Queue Operations](#queue-operations)
3. [Implementation Methods](#implementation-methods)
4. [Array-based Queue](#array-based-queue)
5. [Circular Queue](#circular-queue)
6. [Linked List-based Queue](#linked-list-based-queue)
7. [Double-ended Queue (Deque)](#double-ended-queue-deque)
8. [Priority Queue](#priority-queue)
9. [Applications](#applications)
10. [Practice Problems](#practice-problems)

---

## Basic Concepts

### Key Characteristics:
- **FIFO Principle**: First In, First Out
- **Front**: The first element (oldest)
- **Rear**: The last element (newest)
- **Enqueue**: Add element to rear
- **Dequeue**: Remove element from front

### Visual Representation:
```
Front                           Rear
  |                               |
  v                               v
[1] [2] [3] [4] [5] <- enqueue
  ^
  |
dequeue
```

---

## Queue Operations

### Primary Operations:
1. **Enqueue**: Add an element to the rear
2. **Dequeue**: Remove and return the front element
3. **Front/Peek**: View the front element without removing it
4. **isEmpty**: Check if the queue is empty
5. **Size**: Get the number of elements

### Secondary Operations:
- **Clear**: Remove all elements
- **Display**: Show all elements
- **isFull**: Check if queue is full (for fixed-size queues)

---

## Implementation Methods

There are several ways to implement a queue in Dart:

1. **Array-based**: Using fixed-size array
2. **Circular Queue**: Efficient array-based implementation
3. **Linked List-based**: Using dynamic nodes
4. **Built-in List**: Using Dart's List class
5. **Double-ended Queue**: Queue with operations at both ends

---

## Array-based Queue

### Simple Array Queue

```dart
class ArrayQueue<T> {
  late List<T?> _queue;
  int _front = 0;
  int _rear = -1;
  int _size = 0;
  final int _maxSize;
  
  // Constructor
  ArrayQueue(this._maxSize) {
    _queue = List.filled(_maxSize, null);
  }
  
  // Check if queue is empty
  bool get isEmpty => _size == 0;
  
  // Check if queue is full
  bool get isFull => _size == _maxSize;
  
  // Get current size
  int get size => _size;
  
  // Get maximum capacity
  int get capacity => _maxSize;
  
  // Enqueue operation - O(1)
  bool enqueue(T element) {
    if (isFull) {
      print('Queue Overflow: Cannot enqueue $element');
      return false;
    }
    
    _rear = (_rear + 1) % _maxSize;
    _queue[_rear] = element;
    _size++;
    return true;
  }
  
  // Dequeue operation - O(1)
  T? dequeue() {
    if (isEmpty) {
      print('Queue Underflow: Cannot dequeue from empty queue');
      return null;
    }
    
    T? element = _queue[_front];
    _queue[_front] = null;
    _front = (_front + 1) % _maxSize;
    _size--;
    return element;
  }
  
  // Peek front element - O(1)
  T? front() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _queue[_front];
  }
  
  // Peek rear element - O(1)
  T? rear() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _queue[_rear];
  }
  
  // Clear all elements - O(1)
  void clear() {
    _front = 0;
    _rear = -1;
    _size = 0;
    _queue.fillRange(0, _maxSize, null);
  }
  
  // Display queue contents - O(n)
  void display() {
    if (isEmpty) {
      print('Queue is empty');
      return;
    }
    
    print('Queue contents (front to rear):');
    List<String> elements = [];
    int current = _front;
    
    for (int i = 0; i < _size; i++) {
      elements.add(_queue[current].toString());
      current = (current + 1) % _maxSize;
    }
    
    print('Front <- [${elements.join(', ')}] <- Rear');
  }
  
  // Convert to list - O(n)
  List<T> toList() {
    List<T> result = [];
    int current = _front;
    
    for (int i = 0; i < _size; i++) {
      result.add(_queue[current]!);
      current = (current + 1) % _maxSize;
    }
    return result;
  }
  
  @override
  String toString() {
    if (isEmpty) return 'Queue: []';
    return 'Queue: [${toList().join(', ')}] (front to rear)';
  }
}
```

---

## Circular Queue

### Optimized Circular Implementation

```dart
class CircularQueue<T> {
  late List<T?> _queue;
  int _front = -1;
  int _rear = -1;
  final int _maxSize;
  
  // Constructor
  CircularQueue(this._maxSize) {
    _queue = List.filled(_maxSize, null);
  }
  
  // Check if queue is empty
  bool get isEmpty => _front == -1;
  
  // Check if queue is full
  bool get isFull => (_rear + 1) % _maxSize == _front;
  
  // Get current size
  int get size {
    if (isEmpty) return 0;
    if (_rear >= _front) {
      return _rear - _front + 1;
    } else {
      return _maxSize - _front + _rear + 1;
    }
  }
  
  // Enqueue operation - O(1)
  bool enqueue(T element) {
    if (isFull) {
      print('Queue Overflow: Cannot enqueue $element');
      return false;
    }
    
    if (isEmpty) {
      _front = _rear = 0;
    } else {
      _rear = (_rear + 1) % _maxSize;
    }
    
    _queue[_rear] = element;
    return true;
  }
  
  // Dequeue operation - O(1)
  T? dequeue() {
    if (isEmpty) {
      print('Queue Underflow: Cannot dequeue from empty queue');
      return null;
    }
    
    T? element = _queue[_front];
    _queue[_front] = null;
    
    if (_front == _rear) {
      // Queue becomes empty
      _front = _rear = -1;
    } else {
      _front = (_front + 1) % _maxSize;
    }
    
    return element;
  }
  
  // Peek front element - O(1)
  T? front() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _queue[_front];
  }
  
  // Peek rear element - O(1)
  T? rear() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _queue[_rear];
  }
  
  // Display queue contents - O(n)
  void display() {
    if (isEmpty) {
      print('Circular Queue is empty');
      return;
    }
    
    print('Circular Queue contents:');
    List<String> elements = [];
    int current = _front;
    
    do {
      elements.add(_queue[current].toString());
      current = (current + 1) % _maxSize;
    } while (current != (_rear + 1) % _maxSize);
    
    print('Front <- [${elements.join(', ')}] <- Rear');
    print('Front index: $_front, Rear index: $_rear');
  }
  
  @override
  String toString() {
    if (isEmpty) return 'CircularQueue: []';
    
    List<String> elements = [];
    int current = _front;
    
    do {
      elements.add(_queue[current].toString());
      current = (current + 1) % _maxSize;
    } while (current != (_rear + 1) % _maxSize);
    
    return 'CircularQueue: [${elements.join(', ')}]';
  }
}
```

---

## Linked List-based Queue

### Node Class

```dart
class QueueNode<T> {
  T data;
  QueueNode<T>? next;
  
  QueueNode(this.data, [this.next]);
  
  @override
  String toString() => data.toString();
}
```

### Dynamic Queue Implementation

```dart
class LinkedQueue<T> {
  QueueNode<T>? _front;
  QueueNode<T>? _rear;
  int _size = 0;
  
  // Check if queue is empty
  bool get isEmpty => _front == null;
  
  // Get current size
  int get size => _size;
  
  // Enqueue operation - O(1)
  void enqueue(T element) {
    QueueNode<T> newNode = QueueNode(element);
    
    if (isEmpty) {
      _front = _rear = newNode;
    } else {
      _rear!.next = newNode;
      _rear = newNode;
    }
    _size++;
  }
  
  // Dequeue operation - O(1)
  T? dequeue() {
    if (isEmpty) {
      print('Queue Underflow: Cannot dequeue from empty queue');
      return null;
    }
    
    T data = _front!.data;
    _front = _front!.next;
    
    if (_front == null) {
      _rear = null; // Queue becomes empty
    }
    
    _size--;
    return data;
  }
  
  // Peek front element - O(1)
  T? front() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _front!.data;
  }
  
  // Peek rear element - O(1)
  T? rear() {
    if (isEmpty) {
      print('Queue is empty');
      return null;
    }
    return _rear!.data;
  }
  
  // Clear all elements - O(1)
  void clear() {
    _front = _rear = null;
    _size = 0;
  }
  
  // Display queue contents - O(n)
  void display() {
    if (isEmpty) {
      print('Queue is empty');
      return;
    }
    
    print('Queue contents (front to rear):');
    List<String> elements = [];
    QueueNode<T>? current = _front;
    
    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }
    
    print('Front <- [${elements.join(', ')}] <- Rear');
  }
  
  // Search for an element - O(n)
  bool contains(T element) {
    QueueNode<T>? current = _front;
    
    while (current != null) {
      if (current.data == element) return true;
      current = current.next;
    }
    return false;
  }
  
  // Convert to list - O(n)
  List<T> toList() {
    List<T> result = [];
    QueueNode<T>? current = _front;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
  
  @override
  String toString() {
    if (isEmpty) return 'Queue: []';
    return 'Queue: [${toList().join(', ')}] (front to rear)';
  }
}
```

---

## Double-ended Queue (Deque)

### Deque Implementation

```dart
class Deque<T> {
  QueueNode<T>? _front;
  QueueNode<T>? _rear;
  int _size = 0;
  
  // Check if deque is empty
  bool get isEmpty => _front == null;
  
  // Get current size
  int get size => _size;
  
  // Add element to front - O(1)
  void addFront(T element) {
    QueueNode<T> newNode = QueueNode(element);
    
    if (isEmpty) {
      _front = _rear = newNode;
    } else {
      newNode.next = _front;
      _front = newNode;
    }
    _size++;
  }
  
  // Add element to rear - O(1)
  void addRear(T element) {
    QueueNode<T> newNode = QueueNode(element);
    
    if (isEmpty) {
      _front = _rear = newNode;
    } else {
      _rear!.next = newNode;
      _rear = newNode;
    }
    _size++;
  }
  
  // Remove element from front - O(1)
  T? removeFront() {
    if (isEmpty) {
      print('Deque Underflow: Cannot remove from empty deque');
      return null;
    }
    
    T data = _front!.data;
    _front = _front!.next;
    
    if (_front == null) {
      _rear = null;
    }
    
    _size--;
    return data;
  }
  
  // Remove element from rear - O(n) for singly linked list
  T? removeRear() {
    if (isEmpty) {
      print('Deque Underflow: Cannot remove from empty deque');
      return null;
    }
    
    if (_front == _rear) {
      // Only one element
      T data = _rear!.data;
      _front = _rear = null;
      _size--;
      return data;
    }
    
    // Find second last node
    QueueNode<T> current = _front!;
    while (current.next != _rear) {
      current = current.next!;
    }
    
    T data = _rear!.data;
    _rear = current;
    _rear!.next = null;
    _size--;
    return data;
  }
  
  // Peek front element - O(1)
  T? peekFront() {
    if (isEmpty) return null;
    return _front!.data;
  }
  
  // Peek rear element - O(1)
  T? peekRear() {
    if (isEmpty) return null;
    return _rear!.data;
  }
  
  // Display deque contents - O(n)
  void display() {
    if (isEmpty) {
      print('Deque is empty');
      return;
    }
    
    List<String> elements = [];
    QueueNode<T>? current = _front;
    
    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }
    
    print('Front <- [${elements.join(', ')}] <- Rear');
  }
  
  @override
  String toString() {
    if (isEmpty) return 'Deque: []';
    return 'Deque: [${toList().join(', ')}]';
  }
  
  List<T> toList() {
    List<T> result = [];
    QueueNode<T>? current = _front;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
}
```

---

## Priority Queue

### Priority Queue Node

```dart
class PriorityNode<T> {
  T data;
  int priority;
  PriorityNode<T>? next;
  
  PriorityNode(this.data, this.priority, [this.next]);
  
  @override
  String toString() => '($data, priority: $priority)';
}
```

### Priority Queue Implementation

```dart
class PriorityQueue<T> {
  PriorityNode<T>? _head;
  int _size = 0;
  
  // Check if priority queue is empty
  bool get isEmpty => _head == null;
  
  // Get current size
  int get size => _size;
  
  // Enqueue with priority - O(n)
  void enqueue(T element, int priority) {
    PriorityNode<T> newNode = PriorityNode(element, priority);
    
    // If queue is empty or new node has higher priority than head
    if (_head == null || priority > _head!.priority) {
      newNode.next = _head;
      _head = newNode;
    } else {
      // Find the correct position to insert
      PriorityNode<T> current = _head!;
      while (current.next != null && current.next!.priority >= priority) {
        current = current.next!;
      }
      newNode.next = current.next;
      current.next = newNode;
    }
    _size++;
  }
  
  // Dequeue highest priority element - O(1)
  T? dequeue() {
    if (isEmpty) {
      print('Priority Queue Underflow: Cannot dequeue from empty queue');
      return null;
    }
    
    T data = _head!.data;
    _head = _head!.next;
    _size--;
    return data;
  }
  
  // Peek highest priority element - O(1)
  T? peek() {
    if (isEmpty) {
      print('Priority Queue is empty');
      return null;
    }
    return _head!.data;
  }
  
  // Get priority of front element - O(1)
  int? frontPriority() {
    if (isEmpty) return null;
    return _head!.priority;
  }
  
  // Clear all elements - O(1)
  void clear() {
    _head = null;
    _size = 0;
  }
  
  // Display priority queue contents - O(n)
  void display() {
    if (isEmpty) {
      print('Priority Queue is empty');
      return;
    }
    
    print('Priority Queue contents (highest to lowest priority):');
    List<String> elements = [];
    PriorityNode<T>? current = _head;
    
    while (current != null) {
      elements.add(current.toString());
      current = current.next;
    }
    
    print('[${elements.join(', ')}]');
  }
  
  // Search for an element - O(n)
  bool contains(T element) {
    PriorityNode<T>? current = _head;
    
    while (current != null) {
      if (current.data == element) return true;
      current = current.next;
    }
    return false;
  }
  
  // Convert to list of data - O(n)
  List<T> toList() {
    List<T> result = [];
    PriorityNode<T>? current = _head;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
  
  // Convert to list of (data, priority) pairs - O(n)
  List<Map<String, dynamic>> toDetailedList() {
    List<Map<String, dynamic>> result = [];
    PriorityNode<T>? current = _head;
    
    while (current != null) {
      result.add({
        'data': current.data,
        'priority': current.priority,
      });
      current = current.next;
    }
    return result;
  }
  
  @override
  String toString() {
    if (isEmpty) return 'PriorityQueue: []';
    
    List<String> elements = [];
    PriorityNode<T>? current = _head;
    
    while (current != null) {
      elements.add(current.toString());
      current = current.next;
    }
    
    return 'PriorityQueue: [${elements.join(', ')}]';
  }
}
```

### Min-Heap Based Priority Queue

```dart
class HeapPriorityQueue<T> {
  List<Map<String, dynamic>> _heap = [];
  
  // Check if priority queue is empty
  bool get isEmpty => _heap.isEmpty;
  
  // Get current size
  int get size => _heap.length;
  
  // Get parent index
  int _parent(int index) => (index - 1) ~/ 2;
  
  // Get left child index
  int _leftChild(int index) => 2 * index + 1;
  
  // Get right child index
  int _rightChild(int index) => 2 * index + 2;
  
  // Swap two elements
  void _swap(int i, int j) {
    Map<String, dynamic> temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
  
  // Heapify up (for min-heap: higher priority = lower number)
  void _heapifyUp(int index) {
    if (index == 0) return;
    
    int parentIndex = _parent(index);
    if (_heap[index]['priority'] < _heap[parentIndex]['priority']) {
      _swap(index, parentIndex);
      _heapifyUp(parentIndex);
    }
  }
  
  // Heapify down
  void _heapifyDown(int index) {
    int smallest = index;
    int left = _leftChild(index);
    int right = _rightChild(index);
    
    if (left < _heap.length && 
        _heap[left]['priority'] < _heap[smallest]['priority']) {
      smallest = left;
    }
    
    if (right < _heap.length && 
        _heap[right]['priority'] < _heap[smallest]['priority']) {
      smallest = right;
    }
    
    if (smallest != index) {
      _swap(index, smallest);
      _heapifyDown(smallest);
    }
  }
  
  // Enqueue with priority - O(log n)
  void enqueue(T element, int priority) {
    _heap.add({
      'data': element,
      'priority': priority,
    });
    _heapifyUp(_heap.length - 1);
  }
  
  // Dequeue highest priority element - O(log n)
  T? dequeue() {
    if (isEmpty) {
      print('Priority Queue Underflow: Cannot dequeue from empty queue');
      return null;
    }
    
    if (_heap.length == 1) {
      return _heap.removeLast()['data'];
    }
    
    T data = _heap[0]['data'];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    return data;
  }
  
  // Peek highest priority element - O(1)
  T? peek() {
    if (isEmpty) return null;
    return _heap[0]['data'];
  }
  
  // Get priority of front element - O(1)
  int? frontPriority() {
    if (isEmpty) return null;
    return _heap[0]['priority'];
  }
  
  // Display heap structure - O(n)
  void display() {
    if (isEmpty) {
      print('Heap Priority Queue is empty');
      return;
    }
    
    print('Heap Priority Queue contents:');
    for (int i = 0; i < _heap.length; i++) {
      print('[$i] ${_heap[i]['data']} (priority: ${_heap[i]['priority']})');
    }
  }
  
  @override
  String toString() {
    if (isEmpty) return 'HeapPriorityQueue: []';
    
    List<String> elements = [];
    for (var item in _heap) {
      elements.add('(${item['data']}, p:${item['priority']})');
    }
    
    return 'HeapPriorityQueue: [${elements.join(', ')}]';
  }
}
```

---

## Applications

### 1. Breadth-First Search (BFS)

```dart
class BFSGraph {
  Map<int, List<int>> adjacencyList = {};
  
  void addEdge(int u, int v) {
    adjacencyList.putIfAbsent(u, () => []).add(v);
    adjacencyList.putIfAbsent(v, () => []).add(u);
  }
  
  List<int> bfs(int start) {
    Set<int> visited = {};
    LinkedQueue<int> queue = LinkedQueue<int>();
    List<int> result = [];
    
    queue.enqueue(start);
    visited.add(start);
    
    while (!queue.isEmpty) {
      int current = queue.dequeue()!;
      result.add(current);
      
      for (int neighbor in adjacencyList[current] ?? []) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.enqueue(neighbor);
        }
      }
    }
    
    return result;
  }
}
```

### 2. CPU Scheduling Simulation

```dart
class Process {
  String name;
  int arrivalTime;
  int burstTime;
  int priority;
  
  Process(this.name, this.arrivalTime, this.burstTime, this.priority);
  
  @override
  String toString() => '$name (AT:$arrivalTime, BT:$burstTime, P:$priority)';
}

class CPUScheduler {
  // First Come First Serve (FCFS)
  static List<Process> fcfs(List<Process> processes) {
    LinkedQueue<Process> readyQueue = LinkedQueue<Process>();
    
    // Sort by arrival time
    processes.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
    
    for (Process p in processes) {
      readyQueue.enqueue(p);
    }
    
    List<Process> executionOrder = [];
    while (!readyQueue.isEmpty) {
      executionOrder.add(readyQueue.dequeue()!);
    }
    
    return executionOrder;
  }
  
  // Priority Scheduling
  static List<Process> priorityScheduling(List<Process> processes) {
    PriorityQueue<Process> readyQueue = PriorityQueue<Process>();
    
    for (Process p in processes) {
      readyQueue.enqueue(p, p.priority);
    }
    
    List<Process> executionOrder = [];
    while (!readyQueue.isEmpty) {
      executionOrder.add(readyQueue.dequeue()!);
    }
    
    return executionOrder;
  }
}
```

### 3. Sliding Window Maximum

```dart
class SlidingWindowMaximum {
  static List<int> findMaximums(List<int> arr, int k) {
    List<int> result = [];
    Deque<int> deque = Deque<int>(); // Stores indices
    
    for (int i = 0; i < arr.length; i++) {
      // Remove indices that are out of current window
      while (!deque.isEmpty && deque.peekFront()! <= i - k) {
        deque.removeFront();
      }
      
      // Remove indices whose values are smaller than current element
      while (!deque.isEmpty && arr[deque.peekRear()!] <= arr[i]) {
        deque.removeRear();
      }
      
      deque.addRear(i);
      
      // Add maximum of current window to result
      if (i >= k - 1) {
        result.add(arr[deque.peekFront()!]);
      }
    }
    
    return result;
  }
}
```

### 4. LRU Cache Implementation

```dart
class LRUCache<K, V> {
  final int _capacity;
  final Map<K, V> _cache = {};
  final LinkedQueue<K> _queue = LinkedQueue<K>();
  
  LRUCache(this._capacity);
  
  V? get(K key) {
    if (_cache.containsKey(key)) {
      // Move to rear (most recently used)
      _moveToRear(key);
      return _cache[key];
    }
    return null;
  }
  
  void put(K key, V value) {
    if (_cache.containsKey(key)) {
      _cache[key] = value;
      _moveToRear(key);
    } else {
      if (_cache.length >= _capacity) {
        // Remove least recently used
        K? lru = _queue.dequeue();
        if (lru != null) {
          _cache.remove(lru);
        }
      }
      _cache[key] = value;
      _queue.enqueue(key);
    }
  }
  
  void _moveToRear(K key) {
    // Remove from current position and add to rear
    List<K> temp = [];
    while (!_queue.isEmpty) {
      K? current = _queue.dequeue();
      if (current != key) {
        temp.add(current!);
      }
    }
    
    for (K k in temp) {
      _queue.enqueue(k);
    }
    _queue.enqueue(key);
  }
  
  void display() {
    print('Cache contents: $_cache');
    print('Access order: ${_queue.toList()}');
  }
}
```

---

## Practice Problems

### 1. Generate Binary Numbers

```dart
class BinaryNumberGenerator {
  static List<String> generateBinaryNumbers(int n) {
    List<String> result = [];
    LinkedQueue<String> queue = LinkedQueue<String>();
    
    queue.enqueue('1');
    
    for (int i = 0; i < n; i++) {
      String current = queue.dequeue()!;
      result.add(current);
      
      queue.enqueue(current + '0');
      queue.enqueue(current + '1');
    }
    
    return result;
  }
}
```

### 2. First Non-Repeating Character

```dart
class FirstNonRepeating {
  static List<String> findFirstNonRepeating(String stream) {
    List<String> result = [];
    Map<String, int> frequency = {};
    LinkedQueue<String> queue = LinkedQueue<String>();
    
    for (int i = 0; i < stream.length; i++) {
      String char = stream[i];
      
      // Update frequency
      frequency[char] = (frequency[char] ?? 0) + 1;
      queue.enqueue(char);
      
      // Remove characters with frequency > 1 from front
      while (!queue.isEmpty && frequency[queue.front()!]! > 1) {
        queue.dequeue();
      }
      
      // Add first non-repeating character to result
      result.add(queue.isEmpty ? '#' : queue.front()!);
    }
    
    return result;
  }
}
```

### 3. Circular Tour (Gas Station Problem)

```dart
class CircularTour {
  static int findStartingPoint(List<int> gas, List<int> cost) {
    int n = gas.length;
    LinkedQueue<int> queue = LinkedQueue<int>();
    
    for (int start = 0; start < n; start++) {
      int currentGas = 0;
      bool canComplete = true;
      
      for (int i = 0; i < n; i++) {
        int station = (start + i) % n;
        currentGas += gas[station] - cost[station];
        
        if (currentGas < 0) {
          canComplete = false;
          break;
        }
      }
      
      if (canComplete) return start;
    }
    
    return -1; // No solution
  }
}
```

---

## Complete Example Usage

```dart
void main() {
  print('=== Queue Implementations Demo ===\n');
  
  // Array-based Queue
  print('1. Array-based Queue:');
  ArrayQueue<int> arrayQueue = ArrayQueue<int>(5);
  arrayQueue.enqueue(10);
  arrayQueue.enqueue(20);
  arrayQueue.enqueue(30);
  arrayQueue.display();
  print('Dequeued: ${arrayQueue.dequeue()}');
  print('Front: ${arrayQueue.front()}');
  print('Size: ${arrayQueue.size}\n');
  
  // Circular Queue
  print('2. Circular Queue:');
  CircularQueue<String> circularQueue = CircularQueue<String>(4);
  circularQueue.enqueue('A');
  circularQueue.enqueue('B');
  circularQueue.enqueue('C');
  circularQueue.display();
  circularQueue.dequeue();
  circularQueue.enqueue('D');
  circularQueue.enqueue('E');
  circularQueue.display();
  print();
  
  // Linked Queue
  print('3. Linked List Queue:');
  LinkedQueue<double> linkedQueue = LinkedQueue<double>();
  linkedQueue.enqueue(1.5);
  linkedQueue.enqueue(2.7);
  linkedQueue.enqueue(3.9);
  linkedQueue.display();
  print('Contains 2.7: ${linkedQueue.contains(2.7)}');
  print();
  
  // Deque
  print('4. Double-ended Queue:');
  Deque<int> deque = Deque<int>();
  deque.addFront(10);
  deque.addRear(20);
  deque.addFront(5);
  deque.addRear(30);
  deque.display();
  print('Removed from front: ${deque.removeFront()}');
  print('Removed from rear: ${deque.removeRear()}');
  deque.display();
  print();
  
  // Priority Queue
  print('5. Priority Queue:');
  PriorityQueue<String> pq = PriorityQueue<String>();
  pq.enqueue('Low Priority Task', 1);
  pq.enqueue('High Priority Task', 5);
  pq.enqueue('Medium Priority Task', 3);
  pq.enqueue('Critical Task', 10);
  pq.display();
  
  print('Processing tasks by priority:');
  while (!pq.isEmpty) {
    print('Processing: ${pq.dequeue()}');
  }
  print();
  
  // Heap-based Priority Queue
  print('6. Heap-based Priority Queue:');
  HeapPriorityQueue<String> heapPQ = HeapPriorityQueue<String>();
  heapPQ.enqueue('Task A', 3);
  heapPQ.enqueue('Task B', 1);
  heapPQ.enqueue('Task C', 5);
  heapPQ.enqueue('Task D', 2);
  print(heapPQ);
  
  print('Processing by min-priority:');
  while (!heapPQ.isEmpty) {
    print('Processing: ${heapPQ.dequeue()} (priority: ${heapPQ.isEmpty ? 'N/A' : heapPQ.frontPriority()})');
  }
  print();
  
  // BFS Example
  print('7. BFS Graph Traversal:');
  BFSGraph graph = BFSGraph();
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 4);
  graph.addEdge(3, 5);
  graph.addEdge(4, 5);
  
  List<int> bfsResult = graph.bfs(0);
  print('BFS traversal from node 0: $bfsResult');
  print();
  
  // CPU Scheduling
  print('8. CPU Scheduling:');
  List<Process> processes = [
    Process('P1', 0, 5, 3),
    Process('P2', 1, 3, 1),
    Process('P3', 2, 8, 2),
    Process('P4', 3, 2, 4),
  ];
  
  List<Process> fcfsOrder = CPUScheduler.fcfs(List.from(processes));
  print('FCFS Order: ${fcfsOrder.map((p) => p.name).toList()}');
  
  List<Process> priorityOrder = CPUScheduler.priorityScheduling(List.from(processes));
  print('Priority Order: ${priorityOrder.map((p) => p.name).toList()}');
  print();
  
  // Problem Solutions
  print('9. Problem Solutions:');
  
  // Binary numbers
  List<String> binaryNumbers = BinaryNumberGenerator.generateBinaryNumbers(8);
  print('First 8 binary numbers: $binaryNumbers');
  
  // First non-repeating character
  List<String> nonRepeating = FirstNonRepeating.findFirstNonRepeating('aabc');
  print('First non-repeating in "aabc": $nonRepeating');
  
  // Sliding window maximum
  List<int> arr = [1, 2, 3, 1, 4, 5, 2, 3, 6];
  List<int> maxInWindows = SlidingWindowMaximum.findMaximums(arr, 3);
  print('Sliding window maximums (k=3): $maxInWindows');
  
  // LRU Cache
  print('\n10. LRU Cache:');
  LRUCache<int, String> lruCache = LRUCache<int, String>(3);
  lruCache.put(1, 'A');
  lruCache.put(2, 'B');
  lruCache.put(3, 'C');
  lruCache.display();
  
  lruCache.get(1); // Access 1
  lruCache.put(4, 'D'); // Should evict 2
  lruCache.display();
}
```

---

## Time and Space Complexities

### Queue Operations Comparison

| Operation | Array Queue | Circular Queue | Linked Queue | Priority Queue | Heap Priority Queue |
|-----------|-------------|----------------|--------------|----------------|-------------------|
| Enqueue | O(1) | O(1) | O(1) | O(n) | O(log n) |
| Dequeue | O(1) | O(1) | O(1) | O(1) | O(log n) |
| Front/Peek | O(1) | O(1) | O(1) | O(1) | O(1) |
| Search | O(n) | O(n) | O(n) | O(n) | O(n) |
| Size | O(1) | O(1) | O(1) | O(1) | O(1) |

### Space Complexity

| Implementation | Space Complexity | Notes |
|----------------|------------------|-------|
| Array Queue | O(n) | Fixed size |
| Circular Queue | O(n) | Fixed size, efficient usage |
| Linked Queue | O(n) | Dynamic size |
| Priority Queue | O(n) | Extra space for priority |
| Heap Priority Queue | O(n) | More memory efficient |

---

## Advantages and Disadvantages

### Array-based Queue
**Advantages:**
- Simple implementation
- O(1) operations
- Memory efficient

**Disadvantages:**
- Fixed size
- May waste space
- Queue overflow possible

### Linked List-based Queue
**Advantages:**
- Dynamic size
- No overflow
- Memory efficient

**Disadvantages:**
- Extra pointer overhead
- Not cache-friendly
- More complex

### Priority Queue
**Advantages:**
- Processes by importance
- Flexible ordering
- Real-world applications

**Disadvantages:**
- Higher time complexity
- More memory usage
- Complex implementation

---

## Key Takeaways

1. **Queue follows FIFO principle** - First In, First Out
2. **Multiple implementation approaches** with different trade-offs
3. **Circular queues** solve the space waste problem of linear queues
4. **Priority queues** process elements by importance, not arrival order
5. **Heap-based priority queues** are more efficient for large datasets
6. **Wide applications** in algorithms, OS scheduling, and data processing

This comprehensive guide covers all essential queue concepts with practical implementations in Dart!
