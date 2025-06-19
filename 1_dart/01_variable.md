# Hello World and Variables in Dart 🎯

## Table of Contents
1. [Hello World Program](#hello-world-program)
2. [Understanding Variables](#understanding-variables)
3. [Data Types](#data-types)
4. [Variable Declaration Methods](#variable-declaration-methods)
5. [String Interpolation](#string-interpolation)
6. [Constants](#constants)
7. [Null Safety](#null-safety)
8. [Best Practices](#best-practices)

---

## Hello World Program

The traditional "Hello World" program is the first step in learning any programming language. In Dart, it's simple and elegant:

```dart
void main() {
  print('Hello, World!');
}
```

### Breaking it down:
- `void main()` - The entry point of every Dart program
- `print()` - Built-in function to display output to console
- `'Hello, World!'` - A string literal enclosed in single quotes

### Different ways to print:

```dart
void main() {
  // Using single quotes
  print('Hello, World!');
  
  // Using double quotes
  print("Hello, Dart!");
  
  // Multi-line string
  print('''
  Hello,
  Beautiful
  World!
  ''');
  
  // Using raw strings (preserves backslashes)
  print(r'C:\Users\Documents\file.txt');
}
```

---

## Understanding Variables

Variables are containers that store data values. In Dart, variables are references to objects.

### Key Concepts:
- **Variable Name**: Identifier used to access the stored value
- **Data Type**: The kind of data the variable can hold
- **Value**: The actual data stored in the variable

```dart
void main() {
  // Variable declaration and initialization
  String name = 'Alice';
  int age = 25;
  double height = 5.6;
  bool isStudent = true;
  
  print('Name: $name');
  print('Age: $age');
  print('Height: $height feet');
  print('Is Student: $isStudent');
}
```

---

## Data Types

Dart has several built-in data types:

### 1. **Numbers**
```dart
void main() {
  // Integer - whole numbers
  int wholeNumber = 42;
  int negativeNumber = -10;
  
  // Double - floating-point numbers
  double decimal = 3.14159;
  double scientific = 1.42e5; // 142000.0
  
  // Num - can be either int or double
  num anyNumber = 100;
  anyNumber = 99.9; // Can change from int to double
  
  print('Integer: $wholeNumber');
  print('Double: $decimal');
  print('Scientific: $scientific');
  print('Num: $anyNumber');
}
```

### 2. **Strings**
```dart
void main() {
  String singleQuoted = 'Hello with single quotes';
  String doubleQuoted = "Hello with double quotes";
  
  // Multi-line strings
  String multiLine = '''
  This is a
  multi-line
  string in Dart
  ''';
  
  // String concatenation
  String firstName = 'John';
  String lastName = 'Doe';
  String fullName = firstName + ' ' + lastName;
  
  print('Single: $singleQuoted');
  print('Double: $doubleQuoted');
  print('Multi-line: $multiLine');
  print('Full Name: $fullName');
}
```

### 3. **Booleans**
```dart
void main() {
  bool isTrue = true;
  bool isFalse = false;
  bool result = 5 > 3; // true
  
  print('Is True: $isTrue');
  print('Is False: $isFalse');
  print('5 > 3: $result');
}
```

### 4. **Collections**
```dart
void main() {
  // List (ordered collection)
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // Set (unique elements)
  Set<String> colors = {'Red', 'Green', 'Blue'};
  
  // Map (key-value pairs)
  Map<String, int> ages = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35
  };
  
  print('Fruits: $fruits');
  print('Numbers: $numbers');
  print('Colors: $colors');
  print('Ages: $ages');
}
```

---

## Variable Declaration Methods

### 1. **Using `var` (Type Inference)**
```dart
void main() {
  var name = 'Alice';        // String inferred
  var age = 25;              // int inferred
  var height = 5.6;          // double inferred
  var isActive = true;       // bool inferred
  
  print('Name: $name (${name.runtimeType})');
  print('Age: $age (${age.runtimeType})');
  print('Height: $height (${height.runtimeType})');
  print('Active: $isActive (${isActive.runtimeType})');
}
```

### 2. **Explicit Type Declaration**
```dart
void main() {
  String city = 'New York';
  int population = 8000000;
  double area = 302.6;
  bool isCapital = false;
  
  print('City: $city');
  print('Population: $population');
  print('Area: $area sq miles');
  print('Is Capital: $isCapital');
}
```

### 3. **Late Variables**
```dart
void main() {
  late String description;
  
  // Initialize later
  description = 'This is initialized later';
  
  print('Description: $description');
}
```

---

## String Interpolation

String interpolation allows you to embed expressions inside strings:

```dart
void main() {
  String name = 'Alice';
  int age = 25;
  double salary = 50000.0;
  
  // Basic interpolation with $
  print('Hello, $name!');
  print('Age: $age years old');
  
  // Expression interpolation with ${}
  print('Next year you will be ${age + 1}');
  print('Monthly salary: \$${salary / 12}');
  print('Is adult: ${age >= 18}');
  
  // Complex expressions
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('Status: $status');
  
  // Method calls in interpolation
  print('Name length: ${name.length}');
  print('Name uppercase: ${name.toUpperCase()}');
}
```

---

## Constants

Constants are variables whose values cannot be changed after initialization:

### 1. **`final` - Runtime Constants**
```dart
void main() {
  final String appName = 'My Dart App';
  final DateTime currentTime = DateTime.now();
  final List<String> items = ['Item1', 'Item2'];
  
  // appName = 'New Name'; // Error! Cannot reassign
  items.add('Item3'); // OK! Can modify the list contents
  
  print('App Name: $appName');
  print('Current Time: $currentTime');
  print('Items: $items');
}
```

### 2. **`const` - Compile-time Constants**
```dart
void main() {
  const double pi = 3.14159;
  const String version = '1.0.0';
  const List<int> primes = [2, 3, 5, 7, 11];
  
  // const DateTime now = DateTime.now(); // Error! Not compile-time constant
  
  print('Pi: $pi');
  print('Version: $version');
  print('Primes: $primes');
}
```

---

## Null Safety

Dart has sound null safety, meaning variables cannot contain null unless explicitly declared as nullable:

### 1. **Non-nullable Variables**
```dart
void main() {
  String name = 'Alice';           // Cannot be null
  int age = 25;                    // Cannot be null
  
  // name = null;                  // Error! Cannot assign null
  
  print('Name: $name');
  print('Age: $age');
}
```

### 2. **Nullable Variables**
```dart
void main() {
  String? nullableName = null;     // Can be null
  int? nullableAge;                // Defaults to null
  
  print('Nullable Name: $nullableName');
  print('Nullable Age: $nullableAge');
  
  // Safe access with null-aware operators
  print('Name length: ${nullableName?.length}');
  
  // Null coalescing operator
  String displayName = nullableName ?? 'Unknown';
  print('Display Name: $displayName');
  
  // Null assertion operator (use carefully!)
  if (nullableName != null) {
    print('Name length: ${nullableName!.length}');
  }
}
```

---

## Best Practices

### 1. **Naming Conventions**
```dart
void main() {
  // Use camelCase for variables
  String firstName = 'Alice';
  int totalAmount = 1000;
  bool isLoggedIn = true;
  
  // Use descriptive names
  double accountBalance = 5000.0;  // Good
  double bal = 5000.0;             // Avoid
  
  // Constants in lowerCamelCase
  const int maxRetries = 3;
  const String apiUrl = 'https://api.example.com';
}
```

### 2. **Type Safety**
```dart
void main() {
  // Prefer explicit types for public APIs
  String getUserName() => 'Alice';
  
  // Use var for local variables when type is obvious
  var items = <String>['Apple', 'Banana'];
  var count = items.length;
  
  // Use final for variables that won't be reassigned
  final String appTitle = 'My App';
  final DateTime startTime = DateTime.now();
}
```

### 3. **Initialize Variables**
```dart
void main() {
  // Initialize non-nullable variables
  String message = 'Hello';
  int counter = 0;
  List<String> items = [];
  
  // Use late for expensive initialization
  late String expensiveData;
  
  // Initialize when needed
  expensiveData = computeExpensiveData();
  
  print('Message: $message');
  print('Counter: $counter');
  print('Items: $items');
}

String computeExpensiveData() {
  // Simulate expensive computation
  return 'Computed data';
}
```

---

## Complete Example

Here's a comprehensive example that demonstrates all concepts:

```dart
void main() {
  // Hello World
  print('🌍 Hello, Dart World! 🌍\n');
  
  // Variable declarations
  String developerName = 'Alice Johnson';
  int experienceYears = 5;
  double hourlyRate = 75.50;
  bool isRemote = true;
  
  // Collections
  List<String> skills = ['Dart', 'Flutter', 'Firebase'];
  Map<String, dynamic> contact = {
    'email': 'alice@example.com',
    'phone': '+1-555-0123'
  };
  
  // Constants
  const String company = 'Tech Solutions Inc.';
  final DateTime hireDate = DateTime(2019, 3, 15);
  
  // Nullable variables
  String? middleName;
  int? previousSalary;
  
  // Output with string interpolation
  print('👩‍💻 Developer Profile:');
  print('Name: $developerName ${middleName ?? ''}');
  print('Experience: $experienceYears years');
  print('Hourly Rate: \$${hourlyRate.toStringAsFixed(2)}');
  print('Remote Work: ${isRemote ? 'Yes' : 'No'}');
  print('Company: $company');
  print('Hire Date: ${hireDate.year}-${hireDate.month}-${hireDate.day}');
  
  print('\n🛠️ Skills:');
  for (int i = 0; i < skills.length; i++) {
    print('  ${i + 1}. ${skills[i]}');
  }
  
  print('\n📞 Contact Information:');
  contact.forEach((key, value) {
    print('  ${key.toUpperCase()}: $value');
  });
  
  // Calculations
  int totalHoursPerWeek = 40;
  double weeklyEarnings = hourlyRate * totalHoursPerWeek;
  double monthlyEarnings = weeklyEarnings * 4.33; // Average weeks per month
  
  print('\n💰 Earnings:');
  print('Weekly: \$${weeklyEarnings.toStringAsFixed(2)}');
  print('Monthly: \$${monthlyEarnings.toStringAsFixed(2)}');
  print('Annual: \$${(monthlyEarnings * 12).toStringAsFixed(2)}');
  
  // Conditional output
  if (experienceYears >= 5) {
    print('\n⭐ Status: Senior Developer');
  } else if (experienceYears >= 2) {
    print('\n⭐ Status: Mid-level Developer');
  } else {
    print('\n⭐ Status: Junior Developer');
  }
}
```

---

## Key Takeaways

1. **Hello World** is simple in Dart: `print('Hello, World!');`
2. **Variables** store data and can be declared with `var`, explicit types, or `late`
3. **Data Types** include numbers, strings, booleans, and collections
4. **String Interpolation** uses `$variable` or `${expression}` syntax
5. **Constants** use `final` (runtime) or `const` (compile-time)
6. **Null Safety** prevents null-related runtime errors
7. **Best Practices** include descriptive naming, type safety, and proper initialization

Understanding these fundamentals is crucial for Dart and Flutter development! 🚀