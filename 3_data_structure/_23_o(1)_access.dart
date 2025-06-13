// O(1) Access Time Complexity in Dart
// O(1) means "constant time" - the operation takes the same amount of time
// regardless of the input size or data structure size

// O(1) access means we can retrieve, insert, or delete data in constant time
// This is achieved through direct indexing or hashing mechanisms

import 'dart:math';

// 1. Array/List O(1) Access by Index
class ArrayAccess<T> {
  List<T?> _array;
  
  ArrayAccess(int size) : _array = List.filled(size, null);
  
  // O(1) - Direct access by index
  T? get(int index) {
    if (index < 0 || index >= _array.length) {
      throw RangeError('Index out of bounds');
    }
    return _array[index];
  }
  
  // O(1) - Direct assignment by index
  void set(int index, T value) {
    if (index < 0 || index >= _array.length) {
      throw RangeError('Index out of bounds');
    }
    _array[index] = value;
  }
  
  // O(1) - Get array size
  int get length => _array.length;
  
  void display() {
    print('Array: $_array');
  }
}

// 2. Hash Table Implementation for O(1) Average Access
class HashNode<K, V> {
  K key;
  V value;
  HashNode<K, V>? next;
  
  HashNode(this.key, this.value, [this.next]);
}

class HashTable<K, V> {
  List<HashNode<K, V>?> _buckets;
  int _size = 0;
  
  HashTable([int capacity = 16]) : _buckets = List.filled(capacity, null);
  
  // Simple hash function
  int _hash(K key) {
    return key.hashCode.abs() % _buckets.length;
  }
  
  // O(1) average case - Insert/Update
  void put(K key, V value) {
    int index = _hash(key);
    HashNode<K, V>? current = _buckets[index];
    
    // Check if key already exists
    while (current != null) {
      if (current.key == key) {
        current.value = value; // Update existing
        return;
      }
      current = current.next;
    }
    
    // Insert new node at the beginning of the chain
    HashNode<K, V> newNode = HashNode(key, value, _buckets[index]);
    _buckets[index] = newNode;
    _size++;
  }
  
  // O(1) average case - Retrieve
  V? get(K key) {
    int index = _hash(key);
    HashNode<K, V>? current = _buckets[index];
    
    while (current != null) {
      if (current.key == key) {
        return current.value;
      }
      current = current.next;
    }
    
    return null; // Key not found
  }
  
  // O(1) average case - Delete
  bool remove(K key) {
    int index = _hash(key);
    HashNode<K, V>? current = _buckets[index];
    HashNode<K, V>? previous;
    
    while (current != null) {
      if (current.key == key) {
        if (previous == null) {
          _buckets[index] = current.next;
        } else {
          previous.next = current.next;
        }
        _size--;
        return true;
      }
      previous = current;
      current = current.next;
    }
    
    return false; // Key not found
  }
  
  // O(1) - Check if key exists
  bool containsKey(K key) {
    return get(key) != null;
  }
  
  // O(1) - Get size
  int get size => _size;
  
  // O(1) - Check if empty
  bool get isEmpty => _size == 0;
  
  void display() {
    print('Hash Table Contents:');
    for (int i = 0; i < _buckets.length; i++) {
      if (_buckets[i] != null) {
        String chain = '';
        HashNode<K, V>? current = _buckets[i];
        while (current != null) {
          chain += '(${current.key}:${current.value})';
          if (current.next != null) chain += ' -> ';
          current = current.next;
        }
        print('Bucket $i: $chain');
      }
    }
  }
}

// 3. Stack with O(1) Operations
class Stack<T> {
  List<T> _items = [];
  
  // O(1) - Push element to top
  void push(T item) {
    _items.add(item);
  }
  
  // O(1) - Pop element from top
  T? pop() {
    if (isEmpty) return null;
    return _items.removeLast();
  }
  
  // O(1) - Peek at top element
  T? peek() {
    if (isEmpty) return null;
    return _items.last;
  }
  
  // O(1) - Check if empty
  bool get isEmpty => _items.isEmpty;
  
  // O(1) - Get size
  int get size => _items.length;
  
  void display() {
    print('Stack (top to bottom): ${_items.reversed.toList()}');
  }
}

// 4. Queue with O(1) Operations (using circular buffer)
class CircularQueue<T> {
  List<T?> _buffer;
  int _front = 0;
  int _rear = 0;
  int _size = 0;
  
  CircularQueue(int capacity) : _buffer = List.filled(capacity, null);
  
  // O(1) - Enqueue (add to rear)
  bool enqueue(T item) {
    if (isFull) return false;
    
    _buffer[_rear] = item;
    _rear = (_rear + 1) % _buffer.length;
    _size++;
    return true;
  }
  
  // O(1) - Dequeue (remove from front)
  T? dequeue() {
    if (isEmpty) return null;
    
    T? item = _buffer[_front];
    _buffer[_front] = null;
    _front = (_front + 1) % _buffer.length;
    _size--;
    return item;
  }
  
  // O(1) - Peek at front
  T? peek() {
    if (isEmpty) return null;
    return _buffer[_front];
  }
  
  // O(1) - Check if empty
  bool get isEmpty => _size == 0;
  
  // O(1) - Check if full
  bool get isFull => _size == _buffer.length;
  
  // O(1) - Get size
  int get size => _size;
  
  void display() {
    if (isEmpty) {
      print('Queue is empty');
      return;
    }
    
    List<T> items = [];
    int index = _front;
    for (int i = 0; i < _size; i++) {
      items.add(_buffer[index]!);
      index = (index + 1) % _buffer.length;
    }
    print('Queue (front to rear): $items');
  }
}

// 5. Dart's Built-in O(1) Access Examples
class DartBuiltInExamples {
  
  static void demonstrateListAccess() {
    print('\n=== Dart List O(1) Access ===');
    List<int> numbers = [10, 20, 30, 40, 50];
    
    // O(1) access by index
    print('Element at index 2: ${numbers[2]}');
    print('First element: ${numbers.first}');
    print('Last element: ${numbers.last}');
    print('List length: ${numbers.length}');
    
    // O(1) modifications at the end
    numbers.add(60); // O(1) amortized
    print('After adding 60: $numbers');
    
    int? removed = numbers.removeLast(); // O(1)
    print('Removed: $removed, List: $numbers');
  }
  
  static void demonstrateMapAccess() {
    print('\n=== Dart Map O(1) Access ===');
    Map<String, int> ages = {
      'Alice': 25,
      'Bob': 30,
      'Charlie': 35
    };
    
    // O(1) average case operations
    print('Alice age: ${ages['Alice']}');
    ages['David'] = 28; // O(1) insert
    print('After adding David: $ages');
    
    bool hasAlice = ages.containsKey('Alice'); // O(1)
    print('Contains Alice: $hasAlice');
    
    ages.remove('Bob'); // O(1)
    print('After removing Bob: $ages');
  }
  
  static void demonstrateSetAccess() {
    print('\n=== Dart Set O(1) Access ===');
    Set<String> fruits = {'apple', 'banana', 'orange'};
    
    // O(1) operations
    bool hasApple = fruits.contains('apple'); // O(1)
    print('Contains apple: $hasApple');
    
    fruits.add('grape'); // O(1)
    print('After adding grape: $fruits');
    
    fruits.remove('banana'); // O(1)
    print('After removing banana: $fruits');
  }
}

// Performance Comparison Class
class PerformanceComparison {
  
  static void compareAccessTimes() {
    print('\n=== Performance Comparison ===');
    
    const int size = 100000;
    List<int> list = List.generate(size, (i) => i);
    Map<int, int> map = {for (int i = 0; i < size; i++) i: i};
    
    // Time O(1) list access
    Stopwatch sw = Stopwatch()..start();
    for (int i = 0; i < 1000; i++) {
      int _ = list[size ~/ 2]; // Always access middle element
    }
    sw.stop();
    print('List O(1) access time: ${sw.elapsedMicroseconds}μs');
    
    // Time O(1) map access
    sw.reset();
    sw.start();
    for (int i = 0; i < 1000; i++) {
      int? _ = map[size ~/ 2]; // Always access same key
    }
    sw.stop();
    print('Map O(1) access time: ${sw.elapsedMicroseconds}μs');
    
    // Compare with O(n) linear search
    sw.reset();
    sw.start();
    for (int i = 0; i < 10; i++) { // Fewer iterations due to O(n)
      list.indexOf(size ~/ 2); // Linear search
    }
    sw.stop();
    print('List O(n) search time: ${sw.elapsedMicroseconds}μs');
  }
}

// Main demonstration
void main() {
  print('=== O(1) Access Time Complexity in Dart ===\n');
  
  print('O(1) Definition:');
  print('''
  • O(1) means "constant time"
  • Operation time doesn't change with input size
  • Direct access through indexing or hashing
  • Most efficient time complexity possible
  • Examples: array[index], map[key], stack.push(), queue.enqueue()
  ''');
  
  print('\n' + '='*60);
  
  // 1. Array Access Example
  print('\n1. Array O(1) Access Example:');
  var array = ArrayAccess<String>(5);
  array.set(0, 'Hello');
  array.set(2, 'World');
  array.set(4, 'Dart');
  array.display();
  print('Element at index 2: ${array.get(2)}');
  print('Array length: ${array.length}');
  
  // 2. Hash Table Example
  print('\n2. Hash Table O(1) Average Access:');
  var hashTable = HashTable<String, int>();
  hashTable.put('apple', 5);
  hashTable.put('banana', 3);
  hashTable.put('orange', 8);
  hashTable.put('grape', 12);
  hashTable.display();
  
  print('Get apple: ${hashTable.get('apple')}');
  print('Contains banana: ${hashTable.containsKey('banana')}');
  hashTable.remove('orange');
  print('After removing orange:');
  hashTable.display();
  
  // 3. Stack Example
  print('\n3. Stack O(1) Operations:');
  var stack = Stack<int>();
  [10, 20, 30, 40].forEach(stack.push);
  stack.display();
  print('Peek: ${stack.peek()}');
  print('Pop: ${stack.pop()}');
  stack.display();
  
  // 4. Queue Example
  print('\n4. Circular Queue O(1) Operations:');
  var queue = CircularQueue<String>(5);
  ['A', 'B', 'C'].forEach(queue.enqueue);
  queue.display();
  print('Dequeue: ${queue.dequeue()}');
  queue.enqueue('D');
  queue.display();
  
  // 5. Dart Built-in Examples
  DartBuiltInExamples.demonstrateListAccess();
  DartBuiltInExamples.demonstrateMapAccess();
  DartBuiltInExamples.demonstrateSetAccess();
  
  // 6. Performance Comparison
  PerformanceComparison.compareAccessTimes();
  
  print('\n' + '='*60);
  
  print('\n=== O(1) vs Other Time Complexities ===');
  print('''
  Time Complexity Comparison (for n = 1,000,000):
  
  O(1)      - Constant:     1 operation
  O(log n)  - Logarithmic:  ~20 operations
  O(n)      - Linear:       1,000,000 operations
  O(n²)     - Quadratic:    1,000,000,000,000 operations
  
  Data Structures with O(1) Operations:
  
  Array/List:
  • Access by index: O(1)
  • Insert/delete at end: O(1) amortized
  • Get length: O(1)
  
  Hash Table/Map:
  • Insert: O(1) average
  • Delete: O(1) average
  • Search: O(1) average
  • Worst case: O(n) with many collisions
  
  Stack:
  • Push: O(1)
  • Pop: O(1)
  • Peek: O(1)
  
  Queue (with proper implementation):
  • Enqueue: O(1)
  • Dequeue: O(1)
  • Peek: O(1)
  
  When O(1) Access is Important:
  • Real-time systems
  • High-frequency operations
  • Performance-critical applications
  • Large datasets
  • Gaming engines
  • Database indexing
  
  Limitations of O(1):
  • Hash tables can degrade to O(n) with poor hash function
  • Dynamic arrays may need resizing (O(n) operation)
  • Memory overhead for maintaining O(1) structures
  • Not all operations can be O(1)
  ''');
  
  print('\n=== Key Takeaways ===');
  print('''
  1. O(1) means constant time regardless of input size
  2. Achieved through direct indexing or hashing
  3. Most efficient time complexity possible
  4. Dart's List, Map, and Set provide O(1) operations
  5. Choose the right data structure for O(1) access needs
  6. Consider trade-offs: memory vs. time complexity
  ''');
}
