# Data Types in Dart Language

## Overview

Dart is a strongly typed language with a rich set of built-in data types. Understanding data types is crucial for writing efficient and error-free Dart code. Dart supports both static and dynamic typing with excellent type inference.

## Table of Contents

1. [Basic Data Types](#basic-data-types)
2. [Numbers](#numbers)
3. [Strings](#strings)
4. [Booleans](#booleans)
5. [Collections](#collections)
6. [Null Safety](#null-safety)
7. [Type Inference](#type-inference)
8. [Type Conversion](#type-conversion)
9. [Advanced Types](#advanced-types)

## Basic Data Types

Dart has several built-in data types that form the foundation of the language:

### Primitive Types
- **int** - Integer numbers
- **double** - Floating-point numbers
- **String** - Text data
- **bool** - Boolean values (true/false)

### Collection Types
- **List** - Ordered collection of items
- **Set** - Unordered collection of unique items
- **Map** - Key-value pairs

### Special Types
- **dynamic** - Can hold any type
- **Object** - Base class for all objects
- **null** - Represents absence of value

## Numbers

### Integer (int)
Represents whole numbers without decimal points.

```dart
int age = 25;
int negativeNumber = -10;
int largeNumber = 9223372036854775807; // Max int value
```

**Key Features:**
- Range: -2^63 to 2^63-1
- Platform independent
- Supports arithmetic operations

### Double (double)
Represents floating-point numbers with decimal places.

```dart
double pi = 3.14159;
double temperature = -15.5;
double scientific = 1.23e4; // Scientific notation (12300)
```

**Key Features:**
- 64-bit IEEE 754 standard
- Supports scientific notation
- Can represent very large and very small numbers

### Num (num)
Parent class of both int and double.

```dart
num anyNumber = 42;      // Can be int
anyNumber = 3.14;        // Can be double
```

## Strings

Strings represent text data and are immutable in Dart.

### String Declaration
```dart
String name = 'John Doe';
String message = "Hello, World!";
String multiLine = '''
This is a
multi-line
string
''';
```

### String Features
- **Immutable**: Cannot be changed after creation
- **Unicode Support**: Full Unicode character support
- **String Interpolation**: Embed expressions in strings
- **Escape Sequences**: Special characters like \n, \t

### String Interpolation
```dart
String firstName = 'Alice';
int age = 30;

String greeting = 'Hello, $firstName!';
String info = 'Next year you will be ${age + 1} years old';
```

## Booleans

Boolean type represents logical values.

```dart
bool isActive = true;
bool isComplete = false;
bool result = 5 > 3; // true
```

**Key Features:**
- Only two values: `true` and `false`
- Used in conditional statements
- Result of comparison operations

## Collections

### List
Ordered collection of items that can contain duplicates.

```dart
// Generic List
List<String> fruits = ['apple', 'banana', 'orange'];
List<int> numbers = [1, 2, 3, 4, 5];

// Dynamic List
var mixedList = ['hello', 42, true, 3.14];

// List Operations
fruits.add('grape');
fruits.remove('banana');
print(fruits.length); // 3
```

**List Types:**
- **Fixed Length**: `List.filled(3, 0)` - Creates [0, 0, 0]
- **Growable**: `List<int>()` - Can grow and shrink
- **Generated**: `List.generate(5, (i) => i * 2)` - [0, 2, 4, 6, 8]

### Set
Unordered collection of unique items.

```dart
Set<String> colors = {'red', 'green', 'blue'};
Set<int> uniqueNumbers = {1, 2, 3, 2, 1}; // {1, 2, 3}

// Set Operations
colors.add('yellow');
colors.remove('red');
bool hasBlue = colors.contains('blue');
```

**Set Features:**
- No duplicate elements
- Efficient lookup operations
- Supports set operations (union, intersection, difference)

### Map
Collection of key-value pairs.

```dart
Map<String, int> ages = {
  'Alice': 25,
  'Bob': 30,
  'Charlie': 35
};

// Adding and accessing
ages['David'] = 28;
int? aliceAge = ages['Alice']; // 25
```

**Map Features:**
- Keys must be unique
- Values can be duplicated
- Efficient key-based lookup

## Null Safety

Dart has built-in null safety to prevent null reference errors.

### Non-nullable Types
```dart
String name = 'John';     // Cannot be null
int age = 25;            // Cannot be null
```

### Nullable Types
```dart
String? optionalName = null;    // Can be null
int? optionalAge;              // null by default
```

### Null-aware Operators
```dart
String? nullableName = null;

// Null-aware access
int? length = nullableName?.length;

// Null coalescing
String displayName = nullableName ?? 'Unknown';

// Null assertion (use carefully!)
// String definitelyNotNull = nullableName!;
```

## Type Inference

Dart can automatically infer types using the `var` keyword.

```dart
var name = 'Alice';        // Inferred as String
var age = 30;             // Inferred as int
var height = 5.9;         // Inferred as double
var isActive = true;      // Inferred as bool

// Once inferred, type is fixed
// name = 123; // Error! Cannot assign int to String
```

## Type Conversion

### Explicit Conversion
```dart
// String to Number
String numberStr = '42';
int number = int.parse(numberStr);
double decimal = double.parse('3.14');

// Number to String
int age = 25;
String ageStr = age.toString();
String formatted = age.toStringAsFixed(2); // "25.00"

// Type Checking
var value = 42;
if (value is int) {
  print('It is an integer');
}
```

### Implicit Conversion
```dart
// int to double (automatic)
double result = 5 + 3.14; // int 5 becomes double 5.0

// No automatic string conversion
// String message = 'Age: ' + 25; // Error!
String message = 'Age: ' + 25.toString(); // Correct
```

## Advanced Types

### Dynamic
Can hold any type and type checking is done at runtime.

```dart
dynamic anything = 'Hello';
anything = 42;
anything = true;
anything = [1, 2, 3];
```

### Object
Base class for all Dart objects.

```dart
Object obj = 'Hello';
obj = 42;
obj = [1, 2, 3];
```

### Function Types
Functions are first-class objects in Dart.

```dart
// Function variable
int Function(int, int) calculator = (a, b) => a + b;

// Function as parameter
void processData(List<int> data, int Function(int) processor) {
  for (int item in data) {
    print(processor(item));
  }
}
```

### Typedef
Create aliases for function types.

```dart
typedef Calculator = int Function(int a, int b);

Calculator add = (a, b) => a + b;
Calculator multiply = (a, b) => a * b;
```

## Type Hierarchy

```
Object
├── Null
├── num
│   ├── int
│   └── double
├── String
├── bool
├── List<E>
├── Set<E>
├── Map<K, V>
├── Function
└── ... (other types)
```

## Best Practices

### 1. Use Specific Types
```dart
// Good
List<String> names = ['Alice', 'Bob'];
Map<String, int> scores = {'Alice': 95, 'Bob': 87};

// Avoid when possible
var names = ['Alice', 'Bob'];
dynamic scores = {'Alice': 95, 'Bob': 87};
```

### 2. Leverage Type Inference
```dart
// Good - clear and concise
var userName = 'john_doe';
var userAge = 25;
var isLoggedIn = true;

// Unnecessary verbosity
String userName = 'john_doe';
int userAge = 25;
bool isLoggedIn = true;
```

### 3. Handle Nullability Properly
```dart
// Good
String? getUserName() => currentUser?.name;

String displayName = getUserName() ?? 'Guest';

// Check before use
if (getUserName() != null) {
  print('Welcome, ${getUserName()}!');
}
```

### 4. Use Collections Appropriately
```dart
// Use List for ordered data
List<String> todoItems = ['Buy milk', 'Walk dog', 'Write code'];

// Use Set for unique items
Set<String> uniqueVisitors = {'user1', 'user2', 'user1'}; // Only 2 items

// Use Map for key-value relationships
Map<String, String> userPreferences = {
  'theme': 'dark',
  'language': 'en',
  'notifications': 'enabled'
};
```

## Common Patterns

### 1. Safe Type Casting
```dart
Object someObject = 'Hello, World!';

// Safe casting with 'as'
if (someObject is String) {
  String text = someObject as String;
  print(text.toUpperCase());
}

// Or use type check with automatic promotion
if (someObject is String) {
  print(someObject.toUpperCase()); // No casting needed
}
```

### 2. Working with Collections
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Filtering
List<int> evenNumbers = numbers.where((n) => n % 2 == 0).toList();

// Mapping
List<String> numberStrings = numbers.map((n) => n.toString()).toList();

// Reducing
int sum = numbers.reduce((a, b) => a + b);
```

### 3. Optional Parameters with Types
```dart
// Named parameters with default values
void createUser({
  required String name,
  int age = 18,
  String? email,
  bool isActive = true,
}) {
  // Implementation
}

// Positional optional parameters
String formatName(String first, String last, [String? middle]) {
  if (middle != null) {
    return '$first $middle $last';
  }
  return '$first $last';
}
```

## Summary

Dart's type system provides:

- **Strong typing** with compile-time error checking
- **Type inference** for cleaner code
- **Null safety** to prevent runtime errors
- **Rich collection types** for data organization
- **Flexible typing** with dynamic when needed

Understanding these data types is essential for writing robust Dart applications, whether for mobile development with Flutter, server-side development, or web applications.