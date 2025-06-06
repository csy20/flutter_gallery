void main() {
  print('=== DOUBLY LINKED LIST IN DART ===\n');
  
  // ========== WHAT IS A DOUBLY LINKED LIST? ==========
  print('DOUBLY LINKED LIST CONCEPT:');
  print('- Linear data structure with nodes containing data and two pointers');
  print('- Each node has: data, next pointer, and previous pointer');
  print('- Bidirectional traversal - can move forward and backward');
  print('- More memory overhead than singly linked list');
  print('- Efficient insertion/deletion at both ends: O(1)');
  print('- Better for operations requiring backward traversal\n');
  
  // ========== BASIC OPERATIONS DEMONSTRATION ==========
  print('1. BASIC DOUBLY LINKED LIST OPERATIONS:');
  
  DoublyLinkedList<int> list = DoublyLinkedList<int>();
  print('Created empty doubly linked list');
  print('Is empty: ${list.isEmpty()}');
  print('Size: ${list.size()}\n');
  
  // Insert at beginning
  print('Inserting elements at beginning:');
  list.insertAtBeginning(10);
  list.insertAtBeginning(20);
  list.insertAtBeginning(30);
  print('After inserting 10, 20, 30: $list');
  print('Backward: ${list.toStringReverse()}');
  print('Size: ${list.size()}\n');
  
  // Insert at end
  print('Inserting elements at end:');
  list.insertAtEnd(40);
  list.insertAtEnd(50);
  print('After inserting 40, 50 at end: $list');
  print('Backward: ${list.toStringReverse()}');
  print('Size: ${list.size()}\n');
  
  // Insert at specific position
  print('Inserting at specific positions:');
  list.insertAtPosition(2, 25);
  print('After inserting 25 at position 2: $list');
  list.insertAtPosition(0, 35);
  print('After inserting 35 at position 0: $list');
  print('Backward: ${list.toStringReverse()}');
  print('Size: ${list.size()}\n');
  
  // ========== BIDIRECTIONAL TRAVERSAL ==========
  print('2. BIDIRECTIONAL TRAVERSAL:');
  print('Current list: $list');
  
  print('Forward traversal:');
  list.traverseForward();
  
  print('Backward traversal:');
  list.traverseBackward();
  print('');
  
  // ========== SEARCH OPERATIONS ==========
  print('3. SEARCH OPERATIONS:');
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
  print('4. DELETION OPERATIONS:');
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
  print('5. ADVANCED OPERATIONS:');
  
  // Create a new list for advanced operations
  DoublyLinkedList<int> advList = DoublyLinkedList<int>();
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].forEach(advList.insertAtEnd);
  print('Advanced operations list: $advList');
  
  // Reverse the list in-place
  DoublyLinkedList<int> originalList = DoublyLinkedList.from(advList.toList());
  advList.reverse();
  print('Reversed list: $advList');
  print('Original list: $originalList');
  
  // Find middle element
  int? middle = advList.findMiddle();
  print('Middle element: $middle');
  
  // Get nth node from end (easier with doubly linked list)
  int? nthFromEnd = advList.getNthFromEnd(3);
  print('3rd element from end: $nthFromEnd');
  
  // Count occurrences
  advList.insertAtEnd(5); // Add duplicate
  int count = advList.countOccurrences(5);
  print('Occurrences of 5: $count');
  print('List with duplicate: $advList\n');
  
  // ========== PALINDROME CHECK ==========
  print('6. PALINDROME CHECK:');
  
  DoublyLinkedList<int> palindromeList = DoublyLinkedList<int>();
  [1, 2, 3, 2, 1].forEach(palindromeList.insertAtEnd);
  print('Palindrome test list: $palindromeList');
  print('Is palindrome: ${palindromeList.isPalindrome()}');
  
  DoublyLinkedList<int> nonPalindromeList = DoublyLinkedList<int>();
  [1, 2, 3, 4, 5].forEach(nonPalindromeList.insertAtEnd);
  print('Non-palindrome test list: $nonPalindromeList');
  print('Is palindrome: ${nonPalindromeList.isPalindrome()}\n');
  
  // ========== CIRCULAR DOUBLY LINKED LIST ==========
  print('7. CIRCULAR DOUBLY LINKED LIST:');
  
  CircularDoublyLinkedList<String> circularList = CircularDoublyLinkedList<String>();
  ['A', 'B', 'C', 'D'].forEach(circularList.insert);
  
  print('Circular doubly linked list: $circularList');
  print('Forward traversal (5 steps):');
  circularList.traverseForward(5);
  print('Backward traversal (5 steps):');
  circularList.traverseBackward(5);
  print('');
  
  // ========== PERFORMANCE COMPARISON ==========
  print('8. PERFORMANCE COMPARISON:');
  
  // Compare doubly vs singly linked list operations
  int operations = 5000;
  Stopwatch stopwatch = Stopwatch();
  
  // Doubly linked list insertions at beginning
  DoublyLinkedList<int> perfDoublyList = DoublyLinkedList<int>();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    perfDoublyList.insertAtBeginning(i);
  }
  stopwatch.stop();
  print('DoublyLinkedList - $operations insertions at beginning: ${stopwatch.elapsedMicroseconds} μs');
  
  // Doubly linked list insertions at end
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    perfDoublyList.insertAtEnd(i);
  }
  stopwatch.stop();
  print('DoublyLinkedList - $operations insertions at end: ${stopwatch.elapsedMicroseconds} μs');
  
  // Doubly linked list deletions from end
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < operations; i++) {
    perfDoublyList.deleteFromEnd();
  }
  stopwatch.stop();
  print('DoublyLinkedList - $operations deletions from end: ${stopwatch.elapsedMicroseconds} μs\n');
  
  // ========== REAL-WORLD APPLICATIONS ==========
  print('9. REAL-WORLD APPLICATIONS:');
  
  // Browser History
  BrowserHistory browser = BrowserHistory();
  print('Browser History Implementation:');
  browser.visit('google.com');
  browser.visit('stackoverflow.com');
  browser.visit('github.com');
  browser.displayCurrentPage();
  browser.goBack();
  browser.displayCurrentPage();
  browser.goForward();
  browser.displayCurrentPage();
  print('');
  
  // Text Editor with Undo/Redo
  TextEditor editor = TextEditor();
  print('Text Editor with Undo/Redo:');
  editor.type('Hello');
  editor.type(' World');
  editor.type('!');
  editor.displayText();
  editor.undo();
  editor.displayText();
  editor.redo();
  editor.displayText();
  print('');
  
  // Music Player with Previous/Next
  MusicPlayer player = MusicPlayer();
  print('Music Player Implementation:');
  player.addSong('Song 1');
  player.addSong('Song 2');
  player.addSong('Song 3');
  player.displayCurrentSong();
  player.nextSong();
  player.displayCurrentSong();
  player.previousSong();
  player.displayCurrentSong();
}

// ========== DOUBLY LINKED LIST NODE ==========
class DoublyNode<T> {
  T data;
  DoublyNode<T>? next;
  DoublyNode<T>? prev;
  
  DoublyNode(this.data, [this.next, this.prev]);
  
  @override
  String toString() => 'Node($data)';
}

// ========== DOUBLY LINKED LIST CLASS ==========
class DoublyLinkedList<T> {
  DoublyNode<T>? _head;
  DoublyNode<T>? _tail;
  int _size = 0;
  
  DoublyLinkedList();
  
  // Constructor from iterable
  DoublyLinkedList.from(Iterable<T> iterable) {
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
    DoublyNode<T> newNode = DoublyNode<T>(data);
    
    if (_head == null) {
      _head = _tail = newNode;
    } else {
      newNode.next = _head;
      _head!.prev = newNode;
      _head = newNode;
    }
    _size++;
  }
  
  // Insert at the end - O(1) with tail pointer
  void insertAtEnd(T data) {
    DoublyNode<T> newNode = DoublyNode<T>(data);
    
    if (_tail == null) {
      _head = _tail = newNode;
    } else {
      _tail!.next = newNode;
      newNode.prev = _tail;
      _tail = newNode;
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
    
    if (position == _size) {
      insertAtEnd(data);
      return;
    }
    
    DoublyNode<T> newNode = DoublyNode<T>(data);
    DoublyNode<T> current;
    
    // Optimize by choosing direction based on position
    if (position <= _size ~/ 2) {
      // Start from head
      current = _head!;
      for (int i = 0; i < position; i++) {
        current = current.next!;
      }
    } else {
      // Start from tail
      current = _tail!;
      for (int i = _size - 1; i > position; i--) {
        current = current.prev!;
      }
    }
    
    newNode.next = current;
    newNode.prev = current.prev;
    current.prev!.next = newNode;
    current.prev = newNode;
    _size++;
  }
  
  // ========== TRAVERSAL OPERATIONS ==========
  
  // Forward traversal
  void traverseForward() {
    DoublyNode<T>? current = _head;
    List<T> elements = [];
    
    while (current != null) {
      elements.add(current.data);
      current = current.next;
    }
    
    print('Forward: ${elements.join(' -> ')}');
  }
  
  // Backward traversal
  void traverseBackward() {
    DoublyNode<T>? current = _tail;
    List<T> elements = [];
    
    while (current != null) {
      elements.add(current.data);
      current = current.prev;
    }
    
    print('Backward: ${elements.join(' <- ')}');
  }
  
  // ========== SEARCH OPERATIONS ==========
  
  // Search for an element - O(n)
  bool search(T data) {
    DoublyNode<T>? current = _head;
    while (current != null) {
      if (current.data == data) return true;
      current = current.next;
    }
    return false;
  }
  
  // Find index of element - O(n)
  int indexOf(T data) {
    DoublyNode<T>? current = _head;
    int index = 0;
    
    while (current != null) {
      if (current.data == data) return index;
      current = current.next;
      index++;
    }
    return -1; // Not found
  }
  
  // Get element at position - O(n), optimized for doubly linked list
  T? get(int position) {
    if (position < 0 || position >= _size) return null;
    
    DoublyNode<T> current;
    
    // Optimize by choosing direction based on position
    if (position <= _size ~/ 2) {
      // Start from head
      current = _head!;
      for (int i = 0; i < position; i++) {
        current = current.next!;
      }
    } else {
      // Start from tail
      current = _tail!;
      for (int i = _size - 1; i > position; i--) {
        current = current.prev!;
      }
    }
    
    return current.data;
  }
  
  // Get first element - O(1)
  T? getFirst() => _head?.data;
  
  // Get last element - O(1) with tail pointer
  T? getLast() => _tail?.data;
  
  // ========== DELETION OPERATIONS ==========
  
  // Delete from beginning - O(1)
  T? deleteFromBeginning() {
    if (_head == null) return null;
    
    T data = _head!.data;
    
    if (_head == _tail) {
      // Only one element
      _head = _tail = null;
    } else {
      _head = _head!.next;
      _head!.prev = null;
    }
    
    _size--;
    return data;
  }
  
  // Delete from end - O(1) with tail pointer
  T? deleteFromEnd() {
    if (_tail == null) return null;
    
    T data = _tail!.data;
    
    if (_head == _tail) {
      // Only one element
      _head = _tail = null;
    } else {
      _tail = _tail!.prev;
      _tail!.next = null;
    }
    
    _size--;
    return data;
  }
  
  // Delete at specific position - O(n)
  T? deleteAtPosition(int position) {
    if (position < 0 || position >= _size) return null;
    
    if (position == 0) {
      return deleteFromBeginning();
    }
    
    if (position == _size - 1) {
      return deleteFromEnd();
    }
    
    DoublyNode<T> current;
    
    // Optimize by choosing direction based on position
    if (position <= _size ~/ 2) {
      // Start from head
      current = _head!;
      for (int i = 0; i < position; i++) {
        current = current.next!;
      }
    } else {
      // Start from tail
      current = _tail!;
      for (int i = _size - 1; i > position; i--) {
        current = current.prev!;
      }
    }
    
    T data = current.data;
    current.prev!.next = current.next;
    current.next!.prev = current.prev;
    _size--;
    return data;
  }
  
  // Delete by value - O(n)
  bool deleteByValue(T data) {
    DoublyNode<T>? current = _head;
    
    while (current != null) {
      if (current.data == data) {
        if (current == _head && current == _tail) {
          // Only one element
          _head = _tail = null;
        } else if (current == _head) {
          // First element
          _head = current.next;
          _head!.prev = null;
        } else if (current == _tail) {
          // Last element
          _tail = current.prev;
          _tail!.next = null;
        } else {
          // Middle element
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
  
  // Clear the list - O(1)
  void clear() {
    _head = _tail = null;
    _size = 0;
  }
  
  // ========== ADVANCED OPERATIONS ==========
  
  // Reverse the list in-place - O(n)
  void reverse() {
    DoublyNode<T>? current = _head;
    DoublyNode<T>? temp;
    
    // Swap next and prev for each node
    while (current != null) {
      temp = current.prev;
      current.prev = current.next;
      current.next = temp;
      current = current.prev; // Move to next node (which is prev due to swap)
    }
    
    // Swap head and tail
    temp = _head;
    _head = _tail;
    _tail = temp;
  }
  
  // Find middle element - O(n)
  T? findMiddle() {
    if (_head == null) return null;
    
    DoublyNode<T> slow = _head!;
    DoublyNode<T> fast = _head!;
    
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
    }
    
    return slow.data;
  }
  
  // Get nth node from end - O(n), easier with doubly linked list
  T? getNthFromEnd(int n) {
    if (_tail == null || n <= 0) return null;
    
    DoublyNode<T> current = _tail!;
    
    for (int i = 1; i < n; i++) {
      if (current.prev == null) return null;
      current = current.prev!;
    }
    
    return current.data;
  }
  
  // Count occurrences of a value - O(n)
  int countOccurrences(T data) {
    int count = 0;
    DoublyNode<T>? current = _head;
    
    while (current != null) {
      if (current.data == data) count++;
      current = current.next;
    }
    
    return count;
  }
  
  // Check if list is palindrome - O(n)
  bool isPalindrome() {
    if (_head == null || _head == _tail) return true;
    
    DoublyNode<T>? front = _head;
    DoublyNode<T>? back = _tail;
    
    while (front != back && front!.next != back) {
      if (front!.data != back!.data) return false;
      front = front.next;
      back = back!.prev;
    }
    
    return front!.data == back!.data;
  }
  
  // Convert to Dart List - O(n)
  List<T> toList() {
    List<T> result = [];
    DoublyNode<T>? current = _head;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    
    return result;
  }
  
  // String representation (forward)
  @override
  String toString() {
    if (_head == null) return 'DoublyLinkedList: []';
    
    StringBuffer buffer = StringBuffer('DoublyLinkedList: [');
    DoublyNode<T>? current = _head;
    
    while (current != null) {
      buffer.write(current.data);
      if (current.next != null) buffer.write(' <-> ');
      current = current.next;
    }
    
    buffer.write(']');
    return buffer.toString();
  }
  
  // String representation (reverse)
  String toStringReverse() {
    if (_tail == null) return 'DoublyLinkedList (reverse): []';
    
    StringBuffer buffer = StringBuffer('DoublyLinkedList (reverse): [');
    DoublyNode<T>? current = _tail;
    
    while (current != null) {
      buffer.write(current.data);
      if (current.prev != null) buffer.write(' <-> ');
      current = current.prev;
    }
    
    buffer.write(']');
    return buffer.toString();
  }
}

// ========== CIRCULAR DOUBLY LINKED LIST ==========
class CircularDoublyLinkedList<T> {
  DoublyNode<T>? _head;
  int _size = 0;
  
  bool isEmpty() => _head == null;
  int size() => _size;
  
  void insert(T data) {
    DoublyNode<T> newNode = DoublyNode<T>(data);
    
    if (_head == null) {
      _head = newNode;
      newNode.next = newNode.prev = newNode;
    } else {
      DoublyNode<T> tail = _head!.prev!;
      
      newNode.next = _head;
      newNode.prev = tail;
      tail.next = newNode;
      _head!.prev = newNode;
    }
    _size++;
  }
  
  void traverseForward(int steps) {
    if (_head == null) return;
    
    DoublyNode<T> current = _head!;
    List<T> elements = [];
    
    for (int i = 0; i < steps; i++) {
      elements.add(current.data);
      current = current.next!;
    }
    
    print('Circular forward: ${elements.join(' -> ')}');
  }
  
  void traverseBackward(int steps) {
    if (_head == null) return;
    
    DoublyNode<T> current = _head!;
    List<T> elements = [];
    
    for (int i = 0; i < steps; i++) {
      elements.add(current.data);
      current = current.prev!;
    }
    
    print('Circular backward: ${elements.join(' <- ')}');
  }
  
  @override
  String toString() {
    if (_head == null) return 'CircularDoublyLinkedList: []';
    
    StringBuffer buffer = StringBuffer('CircularDoublyLinkedList: [');
    DoublyNode<T> current = _head!;
    
    do {
      buffer.write(current.data);
      current = current.next!;
      if (current != _head) buffer.write(' <-> ');
    } while (current != _head);
    
    buffer.write('] (circular)');
    return buffer.toString();
  }
}

// ========== REAL-WORLD APPLICATION CLASSES ==========

// Browser History using Doubly Linked List
class BrowserHistory {
  DoublyLinkedList<String> _history = DoublyLinkedList<String>();
  int _currentIndex = -1;
  
  void visit(String url) {
    // Remove any pages after current position (when visiting from middle)
    while (_currentIndex < _history.size() - 1) {
      _history.deleteFromEnd();
    }
    
    _history.insertAtEnd(url);
    _currentIndex++;
    print('Visited: $url');
  }
  
  void goBack() {
    if (_currentIndex > 0) {
      _currentIndex--;
      print('Going back to: ${_history.get(_currentIndex)}');
    } else {
      print('Cannot go back - at beginning of history');
    }
  }
  
  void goForward() {
    if (_currentIndex < _history.size() - 1) {
      _currentIndex++;
      print('Going forward to: ${_history.get(_currentIndex)}');
    } else {
      print('Cannot go forward - at end of history');
    }
  }
  
  void displayCurrentPage() {
    if (_currentIndex >= 0) {
      print('Current page: ${_history.get(_currentIndex)}');
    } else {
      print('No current page');
    }
  }
}

// Text Editor with Undo/Redo using Doubly Linked List
class TextEditor {
  DoublyLinkedList<String> _states = DoublyLinkedList<String>();
  int _currentIndex = -1;
  
  TextEditor() {
    _states.insertAtEnd(''); // Initial empty state
    _currentIndex = 0;
  }
  
  void type(String text) {
    // Remove any states after current position
    while (_currentIndex < _states.size() - 1) {
      _states.deleteFromEnd();
    }
    
    String currentText = _states.get(_currentIndex) ?? '';
    String newText = currentText + text;
    _states.insertAtEnd(newText);
    _currentIndex++;
    print('Typed: "$text"');
  }
  
  void undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      print('Undo performed');
    } else {
      print('Nothing to undo');
    }
  }
  
  void redo() {
    if (_currentIndex < _states.size() - 1) {
      _currentIndex++;
      print('Redo performed');
    } else {
      print('Nothing to redo');
    }
  }
  
  void displayText() {
    String currentText = _states.get(_currentIndex) ?? '';
    print('Current text: "$currentText"');
  }
}

// Music Player using Doubly Linked List
class MusicPlayer {
  DoublyLinkedList<String> _playlist = DoublyLinkedList<String>();
  int _currentIndex = 0;
  
  void addSong(String song) {
    _playlist.insertAtEnd(song);
    print('Added song: $song');
  }
  
  void nextSong() {
    if (_currentIndex < _playlist.size() - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0; // Loop to beginning
    }
    print('Next song');
  }
  
  void previousSong() {
    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _playlist.size() - 1; // Loop to end
    }
    print('Previous song');
  }
  
  void displayCurrentSong() {
    if (_playlist.size() > 0) {
      String currentSong = _playlist.get(_currentIndex) ?? '';
      print('Now playing: $currentSong');
    } else {
      print('No songs in playlist');
    }
  }
}