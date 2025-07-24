# Dart Mathematics - Complete Guide

## Table of Contents
1. [Number Systems in Dart](#number-systems-in-dart)
2. [Basic Arithmetic Operations](#basic-arithmetic-operations)
3. [Number Representation and Precision](#number-representation-and-precision)
4. [The dart:math Library](#the-dartmath-library)
5. [Advanced Mathematical Operations](#advanced-mathematical-operations)
6. [Number Conversion and Parsing](#number-conversion-and-parsing)
7. [Mathematical Constants](#mathematical-constants)
8. [Random Number Generation](#random-number-generation)
9. [Bitwise Operations](#bitwise-operations)
10. [Performance Considerations](#performance-considerations)

## Number Systems in Dart

Dart provides a robust number system based on the IEEE 754 standard for floating-point arithmetic. Understanding how numbers work internally is crucial for mathematical operations.

### Number Type Hierarchy

```dart
// Dart's number hierarchy
abstract class num implements Comparable<num> {
  // Common methods for all numbers
}

abstract class int extends num {
  // Integer-specific methods
}

abstract class double extends num {
  // Double-specific methods
}
```

### Internal Representation

#### Integers (int)
```dart
// In Dart, integers can be:
// 1. Small integers (Smi) - stored directly in the pointer
// 2. Big integers - arbitrary precision (limited by memory)

// Small integers (typically -2^62 to 2^62-1 on 64-bit platforms)
int small = 42;
int maxSmallInt = 9223372036854775807; // 2^63 - 1

// Big integers (arbitrary precision)
int bigInt = 123456789012345678901234567890;
print(bigInt.runtimeType); // int (but internally BigInt)

// Hexadecimal and binary literals
int hex = 0xFF;        // 255
int binary = 0b1010;   // 10
int octal = 0o17;      // 15 (Dart 2.14+)
```

#### Floating-Point Numbers (double)
```dart
// IEEE 754 double-precision (64-bit)
// Structure: [sign:1][exponent:11][mantissa:52]

double pi = 3.14159;
double scientific = 1.23e4;    // 12300.0
double negative = -2.5;

// Special values
double infinity = double.infinity;
double negInfinity = double.negativeInfinity;
double notANumber = double.nan;

// Precision limits
double maxFinite = double.maxFinite;    // ~1.8e308
double minPositive = double.minPositive; // ~5e-324

print('Max finite: $maxFinite');
print('Min positive: $minPositive');
```

### Number Properties and Methods

```dart
void exploreNumberProperties() {
  int integer = -42;
  double floating = 3.14159;
  
  // Common properties
  print('Integer absolute value: ${integer.abs()}');     // 42
  print('Integer sign: ${integer.sign}');                // -1
  print('Is negative: ${integer.isNegative}');           // true
  print('Is finite: ${floating.isFinite}');             // true
  print('Is infinite: ${floating.isInfinite}');         // false
  print('Is NaN: ${floating.isNaN}');                   // false
  
  // Integer-specific properties
  print('Is even: ${integer.abs().isEven}');            // true
  print('Is odd: ${integer.abs().isOdd}');              // false
  
  // Type checking
  print('Integer is int: ${integer is int}');           // true
  print('Floating is double: ${floating is double}');   // true
  print('Both are num: ${integer is num && floating is num}'); // true
}
```

## Basic Arithmetic Operations

Dart provides standard arithmetic operators with specific behaviors for different number types.

### Arithmetic Operators

```dart
void basicArithmetic() {
  int a = 10;
  int b = 3;
  double x = 10.0;
  double y = 3.0;
  
  // Addition
  print('$a + $b = ${a + b}');           // 13 (int)
  print('$x + $y = ${x + y}');           // 13.0 (double)
  print('$a + $y = ${a + y}');           // 13.0 (mixed -> double)
  
  // Subtraction
  print('$a - $b = ${a - b}');           // 7 (int)
  print('$x - $y = ${x - y}');           // 7.0 (double)
  
  // Multiplication
  print('$a * $b = ${a * b}');           // 30 (int)
  print('$x * $y = ${x * y}');           // 30.0 (double)
  
  // Division (always returns double)
  print('$a / $b = ${a / b}');           // 3.3333... (double)
  print('$x / $y = ${x / y}');           // 3.3333... (double)
  
  // Integer division (truncated division)
  print('$a ~/ $b = ${a ~/ b}');         // 3 (int)
  print('$x ~/ $y = ${x ~/ y}');         // 3 (int, even from doubles)
  
  // Modulo (remainder)
  print('$a % $b = ${a % b}');           // 1 (int)
  print('$x % $y = ${x % y}');           // 1.0 (double)
  
  // Exponentiation (power)
  print('$a ^ $b = ${a.pow(b)}');        // 1000 (using math library)
}
```

### Operator Precedence and Associativity

```dart
void operatorPrecedence() {
  // Precedence (highest to lowest):
  // 1. Unary: -expr, !expr, ~expr, ++expr, expr++, --expr, expr--
  // 2. Multiplicative: *, /, ~/, %
  // 3. Additive: +, -
  // 4. Shift: <<, >>, >>>
  // 5. Bitwise AND: &
  // 6. Bitwise XOR: ^
  // 7. Bitwise OR: |
  // 8. Relational: <, >, <=, >=, as, is, is!
  // 9. Equality: ==, !=
  // 10. Logical AND: &&
  // 11. Logical OR: ||
  // 12. Conditional: expr ? expr : expr
  // 13. Assignment: =, *=, /=, +=, -=, &=, ^=, etc.
  
  int result = 2 + 3 * 4;          // 14, not 20 (multiplication first)
  int withParens = (2 + 3) * 4;    // 20 (parentheses override precedence)
  
  // Left-to-right associativity for same precedence
  int leftToRight = 10 - 5 - 2;    // 3, equivalent to (10 - 5) - 2
  
  print('2 + 3 * 4 = $result');
  print('(2 + 3) * 4 = $withParens');
  print('10 - 5 - 2 = $leftToRight');
}
```

### Assignment Operators

```dart
void assignmentOperators() {
  int value = 10;
  
  // Compound assignment operators
  value += 5;    // value = value + 5;  // 15
  value -= 3;    // value = value - 3;  // 12
  value *= 2;    // value = value * 2;  // 24
  value ~/= 4;   // value = value ~/ 4; // 6
  value %= 5;    // value = value % 5;  // 1
  
  print('Final value: $value'); // 1
  
  // Increment and decrement
  int counter = 5;
  print('Pre-increment: ${++counter}');   // 6 (increment then return)
  print('Post-increment: ${counter++}');  // 6 (return then increment)
  print('Counter is now: $counter');      // 7
  
  print('Pre-decrement: ${--counter}');   // 6 (decrement then return)
  print('Post-decrement: ${counter--}');  // 6 (return then decrement)
  print('Counter is now: $counter');      // 5
}
```

## Number Representation and Precision

Understanding how numbers are represented internally helps avoid precision errors.

### Floating-Point Precision Issues

```dart
void precisionIssues() {
  // Classic floating-point precision problem
  double result = 0.1 + 0.2;
  print('0.1 + 0.2 = $result');                    // 0.30000000000000004
  print('0.1 + 0.2 == 0.3: ${result == 0.3}');     // false
  
  // Safe comparison with epsilon
  bool isEqual = (result - 0.3).abs() < 1e-10;
  print('Safe equality check: $isEqual');          // true
  
  // Large number precision loss
  double large = 9007199254740992.0;  // 2^53
  double largerBy1 = large + 1;
  print('$large + 1 = $largerBy1');               // Same as large!
  print('Precision lost: ${large == largerBy1}'); // true
  
  // Decimal representation issues
  for (int i = 1; i <= 10; i++) {
    double fraction = i / 10;
    print('$i/10 = $fraction');
  }
}

// Safe comparison function
bool nearlyEqual(double a, double b, {double epsilon = 1e-10}) {
  return (a - b).abs() < epsilon;
}

// Example usage of safe comparison
void safeComparisons() {
  double a = 0.1 + 0.2;
  double b = 0.3;
  
  print('Unsafe: ${a == b}');                    // false
  print('Safe: ${nearlyEqual(a, b)}');          // true
  print('Safe with custom epsilon: ${nearlyEqual(a, b, epsilon: 1e-15)}'); // true
}
```

### Number Limits and Special Values

```dart
void numberLimits() {
  // Integer limits
  print('int max safe: ${0x1FFFFFFFFFFFFF}');  // 2^53 - 1
  print('int theoretical max: depends on available memory');
  
  // Double limits
  print('double max finite: ${double.maxFinite}');
  print('double min positive: ${double.minPositive}');
  
  // Special double values
  double inf = double.infinity;
  double negInf = double.negativeInfinity;
  double nan = double.nan;
  
  // Operations with infinity
  print('infinity + 1 = ${inf + 1}');          // infinity
  print('infinity * 2 = ${inf * 2}');          // infinity
  print('infinity / infinity = ${inf / inf}');  // NaN
  print('-infinity = ${-inf}');                 // -infinity
  
  // Operations with NaN
  print('NaN + 1 = ${nan + 1}');               // NaN
  print('NaN == NaN: ${nan == nan}');          // false (special case!)
  print('NaN.isNaN: ${nan.isNaN}');            // true
  
  // Checking for special values
  bool isSpecial(double value) {
    return value.isInfinite || value.isNaN;
  }
  
  print('Is infinity special: ${isSpecial(inf)}'); // true
  print('Is NaN special: ${isSpecial(nan)}');     // true
  print('Is 42.0 special: ${isSpecial(42.0)}');   // false
}
```

## The dart:math Library

The `dart:math` library provides comprehensive mathematical functions and utilities.

### Importing and Basic Functions

```dart
import 'dart:math' as math;

void basicMathFunctions() {
  // Power and roots
  print('2^3 = ${math.pow(2, 3)}');           // 8.0
  print('√16 = ${math.sqrt(16)}');            // 4.0
  print('∛27 = ${math.pow(27, 1/3)}');        // 3.0
  
  // Logarithms
  print('log(e) = ${math.log(math.e)}');      // 1.0 (natural log)
  print('log₁₀(100) = ${math.log(100) / math.ln10}'); // 2.0 (log base 10)
  
  // Exponential
  print('e^2 = ${math.exp(2)}');              // 7.389...
  
  // Absolute value and sign
  print('|-5| = ${(-5).abs()}');              // 5
  print('sign(-10) = ${(-10).sign}');         // -1
  
  // Min and max
  print('min(5, 3) = ${math.min(5, 3)}');     // 3
  print('max(5, 3) = ${math.max(5, 3)}');     // 5
}
```

### Trigonometric Functions

```dart
import 'dart:math' as math;

void trigonometricFunctions() {
  // Angles in radians (π radians = 180 degrees)
  double angleRad = math.pi / 4;  // 45 degrees
  double angleDeg = 45.0;
  
  // Convert degrees to radians
  double degToRad(double degrees) => degrees * math.pi / 180;
  double radToDeg(double radians) => radians * 180 / math.pi;
  
  print('45° in radians: ${degToRad(angleDeg)}'); // π/4
  print('π/4 in degrees: ${radToDeg(angleRad)}'); // 45°
  
  // Basic trigonometric functions
  print('sin(π/4) = ${math.sin(angleRad)}');     // √2/2 ≈ 0.707
  print('cos(π/4) = ${math.cos(angleRad)}');     // √2/2 ≈ 0.707
  print('tan(π/4) = ${math.tan(angleRad)}');     // 1.0
  
  // Inverse trigonometric functions
  print('asin(0.5) = ${math.asin(0.5)}');       // π/6 ≈ 0.524 rad
  print('acos(0.5) = ${math.acos(0.5)}');       // π/3 ≈ 1.047 rad
  print('atan(1) = ${math.atan(1)}');           // π/4 ≈ 0.785 rad
  
  // atan2 for proper quadrant handling
  print('atan2(1, 1) = ${math.atan2(1, 1)}');   // π/4 (first quadrant)
  print('atan2(1, -1) = ${math.atan2(1, -1)}'); // 3π/4 (second quadrant)
  
  // Hyperbolic functions (available in some implementations)
  // sinh, cosh, tanh might be available depending on Dart version
}

// Practical trigonometry example: calculating distance
double calculateDistance(double x1, double y1, double x2, double y2) {
  double dx = x2 - x1;
  double dy = y2 - y1;
  return math.sqrt(dx * dx + dy * dy);
}

// Calculate angle between two points
double calculateAngle(double x1, double y1, double x2, double y2) {
  double dx = x2 - x1;
  double dy = y2 - y1;
  return math.atan2(dy, dx);
}
```

### Rounding and Truncation

```dart
import 'dart:math' as math;

void roundingFunctions() {
  double value = 3.7;
  double negValue = -3.7;
  
  // Basic rounding
  print('ceil(3.7) = ${value.ceil()}');         // 4 (round up)
  print('floor(3.7) = ${value.floor()}');       // 3 (round down)
  print('round(3.7) = ${value.round()}');       // 4 (round to nearest)
  print('truncate(3.7) = ${value.truncate()}'); // 3 (remove decimal)
  
  // Negative numbers
  print('ceil(-3.7) = ${negValue.ceil()}');     // -3 (towards positive infinity)
  print('floor(-3.7) = ${negValue.floor()}');   // -4 (towards negative infinity)
  print('round(-3.7) = ${negValue.round()}');   // -4 (round to nearest)
  print('truncate(-3.7) = ${negValue.truncate()}'); // -3 (towards zero)
  
  // Round to specific decimal places
  double roundToDecimals(double value, int decimals) {
    double factor = math.pow(10, decimals).toDouble();
    return (value * factor).round() / factor;
  }
  
  double pi = math.pi;
  print('π rounded to 2 decimals: ${roundToDecimals(pi, 2)}'); // 3.14
  print('π rounded to 4 decimals: ${roundToDecimals(pi, 4)}'); // 3.1416
  
  // Banking rounding (round half to even)
  double bankingRound(double value, int decimals) {
    double factor = math.pow(10, decimals).toDouble();
    double scaled = value * factor;
    double fraction = scaled - scaled.truncate();
    
    if (fraction == 0.5) {
      // Round to even
      return (scaled.truncate().isEven ? scaled.truncate() : scaled.truncate() + 1) / factor;
    } else {
      return scaled.round() / factor;
    }
  }
  
  print('Banking round 2.5: ${bankingRound(2.5, 0)}'); // 2 (even)
  print('Banking round 3.5: ${bankingRound(3.5, 0)}'); // 4 (even)
}
```

## Advanced Mathematical Operations

### Working with Complex Mathematical Concepts

```dart
import 'dart:math' as math;

// Factorial calculation
int factorial(int n) {
  if (n < 0) throw ArgumentError('Factorial undefined for negative numbers');
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Iterative factorial (more efficient)
int factorialIterative(int n) {
  if (n < 0) throw ArgumentError('Factorial undefined for negative numbers');
  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

// Greatest Common Divisor (GCD)
int gcd(int a, int b) {
  a = a.abs();
  b = b.abs();
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

// Least Common Multiple (LCM)
int lcm(int a, int b) {
  return (a.abs() * b.abs()) ~/ gcd(a, b);
}

// Check if number is prime
bool isPrime(int n) {
  if (n < 2) return false;
  if (n == 2) return true;
  if (n.isEven) return false;
  
  int limit = math.sqrt(n).floor();
  for (int i = 3; i <= limit; i += 2) {
    if (n % i == 0) return false;
  }
  return true;
}

// Generate prime numbers using Sieve of Eratosthenes
List<int> sieveOfEratosthenes(int limit) {
  if (limit < 2) return [];
  
  List<bool> isPrime = List.filled(limit + 1, true);
  isPrime[0] = isPrime[1] = false;
  
  for (int i = 2; i * i <= limit; i++) {
    if (isPrime[i]) {
      for (int j = i * i; j <= limit; j += i) {
        isPrime[j] = false;
      }
    }
  }
  
  return [for (int i = 2; i <= limit; i++) if (isPrime[i]) i];
}

void advancedMathExamples() {
  // Factorial examples
  print('5! = ${factorial(5)}');                    // 120
  print('10! = ${factorialIterative(10)}');         // 3628800
  
  // GCD and LCM examples
  print('gcd(48, 18) = ${gcd(48, 18)}');           // 6
  print('lcm(48, 18) = ${lcm(48, 18)}');           // 144
  
  // Prime examples
  print('Is 17 prime? ${isPrime(17)}');            // true
  print('Is 21 prime? ${isPrime(21)}');            // false
  
  List<int> primes = sieveOfEratosthenes(30);
  print('Primes up to 30: $primes');               // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
}
```

### Statistical Functions

```dart
import 'dart:math' as math;

class Statistics {
  // Calculate mean (average)
  static double mean(List<num> values) {
    if (values.isEmpty) throw ArgumentError('Cannot calculate mean of empty list');
    return values.fold(0, (sum, value) => sum + value) / values.length;
  }
  
  // Calculate median
  static double median(List<num> values) {
    if (values.isEmpty) throw ArgumentError('Cannot calculate median of empty list');
    
    List<num> sorted = List.from(values)..sort();
    int middle = sorted.length ~/ 2;
    
    if (sorted.length.isOdd) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }
  
  // Calculate mode
  static List<num> mode(List<num> values) {
    if (values.isEmpty) return [];
    
    Map<num, int> frequency = {};
    for (num value in values) {
      frequency[value] = (frequency[value] ?? 0) + 1;
    }
    
    int maxFreq = frequency.values.fold(0, math.max);
    return frequency.entries
        .where((entry) => entry.value == maxFreq)
        .map((entry) => entry.key)
        .toList();
  }
  
  // Calculate variance
  static double variance(List<num> values) {
    if (values.isEmpty) throw ArgumentError('Cannot calculate variance of empty list');
    
    double meanValue = mean(values);
    double sumSquaredDiffs = values
        .map((value) => math.pow(value - meanValue, 2))
        .fold(0, (sum, value) => sum + value);
    
    return sumSquaredDiffs / values.length;
  }
  
  // Calculate standard deviation
  static double standardDeviation(List<num> values) {
    return math.sqrt(variance(values));
  }
  
  // Calculate range
  static double range(List<num> values) {
    if (values.isEmpty) throw ArgumentError('Cannot calculate range of empty list');
    return values.fold(values.first, math.max) - values.fold(values.first, math.min);
  }
}

void statisticsExamples() {
  List<int> data = [2, 4, 4, 4, 5, 5, 7, 9];
  
  print('Data: $data');
  print('Mean: ${Statistics.mean(data)}');                    // 5.0
  print('Median: ${Statistics.median(data)}');                // 4.5
  print('Mode: ${Statistics.mode(data)}');                    // [4]
  print('Variance: ${Statistics.variance(data)}');            // 4.0
  print('Standard Deviation: ${Statistics.standardDeviation(data)}'); // 2.0
  print('Range: ${Statistics.range(data)}');                  // 7.0
}
```

## Number Conversion and Parsing

### String to Number Conversion

```dart
void numberParsing() {
  // Parsing integers
  int intFromString = int.parse('42');
  int? nullableInt = int.tryParse('invalid'); // Returns null on failure
  
  print('Parsed int: $intFromString');        // 42
  print('Failed parse: $nullableInt');        // null
  
  // Parsing with radix (base)
  int hexValue = int.parse('FF', radix: 16);   // 255
  int binaryValue = int.parse('1010', radix: 2); // 10
  int octalValue = int.parse('17', radix: 8);  // 15
  
  print('Hex FF: $hexValue');
  print('Binary 1010: $binaryValue');
  print('Octal 17: $octalValue');
  
  // Parsing doubles
  double doubleFromString = double.parse('3.14159');
  double? nullableDouble = double.tryParse('not_a_number');
  
  print('Parsed double: $doubleFromString');  // 3.14159
  print('Failed double parse: $nullableDouble'); // null
  
  // Parsing scientific notation
  double scientific = double.parse('1.23e4');  // 12300.0
  double negative = double.parse('-2.5e-3');   // -0.0025
  
  print('Scientific 1.23e4: $scientific');
  print('Scientific -2.5e-3: $negative');
  
  // Parsing special values
  double infinity = double.parse('Infinity');
  double negInfinity = double.parse('-Infinity');
  double nan = double.parse('NaN');
  
  print('Parsed infinity: $infinity');
  print('Parsed -infinity: $negInfinity');
  print('Parsed NaN: $nan');
}

// Safe parsing with error handling
T? safeParse<T extends num>(String value, T Function(String) parser) {
  try {
    return parser(value);
  } catch (e) {
    print('Error parsing "$value": $e');
    return null;
  }
}

void safeParsingExamples() {
  String userInput1 = '42';
  String userInput2 = 'invalid';
  String userInput3 = '3.14';
  
  int? result1 = safeParse(userInput1, int.parse);
  int? result2 = safeParse(userInput2, int.parse);
  double? result3 = safeParse(userInput3, double.parse);
  
  print('Safe parse "$userInput1": $result1'); // 42
  print('Safe parse "$userInput2": $result2'); // null
  print('Safe parse "$userInput3": $result3'); // 3.14
}
```

### Number to String Conversion

```dart
void numberToString() {
  int integer = 42;
  double floating = 3.14159;
  
  // Basic toString
  print('Basic int: ${integer.toString()}');        // "42"
  print('Basic double: ${floating.toString()}');    // "3.14159"
  
  // Radix conversion for integers
  print('Binary: ${integer.toRadixString(2)}');     // "101010"
  print('Hex: ${integer.toRadixString(16)}');       // "2a"
  print('Octal: ${integer.toRadixString(8)}');      // "52"
  
  // Fixed decimal places
  print('2 decimals: ${floating.toStringAsFixed(2)}');     // "3.14"
  print('4 decimals: ${floating.toStringAsFixed(4)}');     // "3.1416"
  
  // Exponential notation
  print('Exponential: ${floating.toStringAsExponential()}'); // "3.14159e+0"
  print('Exp 2 digits: ${floating.toStringAsExponential(2)}'); // "3.14e+0"
  
  // Precision (significant digits)
  print('3 precision: ${floating.toStringAsPrecision(3)}'); // "3.14"
  print('6 precision: ${floating.toStringAsPrecision(6)}'); // "3.14159"
  
  // Padding with zeros
  String padded = integer.toString().padLeft(5, '0');
  print('Padded: $padded');                         // "00042"
  
  // Currency formatting (basic)
  String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
  
  print('Currency: ${formatCurrency(1234.567)}');   // "$1234.57"
}
```

## Mathematical Constants

```dart
import 'dart:math' as math;

void mathematicalConstants() {
  // Built-in constants
  print('π (pi): ${math.pi}');                      // 3.141592653589793
  print('e (Euler): ${math.e}');                    // 2.718281828459045
  print('ln(2): ${math.ln2}');                      // 0.6931471805599453
  print('ln(10): ${math.ln10}');                    // 2.302585092994046
  print('log₂(e): ${math.log2e}');                  // 1.4426950408889634
  print('log₁₀(e): ${math.log10e}');                // 0.4342944819032518
  print('√2: ${math.sqrt2}');                       // 1.4142135623730951
  print('√½: ${math.sqrt1_2}');                     // 0.7071067811865476
  
  // Derived constants
  double goldenRatio = (1 + math.sqrt(5)) / 2;
  double piSquared = math.pi * math.pi;
  double tau = 2 * math.pi; // Full circle in radians
  
  print('Golden ratio φ: $goldenRatio');            // 1.618033988749895
  print('π²: $piSquared');                          // 9.869604401089358
  print('τ (tau): $tau');                           // 6.283185307179586
  
  // Physical constants (examples)
  const double speedOfLight = 299792458; // m/s
  const double gravitationalConstant = 6.67430e-11; // m³/kg⋅s²
  const double planckConstant = 6.62607015e-34; // J⋅s
  const double avogadroNumber = 6.02214076e23; // mol⁻¹
  
  print('Speed of light: $speedOfLight m/s');
  print('Gravitational constant: $gravitationalConstant m³/kg⋅s²');
}
```

## Random Number Generation

```dart
import 'dart:math' as math;

void randomNumbers() {
  math.Random random = math.Random();
  
  // Basic random methods
  print('Random double [0,1): ${random.nextDouble()}');     // 0.0 <= x < 1.0
  print('Random int [0,100): ${random.nextInt(100)}');      // 0 <= x < 100
  print('Random bool: ${random.nextBool()}');               // true or false
  
  // Custom range for doubles
  double randomInRange(double min, double max) {
    return min + random.nextDouble() * (max - min);
  }
  
  print('Random [5.0, 10.0): ${randomInRange(5.0, 10.0)}');
  
  // Custom range for integers
  int randomIntInRange(int min, int max) {
    return min + random.nextInt(max - min + 1);
  }
  
  print('Random [10, 20]: ${randomIntInRange(10, 20)}');
  
  // Seeded random (reproducible)
  math.Random seededRandom = math.Random(42);
  print('Seeded random 1: ${seededRandom.nextInt(100)}');
  print('Seeded random 2: ${seededRandom.nextInt(100)}');
  
  // Reset with same seed for same sequence
  seededRandom = math.Random(42);
  print('Same seed 1: ${seededRandom.nextInt(100)}'); // Same as first
  print('Same seed 2: ${seededRandom.nextInt(100)}'); // Same as second
}

// Advanced random utilities
class RandomUtils {
  static final math.Random _random = math.Random();
  
  // Generate random list of integers
  static List<int> randomIntList(int length, int min, int max) {
    return List.generate(length, (_) => min + _random.nextInt(max - min + 1));
  }
  
  // Generate random list of doubles
  static List<double> randomDoubleList(int length, double min, double max) {
    return List.generate(length, (_) => min + _random.nextDouble() * (max - min));
  }
  
  // Pick random element from list
  static T pickRandom<T>(List<T> list) {
    if (list.isEmpty) throw ArgumentError('Cannot pick from empty list');
    return list[_random.nextInt(list.length)];
  }
  
  // Shuffle list
  static void shuffle<T>(List<T> list) {
    for (int i = list.length - 1; i > 0; i--) {
      int j = _random.nextInt(i + 1);
      T temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }
  
  // Generate random string
  static String randomString(int length, {String chars = 'abcdefghijklmnopqrstuvwxyz0123456789'}) {
    return String.fromCharCodes(
      List.generate(length, (_) => chars.codeUnitAt(_random.nextInt(chars.length)))
    );
  }
}

void advancedRandomExamples() {
  // Random lists
  List<int> randomInts = RandomUtils.randomIntList(5, 1, 100);
  List<double> randomDoubles = RandomUtils.randomDoubleList(5, 0.0, 10.0);
  
  print('Random ints: $randomInts');
  print('Random doubles: $randomDoubles');
  
  // Pick random element
  List<String> fruits = ['apple', 'banana', 'orange', 'grape'];
  String randomFruit = RandomUtils.pickRandom(fruits);
  print('Random fruit: $randomFruit');
  
  // Shuffle list
  List<int> numbers = [1, 2, 3, 4, 5];
  RandomUtils.shuffle(numbers);
  print('Shuffled numbers: $numbers');
  
  // Random string
  String randomId = RandomUtils.randomString(8);
  print('Random ID: $randomId');
}
```

## Bitwise Operations

Bitwise operations work on the binary representation of integers.

```dart
void bitwiseOperations() {
  int a = 12;  // Binary: 1100
  int b = 10;  // Binary: 1010
  
  print('a = $a (${a.toRadixString(2).padLeft(4, '0')})');
  print('b = $b (${b.toRadixString(2).padLeft(4, '0')})');
  print('');
  
  // Bitwise AND (&)
  int and = a & b;  // 1100 & 1010 = 1000 = 8
  print('a & b = $and (${and.toRadixString(2).padLeft(4, '0')})');
  
  // Bitwise OR (|)
  int or = a | b;   // 1100 | 1010 = 1110 = 14
  print('a | b = $or (${or.toRadixString(2).padLeft(4, '0')})');
  
  // Bitwise XOR (^)
  int xor = a ^ b;  // 1100 ^ 1010 = 0110 = 6
  print('a ^ b = $xor (${xor.toRadixString(2).padLeft(4, '0')})');
  
  // Bitwise NOT (~)
  int notA = ~a;    // ~1100 = ...11110011 (two's complement)
  print('~a = $notA');
  
  // Left shift (<<)
  int leftShift = a << 2;  // 1100 << 2 = 110000 = 48
  print('a << 2 = $leftShift (${leftShift.toRadixString(2)})');
  
  // Right shift (>>)
  int rightShift = a >> 2; // 1100 >> 2 = 11 = 3
  print('a >> 2 = $rightShift (${rightShift.toRadixString(2)})');
  
  // Unsigned right shift (>>>)
  int unsignedRightShift = a >>> 2; // Same as >> for positive numbers
  print('a >>> 2 = $unsignedRightShift');
}

// Practical bitwise applications
class BitManipulation {
  // Check if bit is set
  static bool isBitSet(int number, int position) {
    return (number & (1 << position)) != 0;
  }
  
  // Set bit
  static int setBit(int number, int position) {
    return number | (1 << position);
  }
  
  // Clear bit
  static int clearBit(int number, int position) {
    return number & ~(1 << position);
  }
  
  // Toggle bit
  static int toggleBit(int number, int position) {
    return number ^ (1 << position);
  }
  
  // Count set bits (population count)
  static int countSetBits(int number) {
    int count = 0;
    while (number != 0) {
      count += number & 1;
      number >>= 1;
    }
    return count;
  }
  
  // Check if power of 2
  static bool isPowerOfTwo(int number) {
    return number > 0 && (number & (number - 1)) == 0;
  }
  
  // Find rightmost set bit
  static int rightmostSetBit(int number) {
    return number & -number;
  }
}

void bitManipulationExamples() {
  int number = 12; // Binary: 1100
  
  print('Number: $number (${number.toRadixString(2)})');
  print('Bit 2 is set: ${BitManipulation.isBitSet(number, 2)}'); // true
  print('Bit 1 is set: ${BitManipulation.isBitSet(number, 1)}'); // false
  
  int withBitSet = BitManipulation.setBit(number, 1);
  print('Set bit 1: $withBitSet (${withBitSet.toRadixString(2)})'); // 1110 = 14
  
  int withBitCleared = BitManipulation.clearBit(number, 2);
  print('Clear bit 2: $withBitCleared (${withBitCleared.toRadixString(2)})'); // 1000 = 8
  
  int toggled = BitManipulation.toggleBit(number, 0);
  print('Toggle bit 0: $toggled (${toggled.toRadixString(2)})'); // 1101 = 13
  
  print('Set bits count: ${BitManipulation.countSetBits(number)}'); // 2
  print('Is power of 2: ${BitManipulation.isPowerOfTwo(number)}'); // false
  print('Is 8 power of 2: ${BitManipulation.isPowerOfTwo(8)}'); // true
  
  print('Rightmost set bit: ${BitManipulation.rightmostSetBit(number)}'); // 4
}
```

## Performance Considerations

### Optimization Tips

```dart
import 'dart:math' as math;

void performanceOptimization() {
  Stopwatch stopwatch = Stopwatch();
  
  // Integer vs double performance
  stopwatch.start();
  for (int i = 0; i < 1000000; i++) {
    int result = i * 2 + 1; // Integer arithmetic
  }
  stopwatch.stop();
  print('Integer operations: ${stopwatch.elapsedMicroseconds} μs');
  
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < 1000000; i++) {
    double result = i.toDouble() * 2.0 + 1.0; // Double arithmetic
  }
  stopwatch.stop();
  print('Double operations: ${stopwatch.elapsedMicroseconds} μs');
  
  // Avoid repeated expensive calculations
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < 100000; i++) {
    double result = math.sqrt(i.toDouble()); // Expensive
  }
  stopwatch.stop();
  print('Repeated sqrt: ${stopwatch.elapsedMicroseconds} μs');
  
  // Cache expensive calculations
  Map<int, double> sqrtCache = {};
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < 100000; i++) {
    double result = sqrtCache.putIfAbsent(i, () => math.sqrt(i.toDouble()));
  }
  stopwatch.stop();
  print('Cached sqrt: ${stopwatch.elapsedMicroseconds} μs');
  
  // Use bit operations for powers of 2
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < 1000000; i++) {
    int result = i * 8; // Multiplication
  }
  stopwatch.stop();
  print('Multiplication by 8: ${stopwatch.elapsedMicroseconds} μs');
  
  stopwatch.reset();
  stopwatch.start();
  for (int i = 0; i < 1000000; i++) {
    int result = i << 3; // Bit shift (same as * 8)
  }
  stopwatch.stop();
  print('Bit shift by 3: ${stopwatch.elapsedMicroseconds} μs');
}

// Efficient mathematical algorithms
class EfficientMath {
  // Fast integer square root
  static int isqrt(int n) {
    if (n < 0) throw ArgumentError('Square root of negative number');
    if (n < 2) return n;
    
    int x = n;
    int y = (x + 1) ~/ 2;
    while (y < x) {
      x = y;
      y = (x + n ~/ x) ~/ 2;
    }
    return x;
  }
  
  // Fast power calculation (exponentiation by squaring)
  static int fastPow(int base, int exponent) {
    if (exponent < 0) throw ArgumentError('Negative exponent not supported');
    if (exponent == 0) return 1;
    
    int result = 1;
    while (exponent > 0) {
      if (exponent.isOdd) {
        result *= base;
      }
      base *= base;
      exponent >>= 1;
    }
    return result;
  }
  
  // Fast modular exponentiation
  static int modPow(int base, int exponent, int modulus) {
    if (modulus == 1) return 0;
    
    int result = 1;
    base %= modulus;
    while (exponent > 0) {
      if (exponent.isOdd) {
        result = (result * base) % modulus;
      }
      exponent >>= 1;
      base = (base * base) % modulus;
    }
    return result;
  }
}

void efficientMathExamples() {
  print('Integer sqrt of 100: ${EfficientMath.isqrt(100)}'); // 10
  print('Fast 2^10: ${EfficientMath.fastPow(2, 10)}'); // 1024
  print('2^10 mod 7: ${EfficientMath.modPow(2, 10, 7)}'); // 2
  
  // Performance comparison
  Stopwatch sw = Stopwatch();
  
  // Standard power
  sw.start();
  for (int i = 0; i < 10000; i++) {
    math.pow(2, 20);
  }
  sw.stop();
  print('Standard pow: ${sw.elapsedMicroseconds} μs');
  
  // Fast power
  sw.reset();
  sw.start();
  for (int i = 0; i < 10000; i++) {
    EfficientMath.fastPow(2, 20);
  }
  sw.stop();
  print('Fast pow: ${sw.elapsedMicroseconds} μs');
}
```

### Common Pitfalls and Best Practices

```dart
void bestPractices() {
  // 1. Avoid floating-point equality comparisons
  double a = 0.1 + 0.2;
  double b = 0.3;
  
  // BAD
  if (a == b) {
    print('Equal'); // This won't execute!
  }
  
  // GOOD
  if ((a - b).abs() < 1e-10) {
    print('Approximately equal'); // This will execute
  }
  
  // 2. Be careful with integer division
  int x = 5;
  int y = 2;
  
  print('5 / 2 = ${x / y}');     // 2.5 (double)
  print('5 ~/ 2 = ${x ~/ y}');   // 2 (integer division)
  
  // 3. Handle special values
  double value = double.nan;
  
  // BAD
  if (value == double.nan) {
    print('Is NaN'); // This won't work!
  }
  
  // GOOD
  if (value.isNaN) {
    print('Is NaN'); // This works
  }
  
  // 4. Use appropriate number types
  // Use int for counting, indexing, discrete values
  // Use double for measurements, calculations, continuous values
  
  int count = 10;           // Good: counting
  double temperature = 25.5; // Good: measurement
  
  // 5. Be aware of overflow
  int maxInt = 9223372036854775807;
  try {
    int overflow = maxInt + 1; // Might throw or wrap around
    print('Overflow result: $overflow');
  } catch (e) {
    print('Overflow error: $e');
  }
  
  // 6. Use const for compile-time constants
  const double pi = 3.14159; // Compile-time constant
  final double radius = getUserInput(); // Runtime constant
  
  // 7. Choose appropriate precision
  double money = 123.456;
  String formatted = money.toStringAsFixed(2); // "$123.46" for currency
  print('Money: \$$formatted');
}

double getUserInput() => 5.0; // Mock function

// Example of comprehensive number validation
class NumberValidator {
  static bool isValidInteger(String input) {
    return int.tryParse(input) != null;
  }
  
  static bool isValidDouble(String input) {
    return double.tryParse(input) != null;
  }
  
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }
  
  static bool isPositive(num value) {
    return value > 0;
  }
  
  static bool isFinite(double value) {
    return value.isFinite;
  }
  
  static String? validateNumber(String input, {
    bool requireInteger = false,
    num? min,
    num? max,
    bool requirePositive = false,
  }) {
    // Check if parseable
    num? parsed;
    if (requireInteger) {
      parsed = int.tryParse(input);
      if (parsed == null) return 'Must be a valid integer';
    } else {
      parsed = double.tryParse(input);
      if (parsed == null) return 'Must be a valid number';
    }
    
    // Check if finite
    if (parsed is double && !parsed.isFinite) {
      return 'Must be a finite number';
    }
    
    // Check range
    if (min != null && parsed < min) {
      return 'Must be at least $min';
    }
    if (max != null && parsed > max) {
      return 'Must be at most $max';
    }
    
    // Check positive
    if (requirePositive && parsed <= 0) {
      return 'Must be positive';
    }
    
    return null; // Valid
  }
}

void validationExamples() {
  List<String> testInputs = ['42', '3.14', '-5', 'abc', 'Infinity', 'NaN'];
  
  for (String input in testInputs) {
    String? error = NumberValidator.validateNumber(
      input,
      requireInteger: false,
      min: 0,
      max: 100,
      requirePositive: true,
    );
    
    if (error == null) {
      print('$input is valid');
    } else {
      print('$input is invalid: $error');
    }
  }
}
```

This comprehensive guide covers Dart mathematics from basic number systems to advanced mathematical operations, providing you with a deep understanding of how numbers work in Dart and practical examples for real-world applications.
