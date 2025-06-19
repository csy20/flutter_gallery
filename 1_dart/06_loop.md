# Loops in Dart

## Overview
Loops in Dart are control flow statements that allow you to execute a block of code repeatedly based on a condition. They are essential for automating repetitive tasks and iterating over collections of data.

## Types of Loops

### 1. For Loop
The most commonly used loop for iterating a specific number of times.

#### Basic For Loop
```dart
for (initialization; condition; increment/decrement) {
  // Code to execute
}
```

**Example:**
```dart
// Print numbers 1 to 5
for (int i = 1; i <= 5; i++) {
  print('Number: $i');
}
```

#### For-in Loop
Used to iterate over collections like lists, sets, maps, etc.

```dart
List<String> fruits = ['apple', 'banana', 'orange'];
for (String fruit in fruits) {
  print('Fruit: $fruit');
}
```

#### For-each Loop
Another way to iterate over collections using the `forEach` method.

```dart
List<int> numbers = [1, 2, 3, 4, 5];
numbers.forEach((number) {
  print('Number: $number');
});
```

### 2. While Loop
Executes code as long as a condition is true. The condition is checked before each iteration.

```dart
while (condition) {
  // Code to execute
}
```

**Example:**
```dart
int i = 1;
while (i <= 5) {
  print('Count: $i');
  i++; // Don't forget to update the condition variable
}
```

### 3. Do-While Loop
Similar to while loop, but the condition is checked after each iteration, guaranteeing at least one execution.

```dart
do {
  // Code to execute
} while (condition);
```

**Example:**
```dart
int i = 1;
do {
  print('Count: $i');
  i++;
} while (i <= 5);
```

## Loop Control Statements

### Break Statement
Terminates the loop immediately and transfers control to the statement after the loop.

```dart
for (int i = 1; i <= 10; i++) {
  if (i == 5) {
    break; // Exit loop when i equals 5
  }
  print('Number: $i');
}
// Output: 1, 2, 3, 4
```

### Continue Statement
Skips the rest of the current iteration and moves to the next iteration.

```dart
for (int i = 1; i <= 5; i++) {
  if (i == 3) {
    continue; // Skip when i equals 3
  }
  print('Number: $i');
}
// Output: 1, 2, 4, 5
```

## Advanced Loop Concepts

### Nested Loops
Loops inside other loops for multi-dimensional operations.

```dart
// Multiplication table
for (int i = 1; i <= 3; i++) {
  for (int j = 1; j <= 3; j++) {
    print('$i x $j = ${i * j}');
  }
  print('---');
}
```

### Loop with Labels
Labels allow you to break or continue specific loops in nested structures.

```dart
outerLoop: for (int i = 1; i <= 3; i++) {
  innerLoop: for (int j = 1; j <= 3; j++) {
    if (i == 2 && j == 2) {
      break outerLoop; // Break out of outer loop
    }
    print('i: $i, j: $j');
  }
}
```

### Infinite Loops
Loops that run indefinitely (use with caution and proper exit conditions).

```dart
// Infinite loop with break condition
while (true) {
  String? input = stdin.readLineSync();
  if (input == 'quit') {
    break;
  }
  print('You entered: $input');
}
```

## Working with Collections

### Iterating Lists
```dart
List<String> colors = ['red', 'green', 'blue'];

// Method 1: Traditional for loop
for (int i = 0; i < colors.length; i++) {
  print('Color $i: ${colors[i]}');
}

// Method 2: For-in loop
for (String color in colors) {
  print('Color: $color');
}

// Method 3: Using index and value
for (int i = 0; i < colors.length; i++) {
  print('Index $i: ${colors[i]}');
}
```

### Iterating Maps
```dart
Map<String, int> ages = {
  'Alice': 25,
  'Bob': 30,
  'Charlie': 35
};

// Iterate over keys
for (String name in ages.keys) {
  print('$name is ${ages[name]} years old');
}

// Iterate over values
for (int age in ages.values) {
  print('Age: $age');
}

// Iterate over entries
for (MapEntry<String, int> entry in ages.entries) {
  print('${entry.key}: ${entry.value}');
}
```

### Iterating Sets
```dart
Set<String> fruits = {'apple', 'banana', 'orange'};

for (String fruit in fruits) {
  print('Fruit: $fruit');
}
```

## Practical Examples

### 1. Finding Maximum in List
```dart
List<int> numbers = [3, 7, 2, 9, 1, 5];
int max = numbers[0];

for (int i = 1; i < numbers.length; i++) {
  if (numbers[i] > max) {
    max = numbers[i];
  }
}
print('Maximum: $max');
```

### 2. Counting Vowels
```dart
String text = "Hello World";
int vowelCount = 0;
String vowels = "aeiouAEIOU";

for (int i = 0; i < text.length; i++) {
  if (vowels.contains(text[i])) {
    vowelCount++;
  }
}
print('Vowel count: $vowelCount');
```

### 3. Fibonacci Series
```dart
int n = 10;
int first = 0, second = 1;

print('Fibonacci series:');
print(first);
print(second);

for (int i = 2; i < n; i++) {
  int next = first + second;
  print(next);
  first = second;
  second = next;
}
```

### 4. Prime Number Check
```dart
bool isPrime(int number) {
  if (number < 2) return false;
  
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}

// Check prime numbers from 1 to 20
for (int i = 1; i <= 20; i++) {
  if (isPrime(i)) {
    print('$i is prime');
  }
}
```

### 5. Pattern Printing
```dart
// Right triangle pattern
int rows = 5;
for (int i = 1; i <= rows; i++) {
  String pattern = '';
  for (int j = 1; j <= i; j++) {
    pattern += '* ';
  }
  print(pattern);
}
```

## Best Practices

### 1. Choose the Right Loop
- **For loop**: When you know the number of iterations
- **While loop**: When you don't know the exact number of iterations
- **Do-while loop**: When you need at least one execution
- **For-in loop**: When iterating over collections

### 2. Avoid Infinite Loops
```dart
// Bad: Might create infinite loop
int i = 0;
while (i < 10) {
  print(i);
  // Forgot to increment i
}

// Good: Proper increment
int i = 0;
while (i < 10) {
  print(i);
  i++; // Always update loop variable
}
```

### 3. Use Appropriate Loop Control
```dart
// Finding first even number
List<int> numbers = [1, 3, 4, 7, 8, 9];
for (int number in numbers) {
  if (number % 2 == 0) {
    print('First even number: $number');
    break; // Exit once found
  }
}
```

### 4. Consider Performance
```dart
List<String> items = ['a', 'b', 'c', 'd', 'e'];

// Less efficient: Accessing length repeatedly
for (int i = 0; i < items.length; i++) {
  print(items[i]);
}

// More efficient: Store length in variable
int length = items.length;
for (int i = 0; i < length; i++) {
  print(items[i]);
}

// Most efficient for simple iteration
for (String item in items) {
  print(item);
}
```

## Common Loop Patterns

### 1. Accumulation Pattern
```dart
List<int> numbers = [1, 2, 3, 4, 5];
int sum = 0;

for (int number in numbers) {
  sum += number; // Accumulate values
}
print('Sum: $sum');
```

### 2. Filtering Pattern
```dart
List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
List<int> evenNumbers = [];

for (int number in numbers) {
  if (number % 2 == 0) {
    evenNumbers.add(number); // Filter and collect
  }
}
print('Even numbers: $evenNumbers');
```

### 3. Transformation Pattern
```dart
List<String> names = ['alice', 'bob', 'charlie'];
List<String> capitalizedNames = [];

for (String name in names) {
  capitalizedNames.add(name.toUpperCase()); // Transform each element
}
print('Capitalized: $capitalizedNames');
```

### 4. Search Pattern
```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];
String searchName = 'Bob';
bool found = false;

for (String name in names) {
  if (name == searchName) {
    found = true;
    break; // Stop searching once found
  }
}
print('Found $searchName: $found');
```

## Error Handling in Loops

### 1. Boundary Checks
```dart
List<int> numbers = [1, 2, 3];

// Safe iteration with boundary check
for (int i = 0; i < numbers.length; i++) {
  print('Number at index $i: ${numbers[i]}');
}

// Avoid index out of bounds
// for (int i = 0; i <= numbers.length; i++) { // This would cause error
```

### 2. Null Safety
```dart
List<String>? nullableList = getList(); // Might return null

// Safe iteration
if (nullableList != null) {
  for (String item in nullableList) {
    print(item);
  }
}

// Or using null-aware operator
nullableList?.forEach((item) => print(item));
```

## Modern Dart Loop Alternatives

### 1. Higher-Order Functions
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Instead of traditional loops, use:
numbers.where((n) => n % 2 == 0)        // Filter
       .map((n) => n * 2)               // Transform
       .forEach((n) => print(n));       // Iterate
```

### 2. Stream Processing
```dart
// For asynchronous iteration
Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

await for (int number in numberStream) {
  print('Async number: $number');
}
```

## Summary

Loops are fundamental control structures in Dart that enable:
- **Repetitive execution** of code blocks
- **Iteration** over collections and data structures
- **Automation** of repetitive tasks
- **Implementation** of algorithms and patterns

Choose the appropriate loop type based on your specific use case, and always ensure proper termination conditions to avoid infinite loops. Modern Dart also provides functional programming alternatives that can make code more readable and maintainable in many scenarios.