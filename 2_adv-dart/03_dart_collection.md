# Dart Collections - Complete Guide

## Table of Contents
1. [What are Collections?](#what-are-collections)
2. [Memory Model and Internal Structure](#memory-model-and-internal-structure)
3. [List Collection](#list-collection)
4. [Set Collection](#set-collection)
5. [Map Collection](#map-collection)
6. [Queue Collection](#queue-collection)
7. [Iterable and Iterator Pattern](#iterable-and-iterator-pattern)
8. [Collection Operations](#collection-operations)
9. [Performance Characteristics](#performance-characteristics)
10. [Advanced Collection Concepts](#advanced-collection-concepts)

## What are Collections?

Collections in Dart are **data structures that group multiple elements together**. They are fundamental building blocks for organizing and manipulating data in your applications. Think of collections as containers that can hold multiple values of the same or different types.

### Why Collections Matter

```dart
// Without collections - managing multiple values is cumbersome
String student1 = 'Alice';
String student2 = 'Bob';
String student3 = 'Charlie';
// What if we have 100 students? This approach doesn't scale.

// With collections - elegant and scalable
List<String> students = ['Alice', 'Bob', 'Charlie'];
// Easy to add, remove, search, and iterate through students
```

### Collection Hierarchy in Dart

```
Object
  ├── Iterable<E>
  │   ├── List<E>
  │   ├── Set<E>
  │   └── Queue<E>
  └── Map<K, V>
```

All Dart collections (except Map) implement the `Iterable` interface, which provides common iteration capabilities.

## Memory Model and Internal Structure

Understanding how collections store data in memory is crucial for writing efficient code.

### Memory Layout Concepts

#### 1. Reference vs Value Storage
```dart
// Collections store references to objects, not the objects themselves
List<String> names = ['Alice', 'Bob'];

// Memory layout (simplified):
// names variable → [reference1, reference2]
//                      ↓         ↓
//                   'Alice'    'Bob'

// When you assign a collection to another variable
List<String> copyNames = names;
// Both variables point to the SAME collection in memory
copyNames.add('Charlie');
print(names); // ['Alice', 'Bob', 'Charlie'] - original is modified!
```

#### 2. Shallow vs Deep Copy
```dart
// Shallow copy - copies references
List<String> original = ['Alice', 'Bob'];
List<String> shallowCopy = List.from(original);
shallowCopy.add('Charlie');
print(original);     // ['Alice', 'Bob'] - unchanged
print(shallowCopy);  // ['Alice', 'Bob', 'Charlie']

// Deep copy for nested structures
List<List<String>> nested = [['Alice'], ['Bob']];
List<List<String>> deepCopy = nested.map((list) => List<String>.from(list)).toList();
```

### Collection Growth and Capacity

#### Dynamic Sizing
```dart
// Lists grow dynamically
List<int> numbers = [1, 2, 3]; // Initial capacity might be 4
numbers.add(4); // Still fits in current capacity
numbers.add(5); // Might trigger capacity expansion (e.g., to 8)

// You can inspect current length
print(numbers.length); // 5

// Growth strategy: typically doubles when capacity is exceeded
// [1,2,3,_] → [1,2,3,4] → [1,2,3,4,5,_,_,_] (expanded)
```

## List Collection

Lists are **ordered collections** that allow duplicate elements and provide indexed access.

### Internal Structure

Lists in Dart are implemented as **dynamic arrays** (similar to ArrayList in Java or Array in JavaScript).

```dart
// Internal structure (conceptual):
// Index:   0    1    2    3    4    5    6    7
// Data:  ['A', 'B', 'C',  _,   _,   _,   _,   _]
//                    ↑
//                 length = 3, capacity = 8
```

### List Creation and Types

#### 1. Growable Lists (Default)
```dart
// Empty growable list
List<String> names = [];
List<String> names2 = <String>[];
List<String> names3 = List<String>.empty(growable: true);

// Pre-populated growable list
List<int> numbers = [1, 2, 3, 4, 5];
List<String> fruits = ['apple', 'banana', 'orange'];

// Using List constructor
List<int> range = List.generate(5, (index) => index * 2);
print(range); // [0, 2, 4, 6, 8]
```

#### 2. Fixed-Length Lists
```dart
// Fixed-length list (cannot add/remove elements)
List<String> fixedList = List.filled(3, 'empty');
print(fixedList); // ['empty', 'empty', 'empty']

// Can modify existing elements
fixedList[0] = 'first';
fixedList[1] = 'second';
print(fixedList); // ['first', 'second', 'empty']

// Cannot add or remove
// fixedList.add('fourth'); // Error: Unsupported operation
```

#### 3. Unmodifiable Lists
```dart
List<String> originalList = ['a', 'b', 'c'];
List<String> unmodifiableList = List.unmodifiable(originalList);

// Cannot modify
// unmodifiableList.add('d');     // Error
// unmodifiableList[0] = 'x';     // Error

// But original can still be modified
originalList.add('d');
print(unmodifiableList); // ['a', 'b', 'c', 'd'] - reflects changes!
```

### List Operations and Performance

#### Adding Elements
```dart
List<String> fruits = ['apple'];

// Add to end - O(1) amortized
fruits.add('banana');
fruits.addAll(['orange', 'grape']);

// Insert at position - O(n) due to shifting
fruits.insert(1, 'kiwi'); // ['apple', 'kiwi', 'banana', 'orange', 'grape']

// Insert multiple at position - O(n)
fruits.insertAll(2, ['mango', 'pineapple']);

print(fruits);
```

#### Accessing Elements
```dart
List<String> colors = ['red', 'green', 'blue'];

// Index access - O(1)
String firstColor = colors[0];        // 'red'
String lastColor = colors.last;       // 'blue'
String secondColor = colors[1];       // 'green'

// Safe access with bounds checking
String? safeAccess = colors.length > 5 ? colors[5] : null;

// Using elementAt - O(1) for List
String elementAt = colors.elementAt(1); // 'green'
```

#### Searching Elements
```dart
List<String> animals = ['cat', 'dog', 'bird', 'fish', 'dog'];

// Finding elements - O(n)
int index = animals.indexOf('dog');        // 0 (first occurrence)
int lastIndex = animals.lastIndexOf('dog'); // 4 (last occurrence)
bool contains = animals.contains('bird');   // true

// Finding with condition - O(n)
String? found = animals.firstWhere(
  (animal) => animal.startsWith('f'),
  orElse: () => 'none'
); // 'fish'

// Check if any/all match condition
bool hasLongName = animals.any((animal) => animal.length > 4); // false
bool allShortNames = animals.every((animal) => animal.length <= 4); // true
```

#### Removing Elements
```dart
List<int> numbers = [1, 2, 3, 2, 4, 5];

// Remove by value - O(n)
bool removed = numbers.remove(2);  // true, removes first occurrence
print(numbers); // [1, 3, 2, 4, 5]

// Remove by index - O(n) due to shifting
int removedElement = numbers.removeAt(2); // removes '2', returns it
print(numbers); // [1, 3, 4, 5]

// Remove last - O(1)
int lastElement = numbers.removeLast(); // 5
print(numbers); // [1, 3, 4]

// Remove range - O(n)
numbers.removeRange(1, 3); // removes elements from index 1 to 2
print(numbers); // [1]

// Remove with condition - O(n)
List<int> values = [1, 2, 3, 4, 5, 6];
values.removeWhere((value) => value.isEven);
print(values); // [1, 3, 5]
```

### Advanced List Operations

#### List Transformation
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Map - transform each element
List<int> doubled = numbers.map((n) => n * 2).toList();
print(doubled); // [2, 4, 6, 8, 10]

// Where - filter elements
List<int> evens = numbers.where((n) => n.isEven).toList();
print(evens); // [2, 4]

// Expand - flatten nested structures
List<List<int>> nested = [[1, 2], [3, 4], [5]];
List<int> flattened = nested.expand((list) => list).toList();
print(flattened); // [1, 2, 3, 4, 5]
```

#### List Aggregation
```dart
List<int> scores = [85, 92, 78, 96, 88];

// Reduce - combine elements into single value
int sum = scores.reduce((a, b) => a + b); // 439
int max = scores.reduce((a, b) => a > b ? a : b); // 96

// Fold - like reduce but with initial value
double average = scores.fold(0, (sum, score) => sum + score) / scores.length;
print(average); // 87.8

// Join - create string from elements
String scoreString = scores.map((s) => s.toString()).join(', ');
print(scoreString); // "85, 92, 78, 96, 88"
```

## Set Collection

Sets are **unordered collections** of unique elements. They automatically prevent duplicates.

### Internal Structure

Sets are typically implemented using **hash tables** for O(1) average-case operations.

```dart
// Internal structure (conceptual hash table):
// Hash buckets: [bucket0, bucket1, bucket2, ..., bucketN]
// Each bucket contains elements with the same hash code
// Collision resolution: usually chaining or open addressing
```

### Set Creation and Operations

#### Creating Sets
```dart
// Empty set
Set<String> emptySet = <String>{};
Set<String> emptySet2 = Set<String>();

// Pre-populated set
Set<int> numbers = {1, 2, 3, 4, 5};
Set<String> fruits = {'apple', 'banana', 'orange'};

// From other collections
List<String> duplicateList = ['a', 'b', 'a', 'c', 'b'];
Set<String> uniqueSet = Set.from(duplicateList);
print(uniqueSet); // {'a', 'b', 'c'} - duplicates removed

// Using Set constructor
Set<int> evenNumbers = Set.from([2, 4, 6, 8, 10]);
```

#### Set Operations
```dart
Set<String> fruits = {'apple', 'banana', 'orange'};

// Add elements - O(1) average case
fruits.add('grape');
fruits.add('apple'); // Duplicate ignored
print(fruits); // {'apple', 'banana', 'orange', 'grape'}

// Add multiple elements
fruits.addAll(['kiwi', 'mango', 'apple']); // 'apple' duplicate ignored

// Remove elements - O(1) average case
bool removed = fruits.remove('banana'); // true
bool notRemoved = fruits.remove('strawberry'); // false

// Check membership - O(1) average case
bool hasApple = fruits.contains('apple'); // true
```

#### Mathematical Set Operations
```dart
Set<int> setA = {1, 2, 3, 4, 5};
Set<int> setB = {4, 5, 6, 7, 8};

// Union (all elements from both sets)
Set<int> union = setA.union(setB);
print(union); // {1, 2, 3, 4, 5, 6, 7, 8}

// Intersection (common elements)
Set<int> intersection = setA.intersection(setB);
print(intersection); // {4, 5}

// Difference (elements in setA but not in setB)
Set<int> difference = setA.difference(setB);
print(difference); // {1, 2, 3}

// Symmetric difference (elements in either set but not both)
Set<int> symDifference = setA.union(setB).difference(setA.intersection(setB));
print(symDifference); // {1, 2, 3, 6, 7, 8}
```

### Specialized Set Types

#### LinkedHashSet (Default)
```dart
// Maintains insertion order
Set<String> linkedSet = {'third', 'first', 'second'};
linkedSet.add('fourth');
print(linkedSet); // {third, first, second, fourth} - order preserved
```

#### HashSet
```dart
import 'dart:collection';

// No ordering guarantee, potentially faster
HashSet<String> hashSet = HashSet<String>();
hashSet.addAll(['third', 'first', 'second']);
print(hashSet); // Order may vary: {first, second, third} or any permutation
```

#### SplayTreeSet
```dart
import 'dart:collection';

// Keeps elements sorted
SplayTreeSet<int> sortedSet = SplayTreeSet<int>();
sortedSet.addAll([5, 2, 8, 1, 9, 3]);
print(sortedSet); // {1, 2, 3, 5, 8, 9} - always sorted
```

## Map Collection

Maps are **key-value pair collections** where each key is unique and maps to exactly one value.

### Internal Structure

Maps are implemented using **hash tables** with separate chaining or open addressing for collision resolution.

```dart
// Internal structure (conceptual):
// Hash Table:
// Bucket 0: [(key1, value1), (key3, value3)] // collision chain
// Bucket 1: [(key2, value2)]
// Bucket 2: []                               // empty bucket
// ...
// Bucket N: [(keyN, valueN)]
```

### Map Creation and Basic Operations

#### Creating Maps
```dart
// Empty map
Map<String, int> emptyMap = <String, int>{};
Map<String, int> emptyMap2 = Map<String, int>();

// Pre-populated map
Map<String, int> ages = {
  'Alice': 30,
  'Bob': 25,
  'Charlie': 35
};

// Using Map constructor
Map<String, String> capitals = Map.from({
  'USA': 'Washington',
  'France': 'Paris',
  'Japan': 'Tokyo'
});

// Dynamic map (mixed value types)
Map<String, dynamic> userData = {
  'name': 'John',
  'age': 28,
  'isActive': true,
  'hobbies': ['reading', 'swimming']
};
```

#### Basic Map Operations
```dart
Map<String, int> inventory = {'apples': 50, 'bananas': 30};

// Add/Update entries - O(1) average case
inventory['oranges'] = 20;    // Add new entry
inventory['apples'] = 45;     // Update existing entry

// Access values - O(1) average case
int? appleCount = inventory['apples'];        // 45
int orangeCount = inventory['oranges'] ?? 0;  // 20 (with null safety)

// Safe access
int safeAccess = inventory.putIfAbsent('grapes', () => 15); // Adds if absent

// Remove entries - O(1) average case
int? removed = inventory.remove('bananas');   // Returns 30
inventory.remove('nonexistent');             // Returns null

// Check for keys/values
bool hasApples = inventory.containsKey('apples');     // true
bool hasValue50 = inventory.containsValue(50);        // false
```

### Advanced Map Operations

#### Iterating Through Maps
```dart
Map<String, int> scores = {'Math': 95, 'Science': 87, 'English': 92};

// Iterate through keys
for (String subject in scores.keys) {
  print('$subject: ${scores[subject]}');
}

// Iterate through values
for (int score in scores.values) {
  print('Score: $score');
}

// Iterate through entries
for (MapEntry<String, int> entry in scores.entries) {
  print('${entry.key}: ${entry.value}');
}

// Using forEach
scores.forEach((subject, score) {
  print('$subject: $score');
});
```

#### Map Transformation
```dart
Map<String, int> originalScores = {'Math': 85, 'Science': 90, 'English': 78};

// Transform values
Map<String, String> grades = originalScores.map(
  (subject, score) => MapEntry(subject, score >= 90 ? 'A' : score >= 80 ? 'B' : 'C')
);
print(grades); // {'Math': 'B', 'Science': 'A', 'English': 'C'}

// Filter entries
Map<String, int> highScores = Map.fromEntries(
  originalScores.entries.where((entry) => entry.value >= 85)
);
print(highScores); // {'Math': 85, 'Science': 90}

// Group by criteria
List<String> subjects = ['Math', 'Science', 'English', 'History', 'Art'];
Map<String, List<String>> groupedSubjects = {
  for (String subject in subjects)
    subject.length.toString(): [...({}[subject.length.toString()] ?? []), subject]
};
// Groups subjects by name length
```

### Specialized Map Types

#### LinkedHashMap (Default)
```dart
// Maintains insertion order
Map<String, int> linkedMap = {'third': 3, 'first': 1, 'second': 2};
linkedMap['fourth'] = 4;
print(linkedMap.keys); // (third, first, second, fourth) - order preserved
```

#### HashMap
```dart
import 'dart:collection';

// No ordering guarantee, potentially faster
HashMap<String, int> hashMap = HashMap<String, int>();
hashMap.addAll({'third': 3, 'first': 1, 'second': 2});
print(hashMap.keys); // Order may vary
```

#### SplayTreeMap
```dart
import 'dart:collection';

// Keeps keys sorted
SplayTreeMap<String, int> sortedMap = SplayTreeMap<String, int>();
sortedMap.addAll({'zebra': 26, 'apple': 1, 'banana': 2});
print(sortedMap.keys); // (apple, banana, zebra) - always sorted by key
```

## Queue Collection

Queues are **ordered collections** optimized for adding elements at one end and removing from the other (FIFO - First In, First Out).

### Queue Types and Operations

#### ListQueue (Default Implementation)
```dart
import 'dart:collection';

Queue<String> queue = Queue<String>();

// Add elements (enqueue) - O(1)
queue.add('first');
queue.add('second');
queue.addLast('third');  // Same as add()
queue.addFirst('zero');  // Add to front

print(queue); // (zero, first, second, third)

// Remove elements (dequeue) - O(1)
String first = queue.removeFirst();  // 'zero'
String last = queue.removeLast();    // 'third'

print(queue); // (first, second)

// Peek without removing
String? nextToRemove = queue.first;  // 'first'
String? lastElement = queue.last;    // 'second'
```

#### DoubleLinkedQueue
```dart
import 'dart:collection';

// Efficient insertion/removal at both ends
DoubleLinkedQueue<int> deque = DoubleLinkedQueue<int>();

deque.addAll([1, 2, 3, 4, 5]);

// Efficient operations at both ends
deque.addFirst(0);   // [0, 1, 2, 3, 4, 5]
deque.addLast(6);    // [0, 1, 2, 3, 4, 5, 6]

int fromFront = deque.removeFirst(); // 0
int fromBack = deque.removeLast();   // 6

print(deque); // (1, 2, 3, 4, 5)
```

## Iterable and Iterator Pattern

Understanding the `Iterable` interface is crucial because most Dart collections implement it.

### The Iterable Interface

```dart
// All collections (except Map) extend Iterable<E>
abstract class Iterable<E> {
  Iterator<E> get iterator;
  
  // Common methods available on all iterables
  bool get isEmpty;
  bool get isNotEmpty;
  int get length;
  E get first;
  E get last;
  E get single; // Throws if not exactly one element
  
  // Transformation methods
  Iterable<T> map<T>(T Function(E) f);
  Iterable<E> where(bool Function(E) test);
  Iterable<T> expand<T>(Iterable<T> Function(E) f);
  
  // Aggregation methods
  E reduce(E Function(E, E) combine);
  T fold<T>(T initialValue, T Function(T, E) combine);
  
  // Search methods
  bool contains(Object? element);
  E firstWhere(bool Function(E) test, {E Function()? orElse});
  E lastWhere(bool Function(E) test, {E Function()? orElse});
  // ... and many more
}
```

### Custom Iterable Example

```dart
class NumberRange extends Iterable<int> {
  final int start;
  final int end;
  final int step;
  
  NumberRange(this.start, this.end, [this.step = 1]);
  
  @override
  Iterator<int> get iterator => NumberRangeIterator(start, end, step);
}

class NumberRangeIterator implements Iterator<int> {
  final int start;
  final int end;
  final int step;
  int _current;
  bool _hasNext;
  
  NumberRangeIterator(this.start, this.end, this.step) 
    : _current = start - step,
      _hasNext = true;
  
  @override
  int get current => _current;
  
  @override
  bool moveNext() {
    if (!_hasNext) return false;
    
    _current += step;
    if (_current >= end) {
      _hasNext = false;
      return false;
    }
    return true;
  }
}

// Usage
void demonstrateCustomIterable() {
  NumberRange range = NumberRange(0, 10, 2);
  
  for (int number in range) {
    print(number); // 0, 2, 4, 6, 8
  }
  
  // All Iterable methods work
  List<int> doubled = range.map((n) => n * 2).toList();
  print(doubled); // [0, 4, 8, 12, 16]
  
  int sum = range.fold(0, (sum, n) => sum + n);
  print(sum); // 20
}
```

## Collection Operations

### Lazy vs Eager Evaluation

Understanding when operations are executed is crucial for performance.

#### Lazy Evaluation (Iterable methods)
```dart
List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// These operations are LAZY - not executed immediately
Iterable<int> evens = numbers.where((n) => n.isEven);
Iterable<int> doubled = evens.map((n) => n * 2);

print('Operations defined, but not executed yet');

// Execution happens when you iterate or convert to concrete collection
List<int> result = doubled.toList(); // NOW the operations execute
print(result); // [4, 8, 12, 16, 20]

// Each access re-evaluates the chain
for (int value in doubled) {
  print(value); // Operations execute again
}
```

#### Eager Evaluation
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// These create new collections immediately
List<int> doubled = numbers.map((n) => n * 2).toList(); // Eager
Set<int> uniqueDoubled = doubled.toSet(); // Eager
List<int> sorted = List.from(doubled)..sort(); // Eager

print(doubled); // [2, 4, 6, 8, 10]
```

### Method Chaining

```dart
List<String> names = ['alice', 'bob', 'charlie', 'diana', 'eve'];

// Efficient chaining with lazy evaluation
List<String> result = names
    .where((name) => name.length > 3)           // Lazy filter
    .map((name) => name.toUpperCase())          // Lazy transform
    .where((name) => name.startsWith('C'))      // Lazy filter
    .toList();                                  // Eager conversion

print(result); // ['CHARLIE']

// Alternative with intermediate collections (less efficient)
List<String> longNames = names.where((name) => name.length > 3).toList();
List<String> upperNames = longNames.map((name) => name.toUpperCase()).toList();
List<String> cNames = upperNames.where((name) => name.startsWith('C')).toList();
```

### Collection Conversion

```dart
// Starting collections
List<int> numberList = [1, 2, 3, 2, 4, 5, 3];
Set<int> numberSet = {1, 2, 3, 4, 5};
Map<String, int> numberMap = {'one': 1, 'two': 2, 'three': 3};

// List conversions
List<int> fromSet = numberSet.toList();
List<String> fromMapKeys = numberMap.keys.toList();
List<int> fromMapValues = numberMap.values.toList();

// Set conversions (removes duplicates)
Set<int> fromList = numberList.toSet(); // {1, 2, 3, 4, 5}
Set<String> fromMapKeysSet = numberMap.keys.toSet();

// Map conversions
Map<int, String> indexToValue = numberList.asMap().map(
  (index, value) => MapEntry(value, 'Value $value')
);

// Custom conversions
Map<String, int> lengthMap = ['apple', 'banana', 'cherry'].asMap().map(
  (index, fruit) => MapEntry(fruit, fruit.length)
);
print(lengthMap); // {apple: 5, banana: 6, cherry: 6}
```

## Performance Characteristics

Understanding the performance of different operations helps you choose the right collection for your use case.

### Time Complexity Summary

| Operation | List | LinkedList | Set (Hash) | Set (Tree) | Map (Hash) | Map (Tree) |
|-----------|------|------------|------------|------------|------------|------------|
| Access by index/key | O(1) | O(n) | N/A | N/A | O(1) avg | O(log n) |
| Search | O(n) | O(n) | O(1) avg | O(log n) | O(1) avg | O(log n) |
| Insert at end | O(1) amortized | O(1) | O(1) avg | O(log n) | O(1) avg | O(log n) |
| Insert at beginning | O(n) | O(1) | O(1) avg | O(log n) | O(1) avg | O(log n) |
| Insert at middle | O(n) | O(n) | O(1) avg | O(log n) | O(1) avg | O(log n) |
| Delete | O(n) | O(n) | O(1) avg | O(log n) | O(1) avg | O(log n) |
| Iteration | O(n) | O(n) | O(n) | O(n) | O(n) | O(n) |

### Memory Usage Considerations

```dart
// Memory-efficient practices

// 1. Use appropriate collection type
Set<String> uniqueNames = {'Alice', 'Bob'}; // Don't use List if you need uniqueness

// 2. Prefer lazy evaluation for large datasets
Iterable<int> evenNumbers = Iterable.generate(1000000)
    .where((n) => n.isEven)
    .take(100); // Only processes first 100 even numbers

// 3. Use const constructors when possible
const List<String> immutableList = ['a', 'b', 'c']; // Compile-time constant

// 4. Consider memory vs CPU trade-offs
List<int> precomputedValues = List.generate(1000, (i) => i * i); // More memory
int Function(int) computeValue = (i) => i * i; // Less memory, more CPU
```

### Choosing the Right Collection

```dart
// Use List when:
// - You need indexed access
// - Order matters
// - You need to allow duplicates
List<String> orderedTasks = ['wake up', 'brush teeth', 'eat breakfast'];

// Use Set when:
// - You need unique elements
// - Fast lookup is important
// - Order doesn't matter much
Set<String> userPermissions = {'read', 'write', 'delete'};

// Use Map when:
// - You need key-value associations
// - Fast lookup by key is important
Map<String, User> userCache = {'user123': User('Alice'), 'user456': User('Bob')};

// Use Queue when:
// - You need FIFO operations
// - Frequent additions/removals at ends
Queue<Task> taskQueue = Queue<Task>();
```

## Advanced Collection Concepts

### Collection Views and Projections

```dart
List<int> originalList = [1, 2, 3, 4, 5];

// Sublist view (shares storage with original)
List<int> subList = originalList.sublist(1, 4); // [2, 3, 4]
subList[0] = 20; // Modifies original list too!
print(originalList); // [1, 20, 3, 4, 5]

// Safe sublist (independent copy)
List<int> independentSubList = List.from(originalList.sublist(1, 4));

// Reversed view
Iterable<int> reversed = originalList.reversed;
print(reversed.toList()); // [5, 4, 3, 20, 1]

// Skip and take views
Iterable<int> skipped = originalList.skip(2);        // [3, 20, 1]
Iterable<int> taken = originalList.take(3);          // [1, 20, 3]
Iterable<int> middle = originalList.skip(1).take(3); // [20, 3, 4]
```

### Concurrent Modification

```dart
List<int> numbers = [1, 2, 3, 4, 5];

// WRONG: Modifying collection while iterating
try {
  for (int number in numbers) {
    if (number.isEven) {
      numbers.remove(number); // ConcurrentModificationError!
    }
  }
} catch (e) {
  print('Error: $e');
}

// CORRECT: Collect modifications and apply later
List<int> toRemove = [];
for (int number in numbers) {
  if (number.isEven) {
    toRemove.add(number);
  }
}
numbers.removeWhere((n) => toRemove.contains(n));

// BETTER: Use built-in methods
numbers.removeWhere((number) => number.isEven);
```

### Collection Equality

```dart
// Shallow equality (reference comparison)
List<int> list1 = [1, 2, 3];
List<int> list2 = [1, 2, 3];
List<int> list3 = list1;

print(identical(list1, list2)); // false (different objects)
print(identical(list1, list3)); // true (same object)

// Deep equality (element comparison)
import 'package:collection/collection.dart';

bool deepEqual = const ListEquality().equals(list1, list2); // true

// For sets and maps
bool setEqual = const SetEquality().equals({1, 2, 3}, {3, 2, 1}); // true
bool mapEqual = const MapEquality().equals(
  {'a': 1, 'b': 2}, 
  {'b': 2, 'a': 1}
); // true
```

### Immutable Collections

```dart
// Using built-in unmodifiable wrappers
List<String> mutableList = ['a', 'b', 'c'];
List<String> immutableList = List.unmodifiable(mutableList);

// Using const constructors
const List<String> constList = ['a', 'b', 'c'];
const Set<String> constSet = {'a', 'b', 'c'};
const Map<String, int> constMap = {'a': 1, 'b': 2};

// Note: const collections are deeply immutable
const List<List<String>> nestedConst = [['a', 'b'], ['c', 'd']];
// nestedConst[0].add('e'); // Error: cannot modify
```

### Custom Collections

```dart
class LimitedList<T> {
  final List<T> _list = [];
  final int maxSize;
  
  LimitedList(this.maxSize);
  
  void add(T item) {
    if (_list.length >= maxSize) {
      _list.removeAt(0); // Remove oldest
    }
    _list.add(item);
  }
  
  T operator [](int index) => _list[index];
  int get length => _list.length;
  
  void forEach(void Function(T) action) {
    _list.forEach(action);
  }
}

// Usage
LimitedList<String> recentMessages = LimitedList<String>(3);
recentMessages.add('Hello');
recentMessages.add('How are you?');
recentMessages.add('Fine, thanks');
recentMessages.add('Goodbye'); // 'Hello' is automatically removed

recentMessages.forEach(print); // Prints last 3 messages
```

This comprehensive guide covers how Dart collections work from the ground up, including their internal structures, performance characteristics, and practical usage patterns. Understanding these concepts will help you write more efficient and maintainable Dart code.
