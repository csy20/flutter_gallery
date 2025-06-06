void main() {
  print('=== SINGLY LINKED LIST IN DART ===\n');
  
  // ========== WHAT IS A SINGLY LINKED LIST? ==========
  print('SINGLY LINKED LIST CONCEPT:');
  print('- Linear data structure where elements are stored in nodes');
  print('- Each node contains data and a reference to the next node');
  print('- Dynamic size - can grow or shrink during runtime');
  print('- No random access - must traverse from head to reach elements');
  print('- Efficient insertion/deletion at beginning: O(1)');
  print('- Memory efficient - allocates memory as needed\n');
  
  // ========== BASIC OPERATIONS DEMONSTRATION ==========
  print('1. BASIC LINKED LIST OPERATIONS:');
  
  SinglyLinkedList<int> list = SinglyLinkedList<int>();
  print('Created empty linked list');
  print('Is empty: ${list.isEmpty()}');
  print('Size: ${list.size()}\n');
  
  // Insert at beginning
  print('Inserting elements at beginning:');
  list.insertAtBeginning(10);
  list.insertAtBeginning(20);
  list.insertAtBeginning(30);
  print('After inserting 10, 20, 30: $list');
  print('Size: ${list.size()}\n');
  
  // Insert at end
  print('Inserting elements at end:');
  list.insertAtEnd(40);
  list.insertAtEnd(50);
  print('After inserting 40, 50 at end: $list');
  print('Size: ${list.size()}\n');
  
  // Insert at specific position
  print('Inserting at specific positions:');
  list.insertAtPosition(2, 25);
  print('After inserting 25 at position 2: $list');
  list.insertAtPosition(0, 35);
  print('After inserting 35 at position 0: $list');
  print('Size: ${list.size()}\n');
  
  // ========== SEARCH OPERATIONS ==========
  print('2. SEARCH OPERATIONS:');
  print('Current list: $list');
  
  // Search for elements
  print('Search for 25: ${list.search(25)}');
  print('Search for 100: ${list.search(100)}');
  
  // Find position of elements
  print('Position of 40: ${list.indexOf(40)}');
  print('Position of 999: ${list.indexOf(999)}');
  
  // Get element at position
  print('Element at position 3: ${list.get(3)}');
  print('Element at position 10: ${list.get(10)}');
  
  // Get first and last elements
  print('First element: ${list.getFirst()}');
  print('Last element: ${list.getLast()}\n');
  
  // ========== DELETION OPERATIONS ==========
  print('3. DELETION OPERATIONS:');
  print('Before deletions: $list');
  
  // Delete from beginning
  int? deletedFirst = list.deleteFromBeginning();
  print('Deleted from beginning: $deletedFirst');
  print('After deletion: $list');
  
  // Delete from end
  int? deletedLast = list.deleteFromEnd();
  print('Deleted from end: $deletedLast');
  print('After deletion: $list');
  
  // Delete at specific position
  int? deletedAtPos = list.deleteAtPosition(2);
  print('Deleted at position 2: $deletedAtPos');
  print('After deletion: $list');
  
  // Delete by value
  bool deleted = list.deleteByValue(20);
  print('Deleted value 20: $deleted');
  print('After deletion: $list');
  print('Final size: ${list.size()}\n');
  
  // ========== ADVANCED OPERATIONS ==========
  print('4. ADVANCED OPERATIONS:');
  
  // Create a new list for advanced operations
  SinglyLinkedList<int> advList = SinglyLinkedList<int>();
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].forEach(advList.insertAtEnd);
  print('Advanced operations list: $advList');
  
  // Reverse the list
  SinglyLinkedList<int> reversedList = SinglyLinkedList.from(advList.toList().reversed);
  print('Reversed list: $reversedList');
  
  // Find middle element
  int? middle = advList.findMiddle();
  print('Middle element: $middle');
  
  // Detect if list has cycle (it doesn't in this case)
  bool hasCycle = advList.hasCycle();
  print('Has cycle: $hasCycle');
  
  // Get nth node from end
  int? nthFromEnd = advList.getNthFromEnd(3);
  print('3rd element from end: $nthFromEnd');
  
  // Count occurrences
  advList.insertAtEnd(5); // Add duplicate
  int count = advList.countOccurrences(5);
  print('Occurrences of 5: $count');
  print('List with duplicate: $advList\n');
  
  // ========== LIST MANIPULATION ==========
  print('5. LIST MANIPULATION:');
  
  // Create two lists for merging
  SinglyLinkedList<int> list1 = SinglyLinkedList<int>();
  SinglyLinkedList<int> list2 = SinglyLinkedList<int>();
  
  [1, 3, 5].forEach(list1.insertAtEnd);
  [2, 4, 6].forEach(list2.insertAtEnd);
  
  print('List 1: $list1');
  print('List 2: $list2');
  
  // Merge two sorted lists
  SinglyLinkedList<int> mergedList = mergeSortedLists(list1, list2);
  print('Merged sorted list: $mergedList');
  
  // Remove duplicates
  SinglyLinkedList<int> duplicateList = SinglyLinkedList<int>();
  [1, 2, 2, 3, 3, 3, 4, 5, 5].forEach(duplicateList.insertAtEnd);
  print('List with duplicates: $duplicateList');
  duplicateList.removeDuplicates();
  print('After removing duplicates: $duplicateList\n');
  
  // ========== PERFORMANCE COMPARISON ==========
  print('6. PERFORMANCE COMPARISON:');
  
  // Compare with Dart List
  Stopwatch stopwatch = Stopwatch();
  int operations = 10000;
  
  // Linked List insertions at beginning
  SinglyLinkedList<int> perfList = SinglyLinkedList<int>();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    perfList.insertAtBeginning(i);
  }
  stopwatch.stop();
  print('LinkedList - $operations insertions at beginning: ${stopwatch.elapsedMicroseconds} μs');
  
  // Dart List insertions at beginning
  List<int> dartList = [];
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    dartList.insert(0, i);
  }
  stopwatch.stop();
  print('Dart List - $operations insertions at beginning: ${stopwatch.elapsedMicroseconds} μs');
  
  // Clear for end insertions
  perfList.clear();
  dartList.clear();
  
  // Linked List insertions at end
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    perfList.insertAtEnd(i);
  }
  stopwatch.stop();
  print('LinkedList - $operations insertions at end: ${stopwatch.elapsedMicroseconds} μs');
  
  // Dart List insertions at end
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    dartList.add(i);
  }
  stopwatch.stop();
  print('Dart List - $operations insertions at end: ${stopwatch.elapsedMicroseconds} μs\n');
  
  // ========== REAL-WORLD APPLICATIONS ==========
  print('7. REAL-WORLD APPLICATIONS:');
  
  // Undo functionality
  UndoRedoManager undoManager = UndoRedoManager();
  print('Implementing Undo/Redo with Linked List:');
  undoManager.executeCommand('Type "Hello"');
  undoManager.executeCommand('Type " World"');
  undoManager.executeCommand('Delete 2 chars');
  print('Commands executed. Current state after undo operations:');
  undoManager.undo();
  undoManager.undo();
  print('');
  
  // Music playlist
  MusicPlaylist playlist = MusicPlaylist();
  print('Music Playlist with Linked List:');
  playlist.addSong('Song 1');
  playlist.addSong('Song 2');
  playlist.addSong('Song 3');
  playlist.displayPlaylist();
  print('Playing: ${playlist.getCurrentSong()}');
  playlist.nextSong();
  print('Next song: ${playlist.getCurrentSong()}');
  playlist.previousSong();
  print('Previous song: ${playlist.getCurrentSong()}');
}

// ========== NODE CLASS ==========
class Node<T> {
  T data;
  Node<T>? next;
  
  Node(this.data, [this.next]);
  
  @override
  String toString() => 'Node($data)';
}

// ========== SINGLY LINKED LIST CLASS ==========
class SinglyLinkedList<T> {
  Node<T>? _head;
  int _size = 0;
  
  SinglyLinkedList();
  
  // Constructor from iterable
  SinglyLinkedList.from(Iterable<T> iterable) {
    for (T item in iterable) {
      insertAtEnd(item);
    }
  }
  
  // ========== BASIC OPERATIONS ==========
  
  // Check if list is empty
  bool isEmpty() => _head == null;
  
  // Get size of the list
  int size() => _size;
  
  // Insert at the beginning - O(1)
  void insertAtBeginning(T data) {
    Node<T> newNode = Node<T>(data, _head);
    _head = newNode;
    _size++;
  }
  
  // Insert at the end - O(n)
  void insertAtEnd(T data) {
    Node<T> newNode = Node<T>(data);
    
    if (_head == null) {
      _head = newNode;
    } else {
      Node<T> current = _head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = newNode;
    }
    _size++;
  }
  
  // Insert at specific position - O(n)
  void insertAtPosition(int position, T data) {
    if (position < 0 || position > _size) {
      throw RangeError('Position out of bounds');
    }
    
    if (position == 0) {
      insertAtBeginning(data);
      return;
    }
    
    Node<T> newNode = Node<T>(data);
    Node<T> current = _head!;
    
    for (int i = 0; i < position - 1; i++) {
      current = current.next!;
    }
    
    newNode.next = current.next;
    current.next = newNode;
    _size++;
  }
  
  // ========== SEARCH OPERATIONS ==========
  
  // Search for an element - O(n)
  bool search(T data) {
    Node<T>? current = _head;
    while (current != null) {
      if (current.data == data) return true;
      current = current.next;
    }
    return false;
  }
  
  // Find index of element - O(n)
  int indexOf(T data) {
    Node<T>? current = _head;
    int index = 0;
    
    while (current != null) {
      if (current.data == data) return index;
      current = current.next;
      index++;
    }
    return -1; // Not found
  }
  
  // Get element at position - O(n)
  T? get(int position) {
    if (position < 0 || position >= _size) return null;
    
    Node<T> current = _head!;
    for (int i = 0; i < position; i++) {
      current = current.next!;
    }
    return current.data;
  }
  
  // Get first element - O(1)
  T? getFirst() => _head?.data;
  
  // Get last element - O(n)
  T? getLast() {
    if (_head == null) return null;
    
    Node<T> current = _head!;
    while (current.next != null) {
      current = current.next!;
    }
    return current.data;
  }
  
  // ========== DELETION OPERATIONS ==========
  
  // Delete from beginning - O(1)
  T? deleteFromBeginning() {
    if (_head == null) return null;
    
    T data = _head!.data;
    _head = _head!.next;
    _size--;
    return data;
  }
  
  // Delete from end - O(n)
  T? deleteFromEnd() {
    if (_head == null) return null;
    
    if (_head!.next == null) {
      T data = _head!.data;
      _head = null;
      _size--;
      return data;
    }
    
    Node<T> current = _head!;
    while (current.next!.next != null) {
      current = current.next!;
    }
    
    T data = current.next!.data;
    current.next = null;
    _size--;
    return data;
  }
  
  // Delete at specific position - O(n)
  T? deleteAtPosition(int position) {
    if (position < 0 || position >= _size) return null;
    
    if (position == 0) {
      return deleteFromBeginning();
    }
    
    Node<T> current = _head!;
    for (int i = 0; i < position - 1; i++) {
      current = current.next!;
    }
    
    T data = current.next!.data;
    current.next = current.next!.next;
    _size--;
    return data;
  }
  
  // Delete by value - O(n)
  bool deleteByValue(T data) {
    if (_head == null) return false;
    
    if (_head!.data == data) {
      _head = _head!.next;
      _size--;
      return true;
    }
    
    Node<T> current = _head!;
    while (current.next != null && current.next!.data != data) {
      current = current.next!;
    }
    
    if (current.next != null) {
      current.next = current.next!.next;
      _size--;
      return true;
    }
    
    return false;
  }
  
  // Clear the list - O(1)
  void clear() {
    _head = null;
    _size = 0;
  }
  
  // ========== ADVANCED OPERATIONS ==========
  
  // Find middle element - O(n)
  T? findMiddle() {
    if (_head == null) return null;
    
    Node<T> slow = _head!;
    Node<T> fast = _head!;
    
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
    }
    
    return slow.data;
  }
  
  // Detect cycle using Floyd's algorithm - O(n)
  bool hasCycle() {
    if (_head == null) return false;
    
    Node<T> slow = _head!;
    Node<T> fast = _head!;
    
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
      
      if (slow == fast) return true;
    }
    
    return false;
  }
  
  // Get nth node from end - O(n)
  T? getNthFromEnd(int n) {
    if (_head == null || n <= 0) return null;
    
    Node<T> first = _head!;
    Node<T> second = _head!;
    
    // Move first pointer n steps ahead
    for (int i = 0; i < n; i++) {
      if (first.next == null) return null;
      first = first.next!;
    }
    
    // Move both pointers until first reaches end
    while (first.next != null) {
      first = first.next!;
      second = second.next!;
    }
    
    return second.data;
  }
  
  // Count occurrences of a value - O(n)
  int countOccurrences(T data) {
    int count = 0;
    Node<T>? current = _head;
    
    while (current != null) {
      if (current.data == data) count++;
      current = current.next;
    }
    
    return count;
  }
  
  // Remove duplicates - O(n²)
  void removeDuplicates() {
    if (_head == null) return;
    
    Node<T> current = _head!;
    
    while (current.next != null) {
      if (current.data == current.next!.data) {
        current.next = current.next!.next;
        _size--;
      } else {
        current = current.next!;
      }
    }
  }
  
  // Convert to Dart List - O(n)
  List<T> toList() {
    List<T> result = [];
    Node<T>? current = _head;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    
    return result;
  }
  
  // String representation
  @override
  String toString() {
    if (_head == null) return 'LinkedList: []';
    
    StringBuffer buffer = StringBuffer('LinkedList: [');
    Node<T>? current = _head;
    
    while (current != null) {
      buffer.write(current.data);
      if (current.next != null) buffer.write(' -> ');
      current = current.next;
    }
    
    buffer.write(']');
    return buffer.toString();
  }
}

// ========== UTILITY FUNCTIONS ==========

// Merge two sorted linked lists
SinglyLinkedList<int> mergeSortedLists(SinglyLinkedList<int> list1, SinglyLinkedList<int> list2) {
  SinglyLinkedList<int> result = SinglyLinkedList<int>();
  List<int> merged = [];
  
  // Convert to lists, merge, and sort
  merged.addAll(list1.toList());
  merged.addAll(list2.toList());
  merged.sort();
  
  // Create new linked list from merged data
  for (int item in merged) {
    result.insertAtEnd(item);
  }
  
  return result;
}

// ========== REAL-WORLD APPLICATION CLASSES ==========

// Undo/Redo Manager using Linked List
class UndoRedoManager {
  SinglyLinkedList<String> _commands = SinglyLinkedList<String>();
  
  void executeCommand(String command) {
    _commands.insertAtBeginning(command);
    print('Executed: $command');
  }
  
  void undo() {
    String? command = _commands.deleteFromBeginning();
    if (command != null) {
      print('Undoing: $command');
    } else {
      print('Nothing to undo');
    }
  }
}

// Music Playlist using Linked List
class MusicPlaylist {
  SinglyLinkedList<String> _songs = SinglyLinkedList<String>();
  int _currentIndex = 0;
  
  void addSong(String song) {
    _songs.insertAtEnd(song);
  }
  
  String? getCurrentSong() {
    return _songs.get(_currentIndex);
  }
  
  void nextSong() {
    if (_currentIndex < _songs.size() - 1) {
      _currentIndex++;
    }
  }
  
  void previousSong() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
  }
  
  void displayPlaylist() {
    print('Playlist: ${_songs.toString()}');
  }
}