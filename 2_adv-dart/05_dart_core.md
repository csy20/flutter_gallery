# Dart Core Library - Complete Guide

## Table of Contents
1. [What is Dart Core?](#what-is-dart-core)
2. [Core Library Architecture](#core-library-architecture)
3. [Essential Core Classes](#essential-core-classes)
4. [Working with Numbers](#working-with-numbers)
5. [String Manipulation](#string-manipulation)
6. [Collections Framework](#collections-framework)
7. [Date and Time](#date-and-time)
8. [Error Handling](#error-handling)
9. [Streams and Futures](#streams-and-futures)
10. [Practical Examples](#practical-examples)

## What is Dart Core?

Dart Core (`dart:core`) is the fundamental library that provides the essential building blocks for Dart applications. It's automatically imported into every Dart program, so you don't need to explicitly import it.

### Key Characteristics:
- **Automatically Available**: No need to import `dart:core`
- **Foundation Layer**: Contains basic types and utilities
- **Cross-Platform**: Works on all Dart platforms (web, mobile, desktop, server)
- **Built-in Types**: Provides fundamental data types like `int`, `String`, `bool`, etc.

```dart
// These are all part of dart:core (no import needed)
void main() {
  int number = 42;
  String text = "Hello World";
  bool isTrue = true;
  List<int> numbers = [1, 2, 3];
  print("Dart Core is automatically available!");
}
```

## Core Library Architecture

The Dart Core library is organized into several key areas:

### 1. Basic Types
- **Numbers**: `int`, `double`, `num`
- **Text**: `String`, `StringBuffer`
- **Boolean**: `bool`
- **Collections**: `List`, `Set`, `Map`

### 2. Object System
- **Object**: Base class for all objects
- **Type**: Represents types at runtime
- **Symbol**: Represents identifiers

### 3. Utilities
- **DateTime**: Date and time handling
- **Duration**: Time intervals
- **RegExp**: Regular expressions
- **Uri**: URL/URI handling

## Essential Core Classes

### Object Class
Every class in Dart inherits from `Object`:

```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  // These methods come from Object class
  @override
  String toString() => 'Person(name: $name, age: $age)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Person && other.name == name && other.age == age;
  }
  
  @override
  int get hashCode => Object.hash(name, age);
}

void main() {
  var person1 = Person("Alice", 25);
  var person2 = Person("Alice", 25);
  
  print(person1.toString()); // Person(name: Alice, age: 25)
  print(person1 == person2); // true (after override)
  print(person1.runtimeType); // Person
}
```

### Type System
```dart
void demonstrateTypes() {
  var number = 42;
  var text = "Hello";
  var flag = true;
  
  // Runtime type checking
  print(number.runtimeType); // int
  print(text.runtimeType);   // String
  print(flag.runtimeType);   // bool
  
  // Type testing
  print(number is int);      // true
  print(text is String);     // true
  print(number is! String);  // true
}
```

## Working with Numbers

### Number Types and Operations
```dart
void numberOperations() {
  // Integer operations
  int a = 10;
  int b = 3;
  
  print(a + b);        // 13 (addition)
  print(a - b);        // 7 (subtraction)
  print(a * b);        // 30 (multiplication)
  print(a ~/ b);       // 3 (integer division)
  print(a / b);        // 3.3333... (double division)
  print(a % b);        // 1 (remainder)
  
  // Double operations
  double x = 10.5;
  double y = 3.2;
  
  print(x + y);        // 13.7
  print(x.round());    // 11
  print(x.floor());    // 10
  print(x.ceil());     // 11
  
  // Number utilities
  print(a.isEven);     // true
  print(a.isOdd);      // false
  print(x.isFinite);   // true
  print(x.isNaN);      // false
}
```

### Number Parsing and Conversion
```dart
void numberParsing() {
  // String to number conversion
  String intStr = "42";
  String doubleStr = "3.14";
  
  int parsedInt = int.parse(intStr);
  double parsedDouble = double.parse(doubleStr);
  
  print(parsedInt);    // 42
  print(parsedDouble); // 3.14
  
  // Safe parsing with tryParse
  int? safeInt = int.tryParse("not_a_number");
  print(safeInt);      // null
  
  // Number to string conversion
  int num = 42;
  print(num.toString());           // "42"
  print(num.toRadixString(2));     // "101010" (binary)
  print(num.toRadixString(16));    // "2a" (hexadecimal)
  
  double pi = 3.14159;
  print(pi.toStringAsFixed(2));    // "3.14"
  print(pi.toStringAsPrecision(3)); // "3.14"
}
```

## String Manipulation

### Basic String Operations
```dart
void stringOperations() {
  String text = "Hello, Dart World!";
  
  // Basic properties
  print(text.length);              // 18
  print(text.isEmpty);             // false
  print(text.isNotEmpty);          // true
  
  // Case operations
  print(text.toLowerCase());       // "hello, dart world!"
  print(text.toUpperCase());       // "HELLO, DART WORLD!"
  
  // Substring operations
  print(text.substring(0, 5));     // "Hello"
  print(text.substring(7));        // "Dart World!"
  
  // Search operations
  print(text.contains("Dart"));    // true
  print(text.indexOf("Dart"));     // 7
  print(text.lastIndexOf("o"));    // 16
  print(text.startsWith("Hello")); // true
  print(text.endsWith("World!"));  // true
}
```

### String Manipulation and Formatting
```dart
void stringManipulation() {
  String text = "  Hello, World!  ";
  
  // Trimming
  print(text.trim());              // "Hello, World!"
  print(text.trimLeft());          // "Hello, World!  "
  print(text.trimRight());         // "  Hello, World!"
  
  // Replacement
  print(text.replaceAll("World", "Dart"));     // "  Hello, Dart!  "
  print(text.replaceFirst("l", "L"));          // "  HeLlo, World!  "
  
  // Splitting and joining
  String csv = "apple,banana,orange";
  List<String> fruits = csv.split(",");
  print(fruits);                   // [apple, banana, orange]
  print(fruits.join(" | "));       // "apple | banana | orange"
  
  // String interpolation
  String name = "Alice";
  int age = 25;
  print("My name is $name and I'm $age years old");
  print("Next year I'll be ${age + 1}");
}
```

### StringBuffer for Efficient String Building
```dart
void stringBufferExample() {
  // Inefficient way (creates new string objects)
  String result = "";
  for (int i = 0; i < 1000; i++) {
    result += "Item $i ";  // Creates new string each time
  }
  
  // Efficient way using StringBuffer
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < 1000; i++) {
    buffer.write("Item $i ");
  }
  String efficientResult = buffer.toString();
  
  // StringBuffer methods
  StringBuffer sb = StringBuffer();
  sb.write("Hello");
  sb.write(" ");
  sb.write("World");
  sb.writeln("!");           // Adds newline
  sb.writeAll(["A", "B", "C"], ", "); // Joins with separator
  
  print(sb.toString());      // "Hello World!\nA, B, C"
  print(sb.length);          // Length of accumulated string
  
  sb.clear();                // Clears the buffer
  print(sb.isEmpty);         // true
}
```

## Collections Framework

### Lists (Ordered Collections)
```dart
void listOperations() {
  // Creating lists
  List<int> numbers = [1, 2, 3, 4, 5];
  List<String> fruits = List.filled(3, "apple"); // ["apple", "apple", "apple"]
  List<int> empty = <int>[];
  
  // Basic operations
  numbers.add(6);                    // [1, 2, 3, 4, 5, 6]
  numbers.addAll([7, 8, 9]);         // [1, 2, 3, 4, 5, 6, 7, 8, 9]
  numbers.insert(0, 0);              // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  numbers.remove(5);                 // Removes first occurrence of 5
  numbers.removeAt(0);               // Removes element at index 0
  
  // Access and modification
  print(numbers[0]);                 // First element
  print(numbers.first);              // First element
  print(numbers.last);               // Last element
  numbers[0] = 100;                  // Modify element
  
  // Properties
  print(numbers.length);             // Number of elements
  print(numbers.isEmpty);            // false
  print(numbers.isNotEmpty);         // true
  
  // Searching
  print(numbers.contains(3));        // true
  print(numbers.indexOf(3));         // Index of first occurrence
  print(numbers.lastIndexOf(3));     // Index of last occurrence
}
```

### Sets (Unique Collections)
```dart
void setOperations() {
  // Creating sets
  Set<int> numbers = {1, 2, 3, 4, 5};
  Set<String> fruits = <String>{"apple", "banana", "orange"};
  Set<int> empty = <int>{};
  
  // Adding elements
  numbers.add(6);                    // Adds 6
  numbers.add(3);                    // No effect (3 already exists)
  numbers.addAll([7, 8, 9]);
  
  // Removing elements
  numbers.remove(5);
  numbers.removeWhere((n) => n > 7);
  
  // Set operations
  Set<int> set1 = {1, 2, 3, 4};
  Set<int> set2 = {3, 4, 5, 6};
  
  print(set1.union(set2));           // {1, 2, 3, 4, 5, 6}
  print(set1.intersection(set2));    // {3, 4}
  print(set1.difference(set2));      // {1, 2}
  
  // Checking relationships
  print(set1.contains(3));           // true
  print({1, 2}.isSubsetOf(set1));    // true (if available)
  print(set1.containsAll([1, 2]));   // true
}
```

### Maps (Key-Value Pairs)
```dart
void mapOperations() {
  // Creating maps
  Map<String, int> ages = {"Alice": 25, "Bob": 30, "Charlie": 35};
  Map<String, String> capitals = <String, String>{};
  
  // Adding and updating
  ages["David"] = 40;                // Add new entry
  ages["Alice"] = 26;                // Update existing entry
  ages.addAll({"Eve": 28, "Frank": 33});
  
  // Accessing values
  print(ages["Alice"]);              // 26
  print(ages["Unknown"]);            // null
  
  // Safe access
  int? aliceAge = ages["Alice"];
  int bobAge = ages["Bob"] ?? 0;     // Default value if null
  
  // Checking existence
  print(ages.containsKey("Alice"));  // true
  print(ages.containsValue(30));     // true
  
  // Removing entries
  ages.remove("Charlie");
  ages.removeWhere((key, value) => value < 30);
  
  // Iterating
  ages.forEach((key, value) {
    print("$key is $value years old");
  });
  
  // Getting keys and values
  print(ages.keys);                  // Iterable of keys
  print(ages.values);                // Iterable of values
  print(ages.entries);               // Iterable of MapEntry objects
}
```

## Date and Time

### DateTime Operations
```dart
void dateTimeOperations() {
  // Creating DateTime objects
  DateTime now = DateTime.now();
  DateTime specific = DateTime(2023, 12, 25, 10, 30, 0);
  DateTime utc = DateTime.utc(2023, 12, 25);
  DateTime parsed = DateTime.parse("2023-12-25 10:30:00");
  
  print("Current time: $now");
  print("Christmas 2023: $specific");
  
  // DateTime properties
  print("Year: ${now.year}");
  print("Month: ${now.month}");
  print("Day: ${now.day}");
  print("Hour: ${now.hour}");
  print("Minute: ${now.minute}");
  print("Second: ${now.second}");
  print("Weekday: ${now.weekday}"); // 1 = Monday, 7 = Sunday
  
  // DateTime operations
  DateTime tomorrow = now.add(Duration(days: 1));
  DateTime lastWeek = now.subtract(Duration(days: 7));
  
  print("Tomorrow: $tomorrow");
  print("Last week: $lastWeek");
  
  // Comparison
  print(now.isAfter(lastWeek));      // true
  print(now.isBefore(tomorrow));     // true
  print(now.isAtSameMomentAs(now));  // true
  
  // Difference
  Duration diff = tomorrow.difference(now);
  print("Difference: ${diff.inHours} hours");
}
```

### Duration Operations
```dart
void durationOperations() {
  // Creating durations
  Duration oneHour = Duration(hours: 1);
  Duration twoMinutes = Duration(minutes: 2);
  Duration combined = Duration(days: 1, hours: 2, minutes: 30, seconds: 15);
  
  // Duration properties
  print("Total milliseconds: ${oneHour.inMilliseconds}");
  print("Total seconds: ${oneHour.inSeconds}");
  print("Total minutes: ${oneHour.inMinutes}");
  print("Total hours: ${oneHour.inHours}");
  print("Total days: ${oneHour.inDays}");
  
  // Duration arithmetic
  Duration sum = oneHour + twoMinutes;
  Duration difference = oneHour - twoMinutes;
  Duration multiplied = oneHour * 2;
  Duration divided = oneHour ~/ 2;
  
  print("Sum: $sum");
  print("Difference: $difference");
  
  // Comparison
  print(oneHour > twoMinutes);       // true
  print(oneHour == Duration(minutes: 60)); // true
}
```

## Error Handling

### Exception Types and Handling
```dart
void errorHandling() {
  // Common exception types
  try {
    // FormatException
    int.parse("not_a_number");
  } on FormatException catch (e) {
    print("Format error: ${e.message}");
  }
  
  try {
    // RangeError
    List<int> list = [1, 2, 3];
    print(list[10]); // Index out of range
  } on RangeError catch (e) {
    print("Range error: $e");
  }
  
  try {
    // ArgumentError
    String text = "Hello";
    text.substring(-1); // Invalid argument
  } on ArgumentError catch (e) {
    print("Argument error: $e");
  }
  
  // Generic exception handling
  try {
    riskyOperation();
  } catch (e, stackTrace) {
    print("Error: $e");
    print("Stack trace: $stackTrace");
  } finally {
    print("Cleanup code always runs");
  }
}

void riskyOperation() {
  throw StateError("Something went wrong!");
}
```

### Custom Exceptions
```dart
class CustomException implements Exception {
  final String message;
  final int errorCode;
  
  const CustomException(this.message, this.errorCode);
  
  @override
  String toString() => 'CustomException: $message (Code: $errorCode)';
}

void customExceptionExample() {
  try {
    throw CustomException("Invalid user input", 400);
  } on CustomException catch (e) {
    print("Caught custom exception: $e");
    print("Error code: ${e.errorCode}");
  }
}
```

## Streams and Futures

### Future Basics
```dart
// Future represents a potential value or error that will be available at some time in the future
Future<String> fetchUserName() async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 2));
  return "John Doe";
}

Future<int> calculateSum(int a, int b) async {
  // Simulate computation delay
  await Future.delayed(Duration(milliseconds: 500));
  return a + b;
}

void futureExamples() async {
  print("Starting async operations...");
  
  // Using await
  try {
    String name = await fetchUserName();
    print("User name: $name");
    
    int sum = await calculateSum(10, 20);
    print("Sum: $sum");
  } catch (e) {
    print("Error: $e");
  }
  
  // Using then/catchError
  fetchUserName()
    .then((name) => print("Name: $name"))
    .catchError((error) => print("Error: $error"));
  
  // Future.wait for multiple futures
  List<Future<int>> futures = [
    calculateSum(1, 2),
    calculateSum(3, 4),
    calculateSum(5, 6),
  ];
  
  List<int> results = await Future.wait(futures);
  print("Results: $results"); // [3, 7, 11]
}
```

### Stream Basics
```dart
// Stream represents a sequence of asynchronous events
Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // Emit value
  }
}

Stream<String> messageStream() async* {
  yield "Hello";
  await Future.delayed(Duration(seconds: 1));
  yield "World";
  await Future.delayed(Duration(seconds: 1));
  yield "From Dart";
}

void streamExamples() async {
  print("Stream examples:");
  
  // Listening to a stream
  await for (int number in numberStream()) {
    print("Received: $number");
  }
  
  // Using listen method
  messageStream().listen(
    (message) => print("Message: $message"),
    onError: (error) => print("Error: $error"),
    onDone: () => print("Stream completed"),
  );
  
  // Stream transformation
  Stream<int> doubled = numberStream().map((n) => n * 2);
  Stream<int> filtered = numberStream().where((n) => n.isEven);
  
  print("Doubled numbers:");
  await for (int number in doubled) {
    print(number);
  }
}
```

## Practical Examples

### File Processing Example
```dart
import 'dart:io';

class FileProcessor {
  static Future<Map<String, int>> countWordsInFile(String filePath) async {
    try {
      // Read file content
      String content = await File(filePath).readAsString();
      
      // Process text
      String cleaned = content.toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), ' ')
          .trim();
      
      List<String> words = cleaned.split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .toList();
      
      // Count words
      Map<String, int> wordCount = <String, int>{};
      for (String word in words) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
      }
      
      return wordCount;
    } catch (e) {
      print("Error processing file: $e");
      return <String, int>{};
    }
  }
  
  static void printTopWords(Map<String, int> wordCount, int top) {
    List<MapEntry<String, int>> sorted = wordCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    print("Top $top words:");
    for (int i = 0; i < top && i < sorted.length; i++) {
      print("${sorted[i].key}: ${sorted[i].value}");
    }
  }
}
```

### Data Validation Example
```dart
class Validator {
  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  static bool isValidPhoneNumber(String phone) {
    RegExp phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(phone);
  }
  
  static String? validatePassword(String password) {
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one digit";
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
    return null; // Valid password
  }
}

void validationExample() {
  List<String> emails = [
    "user@example.com",
    "invalid.email",
    "test@domain.co.uk",
  ];
  
  for (String email in emails) {
    print("$email is ${Validator.isValidEmail(email) ? 'valid' : 'invalid'}");
  }
  
  String password = "MyPassword123!";
  String? error = Validator.validatePassword(password);
  if (error == null) {
    print("Password is valid");
  } else {
    print("Password error: $error");
  }
}
```

### JSON Processing Example
```dart
import 'dart:convert';

class JsonProcessor {
  static Map<String, dynamic> parseUser(String jsonString) {
    try {
      Map<String, dynamic> data = jsonDecode(jsonString);
      return data;
    } catch (e) {
      print("Error parsing JSON: $e");
      return <String, dynamic>{};
    }
  }
  
  static String createUserJson(String name, int age, List<String> hobbies) {
    Map<String, dynamic> user = {
      'name': name,
      'age': age,
      'hobbies': hobbies,
      'created_at': DateTime.now().toIso8601String(),
    };
    
    return jsonEncode(user);
  }
  
  static List<Map<String, dynamic>> filterUsers(
    List<Map<String, dynamic>> users, 
    bool Function(Map<String, dynamic>) predicate
  ) {
    return users.where(predicate).toList();
  }
}

void jsonExample() {
  String userJson = '''
  {
    "name": "Alice Johnson",
    "age": 28,
    "email": "alice@example.com",
    "hobbies": ["reading", "hiking", "coding"]
  }
  ''';
  
  Map<String, dynamic> user = JsonProcessor.parseUser(userJson);
  print("User: ${user['name']}, Age: ${user['age']}");
  
  String newUserJson = JsonProcessor.createUserJson(
    "Bob Smith", 
    32, 
    ["gaming", "cooking"]
  );
  print("New user JSON: $newUserJson");
}
```

## Best Practices and Tips

### 1. Null Safety
```dart
void nullSafetyExamples() {
  // Use nullable types when appropriate
  String? nullableString;
  
  // Safe navigation
  print(nullableString?.length); // null
  
  // Null-aware operators
  String result = nullableString ?? "default";
  nullableString ??= "assigned if null";
  
  // Null assertion (use carefully)
  // String definitelyNotNull = nullableString!; // Throws if null
}
```

### 2. Performance Tips
```dart
void performanceTips() {
  // Use StringBuffer for building large strings
  StringBuffer buffer = StringBuffer();
  
  // Use const constructors when possible
  const List<int> constList = [1, 2, 3];
  
  // Prefer final over var when value won't change
  final String name = "Alice";
  
  // Use appropriate collection types
  Set<String> uniqueItems = <String>{}; // For unique items
  List<String> orderedItems = <String>[]; // For ordered items
  Map<String, String> keyValue = <String, String>{}; // For key-value pairs
}
```

### 3. Error Handling Best Practices
```dart
Future<String> robustOperation() async {
  try {
    // Risky operation
    return await someAsyncOperation();
  } on SpecificException catch (e) {
    // Handle specific exceptions
    print("Specific error: $e");
    rethrow; // Re-throw if needed
  } catch (e, stackTrace) {
    // Handle general exceptions
    print("General error: $e");
    print("Stack trace: $stackTrace");
    return "default_value";
  }
}

Future<String> someAsyncOperation() async {
  throw FormatException("Example error");
}
```

## Summary

Dart Core provides the fundamental building blocks for Dart applications:

1. **Essential Types**: Numbers, strings, booleans, and collections
2. **Object System**: Base classes and type system
3. **Collections**: Lists, sets, and maps with rich APIs
4. **Date/Time**: Comprehensive date and time handling
5. **Async Programming**: Futures and streams for asynchronous operations
6. **Error Handling**: Robust exception handling mechanisms

The library is designed to be:
- **Intuitive**: Easy to learn and use
- **Consistent**: Similar patterns across different APIs
- **Efficient**: Optimized for performance
- **Safe**: Strong type system with null safety

Understanding Dart Core is essential for effective Dart programming, as it provides the foundation upon which all other Dart libraries are built.