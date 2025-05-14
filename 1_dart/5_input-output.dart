import 'dart:io'; // Import the dart:io library for input/output operations

void main() {
  // ========== OUTPUT OPERATIONS ==========
  
  // 1. Using print() function for standard output
  print('Hello, World!'); // Basic print statement
  
  // 2. Using stdout.write() for output without newline
  stdout.write('This text will not end with a newline ');
  stdout.writeln('but this one will.');
  
  // 3. String interpolation for formatting output
  String name = 'Dart';
  int year = 2011;
  print('$name was first released in $year'); // Using variables in strings
  print('${name.toUpperCase()} is awesome!'); // Using expressions in strings
  
  // 4. Formatted output with toString() and string methods
  double pi = 3.14159265359;
  print('Pi rounded to 2 decimal places: ${pi.toStringAsFixed(2)}');
  
  // ========== INPUT OPERATIONS ==========
  
  // 1. Reading user input with stdin.readLineSync()
  stdout.write('Enter your name: ');
  String? userName = stdin.readLineSync(); // The ? indicates nullable type
  print('Hello, $userName!');
  
  // 2. Reading and parsing numeric input
  stdout.write('Enter your age: ');
  String? ageInput = stdin.readLineSync();
  if (ageInput != null) {
    // Parse string to integer with error handling
    try {
      int age = int.parse(ageInput);
      print('In 10 years, you will be ${age + 10} years old.');
    } catch (e) {
      print('Invalid input: $ageInput is not a valid number');
    }
  }
  
  // 3. Reading from files
  try {
    // Note: This assumes 'example.txt' exists in the project directory
    // File handling would typically be in a separate function with proper error handling
    File file = File('example.txt');
    if (file.existsSync()) {
      String contents = file.readAsStringSync();
      print('File contents: $contents');
    } else {
      print('File does not exist. Skipping file read example.');
    }
  } catch (e) {
    print('Error reading file: $e');
  }
  
  // 4. Writing to files
  try {
    File outputFile = File('output.txt');
    outputFile.writeAsStringSync('This text was written using Dart File I/O\n');
    outputFile.writeAsStringSync('This is a second line.', mode: FileMode.append);
    print('Successfully wrote to output.txt');
  } catch (e) {
    print('Error writing to file: $e');
  }
}

// NOTES ON DART INPUT AND OUTPUT:
// 1. The `dart:io` library is required for most I/O operations and only works in command-line apps
// 2. In Flutter applications, you would use widgets like TextField for input instead of stdin
// 3. For complex input parsing, consider using packages like 'args' for command-line argument parsing
// 4. When handling user input, always include proper error handling
// 5. File operations should include try-catch blocks to handle exceptions