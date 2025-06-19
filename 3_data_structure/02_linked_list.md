# Linked List - Complete Guide

A **Linked List** is a linear data structure where elements are stored in nodes, and each node contains data and a reference (or pointer) to the next node in the sequence. Unlike arrays, linked lists don't store elements in contiguous memory locations.

## Table of Contents
1. [Single Linked List](#single-linked-list)
2. [Double Linked List](#double-linked-list)
3. [Cycle Detection in Linked Lists](#cycle-detection)

---

## Single Linked List

### Structure
In a single linked list, each node contains:
- **Data**: The actual value stored in the node
- **Next**: A reference to the next node in the list

### Node Class Implementation

```dart
// Single Linked List Node
class ListNode {
  int data;
  ListNode? next;
  
  ListNode(this.data, [this.next]);
  
  @override
  String toString() => data.toString();
}
```

### Single Linked List Class

```dart
class SingleLinkedList {
  ListNode? head;
  int _size = 0;
  
  // Get the size of the list
  int get size => _size;
  
  // Check if list is empty
  bool get isEmpty => head == null;
  
  // Insert at the beginning
  void insertAtBeginning(int data) {
    ListNode newNode = ListNode(data, head);
    head = newNode;
    _size++;
  }
  
  // Insert at the end
  void insertAtEnd(int data) {
    ListNode newNode = ListNode(data);
    
    if (head == null) {
      head = newNode;
    } else {
      ListNode current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = newNode;
    }
    _size++;
  }
  
  // Insert at specific position (0-indexed)
  void insertAtPosition(int position, int data) {
    if (position < 0 || position > _size) {
      throw ArgumentError('Position out of bounds');
    }
    
    if (position == 0) {
      insertAtBeginning(data);
      return;
    }
    
    ListNode newNode = ListNode(data);
    ListNode current = head!;
    
    for (int i = 0; i < position - 1; i++) {
      current = current.next!;
    }
    
    newNode.next = current.next;
    current.next = newNode;
    _size++;
  }
  
  // Delete from beginning
  void deleteFromBeginning() {
    if (head == null) return;
    
    head = head!.next;
    _size--;
  }
  
  // Delete from end
  void deleteFromEnd() {
    if (head == null) return;
    
    if (head!.next == null) {
      head = null;
      _size--;
      return;
    }
    
    ListNode current = head!;
    while (current.next!.next != null) {
      current = current.next!;
    }
    current.next = null;
    _size--;
  }
  
  // Delete by value
  bool deleteByValue(int value) {
    if (head == null) return false;
    
    if (head!.data == value) {
      deleteFromBeginning();
      return true;
    }
    
    ListNode current = head!;
    while (current.next != null && current.next!.data != value) {
      current = current.next!;
    }
    
    if (current.next != null) {
      current.next = current.next!.next;
      _size--;
      return true;
    }
    
    return false;
  }
  
  // Search for a value
  bool search(int value) {
    ListNode? current = head;
    while (current != null) {
      if (current.data == value) return true;
      current = current.next;
    }
    return false;
  }
  
  // Get element at specific position
  int? getAt(int position) {
    if (position < 0 || position >= _size) return null;
    
    ListNode current = head!;
    for (int i = 0; i < position; i++) {
      current = current.next!;
    }
    return current.data;
  }
  
  // Reverse the linked list
  void reverse() {
    ListNode? prev = null;
    ListNode? current = head;
    ListNode? next;
    
    while (current != null) {
      next = current.next;
      current.next = prev;
      prev = current;
      current = next;
    }
    head = prev;
  }
  
  // Display the list
  void display() {
    if (head == null) {
      print('List is empty');
      return;
    }
    
    List<String> elements = [];
    ListNode? current = head;
    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }
    print(elements.join(' -> ') + ' -> null');
  }
  
  // Convert to list
  List<int> toList() {
    List<int> result = [];
    ListNode? current = head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
}
```

---

## Double Linked List

### Structure
In a double linked list, each node contains:
- **Data**: The actual value stored in the node
- **Next**: A reference to the next node
- **Previous**: A reference to the previous node

### Double Linked List Node

```dart
// Double Linked List Node
class DoublyListNode {
  int data;
  DoublyListNode? next;
  DoublyListNode? prev;
  
  DoublyListNode(this.data, [this.next, this.prev]);
  
  @override
  String toString() => data.toString();
}
```

### Double Linked List Class

```dart
class DoubleLinkedList {
  DoublyListNode? head;
  DoublyListNode? tail;
  int _size = 0;
  
  // Get the size of the list
  int get size => _size;
  
  // Check if list is empty
  bool get isEmpty => head == null;
  
  // Insert at the beginning
  void insertAtBeginning(int data) {
    DoublyListNode newNode = DoublyListNode(data);
    
    if (head == null) {
      head = tail = newNode;
    } else {
      newNode.next = head;
      head!.prev = newNode;
      head = newNode;
    }
    _size++;
  }
  
  // Insert at the end
  void insertAtEnd(int data) {
    DoublyListNode newNode = DoublyListNode(data);
    
    if (tail == null) {
      head = tail = newNode;
    } else {
      tail!.next = newNode;
      newNode.prev = tail;
      tail = newNode;
    }
    _size++;
  }
  
  // Insert at specific position (0-indexed)
  void insertAtPosition(int position, int data) {
    if (position < 0 || position > _size) {
      throw ArgumentError('Position out of bounds');
    }
    
    if (position == 0) {
      insertAtBeginning(data);
      return;
    }
    
    if (position == _size) {
      insertAtEnd(data);
      return;
    }
    
    DoublyListNode newNode = DoublyListNode(data);
    DoublyListNode current = head!;
    
    for (int i = 0; i < position; i++) {
      current = current.next!;
    }
    
    newNode.next = current;
    newNode.prev = current.prev;
    current.prev!.next = newNode;
    current.prev = newNode;
    _size++;
  }
  
  // Delete from beginning
  void deleteFromBeginning() {
    if (head == null) return;
    
    if (head == tail) {
      head = tail = null;
    } else {
      head = head!.next;
      head!.prev = null;
    }
    _size--;
  }
  
  // Delete from end
  void deleteFromEnd() {
    if (tail == null) return;
    
    if (head == tail) {
      head = tail = null;
    } else {
      tail = tail!.prev;
      tail!.next = null;
    }
    _size--;
  }
  
  // Delete by value
  bool deleteByValue(int value) {
    DoublyListNode? current = head;
    
    while (current != null) {
      if (current.data == value) {
        if (current == head && current == tail) {
          head = tail = null;
        } else if (current == head) {
          head = current.next;
          head!.prev = null;
        } else if (current == tail) {
          tail = current.prev;
          tail!.next = null;
        } else {
          current.prev!.next = current.next;
          current.next!.prev = current.prev;
        }
        _size--;
        return true;
      }
      current = current.next;
    }
    return false;
  }
  
  // Search for a value
  bool search(int value) {
    DoublyListNode? current = head;
    while (current != null) {
      if (current.data == value) return true;
      current = current.next;
    }
    return false;
  }
  
  // Get element at specific position
  int? getAt(int position) {
    if (position < 0 || position >= _size) return null;
    
    DoublyListNode? current;
    
    // Optimize by starting from head or tail based on position
    if (position < _size ~/ 2) {
      current = head;
      for (int i = 0; i < position; i++) {
        current = current!.next;
      }
    } else {
      current = tail;
      for (int i = _size - 1; i > position; i--) {
        current = current!.prev;
      }
    }
    
    return current!.data;
  }
  
  // Reverse the linked list
  void reverse() {
    DoublyListNode? current = head;
    DoublyListNode? temp;
    
    while (current != null) {
      temp = current.prev;
      current.prev = current.next;
      current.next = temp;
      current = current.prev;
    }
    
    if (temp != null) {
      head = temp.prev;
    }
    
    // Swap head and tail
    temp = head;
    head = tail;
    tail = temp;
  }
  
  // Display forward
  void displayForward() {
    if (head == null) {
      print('List is empty');
      return;
    }
    
    List<String> elements = [];
    DoublyListNode? current = head;
    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }
    print('Forward: null <- ' + elements.join(' <-> ') + ' -> null');
  }
  
  // Display backward
  void displayBackward() {
    if (tail == null) {
      print('List is empty');
      return;
    }
    
    List<String> elements = [];
    DoublyListNode? current = tail;
    while (current != null) {
      elements.add(current.data.toString());
      current = current.prev;
    }
    print('Backward: null <- ' + elements.join(' <-> ') + ' -> null');
  }
  
  // Convert to list
  List<int> toList() {
    List<int> result = [];
    DoublyListNode? current = head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
}
```

---

## Cycle Detection

### Floyd's Cycle Detection Algorithm (Tortoise and Hare)

This algorithm uses two pointers moving at different speeds to detect cycles in a linked list.

```dart
class CycleDetection {
  // Detect cycle using Floyd's algorithm
  static bool hasCycle(ListNode? head) {
    if (head == null || head.next == null) return false;
    
    ListNode? slow = head;
    ListNode? fast = head;
    
    while (fast != null && fast.next != null) {
      slow = slow!.next;
      fast = fast.next!.next;
      
      if (slow == fast) {
        return true; // Cycle detected
      }
    }
    
    return false; // No cycle
  }
  
  // Find the start of the cycle
  static ListNode? findCycleStart(ListNode? head) {
    if (head == null || head.next == null) return null;
    
    ListNode? slow = head;
    ListNode? fast = head;
    
    // First, detect if there's a cycle
    while (fast != null && fast.next != null) {
      slow = slow!.next;
      fast = fast.next!.next;
      
      if (slow == fast) break;
    }
    
    // No cycle found
    if (fast == null || fast.next == null) return null;
    
    // Move one pointer to head and keep other at meeting point
    slow = head;
    while (slow != fast) {
      slow = slow!.next;
      fast = fast!.next;
    }
    
    return slow; // Start of cycle
  }
  
  // Get the length of the cycle
  static int getCycleLength(ListNode? head) {
    if (head == null || head.next == null) return 0;
    
    ListNode? slow = head;
    ListNode? fast = head;
    
    // First, detect if there's a cycle
    while (fast != null && fast.next != null) {
      slow = slow!.next;
      fast = fast.next!.next;
      
      if (slow == fast) break;
    }
    
    // No cycle found
    if (fast == null || fast.next == null) return 0;
    
    // Count the cycle length
    int length = 1;
    fast = fast!.next;
    while (slow != fast) {
      fast = fast!.next;
      length++;
    }
    
    return length;
  }
  
  // Remove cycle from linked list
  static void removeCycle(ListNode? head) {
    if (head == null || head.next == null) return;
    
    ListNode? slow = head;
    ListNode? fast = head;
    
    // Detect cycle
    while (fast != null && fast.next != null) {
      slow = slow!.next;
      fast = fast.next!.next;
      
      if (slow == fast) break;
    }
    
    // No cycle found
    if (fast == null || fast.next == null) return;
    
    // Find the start of cycle
    slow = head;
    while (slow!.next != fast!.next) {
      slow = slow.next;
      fast = fast.next;
    }
    
    // Remove the cycle
    fast.next = null;
  }
}
```

### Alternative Cycle Detection Methods

```dart
class AlternativeCycleDetection {
  // Using HashSet to detect cycle
  static bool hasCycleWithSet(ListNode? head) {
    Set<ListNode> visited = <ListNode>{};
    ListNode? current = head;
    
    while (current != null) {
      if (visited.contains(current)) {
        return true; // Cycle detected
      }
      visited.add(current);
      current = current.next;
    }
    
    return false; // No cycle
  }
  
  // Detect cycle by modifying data (destructive method)
  static bool hasCycleDestructive(ListNode? head) {
    const int marker = -999999; // Special marker value
    ListNode? current = head;
    
    while (current != null) {
      if (current.data == marker) {
        return true; // Cycle detected
      }
      
      int originalData = current.data;
      current.data = marker;
      current = current.next;
    }
    
    return false; // No cycle
  }
}
```

---

## Complete Example Usage

```dart
void main() {
  print('=== Single Linked List Demo ===');
  
  // Single Linked List
  SingleLinkedList sll = SingleLinkedList();
  
  // Insert elements
  sll.insertAtEnd(1);
  sll.insertAtEnd(2);
  sll.insertAtEnd(3);
  sll.insertAtBeginning(0);
  sll.insertAtPosition(2, 99);
  
  print('Original list:');
  sll.display(); // 0 -> 1 -> 99 -> 2 -> 3 -> null
  
  print('Size: ${sll.size}');
  print('Element at position 2: ${sll.getAt(2)}');
  print('Search for 99: ${sll.search(99)}');
  
  // Delete operations
  sll.deleteByValue(99);
  print('After deleting 99:');
  sll.display(); // 0 -> 1 -> 2 -> 3 -> null
  
  // Reverse
  sll.reverse();
  print('After reversing:');
  sll.display(); // 3 -> 2 -> 1 -> 0 -> null
  
  print('\n=== Double Linked List Demo ===');
  
  // Double Linked List
  DoubleLinkedList dll = DoubleLinkedList();
  
  dll.insertAtEnd(10);
  dll.insertAtEnd(20);
  dll.insertAtEnd(30);
  dll.insertAtBeginning(5);
  
  print('Double linked list:');
  dll.displayForward();  // Forward: null <- 5 <-> 10 <-> 20 <-> 30 -> null
  dll.displayBackward(); // Backward: null <- 30 <-> 20 <-> 10 <-> 5 -> null
  
  print('\n=== Cycle Detection Demo ===');
  
  // Create a linked list with cycle for testing
  ListNode node1 = ListNode(1);
  ListNode node2 = ListNode(2);
  ListNode node3 = ListNode(3);
  ListNode node4 = ListNode(4);
  
  node1.next = node2;
  node2.next = node3;
  node3.next = node4;
  node4.next = node2; // Creates cycle: 1 -> 2 -> 3 -> 4 -> 2 (cycle)
  
  print('Has cycle: ${CycleDetection.hasCycle(node1)}'); // true
  print('Cycle length: ${CycleDetection.getCycleLength(node1)}'); // 3
  
  ListNode? cycleStart = CycleDetection.findCycleStart(node1);
  print('Cycle starts at node with data: ${cycleStart?.data}'); // 2
  
  // Remove cycle
  CycleDetection.removeCycle(node1);
  print('Has cycle after removal: ${CycleDetection.hasCycle(node1)}'); // false
}
```

---

## Time and Space Complexities

### Single Linked List
| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Insert at beginning | O(1) | O(1) |
| Insert at end | O(n) | O(1) |
| Insert at position | O(n) | O(1) |
| Delete from beginning | O(1) | O(1) |
| Delete from end | O(n) | O(1) |
| Delete by value | O(n) | O(1) |
| Search | O(n) | O(1) |
| Access by index | O(n) | O(1) |

### Double Linked List
| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Insert at beginning | O(1) | O(1) |
| Insert at end | O(1) | O(1) |
| Insert at position | O(n) | O(1) |
| Delete from beginning | O(1) | O(1) |
| Delete from end | O(1) | O(1) |
| Delete by value | O(n) | O(1) |
| Search | O(n) | O(1) |
| Access by index | O(n) | O(1) |

### Cycle Detection
| Algorithm | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Floyd's Algorithm | O(n) | O(1) |
| HashSet Method | O(n) | O(n) |

---

## Advantages and Disadvantages

### Single Linked List
**Advantages:**
- Dynamic size
- Efficient insertion/deletion at beginning
- Memory efficient (only one pointer per node)

**Disadvantages:**
- No random access
- Extra memory for pointers
- Not cache-friendly
- Cannot traverse backward

### Double Linked List
**Advantages:**
- Bidirectional traversal
- Efficient insertion/deletion at both ends
- Better for operations requiring backward movement

**Disadvantages:**
- Extra memory for previous pointer
- More complex implementation
- Higher memory overhead

---

## Key Concepts Summary

1. **Linked Lists** store data in nodes with pointers to connect them
2. **Single Linked Lists** have unidirectional traversal
3. **Double Linked Lists** allow bidirectional traversal
4. **Cycle Detection** is crucial for avoiding infinite loops
5. **Floyd's Algorithm** is the most efficient cycle detection method
6. **Memory management** is important when implementing in languages without garbage collection

This comprehensive guide covers all essential aspects of linked lists with practical implementations in Dart!
