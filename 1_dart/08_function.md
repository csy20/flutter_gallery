# Functions in Dart

## Overview
Functions in Dart are reusable blocks of code that perform specific tasks. They are fundamental building blocks that help organize code, promote reusability, and make programs more modular and maintainable.

## Key Characteristics
- **First-class objects**: Functions can be assigned to variables, passed as arguments, and returned from other functions
- **Type-safe**: Support strong typing with return types and parameter types
- **Flexible**: Support various parameter types (required, optional, named)
- **Closures**: Can capture variables from their surrounding scope
- **Anonymous**: Can be defined without names (lambda functions)

## Basic Function Syntax

### 1. Simple Function Declaration
```dart
// Basic function with return type
int add(int a, int b) {
  return a + b;
}

// Function without return value (void)
void greet(String name) {
  print('Hello, $name!');
}

// Function with inferred return type
addNumbers(int x, int y) {
  return x + y; // Return type inferred as int
}
```

### 2. Arrow Functions (Short Syntax)
```dart
// Single expression functions
int multiply(int a, int b) => a * b;

void sayHello(String name) => print('Hello, $name!');

bool isEven(int number) => number % 2 == 0;

String formatName(String first, String last) => '$first $last';
```

## Function Parameters

### 1. Required Parameters
```dart
// All parameters are required
double calculateArea(double length, double width) {
  return length * width;
}

// Usage
double area = calculateArea(5.0, 3.0); // Must provide both parameters
```

### 2. Optional Positional Parameters
```dart
// Optional parameters in square brackets with default values
String createMessage(String text, [String prefix = 'Info', String suffix = '']) {
  return '$prefix: $text$suffix';
}

// Usage examples
print(createMessage('Hello'));                    // "Info: Hello"
print(createMessage('Hello', 'Warning'));         // "Warning: Hello"
print(createMessage('Hello', 'Error', '!'));      // "Error: Hello!"
```

### 3. Named Parameters
```dart
// Named parameters in curly braces
void printPersonInfo({
  required String name,
  int age = 0,
  String? city,
  bool isStudent = false
}) {
  print('Name: $name');
  print('Age: $age');
  if (city != null) print('City: $city');
  print('Student: $isStudent');
}

// Usage with named parameters
printPersonInfo(name: 'Alice', age: 25, city: 'New York');
printPersonInfo(name: 'Bob', isStudent: true);
```

### 4. Mixed Parameters
```dart
// Combination of required, optional positional, and named parameters
String formatUserData(
  String name,                    // Required positional
  [int age = 0],                 // Optional positional
  {String? email, bool verified = false} // Named parameters
) {
  String result = 'User: $name (Age: $age)';
  if (email != null) result += ', Email: $email';
  if (verified) result += ' ✓';
  return result;
}

// Usage examples
print(formatUserData('Alice'));
print(formatUserData('Bob', 30));
print(formatUserData('Charlie', 25, email: 'charlie@email.com', verified: true));
```

## Return Types

### 1. Explicit Return Types
```dart
// Specific return types
int getLength(String text) {
  return text.length;
}

List<String> getWords(String sentence) {
  return sentence.split(' ');
}

Map<String, int> getCharacterCount(String text) {
  Map<String, int> count = {};
  for (int i = 0; i < text.length; i++) {
    String char = text[i];
    count[char] = (count[char] ?? 0) + 1;
  }
  return count;
}
```

### 2. Generic Return Types
```dart
// Generic functions
T getFirst<T>(List<T> items) {
  if (items.isEmpty) throw ArgumentError('List cannot be empty');
  return items.first;
}

List<T> filterItems<T>(List<T> items, bool Function(T) predicate) {
  return items.where(predicate).toList();
}

// Usage
int firstNumber = getFirst<int>([1, 2, 3]);
String firstName = getFirst<String>(['Alice', 'Bob']);
List<int> evenNumbers = filterItems<int>([1, 2, 3, 4, 5], (n) => n % 2 == 0);
```

### 3. Nullable Return Types
```dart
// Function that might return null
String? findUserById(int id) {
  Map<int, String> users = {1: 'Alice', 2: 'Bob', 3: 'Charlie'};
  return users[id]; // Returns null if id not found
}

// Safe handling of nullable returns
String? user = findUserById(5);
if (user != null) {
  print('Found user: $user');
} else {
  print('User not found');
}
```

## Higher-Order Functions

### 1. Functions as Parameters
```dart
// Function that takes another function as parameter
void executeOperation(int a, int b, int Function(int, int) operation) {
  int result = operation(a, b);
  print('Result: $result');
}

// Usage with different operations
executeOperation(5, 3, (x, y) => x + y);  // Addition
executeOperation(5, 3, (x, y) => x * y);  // Multiplication
executeOperation(5, 3, (x, y) => x - y);  // Subtraction
```

### 2. Functions Returning Functions
```dart
// Function that returns another function
Function(int) createMultiplier(int multiplier) {
  return (int value) => value * multiplier;
}

// Usage
var double = createMultiplier(2);
var triple = createMultiplier(3);

print(double(5));  // 10
print(triple(4));  // 12
```

### 3. Callback Functions
```dart
// Asynchronous operation with callback
void fetchData(String url, void Function(String) onSuccess, void Function(String) onError) {
  // Simulate async operation
  Future.delayed(Duration(seconds: 1), () {
    if (url.isNotEmpty) {
      onSuccess('Data from $url');
    } else {
      onError('Invalid URL');
    }
  });
}

// Usage
fetchData(
  'https://api.example.com/data',
  (data) => print('Success: $data'),
  (error) => print('Error: $error')
);
```

## Anonymous Functions and Closures

### 1. Anonymous Functions (Lambda)
```dart
// Anonymous function assigned to variable
var square = (int x) => x * x;
print(square(5)); // 25

// Anonymous function in method calls
List<int> numbers = [1, 2, 3, 4, 5];
List<int> squared = numbers.map((n) => n * n).toList();
List<int> evens = numbers.where((n) => n % 2 == 0).toList();

// Multi-line anonymous function
var processData = (List<String> data) {
  return data
      .where((item) => item.isNotEmpty)
      .map((item) => item.toUpperCase())
      .toList();
};
```

### 2. Closures
```dart
// Closure that captures variables from outer scope
Function createCounter() {
  int count = 0;
  
  return () {
    count++;
    return count;
  };
}

// Usage
var counter1 = createCounter();
var counter2 = createCounter();

print(counter1()); // 1
print(counter1()); // 2
print(counter2()); // 1 (separate closure)
print(counter1()); // 3
```

### 3. Practical Closure Example
```dart
// Configuration closure
Map<String, dynamic> createApiClient(String baseUrl, String apiKey) {
  // Private configuration captured in closure
  
  Future<String> get(String endpoint) async {
    String url = '$baseUrl$endpoint';
    // Simulate API call
    return 'GET $url with key: $apiKey';
  }
  
  Future<String> post(String endpoint, Map<String, dynamic> data) async {
    String url = '$baseUrl$endpoint';
    return 'POST $url with data: $data and key: $apiKey';
  }
  
  return {
    'get': get,
    'post': post,
  };
}
```

## Function Types and Typedef

### 1. Function Type Declarations
```dart
// Function type as parameter
void processNumbers(List<int> numbers, int Function(int) transformer) {
  for (int number in numbers) {
    print(transformer(number));
  }
}

// Function type as variable
int Function(int, int) calculator;
calculator = (a, b) => a + b;
print(calculator(5, 3)); // 8
```

### 2. Typedef for Complex Function Types
```dart
// Define function type aliases
typedef MathOperation = int Function(int a, int b);
typedef StringProcessor = String Function(String input);
typedef EventHandler = void Function(String eventType, Map<String, dynamic> data);

// Usage of typedef
MathOperation addition = (a, b) => a + b;
MathOperation multiplication = (a, b) => a * b;

StringProcessor upperCase = (text) => text.toUpperCase();
StringProcessor reverse = (text) => text.split('').reversed.join('');

// Function that accepts typedef
void performCalculation(int x, int y, MathOperation operation) {
  int result = operation(x, y);
  print('Result: $result');
}

performCalculation(10, 5, addition);       // Result: 15
performCalculation(10, 5, multiplication); // Result: 50
```

## Recursive Functions

### 1. Basic Recursion
```dart
// Factorial calculation
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Fibonacci sequence
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// Usage
print(factorial(5));  // 120
print(fibonacci(7));  // 13
```

### 2. Tail Recursion
```dart
// Tail recursive factorial (more efficient)
int factorialTail(int n, [int accumulator = 1]) {
  if (n <= 1) return accumulator;
  return factorialTail(n - 1, n * accumulator);
}

// Tail recursive sum
int sumList(List<int> numbers, [int index = 0, int sum = 0]) {
  if (index >= numbers.length) return sum;
  return sumList(numbers, index + 1, sum + numbers[index]);
}
```

### 3. Tree Traversal Example
```dart
class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  
  TreeNode(this.value, [this.left, this.right]);
}

// Recursive tree traversal
void inorderTraversal(TreeNode? node, void Function(int) visit) {
  if (node == null) return;
  
  inorderTraversal(node.left, visit);
  visit(node.value);
  inorderTraversal(node.right, visit);
}

// Usage
TreeNode root = TreeNode(1, TreeNode(2), TreeNode(3));
inorderTraversal(root, (value) => print(value));
```

## Asynchronous Functions

### 1. Future-based Functions
```dart
// Async function returning Future
Future<String> fetchUserData(int userId) async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 2));
  return 'User data for ID: $userId';
}

// Function with error handling
Future<Map<String, dynamic>> fetchJsonData(String url) async {
  try {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    if (url.isEmpty) throw Exception('Invalid URL');
    return {'data': 'Sample JSON data', 'status': 'success'};
  } catch (e) {
    return {'error': e.toString(), 'status': 'error'};
  }
}
```

### 2. Stream-based Functions
```dart
// Function returning Stream
Stream<int> generateNumbers(int count) async* {
  for (int i = 1; i <= count; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}

// Stream processing function
Stream<String> processDataStream(Stream<int> numbers) async* {
  await for (int number in numbers) {
    yield 'Processed: ${number * 2}';
  }
}

// Usage
void useStreams() async {
  Stream<int> numbers = generateNumbers(5);
  Stream<String> processed = processDataStream(numbers);
  
  await for (String result in processed) {
    print(result);
  }
}
```

## Function Generators

### 1. Sync Generators
```dart
// Synchronous generator
Iterable<int> countUp(int max) sync* {
  for (int i = 1; i <= max; i++) {
    yield i;
  }
}

// Generator with condition
Iterable<int> evenNumbers(int limit) sync* {
  for (int i = 0; i <= limit; i += 2) {
    yield i;
  }
}

// Recursive generator
Iterable<int> fibonacci(int count) sync* {
  int a = 0, b = 1;
  for (int i = 0; i < count; i++) {
    yield a;
    int temp = a + b;
    a = b;
    b = temp;
  }
}
```

### 2. Async Generators
```dart
// Asynchronous generator
Stream<String> readLines(String filename) async* {
  // Simulate reading file line by line
  List<String> lines = ['Line 1', 'Line 2', 'Line 3', 'Line 4'];
  
  for (String line in lines) {
    await Future.delayed(Duration(milliseconds: 100));
    yield line;
  }
}

// Data processing stream
Stream<Map<String, dynamic>> processEvents() async* {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield {
      'id': i,
      'timestamp': DateTime.now().toIso8601String(),
      'event': 'Event $i'
    };
  }
}
```

## Advanced Function Patterns

### 1. Function Composition
```dart
// Compose multiple functions
T Function(A) compose<A, B, T>(T Function(B) f, B Function(A) g) {
  return (A input) => f(g(input));
}

// Example functions
int addOne(int x) => x + 1;
int multiplyByTwo(int x) => x * 2;
String toString(int x) => x.toString();

// Compose functions
var addThenMultiply = compose<int, int, int>(multiplyByTwo, addOne);
var processNumber = compose<int, int, String>(toString, addThenMultiply);

print(processNumber(5)); // "12" (5 + 1 = 6, 6 * 2 = 12)
```

### 2. Partial Application
```dart
// Partial application function
Function partial(Function func, List<dynamic> args1) {
  return (List<dynamic> args2) {
    List<dynamic> allArgs = [...args1, ...args2];
    return Function.apply(func, allArgs);
  };
}

// Example usage
int add3Numbers(int a, int b, int c) => a + b + c;

var add5And = partial(add3Numbers, [5]);
print(add5And([3, 2])); // 10 (5 + 3 + 2)
```

### 3. Memoization
```dart
// Memoization decorator
Function memoize(Function func) {
  Map<String, dynamic> cache = {};
  
  return (List<dynamic> args) {
    String key = args.toString();
    if (cache.containsKey(key)) {
      print('Cache hit for: $key');
      return cache[key];
    }
    
    dynamic result = Function.apply(func, args);
    cache[key] = result;
    return result;
  };
}

// Expensive function to memoize
int expensiveCalculation(int n) {
  print('Computing for: $n');
  // Simulate expensive operation
  int result = 1;
  for (int i = 1; i <= n; i++) {
    result *= i;
  }
  return result;
}

// Memoized version
var memoizedFactorial = memoize(expensiveCalculation);
```

## Error Handling in Functions

### 1. Exception Handling
```dart
// Function with exception handling
double divide(double a, double b) {
  if (b == 0) {
    throw ArgumentError('Cannot divide by zero');
  }
  return a / b;
}

// Safe division function
double? safeDivide(double a, double b) {
  try {
    return divide(a, b);
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

// Function with custom exceptions
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => 'ValidationException: $message';
}

void validateAge(int age) {
  if (age < 0) {
    throw ValidationException('Age cannot be negative');
  }
  if (age > 150) {
    throw ValidationException('Age seems unrealistic');
  }
}
```

### 2. Result Type Pattern
```dart
// Result type for better error handling
class Result<T> {
  final T? value;
  final String? error;
  final bool isSuccess;
  
  Result.success(this.value) : error = null, isSuccess = true;
  Result.failure(this.error) : value = null, isSuccess = false;
}

// Function returning Result
Result<int> parseInteger(String input) {
  try {
    int value = int.parse(input);
    return Result.success(value);
  } catch (e) {
    return Result.failure('Invalid integer: $input');
  }
}

// Usage
Result<int> result = parseInteger('123');
if (result.isSuccess) {
  print('Parsed value: ${result.value}');
} else {
  print('Error: ${result.error}');
}
```

## Best Practices and Common Patterns

### 1. Function Naming
```dart
// Good function names - verbs that describe what they do
bool isEmpty(List list) => list.isEmpty;
String formatCurrency(double amount) => '\$${amount.toStringAsFixed(2)}';
void validateEmail(String email) { /* validation logic */ }
List<String> filterActiveUsers(List<User> users) { /* filtering logic */ }

// Boolean functions should ask questions
bool isValid(String input) => input.isNotEmpty;
bool hasPermission(User user, String permission) => user.permissions.contains(permission);
bool canEdit(User user, Document doc) => user.id == doc.ownerId || user.isAdmin;
```

### 2. Single Responsibility
```dart
// Bad - function does too many things
void processUser(String email, String password) {
  // Validate email
  if (!email.contains('@')) throw Exception('Invalid email');
  
  // Hash password
  String hashedPassword = hashPassword(password);
  
  // Save to database
  saveUser(email, hashedPassword);
  
  // Send welcome email
  sendWelcomeEmail(email);
}

// Good - separate concerns
bool isValidEmail(String email) => email.contains('@');
String hashPassword(String password) => /* hashing logic */;
void saveUser(String email, String hashedPassword) => /* save logic */;
void sendWelcomeEmail(String email) => /* email logic */;

void createUser(String email, String password) {
  if (!isValidEmail(email)) throw Exception('Invalid email');
  
  String hashed = hashPassword(password);
  saveUser(email, hashed);
  sendWelcomeEmail(email);
}
```

### 3. Pure Functions
```dart
// Pure function - no side effects, same input always produces same output
int add(int a, int b) => a + b;

List<T> filter<T>(List<T> items, bool Function(T) predicate) {
  return items.where(predicate).toList();
}

// Impure function - has side effects
int counter = 0;
int incrementCounter() => ++counter; // Modifies global state

// Better - pure version
int increment(int current) => current + 1;
```

### 4. Function Documentation
```dart
/// Calculates the area of a rectangle.
/// 
/// Takes the [length] and [width] of a rectangle and returns the area.
/// Both parameters must be positive numbers.
/// 
/// Example:
/// ```dart
/// double area = calculateRectangleArea(5.0, 3.0);
/// print(area); // 15.0
/// ```
/// 
/// Throws [ArgumentError] if either parameter is negative or zero.
double calculateRectangleArea(double length, double width) {
  if (length <= 0 || width <= 0) {
    throw ArgumentError('Length and width must be positive');
  }
  return length * width;
}

/// Finds the maximum value in a list of numbers.
/// 
/// Returns `null` if the list is empty.
/// 
/// Example:
/// ```dart
/// int? max = findMaximum([1, 5, 3, 9, 2]);
/// print(max); // 9
/// ```
int? findMaximum(List<int> numbers) {
  if (numbers.isEmpty) return null;
  return numbers.reduce((a, b) => a > b ? a : b);
}
```

## Common Use Cases and Examples

### 1. Data Processing Functions
```dart
// Transform and filter data
List<Map<String, dynamic>> processProducts(List<Map<String, dynamic>> products) {
  return products
      .where((product) => product['price'] > 0)
      .map((product) => {
        ...product,
        'formattedPrice': '\$${product['price'].toStringAsFixed(2)}',
        'isExpensive': product['price'] > 100,
      })
      .toList();
}

// Aggregate data
Map<String, dynamic> calculateStatistics(List<double> values) {
  if (values.isEmpty) return {'error': 'No data provided'};
  
  double sum = values.fold(0.0, (a, b) => a + b);
  double mean = sum / values.length;
  
  List<double> sorted = [...values]..sort();
  double median = sorted.length % 2 == 0
      ? (sorted[sorted.length ~/ 2 - 1] + sorted[sorted.length ~/ 2]) / 2
      : sorted[sorted.length ~/ 2];
  
  return {
    'count': values.length,
    'sum': sum,
    'mean': mean,
    'median': median,
    'min': sorted.first,
    'max': sorted.last,
  };
}
```

### 2. Validation Functions
```dart
// Input validation
bool isValidPassword(String password) {
  if (password.length < 8) return false;
  if (!password.contains(RegExp(r'[A-Z]'))) return false;
  if (!password.contains(RegExp(r'[a-z]'))) return false;
  if (!password.contains(RegExp(r'[0-9]'))) return false;
  return true;
}

Map<String, String> validateUser(Map<String, dynamic> userData) {
  Map<String, String> errors = {};
  
  if (userData['name']?.isEmpty ?? true) {
    errors['name'] = 'Name is required';
  }
  
  if (userData['email']?.isEmpty ?? true) {
    errors['email'] = 'Email is required';
  } else if (!userData['email'].contains('@')) {
    errors['email'] = 'Invalid email format';
  }
  
  if (!isValidPassword(userData['password'] ?? '')) {
    errors['password'] = 'Password must be at least 8 characters with uppercase, lowercase, and numbers';
  }
  
  return errors;
}
```

### 3. Utility Functions
```dart
// String utilities
String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String truncate(String text, int maxLength, [String suffix = '...']) {
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength - suffix.length) + suffix;
}

// List utilities
List<T> removeDuplicates<T>(List<T> items) {
  return items.toSet().toList();
}

List<List<T>> chunk<T>(List<T> items, int size) {
  List<List<T>> chunks = [];
  for (int i = 0; i < items.length; i += size) {
    int end = (i + size < items.length) ? i + size : items.length;
    chunks.add(items.sublist(i, end));
  }
  return chunks;
}

// Date utilities
String formatDate(DateTime date, [String format = 'yyyy-MM-dd']) {
  return date.toIso8601String().split('T')[0];
}

bool isWeekend(DateTime date) {
  return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
}
```

## Performance Considerations

### 1. Function Call Overhead
```dart
// Inline simple operations instead of function calls in tight loops
// Bad for performance in tight loops
int square(int x) => x * x;

void processLargeList(List<int> numbers) {
  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = square(numbers[i]); // Function call overhead
  }
}

// Better for performance
void processLargeListOptimized(List<int> numbers) {
  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = numbers[i] * numbers[i]; // Inline operation
  }
}
```

### 2. Memory Efficiency
```dart
// Avoid creating unnecessary intermediate collections
// Less efficient - creates intermediate list
List<String> processNames(List<String> names) {
  return names
      .where((name) => name.isNotEmpty)
      .map((name) => name.trim())
      .map((name) => name.toUpperCase())
      .toList();
}

// More efficient - single pass
List<String> processNamesEfficient(List<String> names) {
  List<String> result = [];
  for (String name in names) {
    if (name.isNotEmpty) {
      result.add(name.trim().toUpperCase());
    }
  }
  return result;
}
```

## Summary

Functions in Dart are powerful and flexible, supporting:

- **Multiple parameter types**: Required, optional positional, and named parameters
- **Strong typing**: Explicit return types and parameter types
- **First-class support**: Functions as values, parameters, and return types
- **Async programming**: Future and Stream support
- **Generators**: Sync and async generators for lazy evaluation
- **Closures**: Capturing variables from outer scope
- **Pattern matching**: Various function patterns and compositions

Understanding functions thoroughly is crucial for effective Dart programming and building maintainable, reusable code structures.