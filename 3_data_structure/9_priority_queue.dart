// Priority Queue Implementation in Dart
// A Priority Queue is a data structure where each element has a priority
// Elements are served based on their priority, not their arrival order

// 1. Simple Priority Queue using List (Array-based)
class PriorityQueueItem<T> {
  T data;
  int priority;
  
  PriorityQueueItem(this.data, this.priority);
  
  @override
  String toString() => '($data, priority: $priority)';
}

class SimplePriorityQueue<T> {
  List<PriorityQueueItem<T>> _items = [];

  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;
  int get size => _items.length;

  // Insert element with priority (higher number = higher priority)
  void enqueue(T data, int priority) {
    PriorityQueueItem<T> newItem = PriorityQueueItem(data, priority);
    
    // Find correct position to maintain priority order
    int insertIndex = 0;
    while (insertIndex < _items.length && 
           _items[insertIndex].priority >= priority) {
      insertIndex++;
    }
    
    _items.insert(insertIndex, newItem);
    print('Enqueued: $data with priority $priority');
  }

  // Remove and return highest priority element
  T? dequeue() {
    if (isEmpty) {
      print('Priority Queue is empty! Cannot dequeue.');
      return null;
    }
    
    PriorityQueueItem<T> item = _items.removeAt(0);
    print('Dequeued: ${item.data} with priority ${item.priority}');
    return item.data;
  }

  // Peek at highest priority element without removing
  T? peek() {
    return isEmpty ? null : _items.first.data;
  }

  int? peekPriority() {
    return isEmpty ? null : _items.first.priority;
  }

  void display() {
    if (isEmpty) {
      print('Priority Queue is empty!');
      return;
    }
    print('Priority Queue (highest to lowest): $_items');
  }

  // Change priority of existing element
  bool changePriority(T data, int newPriority) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].data == data) {
        _items.removeAt(i);
        enqueue(data, newPriority);
        return true;
      }
    }
    return false;
  }
}

// 2. Binary Heap-based Priority Queue (Min-Heap implementation)
class MinHeapPriorityQueue<T> {
  List<PriorityQueueItem<T>> _heap = [];

  bool get isEmpty => _heap.isEmpty;
  int get size => _heap.length;

  // Helper methods for heap operations
  int _parent(int index) => (index - 1) ~/ 2;
  int _leftChild(int index) => 2 * index + 1;
  int _rightChild(int index) => 2 * index + 2;

  void _swap(int i, int j) {
    PriorityQueueItem<T> temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  // Heapify up (bubble up)
  void _heapifyUp(int index) {
    while (index > 0) {
      int parentIndex = _parent(index);
      if (_heap[index].priority >= _heap[parentIndex].priority) break;
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }

  // Heapify down (bubble down)
  void _heapifyDown(int index) {
    while (_leftChild(index) < _heap.length) {
      int minChildIndex = _leftChild(index);
      
      // Find smaller child
      if (_rightChild(index) < _heap.length &&
          _heap[_rightChild(index)].priority < _heap[minChildIndex].priority) {
        minChildIndex = _rightChild(index);
      }
      
      if (_heap[index].priority <= _heap[minChildIndex].priority) break;
      
      _swap(index, minChildIndex);
      index = minChildIndex;
    }
  }

  // Insert with priority (lower number = higher priority in min-heap)
  void enqueue(T data, int priority) {
    PriorityQueueItem<T> newItem = PriorityQueueItem(data, priority);
    _heap.add(newItem);
    _heapifyUp(_heap.length - 1);
    print('Enqueued: $data with priority $priority');
  }

  // Remove and return highest priority element (lowest priority number)
  T? dequeue() {
    if (isEmpty) {
      print('Min-Heap Priority Queue is empty!');
      return null;
    }

    if (_heap.length == 1) {
      PriorityQueueItem<T> item = _heap.removeAt(0);
      print('Dequeued: ${item.data} with priority ${item.priority}');
      return item.data;
    }

    PriorityQueueItem<T> root = _heap[0];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    
    print('Dequeued: ${root.data} with priority ${root.priority}');
    return root.data;
  }

  T? peek() {
    return isEmpty ? null : _heap[0].data;
  }

  int? peekPriority() {
    return isEmpty ? null : _heap[0].priority;
  }

  void display() {
    if (isEmpty) {
      print('Min-Heap Priority Queue is empty!');
      return;
    }
    print('Min-Heap: ${_heap.map((item) => '${item.data}(${item.priority})').toList()}');
  }
}

// 3. Max-Heap Priority Queue
class MaxHeapPriorityQueue<T> {
  List<PriorityQueueItem<T>> _heap = [];

  bool get isEmpty => _heap.isEmpty;
  int get size => _heap.length;

  int _parent(int index) => (index - 1) ~/ 2;
  int _leftChild(int index) => 2 * index + 1;
  int _rightChild(int index) => 2 * index + 2;

  void _swap(int i, int j) {
    PriorityQueueItem<T> temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  void _heapifyUp(int index) {
    while (index > 0) {
      int parentIndex = _parent(index);
      if (_heap[index].priority <= _heap[parentIndex].priority) break;
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }

  void _heapifyDown(int index) {
    while (_leftChild(index) < _heap.length) {
      int maxChildIndex = _leftChild(index);
      
      if (_rightChild(index) < _heap.length &&
          _heap[_rightChild(index)].priority > _heap[maxChildIndex].priority) {
        maxChildIndex = _rightChild(index);
      }
      
      if (_heap[index].priority >= _heap[maxChildIndex].priority) break;
      
      _swap(index, maxChildIndex);
      index = maxChildIndex;
    }
  }

  void enqueue(T data, int priority) {
    PriorityQueueItem<T> newItem = PriorityQueueItem(data, priority);
    _heap.add(newItem);
    _heapifyUp(_heap.length - 1);
    print('Enqueued: $data with priority $priority');
  }

  T? dequeue() {
    if (isEmpty) {
      print('Max-Heap Priority Queue is empty!');
      return null;
    }

    if (_heap.length == 1) {
      PriorityQueueItem<T> item = _heap.removeAt(0);
      print('Dequeued: ${item.data} with priority ${item.priority}');
      return item.data;
    }

    PriorityQueueItem<T> root = _heap[0];
    _heap[0] = _heap.removeLast();
    _heapifyDown(0);
    
    print('Dequeued: ${root.data} with priority ${root.priority}');
    return root.data;
  }

  T? peek() => isEmpty ? null : _heap[0].data;
  int? peekPriority() => isEmpty ? null : _heap[0].priority;

  void display() {
    if (isEmpty) {
      print('Max-Heap Priority Queue is empty!');
      return;
    }
    print('Max-Heap: ${_heap.map((item) => '${item.data}(${item.priority})').toList()}');
  }
}

// 4. Task Priority Queue for real-world scenarios
enum TaskPriority { 
  low(1), 
  medium(2), 
  high(3), 
  critical(4);
  
  const TaskPriority(this.value);
  final int value;
}

class Task {
  String name;
  String description;
  TaskPriority priority;
  DateTime deadline;
  
  Task(this.name, this.description, this.priority, this.deadline);
  
  @override
  String toString() => '$name (${priority.name})';
}

class TaskPriorityQueue {
  MaxHeapPriorityQueue<Task> _queue = MaxHeapPriorityQueue<Task>();

  void addTask(Task task) {
    _queue.enqueue(task, task.priority.value);
  }

  Task? getNextTask() {
    return _queue.dequeue();
  }

  Task? peekNextTask() {
    return _queue.peek();
  }

  bool get hasTask => _queue.isNotEmpty;
  int get taskCount => _queue.size;

  void displayTasks() {
    _queue.display();
  }
}

// 5. Practical Examples
class PriorityQueueExamples {
  
  // Operating System Process Scheduling
  static void processScheduling() {
    print('\n--- Process Scheduling Example ---');
    MaxHeapPriorityQueue<String> scheduler = MaxHeapPriorityQueue<String>();
    
    scheduler.enqueue('System Process', 10);
    scheduler.enqueue('User App 1', 5);
    scheduler.enqueue('Background Task', 2);
    scheduler.enqueue('Critical Driver', 15);
    scheduler.enqueue('User App 2', 5);
    
    print('\nProcessing in priority order:');
    while (scheduler.isNotEmpty) {
      String? process = scheduler.dequeue();
    }
  }
  
  // Hospital Emergency Room
  static void hospitalEmergencyRoom() {
    print('\n--- Hospital Emergency Room Example ---');
    MinHeapPriorityQueue<String> emergencyRoom = MinHeapPriorityQueue<String>();
    
    // Lower number = higher priority (more critical)
    emergencyRoom.enqueue('Heart Attack Patient', 1);
    emergencyRoom.enqueue('Broken Arm', 5);
    emergencyRoom.enqueue('Flu Symptoms', 8);
    emergencyRoom.enqueue('Severe Bleeding', 2);
    emergencyRoom.enqueue('Minor Cut', 9);
    
    print('\nTreating patients in order of severity:');
    while (emergencyRoom.isNotEmpty) {
      String? patient = emergencyRoom.dequeue();
    }
  }
  
  // Dijkstra's Algorithm simulation
  static void dijkstraSimulation() {
    print('\n--- Dijkstra\'s Algorithm Simulation ---');
    MinHeapPriorityQueue<String> pathQueue = MinHeapPriorityQueue<String>();
    
    pathQueue.enqueue('Node A', 0);
    pathQueue.enqueue('Node B', 4);
    pathQueue.enqueue('Node C', 2);
    pathQueue.enqueue('Node D', 7);
    pathQueue.enqueue('Node E', 3);
    
    print('Processing nodes by shortest distance:');
    while (pathQueue.isNotEmpty) {
      String? node = pathQueue.dequeue();
    }
  }
  
  // Task Management System
  static void taskManagement() {
    print('\n--- Task Management System ---');
    TaskPriorityQueue taskQueue = TaskPriorityQueue();
    
    DateTime now = DateTime.now();
    taskQueue.addTask(Task('Fix Bug', 'Critical system bug', 
                          TaskPriority.critical, now.add(Duration(hours: 2))));
    taskQueue.addTask(Task('Code Review', 'Review teammate code', 
                          TaskPriority.medium, now.add(Duration(days: 1))));
    taskQueue.addTask(Task('Documentation', 'Update API docs', 
                          TaskPriority.low, now.add(Duration(days: 3))));
    taskQueue.addTask(Task('Security Patch', 'Apply security update', 
                          TaskPriority.high, now.add(Duration(hours: 4))));
    
    print('\nProcessing tasks by priority:');
    while (taskQueue.hasTask) {
      Task? task = taskQueue.getNextTask();
      if (task != null) {
        print('Working on: ${task.name} - ${task.description}');
      }
    }
  }
}

void main() {
  print('=== Priority Queue Implementation Demo ===\n');
  
  // Demo 1: Simple Priority Queue
  print('1. Simple Priority Queue:');
  SimplePriorityQueue<String> simpleQueue = SimplePriorityQueue<String>();
  
  simpleQueue.enqueue('Low Priority Task', 1);
  simpleQueue.enqueue('High Priority Task', 5);
  simpleQueue.enqueue('Medium Priority Task', 3);
  simpleQueue.enqueue('Critical Task', 10);
  simpleQueue.display();
  
  print('\nDequeuing all elements:');
  while (simpleQueue.isNotEmpty) {
    simpleQueue.dequeue();
  }
  
  // Demo 2: Min-Heap Priority Queue
  print('\n2. Min-Heap Priority Queue (Lower number = Higher priority):');
  MinHeapPriorityQueue<String> minHeap = MinHeapPriorityQueue<String>();
  
  minHeap.enqueue('Task A', 5);
  minHeap.enqueue('Task B', 2);
  minHeap.enqueue('Task C', 8);
  minHeap.enqueue('Task D', 1);
  minHeap.enqueue('Task E', 3);
  minHeap.display();
  
  print('\nDequeuing all elements:');
  while (minHeap.isNotEmpty) {
    minHeap.dequeue();
  }
  
  // Demo 3: Max-Heap Priority Queue
  print('\n3. Max-Heap Priority Queue (Higher number = Higher priority):');
  MaxHeapPriorityQueue<String> maxHeap = MaxHeapPriorityQueue<String>();
  
  maxHeap.enqueue('Task A', 5);
  maxHeap.enqueue('Task B', 2);
  maxHeap.enqueue('Task C', 8);
  maxHeap.enqueue('Task D', 1);
  maxHeap.enqueue('Task E', 3);
  maxHeap.display();
  
  print('\nPeeking at highest priority: ${maxHeap.peek()} (Priority: ${maxHeap.peekPriority()})');
  
  print('\nDequeuing all elements:');
  while (maxHeap.isNotEmpty) {
    maxHeap.dequeue();
  }
  
  // Demo 4: Practical Examples
  print('\n4. Practical Examples:');
  PriorityQueueExamples.processScheduling();
  PriorityQueueExamples.hospitalEmergencyRoom();
  PriorityQueueExamples.dijkstraSimulation();
  PriorityQueueExamples.taskManagement();
  
  print('\n=== Priority Queue Concepts Summary ===');
  print('• Priority Queue: Elements are served based on priority, not arrival order');
  print('• Min-Heap: Lower priority number = Higher actual priority');
  print('• Max-Heap: Higher priority number = Higher actual priority');
  print('• Time Complexity: O(log n) for enqueue/dequeue operations');
  print('• Applications: Process scheduling, Dijkstra\'s algorithm, A* search, etc.');
}