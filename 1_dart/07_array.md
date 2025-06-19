# Arrays (Lists) in Dart

## Overview
In Dart, arrays are called **Lists**. A List is an ordered collection of objects that can store multiple values of the same or different types. Lists are one of the most commonly used data structures in Dart programming.

## Key Characteristics
- **Ordered**: Elements maintain their insertion order
- **Indexed**: Elements can be accessed using zero-based indexing
- **Dynamic**: Can grow or shrink in size during runtime
- **Generic**: Can be typed to store specific data types
- **Iterable**: Can be traversed using loops and iterators

## Declaration and Initialization

### 1. Basic Declaration
```dart
// Empty list
List<int> numbers = [];
List<String> names = <String>[];

// Using List constructor
List<int> scores = List<int>.empty(growable: true);

// Fixed-length list
List<int> fixedList = List<int>.filled(5, 0); // [0, 0, 0, 0, 0]
```

### 2. List Literals
```dart
// List with initial values
List<int> numbers = [1, 2, 3, 4, 5];
List<String> fruits = ['apple', 'banana', 'orange'];
List<double> prices = [19.99, 25.50, 12.75];

// Mixed types (not recommended)
List<dynamic> mixed = [1, 'hello', 3.14, true];

// Using var with type inference
var colors = ['red', 'green', 'blue'];
var ages = [25, 30, 22, 35];
```

### 3. List Generation
```dart
// Generate list with pattern
List<int> evenNumbers = List.generate(5, (index) => index * 2);
// Result: [0, 2, 4, 6, 8]

// Generate list from range
List<int> range = List.generate(10, (index) => index + 1);
// Result: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

## Accessing Elements

### 1. Index-based Access
```dart
List<String> fruits = ['apple', 'banana', 'orange'];

// Accessing elements
String first = fruits[0];        // 'apple'
String second = fruits[1];       // 'banana'
String last = fruits[fruits.length - 1]; // 'orange'

// Using getter methods
String firstFruit = fruits.first;  // 'apple'
String lastFruit = fruits.last;    // 'orange'
```

### 2. Safe Access
```dart
List<int> numbers = [1, 2, 3];

// Safe access with bounds checking
int? getValue(List<int> list, int index) {
  return index >= 0 && index < list.length ? list[index] : null;
}

// Using elementAt (throws error if out of bounds)
int value = numbers.elementAt(1); // 2
```

## Common Properties

### 1. Length and State
```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];

print(names.length);     // 3
print(names.isEmpty);    // false
print(names.isNotEmpty); // true

List<int> empty = [];
print(empty.isEmpty);    // true
```

### 2. Index Properties
```dart
List<String> colors = ['red', 'green', 'blue'];

print(colors.first);     // 'red'
print(colors.last);      // 'blue'
print(colors.single);    // Error if not exactly one element
```

## Adding Elements

### 1. Single Elements
```dart
List<int> numbers = [1, 2, 3];

// Add to end
numbers.add(4);              // [1, 2, 3, 4]

// Insert at specific position
numbers.insert(0, 0);        // [0, 1, 2, 3, 4]
numbers.insert(2, 1.5);      // Error: int expected
```

### 2. Multiple Elements
```dart
List<String> fruits = ['apple'];

// Add multiple elements
fruits.addAll(['banana', 'orange']);  // ['apple', 'banana', 'orange']

// Insert multiple at position
fruits.insertAll(1, ['grape', 'kiwi']); 
// ['apple', 'grape', 'kiwi', 'banana', 'orange']
```

## Removing Elements

### 1. By Value
```dart
List<String> colors = ['red', 'green', 'blue', 'red'];

// Remove first occurrence
colors.remove('red');        // ['green', 'blue', 'red']

// Remove all occurrences
colors.removeWhere((color) => color == 'red'); // ['green', 'blue']
```

### 2. By Index
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Remove by index
int removed = numbers.removeAt(2);  // removed = 3, list = [1, 2, 4, 5]

// Remove first/last
int first = numbers.removeFirst();  // first = 1, list = [2, 4, 5]
int last = numbers.removeLast();    // last = 5, list = [2, 4]
```

### 3. Range Removal
```dart
List<String> letters = ['a', 'b', 'c', 'd', 'e'];

// Remove range
letters.removeRange(1, 4);  // ['a', 'e']

// Clear all
letters.clear();            // []
```

## Modifying Elements

### 1. Direct Assignment
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Modify single element
numbers[0] = 10;            // [10, 2, 3, 4, 5]

// Modify range
numbers.setRange(1, 3, [20, 30]); // [10, 20, 30, 4, 5]
```

### 2. Fill Operations
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Fill entire list
numbers.fillRange(0, numbers.length, 0); // [0, 0, 0, 0, 0]

// Fill partial range
numbers.fillRange(1, 4, 5); // [0, 5, 5, 5, 0]
```

## Searching and Finding

### 1. Contains and Index
```dart
List<String> fruits = ['apple', 'banana', 'orange'];

// Check if contains
bool hasApple = fruits.contains('apple');     // true
bool hasPear = fruits.contains('pear');       // false

// Find index
int appleIndex = fruits.indexOf('apple');     // 0
int pearIndex = fruits.indexOf('pear');       // -1 (not found)
int lastApple = fruits.lastIndexOf('apple');  // 0
```

### 2. Advanced Finding
```dart
List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Find first element matching condition
int? firstEven = numbers.firstWhere((n) => n % 2 == 0, 
                                   orElse: () => null);  // 2

// Find index with condition
int firstEvenIndex = numbers.indexWhere((n) => n % 2 == 0); // 1

// Check if any/all match condition
bool hasEven = numbers.any((n) => n % 2 == 0);      // true
bool allPositive = numbers.every((n) => n > 0);     // true
```

## Sorting and Ordering

### 1. Basic Sorting
```dart
List<int> numbers = [3, 1, 4, 1, 5, 9, 2, 6];

// Sort in place
numbers.sort();             // [1, 1, 2, 3, 4, 5, 6, 9]

// Reverse
numbers = numbers.reversed.toList(); // [9, 6, 5, 4, 3, 2, 1, 1]
```

### 2. Custom Sorting
```dart
List<String> names = ['Alice', 'bob', 'Charlie', 'david'];

// Case-insensitive sort
names.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
// ['Alice', 'bob', 'Charlie', 'david']

// Sort by length
names.sort((a, b) => a.length.compareTo(b.length));
// ['bob', 'Alice', 'david', 'Charlie']
```

## Iteration Methods

### 1. Basic Loops
```dart
List<String> colors = ['red', 'green', 'blue'];

// For loop
for (int i = 0; i < colors.length; i++) {
  print('$i: ${colors[i]}');
}

// Enhanced for loop
for (String color in colors) {
  print(color);
}

// forEach method
colors.forEach((color) => print(color));
```

### 2. Advanced Iteration
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Map - transform each element
List<int> doubled = numbers.map((n) => n * 2).toList();
// [2, 4, 6, 8, 10]

// Where - filter elements
List<int> evens = numbers.where((n) => n % 2 == 0).toList();
// [2, 4]

// Fold - reduce to single value
int sum = numbers.fold(0, (prev, element) => prev + element);
// 15

// Reduce - combine elements
int product = numbers.reduce((value, element) => value * element);
// 120
```

## List Operations

### 1. Combining Lists
```dart
List<int> list1 = [1, 2, 3];
List<int> list2 = [4, 5, 6];

// Concatenation
List<int> combined = [...list1, ...list2];  // [1, 2, 3, 4, 5, 6]
List<int> combined2 = list1 + list2;        // [1, 2, 3, 4, 5, 6]
```

### 2. Sublist Operations
```dart
List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Get sublist
List<int> middle = numbers.sublist(2, 7);   // [3, 4, 5, 6, 7]
List<int> fromIndex = numbers.sublist(5);   // [6, 7, 8, 9, 10]

// Get range
Iterable<int> range = numbers.getRange(1, 4); // (2, 3, 4)
```

### 3. List Conversion
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// To Set (removes duplicates)
Set<int> uniqueNumbers = numbers.toSet();

// To String
String numberString = numbers.join(', ');    // "1, 2, 3, 4, 5"

// To different type
List<String> stringNumbers = numbers.map((n) => n.toString()).toList();
```

## Advanced Features

### 1. List Comprehension (using where, map, etc.)
```dart
List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Get squares of even numbers
List<int> evenSquares = numbers
    .where((n) => n % 2 == 0)
    .map((n) => n * n)
    .toList();
// [4, 16, 36, 64, 100]
```

### 2. Null Safety with Lists
```dart
List<String>? nullableList;
List<String?> listWithNullElements = ['hello', null, 'world'];

// Safe access
int? length = nullableList?.length;

// Null-aware operations
nullableList?.add('item');

// Remove nulls
List<String> nonNullItems = listWithNullElements
    .where((item) => item != null)
    .cast<String>()
    .toList();
```

### 3. Immutable Lists
```dart
// Unmodifiable list
List<String> originalList = ['a', 'b', 'c'];
List<String> immutableList = List.unmodifiable(originalList);

// Const list (compile-time constant)
const List<int> constList = [1, 2, 3];
```

## Performance Considerations

### 1. List Types
- **Growable Lists**: Dynamic size, more memory overhead
- **Fixed Lists**: Better performance, fixed size
- **Const Lists**: Compile-time optimization

### 2. Best Practices
```dart
// Pre-allocate if size is known
List<int> numbers = List<int>.filled(1000, 0);

// Use appropriate methods
// Efficient for adding multiple items
list.addAll(items);

// Less efficient
for (var item in items) {
  list.add(item);
}
```

## Common Use Cases

### 1. Data Storage
```dart
// Student grades
List<double> grades = [85.5, 92.0, 78.5, 96.0, 88.5];

// Shopping cart items
List<String> cartItems = ['milk', 'bread', 'eggs', 'cheese'];

// Coordinates
List<List<double>> points = [[0.0, 0.0], [1.0, 1.0], [2.0, 2.0]];
```

### 2. Algorithm Implementation
```dart
// Stack using List
class Stack<T> {
  final List<T> _items = [];
  
  void push(T item) => _items.add(item);
  T? pop() => _items.isNotEmpty ? _items.removeLast() : null;
  T? peek() => _items.isNotEmpty ? _items.last : null;
  bool get isEmpty => _items.isEmpty;
}

// Queue using List
class Queue<T> {
  final List<T> _items = [];
  
  void enqueue(T item) => _items.add(item);
  T? dequeue() => _items.isNotEmpty ? _items.removeAt(0) : null;
  bool get isEmpty => _items.isEmpty;
}
```

## Practical Examples

### 1. Grade Calculator
```dart
List<double> calculateGradeStats(List<double> grades) {
  if (grades.isEmpty) return [0.0, 0.0, 0.0];
  
  double sum = grades.fold(0.0, (prev, grade) => prev + grade);
  double average = sum / grades.length;
  
  List<double> sortedGrades = [...grades]..sort();
  double min = sortedGrades.first;
  double max = sortedGrades.last;
  
  return [average, min, max];
}
```

### 2. Text Analysis
```dart
Map<String, int> analyzeText(String text) {
  List<String> words = text.toLowerCase()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
  
  Map<String, int> wordCount = {};
  for (String word in words) {
    wordCount[word] = (wordCount[word] ?? 0) + 1;
  }
  
  return wordCount;
}
```

### 3. Data Filtering and Transformation
```dart
class Person {
  String name;
  int age;
  String city;
  
  Person(this.name, this.age, this.city);
  
  @override
  String toString() => '$name ($age) from $city';
}

void processPersonData() {
  List<Person> people = [
    Person('Alice', 25, 'New York'),
    Person('Bob', 30, 'San Francisco'),
    Person('Charlie', 22, 'New York'),
    Person('Diana', 28, 'Los Angeles'),
  ];
  
  // Filter adults from New York
  List<Person> nyAdults = people
      .where((person) => person.city == 'New York' && person.age >= 25)
      .toList();
  
  // Get all cities
  List<String> cities = people
      .map((person) => person.city)
      .toSet()
      .toList()
    ..sort();
  
  // Calculate average age
  double averageAge = people
      .map((person) => person.age)
      .fold(0, (prev, age) => prev + age) / people.length;
}
```

## Common Pitfalls and Solutions

### 1. Index Out of Bounds
```dart
List<int> numbers = [1, 2, 3];

// Problem
// int value = numbers[5]; // RangeError

// Solution
int? safeGet(List<int> list, int index) {
  return index >= 0 && index < list.length ? list[index] : null;
}
```

### 2. Modifying List While Iterating
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Problem - can cause issues
// for (int i = 0; i < numbers.length; i++) {
//   if (numbers[i] % 2 == 0) {
//     numbers.removeAt(i); // Modifies list during iteration
//   }
// }

// Solution 1 - iterate backwards
for (int i = numbers.length - 1; i >= 0; i--) {
  if (numbers[i] % 2 == 0) {
    numbers.removeAt(i);
  }
}

// Solution 2 - use removeWhere
numbers.removeWhere((n) => n % 2 == 0);
```

### 3. Null Safety Issues
```dart
List<String?> names = ['Alice', null, 'Bob'];

// Problem
// int totalLength = names.map((name) => name.length).fold(0, (a, b) => a + b);

// Solution
int totalLength = names
    .where((name) => name != null)
    .map((name) => name!.length)
    .fold(0, (a, b) => a + b);
```

## Summary

Lists in Dart are powerful, flexible data structures that provide:

- **Dynamic sizing** with efficient operations
- **Rich API** for manipulation and querying
- **Type safety** with generic support
- **Functional programming** features
- **Null safety** integration
- **Performance optimizations** for different use cases

Understanding Lists is fundamental to Dart programming as they're used extensively in Flutter development, data processing, and algorithm implementation.