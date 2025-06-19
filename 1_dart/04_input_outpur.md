# Input and Output in Dart

## Overview
Input and Output (I/O) operations are fundamental concepts in programming that allow programs to interact with users and external systems. In Dart, we have various ways to handle input from users and display output to the console or other destinations.

## Table of Contents
1. [Output Operations](#output-operations)
2. [Input Operations](#input-operations)
3. [String Interpolation](#string-interpolation)
4. [Formatting Output](#formatting-output)
5. [File I/O Operations](#file-io-operations)
6. [Error Handling in I/O](#error-handling-in-io)
7. [Best Practices](#best-practices)

## Output Operations

### Basic Print Statement
The most common way to display output in Dart is using the `print()` function.

```dart
void main() {
  // Basic print statements
  print('Hello, World!');
  print('Welcome to Dart programming!');
  
  // Printing variables
  String name = 'Alice';
  int age = 25;
  print('Name: $name');
  print('Age: $age');
}
```

### Different Print Methods

```dart
import 'dart:io';

void main() {
  // Using print() - adds newline automatically
  print('This is line 1');
  print('This is line 2');
  
  // Using stdout.write() - no automatic newline
  stdout.write('Hello ');
  stdout.write('World');
  stdout.write('\n'); // Manual newline
  
  // Using stdout.writeln() - adds newline
  stdout.writeln('This line ends with newline');
  
  // Printing different data types
  print(42);           // Integer
  print(3.14);         // Double
  print(true);         // Boolean
  print([1, 2, 3]);    // List
  print({'a': 1, 'b': 2}); // Map
}
```

## Input Operations

### Reading from Console
To read input from the user, we use `stdin.readLineSync()`.

```dart
import 'dart:io';

void main() {
  // Basic input reading
  print('Enter your name: ');
  String? name = stdin.readLineSync();
  print('Hello, $name!');
  
  // Reading and converting to different types
  print('Enter your age: ');
  String? ageInput = stdin.readLineSync();
  int age = int.parse(ageInput ?? '0');
  print('You are $age years old');
  
  // Reading double values
  print('Enter your height in meters: ');
  String? heightInput = stdin.readLineSync();
  double height = double.parse(heightInput ?? '0.0');
  print('Your height is $height meters');
}
```

### Safe Input Handling

```dart
import 'dart:io';

void main() {
  // Safe integer input with error handling
  print('Enter a number: ');
  String? input = stdin.readLineSync();
  
  try {
    int number = int.parse(input ?? '');
    print('You entered: $number');
    print('Double of your number: ${number * 2}');
  } catch (e) {
    print('Invalid input! Please enter a valid number.');
  }
  
  // Using null-aware operators
  print('Enter your favorite color: ');
  String color = stdin.readLineSync() ?? 'unknown';
  print('Your favorite color is: $color');
}
```

## String Interpolation

### Basic String Interpolation

```dart
void main() {
  String firstName = 'John';
  String lastName = 'Doe';
  int age = 30;
  double salary = 50000.50;
  
  // Simple variable interpolation
  print('First Name: $firstName');
  print('Last Name: $lastName');
  
  // Expression interpolation
  print('Full Name: $firstName $lastName');
  print('Age next year: ${age + 1}');
  print('Monthly Salary: \$${salary / 12}');
  
  // Complex expressions
  print('Status: ${age >= 18 ? "Adult" : "Minor"}');
  print('Name Length: ${firstName.length + lastName.length} characters');
}
```

### Advanced String Interpolation

```dart
void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  Map<String, String> person = {
    'name': 'Alice',
    'city': 'New York'
  };
  
  // Collection interpolation
  print('Numbers: $numbers');
  print('First number: ${numbers.first}');
  print('Last number: ${numbers.last}');
  print('Sum: ${numbers.reduce((a, b) => a + b)}');
  
  // Map interpolation
  print('Person: ${person['name']} lives in ${person['city']}');
  
  // Method calls in interpolation
  DateTime now = DateTime.now();
  print('Current time: ${now.toString()}');
  print('Year: ${now.year}');
  print('Formatted: ${now.day}/${now.month}/${now.year}');
}
```

## Formatting Output

### Number Formatting

```dart
void main() {
  double pi = 3.14159265359;
  double price = 1234.567;
  
  // Decimal places
  print('Pi to 2 decimal places: ${pi.toStringAsFixed(2)}');
  print('Pi to 4 decimal places: ${pi.toStringAsFixed(4)}');
  
  // Precision formatting
  print('Pi with 3 significant digits: ${pi.toStringAsPrecision(3)}');
  
  // Currency formatting
  print('Price: \$${price.toStringAsFixed(2)}');
  
  // Padding numbers
  int number = 42;
  print('Padded number: ${number.toString().padLeft(5, '0')}');
}
```

### String Formatting

```dart
void main() {
  String name = 'Alice';
  String message = 'Hello';
  
  // String padding
  print('Left padded: ${name.padLeft(10, '*')}');
  print('Right padded: ${name.padRight(10, '*')}');
  
  // String manipulation in output
  print('Uppercase: ${name.toUpperCase()}');
  print('Lowercase: ${name.toLowerCase()}');
  print('Reversed: ${name.split('').reversed.join()}');
  
  // Multi-line strings
  String multiLine = '''
  Name: $name
  Message: $message
  Time: ${DateTime.now()}
  ''';
  print(multiLine);
}
```

## File I/O Operations

### Reading from Files

```dart
import 'dart:io';

void main() async {
  try {
    // Reading entire file as string
    File file = File('example.txt');
    String contents = await file.readAsString();
    print('File contents:');
    print(contents);
    
    // Reading file line by line
    List<String> lines = await file.readAsLines();
    print('File has ${lines.length} lines');
    for (int i = 0; i < lines.length; i++) {
      print('Line ${i + 1}: ${lines[i]}');
    }
  } catch (e) {
    print('Error reading file: $e');
  }
}
```

### Writing to Files

```dart
import 'dart:io';

void main() async {
  try {
    File outputFile = File('output.txt');
    
    // Writing string to file
    await outputFile.writeAsString('Hello, Dart!\n');
    
    // Appending to file
    await outputFile.writeAsString('This is appended text.\n', 
                                   mode: FileMode.append);
    
    // Writing multiple lines
    List<String> lines = [
      'Line 1',
      'Line 2',
      'Line 3'
    ];
    await outputFile.writeAsString(lines.join('\n'));
    
    print('Data written to output.txt successfully!');
  } catch (e) {
    print('Error writing to file: $e');
  }
}
```

## Error Handling in I/O

### Input Validation

```dart
import 'dart:io';

int getValidInteger(String prompt) {
  while (true) {
    print(prompt);
    String? input = stdin.readLineSync();
    
    if (input == null || input.isEmpty) {
      print('Please enter a value.');
      continue;
    }
    
    try {
      return int.parse(input);
    } catch (e) {
      print('Invalid input. Please enter a valid integer.');
    }
  }
}

void main() {
  // Get valid integer input
  int age = getValidInteger('Enter your age: ');
  print('Your age is: $age');
  
  // Get valid double input
  print('Enter your weight in kg: ');
  double weight = 0.0;
  
  while (weight <= 0) {
    String? input = stdin.readLineSync();
    try {
      weight = double.parse(input ?? '');
      if (weight <= 0) {
        print('Weight must be positive. Enter again: ');
      }
    } catch (e) {
      print('Invalid input. Enter a valid number: ');
    }
  }
  
  print('Your weight is: ${weight}kg');
}
```

### File I/O Error Handling

```dart
import 'dart:io';

void main() async {
  // Safe file reading
  try {
    File file = File('data.txt');
    
    // Check if file exists
    if (await file.exists()) {
      String content = await file.readAsString();
      print('File content: $content');
    } else {
      print('File does not exist. Creating new file...');
      await file.writeAsString('Default content');
      print('File created successfully!');
    }
  } on FileSystemException catch (e) {
    print('File system error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}
```

## Best Practices

### 1. Input Validation
Always validate user input to prevent runtime errors:

```dart
import 'dart:io';

void main() {
  // Good practice: Always validate input
  print('Enter your birth year: ');
  String? input = stdin.readLineSync();
  
  if (input != null && input.isNotEmpty) {
    try {
      int birthYear = int.parse(input);
      int currentYear = DateTime.now().year;
      
      if (birthYear > currentYear) {
        print('Birth year cannot be in the future!');
      } else if (birthYear < 1900) {
        print('Please enter a valid birth year!');
      } else {
        int age = currentYear - birthYear;
        print('You are approximately $age years old.');
      }
    } catch (e) {
      print('Please enter a valid year!');
    }
  } else {
    print('No input provided!');
  }
}
```

### 2. Null Safety
Handle null values properly:

```dart
import 'dart:io';

void main() {
  print('Enter your email: ');
  String? email = stdin.readLineSync();
  
  // Using null-aware operators
  String displayEmail = email?.trim() ?? 'No email provided';
  print('Email: $displayEmail');
  
  // Safe length check
  int emailLength = email?.length ?? 0;
  print('Email length: $emailLength characters');
  
  // Conditional output
  if (email != null && email.isNotEmpty) {
    if (email.contains('@')) {
      print('Valid email format');
    } else {
      print('Invalid email format');
    }
  }
}
```

### 3. Efficient String Building
For multiple concatenations, use StringBuffer:

```dart
void main() {
  // Inefficient for multiple concatenations
  String result = '';
  for (int i = 1; i <= 5; i++) {
    result += 'Number: $i\n';
  }
  print(result);
  
  // Efficient approach
  StringBuffer buffer = StringBuffer();
  for (int i = 1; i <= 5; i++) {
    buffer.writeln('Number: $i');
  }
  print(buffer.toString());
}
```

### 4. Structured Output
Organize output for better readability:

```dart
void displayUserInfo(Map<String, dynamic> user) {
  print('=' * 30);
  print('USER INFORMATION');
  print('=' * 30);
  print('Name: ${user['name']}');
  print('Age: ${user['age']}');
  print('Email: ${user['email']}');
  print('City: ${user['city']}');
  print('=' * 30);
}

void main() {
  Map<String, dynamic> user = {
    'name': 'John Doe',
    'age': 28,
    'email': 'john@example.com',
    'city': 'New York'
  };
  
  displayUserInfo(user);
}
```

## Common I/O Patterns

### Interactive Menu System

```dart
import 'dart:io';

void showMenu() {
  print('\n--- MAIN MENU ---');
  print('1. Add numbers');
  print('2. Calculate area of circle');
  print('3. Convert temperature');
  print('4. Exit');
  print('Enter your choice: ');
}

void main() {
  while (true) {
    showMenu();
    String? choice = stdin.readLineSync();
    
    switch (choice) {
      case '1':
        addNumbers();
        break;
      case '2':
        calculateCircleArea();
        break;
      case '3':
        convertTemperature();
        break;
      case '4':
        print('Goodbye!');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void addNumbers() {
  print('Enter first number: ');
  double num1 = double.parse(stdin.readLineSync() ?? '0');
  print('Enter second number: ');
  double num2 = double.parse(stdin.readLineSync() ?? '0');
  print('Sum: ${num1 + num2}');
}

void calculateCircleArea() {
  print('Enter radius: ');
  double radius = double.parse(stdin.readLineSync() ?? '0');
  double area = 3.14159 * radius * radius;
  print('Area: ${area.toStringAsFixed(2)}');
}

void convertTemperature() {
  print('Enter temperature in Celsius: ');
  double celsius = double.parse(stdin.readLineSync() ?? '0');
  double fahrenheit = (celsius * 9/5) + 32;
  print('Temperature in Fahrenheit: ${fahrenheit.toStringAsFixed(1)}°F');
}
```

## Summary

Input and Output operations in Dart provide powerful ways to interact with users and external systems:

- **Output**: Use `print()`, `stdout.write()`, and string interpolation
- **Input**: Use `stdin.readLineSync()` with proper error handling
- **Formatting**: Utilize `toStringAsFixed()`, `padLeft()`, `padRight()`
- **File I/O**: Use `File` class for reading and writing files
- **Best Practices**: Always validate input, handle null values, and structure output clearly

These concepts form the foundation for creating interactive Dart applications that can communicate effectively with users and external data sources.