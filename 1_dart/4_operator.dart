void main() {
  // 1. Arithmetic Operators
  print('\n--- Arithmetic Operators ---');
  int a = 10;
  int b = 3;
  
  print('a = $a, b = $b');
  print('a + b = ${a + b}');  // Addition
  print('a - b = ${a - b}');  // Subtraction
  print('a * b = ${a * b}');  // Multiplication
  print('a / b = ${a / b}');  // Division (returns double)
  print('a ~/ b = ${a ~/ b}');  // Integer Division
  print('a % b = ${a % b}');  // Modulo (remainder)
  
  // Increment and Decrement
  int c = 5;
  print('\nc = $c');
  print('++c = ${++c}');  // Pre-increment
  print('c = $c');
  print('c++ = ${c++}');  // Post-increment
  print('c = $c');
  print('--c = ${--c}');  // Pre-decrement
  print('c = $c');
  print('c-- = ${c--}');  // Post-decrement
  print('c = $c');
  
  // 2. Relational Operators
  print('\n--- Relational Operators ---');
  print('a = $a, b = $b');
  print('a > b: ${a > b}');   // Greater than
  print('a < b: ${a < b}');   // Less than
  print('a >= b: ${a >= b}');  // Greater than or equal to
  print('a <= b: ${a <= b}');  // Less than or equal to
  print('a == b: ${a == b}');  // Equal to
  print('a != b: ${a != b}');  // Not equal to
  
  // 3. Logical Operators
  print('\n--- Logical Operators ---');
  bool x = true;
  bool y = false;
  
  print('x = $x, y = $y');
  print('x && y: ${x && y}');  // Logical AND
  print('x || y: ${x || y}');  // Logical OR
  print('!x: ${!x}');          // Logical NOT
  
  // 4. Bitwise Operators
  print('\n--- Bitwise Operators ---');
  int d = 5;  // 0101 in binary
  int e = 3;  // 0011 in binary
  
  print('d = $d (${d.toRadixString(2)}), e = $e (${e.toRadixString(2)})');
  print('d & e = ${d & e} (${(d & e).toRadixString(2)})');    // Bitwise AND
  print('d | e = ${d | e} (${(d | e).toRadixString(2)})');    // Bitwise OR
  print('d ^ e = ${d ^ e} (${(d ^ e).toRadixString(2)})');    // Bitwise XOR
  print('~d = ${(~d)} (${(~d).toRadixString(2)})');           // Bitwise NOT
  print('d << 1 = ${d << 1} (${(d << 1).toRadixString(2)})'); // Left shift
  print('d >> 1 = ${d >> 1} (${(d >> 1).toRadixString(2)})'); // Right shift
  
  // 5. Assignment Operators
  print('\n--- Assignment Operators ---');
  int f = 10;
  print('Initial f = $f');
  
  f += 5;  // Same as: f = f + 5
  print('After f += 5: $f');
  
  f -= 3;  // Same as: f = f - 3
  print('After f -= 3: $f');
  
  f *= 2;  // Same as: f = f * 2
  print('After f *= 2: $f');
  
  f ~/= 4;  // Same as: f = f ~/ 4
  print('After f ~/= 4: $f');
  
  f %= 2;  // Same as: f = f % 2
  print('After f %= 2: $f');
  
  // 6. Conditional (Ternary) Operator
  print('\n--- Conditional (Ternary) Operator ---');
  int age = 20;
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('Age: $age, Status: $status');
  
  // 7. Null-aware Operators
  print('\n--- Null-aware Operators ---');
  
  // ??= operator: Assign value if null
  String? name;
  print('name = $name');
  name ??= 'John';  // Assign 'John' to name if name is null
  print('After name ??= "John": $name');
  name ??= 'Jane';  // Won't change because name is no longer null
  print('After name ??= "Jane": $name');
  
  // ?? operator: Null coalescing operator
  String? nullableValue;
  String nonNullValue = nullableValue ?? 'Default';
  print('nullableValue ?? "Default" = $nonNullValue');
  
  // ?. operator: Null-aware access
  String? maybeNull;
  print('maybeNull?.length: ${maybeNull?.length}');  // Safe access, returns null
  
  // 8. Type Test Operators
  print('\n--- Type Test Operators ---');
  var testValue = 100;
  print('testValue is int: ${testValue is int}');      // Type check
  print('testValue is! String: ${testValue is! String}');  // Not type check
  
  // 9. Cascade Notation (..)
  print('\n--- Cascade Notation (..) ---');
  // Example with a simple class
  var person = Person()
    ..name = 'Alice'
    ..age = 30
    ..introduce();
}

class Person {
  String name = '';
  int age = 0;
  
  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }
}