// 1.1 int - for integer values (whole numbers without decimal)
int age = 30;
int negativeNumber = -5;
int hexValue = 0xEADEBAEE; // Hexadecimal notation

// 1.2 double - for floating-point values (numbers with decimal)
double height = 1.85;
double scientificNotation = 1.42e5; // 142000.0

// Both int and double are subtypes of num
num count = 3;
num price = 9.99;

// 2. Strings - for text
String name = 'John';
String surname = "Doe";
String multiLine = '''
This is a
multi-line string
''';
String interpolation = 'Hello $name'; // String interpolation
String expression = 'Sum: ${2 + 2}'; // Expression in string

// 3. Booleans - for true/false values
bool isTrue = true;
bool isFalse = false;
bool isGreater = 10 > 5; // Will be true

// 4. Lists - for ordered collections of objects
List<int> numbers = [1, 2, 3, 4, 5];
List<String> fruits = ['apple', 'banana', 'orange'];
var dynamicList = [1, 'two', true]; // List with dynamic types

// Accessing list elements (zero-based index)
var firstNumber = numbers[0]; // 1
var secondFruit = fruits[1]; // 'banana'

// 5. Sets - for unordered collections of unique items
Set<int> uniqueNumbers = {1, 2, 3, 4, 5};
Set<String> uniqueNames = {'John', 'Jane', 'Jack'};

// 6. Maps - for key-value pairs
Map<String, int> ages = {
  'John': 30,
  'Jane': 25,
  'Jack': 40,
};
Map<int, String> numberWords = {
  1: 'one',
  2: 'two',
  3: 'three',
};

// 7. Runes - for UTF-32 code points
Runes input = new Runes('\u2665 \u{1f605}'); // Heart and emoji
String heart = String.fromCharCodes(input);

// 8. Symbols - rarely used, represents operators or identifiers
#radix
Symbol sym = #radix;

// 9. Null Safety - Dart has null safety
// Variables can't be null by default unless explicitly marked as nullable
String nonNullable = 'This cannot be null';
String? nullable = null; // This can be null

// 10. Dynamic Type - can change type
dynamic dynamicVar = 'A string';
dynamicVar = 100; // Can change to int
dynamicVar = true; // Can change to bool

// 11. Type Checking and Casting
var someValue = 42;
if (someValue is int) {
  // Type checking
  print('someValue is an integer');
}

// 12. Type inference
var inferredInt = 42; // Dart infers this as int
var inferredString = 'Hello'; // Dart infers this as String

// 13. Final and Const
// final variables can only be set once
final String finalName = 'John';

// const variables are compile-time constants
const double pi = 3.14159;
const list = [1, 2, 3]; // Immutable list

// 14. Function types
typedef IntFunction = int Function(int);
IntFunction addOne = (int x) => x + 1;

// 15. Record types (Dart 3.0+)
var record = (1, 2, 'three');
(int, int, String) typedRecord = (1, 2, 'three');
var namedRecord = (a: 1, b: 2, c: 'three');

// Example of using these types
void main() {
  print('Integer: $age');
  print('Double: $height');
  print('String with interpolation: $interpolation');
  print('Boolean: $isTrue');
  print('First number in list: $firstNumber');
  print('Age of John: ${ages['John']}');
  print('Unicode characters: $heart');
  print('Dynamic value: $dynamicVar');
}