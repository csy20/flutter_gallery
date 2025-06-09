// 1. Simple Queue Implementation using List
class Queue<T> {
  List<T> _items = [];

  // Check if queue is empty
  bool get isEmpty => _items.isEmpty;

  // Check if queue is not empty
  bool get isNotEmpty => _items.isNotEmpty;

  // Get the size of the queue
  int get size => _items.length;

  // Get the front element without removing it
  T? get front => isEmpty ? null : _items.first;

  // Get the rear element without removing it
  T? get rear => isEmpty ? null : _items.last;

  // Enqueue: Add an element to the rear of the queue
  void enqueue(T item) {
    _items.add(item);
    print('Enqueued: $item');
  }

  // Dequeue: Remove and return the front element
  T? dequeue() {
    if (isEmpty) {
      print('Queue is empty! Cannot dequeue.');
      return null;
    }
    T dequeuedItem = _items.removeAt(0);
    print('Dequeued: $dequeuedItem');
    return dequeuedItem;
  }

  // Display all elements in the queue
  void display() {
    if (isEmpty) {
      print('Queue is empty!');
      return;
    }
    print('Queue (front to rear): $_items');
  }

  // Clear all elements from the queue
  void clear() {
    _items.clear();
    print('Queue cleared!');
  }

  // Check if an element exists in the queue
  bool contains(T item) {
    return _items.contains(item);
  }

  // Convert queue to list
  List<T> toList() {
    return List.from(_items);
  }
}

// 2. Circular Queue Implementation (Fixed Size)
class CircularQueue<T> {
  late List<T?> _items;
  int _front = -1;
  int _rear = -1;
  int _capacity;
  int _size = 0;

  CircularQueue(this._capacity) {
    _items = List.filled(_capacity, null);
  }

  bool get isEmpty => _size == 0;
  bool get isFull => _size == _capacity;
  int get size => _size;
  int get capacity => _capacity;

  T? get front => isEmpty ? null : _items[_front];
  T? get rear => isEmpty ? null : _items[_rear];

  void enqueue(T item) {
    if (isFull) {
      print('Queue is full! Cannot enqueue $item');
      return;
    }

    if (isEmpty) {
      _front = 0;
      _rear = 0;
    } else {
      _rear = (_rear + 1) % _capacity;
    }

    _items[_rear] = item;
    _size++;
    print('Enqueued: $item');
  }

  T? dequeue() {
    if (isEmpty) {
      print('Queue is empty! Cannot dequeue.');
      return null;
    }

    T? item = _items[_front];
    _items[_front] = null;
    _size--;

    if (isEmpty) {
      _front = -1;
      _rear = -1;
    } else {
      _front = (_front + 1) % _capacity;
    }

    print('Dequeued: $item');
    return item;
  }

  void display() {
    if (isEmpty) {
      print('Circular Queue is empty!');
      return;
    }

    List<T> elements = [];
    int current = _front;
    for (int i = 0; i < _size; i++) {
      elements.add(_items[current]!);
      current = (current + 1) % _capacity;
    }
    print('Circular Queue (front to rear): $elements');
  }
}

// 3. Queue Implementation using Linked List
class QueueNode<T> {
  T data;
  QueueNode<T>? next;
  
  QueueNode(this.data, [this.next]);
}

class LinkedQueue<T> {
  QueueNode<T>? _front;
  QueueNode<T>? _rear;
  int _size = 0;

  bool get isEmpty => _front == null;
  int get size => _size;
  T? get front => isEmpty ? null : _front!.data;
  T? get rear => isEmpty ? null : _rear!.data;

  void enqueue(T data) {
    QueueNode<T> newNode = QueueNode(data);
    
    if (isEmpty) {
      _front = newNode;
      _rear = newNode;
    } else {
      _rear!.next = newNode;
      _rear = newNode;
    }
    
    _size++;
    print('Enqueued: $data');
  }

  T? dequeue() {
    if (isEmpty) {
      print('Queue is empty! Cannot dequeue.');
      return null;
    }

    T data = _front!.data;
    _front = _front!.next;
    _size--;

    if (_front == null) {
      _rear = null;
    }

    print('Dequeued: $data');
    return data;
  }

  void display() {
    if (isEmpty) {
      print('Linked Queue is empty!');
      return;
    }
    
    List<T> elements = [];
    QueueNode<T>? current = _front;
    while (current != null) {
      elements.add(current.data);
      current = current.next;
    }
    print('Linked Queue (front to rear): $elements');
  }
}

// 4. Priority Queue Implementation
class PriorityQueueItem<T> {
  T data;
  int priority;
  
  PriorityQueueItem(this.data, this.priority);
  
  @override
  String toString() => '($data, priority: $priority)';
}

class PriorityQueue<T> {
  List<PriorityQueueItem<T>> _items = [];

  bool get isEmpty => _items.isEmpty;
  int get size => _items.length;

  void enqueue(T data, int priority) {
    PriorityQueueItem<T> newItem = PriorityQueueItem(data, priority);
    
    // Insert based on priority (higher priority first)
    int insertIndex = 0;
    while (insertIndex < _items.length && 
           _items[insertIndex].priority >= priority) {
      insertIndex++;
    }
    
    _items.insert(insertIndex, newItem);
    print('Enqueued: $data with priority $priority');
  }

  T? dequeue() {
    if (isEmpty) {
      print('Priority Queue is empty! Cannot dequeue.');
      return null;
    }
    
    PriorityQueueItem<T> item = _items.removeAt(0);
    print('Dequeued: ${item.data} with priority ${item.priority}');
    return item.data;
  }

  T? peek() {
    return isEmpty ? null : _items.first.data;
  }

  void display() {
    if (isEmpty) {
      print('Priority Queue is empty!');
      return;
    }
    print('Priority Queue: $_items');
  }
}

// 5. Deque (Double-ended Queue) Implementation
class Deque<T> {
  List<T> _items = [];

  bool get isEmpty => _items.isEmpty;
  int get size => _items.length;
  T? get front => isEmpty ? null : _items.first;
  T? get rear => isEmpty ? null : _items.last;

  // Add to front
  void addFront(T item) {
    _items.insert(0, item);
    print('Added to front: $item');
  }

  // Add to rear
  void addRear(T item) {
    _items.add(item);
    print('Added to rear: $item');
  }

  // Remove from front
  T? removeFront() {
    if (isEmpty) {
      print('Deque is empty! Cannot remove from front.');
      return null;
    }
    T item = _items.removeAt(0);
    print('Removed from front: $item');
    return item;
  }

  // Remove from rear
  T? removeRear() {
    if (isEmpty) {
      print('Deque is empty! Cannot remove from rear.');
      return null;
    }
    T item = _items.removeLast();
    print('Removed from rear: $item');
    return item;
  }

  void display() {
    if (isEmpty) {
      print('Deque is empty!');
      return;
    }
    print('Deque: $_items');
  }
}

// Practical examples of queue usage
class QueueExamples {
  
  // Breadth-First Search simulation
  static void bfsExample() {
    print('\n--- BFS Simulation ---');
    Queue<String> queue = Queue<String>();
    
    // Simulate visiting nodes in a tree/graph
    queue.enqueue('A');
    queue.enqueue('B');
    queue.enqueue('C');
    
    while (queue.isNotEmpty) {
      String? node = queue.dequeue();
      print('Visiting node: $node');
      
      // Simulate adding child nodes
      if (node == 'A') {
        queue.enqueue('D');
        queue.enqueue('E');
      }
    }
  }
  
  // Process scheduling simulation
  static void processScheduling() {
    print('\n--- Process Scheduling ---');
    Queue<String> processQueue = Queue<String>();
    
    processQueue.enqueue('Process1');
    processQueue.enqueue('Process2');
    processQueue.enqueue('Process3');
    
    print('Processing tasks in FIFO order:');
    while (processQueue.isNotEmpty) {
      String? process = processQueue.dequeue();
      print('Executing: $process');
    }
  }
  
  // Buffer implementation for data streaming
  static void bufferExample() {
    print('\n--- Buffer Example ---');
    CircularQueue<int> buffer = CircularQueue<int>(5);
    
    // Fill buffer
    for (int i = 1; i <= 7; i++) {
      buffer.enqueue(i);
    }
    
    // Process some data
    buffer.dequeue();
    buffer.dequeue();
    
    // Add more data
    buffer.enqueue(8);
    buffer.enqueue(9);
    
    buffer.display();
  }
}

void main() {
  print('=== Queue Implementation Demo ===\n');
  
  // Demo 1: Basic Queue Operations
  print('1. Basic Queue Operations:');
  Queue<int> queue = Queue<int>();
  
  queue.enqueue(10);
  queue.enqueue(20);
  queue.enqueue(30);
  queue.display();
  
  print('Front element: ${queue.front}');
  print('Rear element: ${queue.rear}');
  print('Queue size: ${queue.size}');
  
  queue.dequeue();
  queue.display();
  
  print('\n2. Circular Queue:');
  CircularQueue<String> circularQueue = CircularQueue<String>(4);
  
  circularQueue.enqueue('A');
  circularQueue.enqueue('B');
  circularQueue.enqueue('C');
  circularQueue.enqueue('D');
  circularQueue.display();
  
  circularQueue.dequeue();
  circularQueue.enqueue('E');
  circularQueue.display();
  
  print('\n3. Linked Queue:');
  LinkedQueue<double> linkedQueue = LinkedQueue<double>();
  linkedQueue.enqueue(1.5);
  linkedQueue.enqueue(2.7);
  linkedQueue.enqueue(3.9);
  linkedQueue.display();
  linkedQueue.dequeue();
  linkedQueue.display();
  
  print('\n4. Priority Queue:');
  PriorityQueue<String> priorityQueue = PriorityQueue<String>();
  priorityQueue.enqueue('Low Priority Task', 1);
  priorityQueue.enqueue('High Priority Task', 5);
  priorityQueue.enqueue('Medium Priority Task', 3);
  priorityQueue.display();
  
  priorityQueue.dequeue();
  priorityQueue.display();
  
  print('\n5. Deque (Double-ended Queue):');
  Deque<int> deque = Deque<int>();
  deque.addRear(1);
  deque.addFront(2);
  deque.addRear(3);
  deque.display();
  
  deque.removeFront();
  deque.removeRear();
  deque.display();
  
  print('\n6. Practical Examples:');
  QueueExamples.bfsExample();
  QueueExamples.processScheduling();
  QueueExamples.bufferExample();
}