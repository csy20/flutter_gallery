# Stack Data Structure - Complete Guide

A **Stack** is a linear data structure that follows the **LIFO (Last In, First Out)** principle. The element that is inserted last is the first one to be removed. Think of it like a stack of plates - you can only add or remove plates from the top.

## Table of Contents
1. [Basic Concepts](#basic-concepts)
2. [Stack Operations](#stack-operations)
3. [Implementation Methods](#implementation-methods)
4. [Array-based Implementation](#array-based-implementation)
5. [Linked List-based Implementation](#linked-list-based-implementation)
6. [Built-in List Implementation](#built-in-list-implementation)
7. [Applications](#applications)
8. [Practice Problems](#practice-problems)

---

## Basic Concepts

### Key Characteristics:
- **LIFO Principle**: Last In, First Out
- **Top**: The uppermost element (last inserted)
- **Bottom**: The lowermost element (first inserted)
- **Access**: Only the top element can be accessed directly

### Visual Representation:
```
    |   |  <- Top (Last In, First Out)
    | 3 |
    | 2 |
    | 1 |  <- Bottom
    +---+
```

---

## Stack Operations

### Primary Operations:
1. **Push**: Add an element to the top
2. **Pop**: Remove and return the top element
3. **Peek/Top**: View the top element without removing it
4. **isEmpty**: Check if the stack is empty
5. **Size**: Get the number of elements

### Secondary Operations:
- **Clear**: Remove all elements
- **Display**: Show all elements
- **Search**: Find an element in the stack

---

## Implementation Methods

There are three main ways to implement a stack in Dart:

1. **Array-based**: Using fixed-size array
2. **Linked List-based**: Using dynamic nodes
3. **Built-in List**: Using Dart's List class

---

## Array-based Implementation

### Fixed Size Stack

```dart
class ArrayStack<T> {
  late List<T?> _stack;
  int _top = -1;
  final int _maxSize;
  
  // Constructor
  ArrayStack(this._maxSize) {
    _stack = List.filled(_maxSize, null);
  }
  
  // Check if stack is empty
  bool get isEmpty => _top == -1;
  
  // Check if stack is full
  bool get isFull => _top == _maxSize - 1;
  
  // Get current size
  int get size => _top + 1;
  
  // Get maximum capacity
  int get capacity => _maxSize;
  
  // Push operation - O(1)
  bool push(T element) {
    if (isFull) {
      print('Stack Overflow: Cannot push $element');
      return false;
    }
    
    _stack[++_top] = element;
    return true;
  }
  
  // Pop operation - O(1)
  T? pop() {
    if (isEmpty) {
      print('Stack Underflow: Cannot pop from empty stack');
      return null;
    }
    
    T? element = _stack[_top];
    _stack[_top] = null; // Clear reference
    _top--;
    return element;
  }
  
  // Peek operation - O(1)
  T? peek() {
    if (isEmpty) {
      print('Stack is empty');
      return null;
    }
    return _stack[_top];
  }
  
  // Search for an element - O(n)
  int search(T element) {
    for (int i = _top; i >= 0; i--) {
      if (_stack[i] == element) {
        return _top - i + 1; // Position from top (1-indexed)
      }
    }
    return -1; // Not found
  }
  
  // Clear all elements - O(1)
  void clear() {
    _top = -1;
    _stack.fillRange(0, _maxSize, null);
  }
  
  // Display stack contents - O(n)
  void display() {
    if (isEmpty) {
      print('Stack is empty');
      return;
    }
    
    print('Stack contents (top to bottom):');
    for (int i = _top; i >= 0; i--) {
      String arrow = i == _top ? ' <- TOP' : '';
      print('[$i] ${_stack[i]}$arrow');
    }
    print('---');
  }
  
  // Convert to list - O(n)
  List<T> toList() {
    List<T> result = [];
    for (int i = _top; i >= 0; i--) {
      result.add(_stack[i]!);
    }
    return result;
  }
  
  // Get all elements as string
  @override
  String toString() {
    if (isEmpty) return 'Stack: []';
    
    List<String> elements = [];
    for (int i = _top; i >= 0; i--) {
      elements.add(_stack[i].toString());
    }
    return 'Stack: [${elements.join(', ')}] <- TOP';
  }
}
```

---

## Linked List-based Implementation

### Node Class

```dart
class StackNode<T> {
  T data;
  StackNode<T>? next;
  
  StackNode(this.data, [this.next]);
  
  @override
  String toString() => data.toString();
}
```

### Dynamic Stack

```dart
class LinkedStack<T> {
  StackNode<T>? _top;
  int _size = 0;
  
  // Check if stack is empty
  bool get isEmpty => _top == null;
  
  // Get current size
  int get size => _size;
  
  // Push operation - O(1)
  void push(T element) {
    StackNode<T> newNode = StackNode(element, _top);
    _top = newNode;
    _size++;
  }
  
  // Pop operation - O(1)
  T? pop() {
    if (isEmpty) {
      print('Stack Underflow: Cannot pop from empty stack');
      return null;
    }
    
    T data = _top!.data;
    _top = _top!.next;
    _size--;
    return data;
  }
  
  // Peek operation - O(1)
  T? peek() {
    if (isEmpty) {
      print('Stack is empty');
      return null;
    }
    return _top!.data;
  }
  
  // Search for an element - O(n)
  int search(T element) {
    StackNode<T>? current = _top;
    int position = 1;
    
    while (current != null) {
      if (current.data == element) {
        return position;
      }
      current = current.next;
      position++;
    }
    return -1; // Not found
  }
  
  // Clear all elements - O(1)
  void clear() {
    _top = null;
    _size = 0;
  }
  
  // Display stack contents - O(n)
  void display() {
    if (isEmpty) {
      print('Stack is empty');
      return;
    }
    
    print('Stack contents (top to bottom):');
    StackNode<T>? current = _top;
    int index = 0;
    
    while (current != null) {
      String arrow = index == 0 ? ' <- TOP' : '';
      print('[$index] ${current.data}$arrow');
      current = current.next;
      index++;
    }
    print('---');
  }
  
  // Convert to list - O(n)
  List<T> toList() {
    List<T> result = [];
    StackNode<T>? current = _top;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
  
  // Check if stack contains an element - O(n)
  bool contains(T element) {
    return search(element) != -1;
  }
  
  @override
  String toString() {
    if (isEmpty) return 'Stack: []';
    
    List<String> elements = [];
    StackNode<T>? current = _top;
    
    while (current != null) {
      elements.add(current.data.toString());
      current = current.next;
    }
    return 'Stack: [${elements.join(', ')}] <- TOP';
  }
}
```

---

## Built-in List Implementation

### Simple Stack using Dart List

```dart
class ListStack<T> {
  final List<T> _stack = [];
  
  // Check if stack is empty
  bool get isEmpty => _stack.isEmpty;
  
  // Get current size
  int get size => _stack.length;
  
  // Push operation - O(1) amortized
  void push(T element) {
    _stack.add(element);
  }
  
  // Pop operation - O(1)
  T? pop() {
    if (isEmpty) {
      print('Stack Underflow: Cannot pop from empty stack');
      return null;
    }
    return _stack.removeLast();
  }
  
  // Peek operation - O(1)
  T? peek() {
    if (isEmpty) {
      print('Stack is empty');
      return null;
    }
    return _stack.last;
  }
  
  // Search for an element - O(n)
  int search(T element) {
    for (int i = _stack.length - 1; i >= 0; i--) {
      if (_stack[i] == element) {
        return _stack.length - i; // Position from top (1-indexed)
      }
    }
    return -1; // Not found
  }
  
  // Clear all elements - O(1)
  void clear() {
    _stack.clear();
  }
  
  // Display stack contents - O(n)
  void display() {
    if (isEmpty) {
      print('Stack is empty');
      return;
    }
    
    print('Stack contents (top to bottom):');
    for (int i = _stack.length - 1; i >= 0; i--) {
      String arrow = i == _stack.length - 1 ? ' <- TOP' : '';
      print('[$i] ${_stack[i]}$arrow');
    }
    print('---');
  }
  
  // Get all elements as list (copy)
  List<T> toList() => List.from(_stack.reversed);
  
  // Check if stack contains an element
  bool contains(T element) => _stack.contains(element);
  
  @override
  String toString() {
    if (isEmpty) return 'Stack: []';
    return 'Stack: [${_stack.reversed.join(', ')}] <- TOP';
  }
}
```

---

## Applications

### 1. Expression Evaluation

```dart
class ExpressionEvaluator {
  // Check if parentheses are balanced
  static bool isBalanced(String expression) {
    ListStack<String> stack = ListStack<String>();
    Map<String, String> pairs = {')': '(', '}': '{', ']': '['};
    
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      
      if (char == '(' || char == '{' || char == '[') {
        stack.push(char);
      } else if (char == ')' || char == '}' || char == ']') {
        if (stack.isEmpty || stack.pop() != pairs[char]) {
          return false;
        }
      }
    }
    
    return stack.isEmpty;
  }
  
  // Evaluate postfix expression
  static double evaluatePostfix(String expression) {
    ListStack<double> stack = ListStack<double>();
    List<String> tokens = expression.split(' ');
    
    for (String token in tokens) {
      if (_isOperator(token)) {
        if (stack.size < 2) {
          throw ArgumentError('Invalid postfix expression');
        }
        
        double operand2 = stack.pop()!;
        double operand1 = stack.pop()!;
        double result = _performOperation(operand1, operand2, token);
        stack.push(result);
      } else {
        stack.push(double.parse(token));
      }
    }
    
    if (stack.size != 1) {
      throw ArgumentError('Invalid postfix expression');
    }
    
    return stack.pop()!;
  }
  
  // Convert infix to postfix
  static String infixToPostfix(String infix) {
    ListStack<String> stack = ListStack<String>();
    List<String> result = [];
    List<String> tokens = _tokenize(infix);
    
    for (String token in tokens) {
      if (_isOperand(token)) {
        result.add(token);
      } else if (token == '(') {
        stack.push(token);
      } else if (token == ')') {
        while (!stack.isEmpty && stack.peek() != '(') {
          result.add(stack.pop()!);
        }
        if (!stack.isEmpty) stack.pop(); // Remove '('
      } else if (_isOperator(token)) {
        while (!stack.isEmpty && 
               _precedence(stack.peek()!) >= _precedence(token)) {
          result.add(stack.pop()!);
        }
        stack.push(token);
      }
    }
    
    while (!stack.isEmpty) {
      result.add(stack.pop()!);
    }
    
    return result.join(' ');
  }
  
  static bool _isOperator(String token) {
    return ['+', '-', '*', '/', '^'].contains(token);
  }
  
  static bool _isOperand(String token) {
    return double.tryParse(token) != null;
  }
  
  static double _performOperation(double a, double b, String operator) {
    switch (operator) {
      case '+': return a + b;
      case '-': return a - b;
      case '*': return a * b;
      case '/': return a / b;
      case '^': return math.pow(a, b).toDouble();
      default: throw ArgumentError('Unknown operator: $operator');
    }
  }
  
  static int _precedence(String operator) {
    switch (operator) {
      case '+':
      case '-': return 1;
      case '*':
      case '/': return 2;
      case '^': return 3;
      default: return 0;
    }
  }
  
  static List<String> _tokenize(String expression) {
    // Simple tokenization - can be improved
    return expression.replaceAll(' ', '').split('').where((s) => s.isNotEmpty).toList();
  }
}
```

### 2. Function Call Management

```dart
class CallStack {
  final ListStack<Map<String, dynamic>> _callStack = ListStack();
  
  void enterFunction(String functionName, Map<String, dynamic> parameters) {
    Map<String, dynamic> frame = {
      'function': functionName,
      'parameters': parameters,
      'timestamp': DateTime.now(),
    };
    _callStack.push(frame);
    print('Entering: $functionName');
  }
  
  void exitFunction() {
    if (!_callStack.isEmpty) {
      Map<String, dynamic> frame = _callStack.pop()!;
      print('Exiting: ${frame['function']}');
    }
  }
  
  void displayCallStack() {
    print('\n=== Call Stack ===');
    if (_callStack.isEmpty) {
      print('No active functions');
      return;
    }
    
    List<Map<String, dynamic>> frames = _callStack.toList();
    for (int i = 0; i < frames.length; i++) {
      String arrow = i == 0 ? ' <- CURRENT' : '';
      print('${frames[i]['function']}${arrow}');
    }
    print('==================');
  }
}
```

### 3. Undo/Redo Functionality

```dart
class UndoRedoManager<T> {
  final ListStack<T> _undoStack = ListStack<T>();
  final ListStack<T> _redoStack = ListStack<T>();
  
  void executeCommand(T command) {
    _undoStack.push(command);
    _redoStack.clear(); // Clear redo stack when new command is executed
  }
  
  T? undo() {
    if (_undoStack.isEmpty) {
      print('Nothing to undo');
      return null;
    }
    
    T command = _undoStack.pop()!;
    _redoStack.push(command);
    return command;
  }
  
  T? redo() {
    if (_redoStack.isEmpty) {
      print('Nothing to redo');
      return null;
    }
    
    T command = _redoStack.pop()!;
    _undoStack.push(command);
    return command;
  }
  
  bool get canUndo => !_undoStack.isEmpty;
  bool get canRedo => !_redoStack.isEmpty;
  
  void displayStatus() {
    print('Undo stack size: ${_undoStack.size}');
    print('Redo stack size: ${_redoStack.size}');
  }
}
```

---

## Practice Problems

### 1. Next Greater Element

```dart
class NextGreaterElement {
  static List<int> findNextGreater(List<int> arr) {
    List<int> result = List.filled(arr.length, -1);
    ListStack<int> stack = ListStack<int>();
    
    for (int i = 0; i < arr.length; i++) {
      while (!stack.isEmpty && arr[stack.peek()!] < arr[i]) {
        int index = stack.pop()!;
        result[index] = arr[i];
      }
      stack.push(i);
    }
    
    return result;
  }
}
```

### 2. Valid Parentheses Combinations

```dart
class ParenthesesGenerator {
  static List<String> generateParentheses(int n) {
    List<String> result = [];
    
    void backtrack(String current, int open, int close) {
      if (current.length == 2 * n) {
        result.add(current);
        return;
      }
      
      if (open < n) {
        backtrack(current + '(', open + 1, close);
      }
      
      if (close < open) {
        backtrack(current + ')', open, close + 1);
      }
    }
    
    backtrack('', 0, 0);
    return result;
  }
}
```

### 3. Stock Span Problem

```dart
class StockSpan {
  static List<int> calculateSpan(List<int> prices) {
    List<int> span = [];
    ListStack<int> stack = ListStack<int>();
    
    for (int i = 0; i < prices.length; i++) {
      while (!stack.isEmpty && prices[stack.peek()!] <= prices[i]) {
        stack.pop();
      }
      
      span.add(stack.isEmpty ? i + 1 : i - stack.peek()!);
      stack.push(i);
    }
    
    return span;
  }
}
```

---

## Complete Example Usage

```dart
import 'dart:math' as math;

void main() {
  print('=== Stack Implementations Demo ===\n');
  
  // Array-based Stack
  print('1. Array-based Stack:');
  ArrayStack<int> arrayStack = ArrayStack<int>(5);
  arrayStack.push(10);
  arrayStack.push(20);
  arrayStack.push(30);
  arrayStack.display();
  print('Popped: ${arrayStack.pop()}');
  print('Top element: ${arrayStack.peek()}');
  print('Size: ${arrayStack.size}\n');
  
  // Linked List-based Stack
  print('2. Linked List-based Stack:');
  LinkedStack<String> linkedStack = LinkedStack<String>();
  linkedStack.push('First');
  linkedStack.push('Second');
  linkedStack.push('Third');
  linkedStack.display();
  print('Search "Second": Position ${linkedStack.search("Second")}');
  print('Contains "Fourth": ${linkedStack.contains("Fourth")}\n');
  
  // List-based Stack
  print('3. List-based Stack:');
  ListStack<double> listStack = ListStack<double>();
  listStack.push(1.5);
  listStack.push(2.7);
  listStack.push(3.9);
  print(listStack);
  print('Popped: ${listStack.pop()}');
  print(listStack);
  
  // Expression Evaluation
  print('\n4. Expression Evaluation:');
  print('Balanced "(()())": ${ExpressionEvaluator.isBalanced("(()())")}');
  print('Balanced "((())": ${ExpressionEvaluator.isBalanced("((())")}');
  
  String postfix = "5 3 + 2 *";
  print('Postfix "$postfix" = ${ExpressionEvaluator.evaluatePostfix(postfix)}');
  
  // Call Stack Demo
  print('\n5. Call Stack Demo:');
  CallStack callStack = CallStack();
  callStack.enterFunction('main', {});
  callStack.enterFunction('processData', {'data': 'test'});
  callStack.enterFunction('validateInput', {'input': 'value'});
  callStack.displayCallStack();
  callStack.exitFunction();
  callStack.exitFunction();
  callStack.displayCallStack();
  
  // Undo/Redo Demo
  print('\n6. Undo/Redo Demo:');
  UndoRedoManager<String> undoRedo = UndoRedoManager<String>();
  undoRedo.executeCommand('Type "Hello"');
  undoRedo.executeCommand('Type " World"');
  undoRedo.executeCommand('Delete "d"');
  undoRedo.displayStatus();
  
  print('Undo: ${undoRedo.undo()}');
  print('Undo: ${undoRedo.undo()}');
  print('Redo: ${undoRedo.redo()}');
  undoRedo.displayStatus();
  
  // Problem Solutions
  print('\n7. Problem Solutions:');
  List<int> arr = [4, 5, 2, 25, 7, 8];
  List<int> nextGreater = NextGreaterElement.findNextGreater(arr);
  print('Array: $arr');
  print('Next Greater: $nextGreater');
  
  List<int> prices = [100, 80, 60, 70, 60, 75, 85];
  List<int> spans = StockSpan.calculateSpan(prices);
  print('Stock Prices: $prices');
  print('Stock Spans: $spans');
  
  List<String> parentheses = ParenthesesGenerator.generateParentheses(3);
  print('Valid parentheses combinations for n=3: $parentheses');
}
```

---

## Time and Space Complexities

### Operations Comparison

| Operation | Array Stack | Linked Stack | List Stack |
|-----------|-------------|--------------|------------|
| Push | O(1) | O(1) | O(1) amortized |
| Pop | O(1) | O(1) | O(1) |
| Peek | O(1) | O(1) | O(1) |
| Search | O(n) | O(n) | O(n) |
| Display | O(n) | O(n) | O(n) |

### Space Complexity

| Implementation | Space Complexity | Notes |
|----------------|------------------|-------|
| Array Stack | O(n) | Fixed size, may waste space |
| Linked Stack | O(n) | Dynamic, extra pointer overhead |
| List Stack | O(n) | Dynamic, automatic resizing |

---

## Advantages and Disadvantages

### Array-based Stack
**Advantages:**
- Simple implementation
- Memory efficient (no extra pointers)
- Cache-friendly (contiguous memory)

**Disadvantages:**
- Fixed size
- Stack overflow possible
- Memory waste if not fully used

### Linked List-based Stack
**Advantages:**
- Dynamic size
- No stack overflow
- Memory efficient (grows as needed)

**Disadvantages:**
- Extra memory for pointers
- Not cache-friendly
- More complex implementation

### List-based Stack
**Advantages:**
- Built-in functionality
- Dynamic resizing
- Easy to implement

**Disadvantages:**
- May have overhead
- Less control over memory
- Amortized time complexity for push

---

## Key Takeaways

1. **Stack follows LIFO principle** - Last In, First Out
2. **Primary operations** are push, pop, and peek
3. **Multiple implementation approaches** each with trade-offs
4. **Wide applications** in programming: expression evaluation, function calls, undo operations
5. **Time complexity** is O(1) for basic operations
6. **Choose implementation** based on requirements (fixed vs dynamic size)

This comprehensive guide provides everything you need to understand and implement stacks in Dart!
