
void main() {
  print('===== Function Basics =====');
  
  // Calling a simple function
  greet();
  
  // Function with parameters
  greetPerson('Alice');
  
  // Function with return value
  int sum = addNumbers(5, 3);
  print('Sum: $sum');
  
  // Function with named parameters
  printPersonDetails(name: 'Bob', age: 30);
  
  // Named parameters with default values
  printPersonDetails(name: 'Charlie'); // age will use default value
  
  // Function with optional positional parameters
  printItems('Apple', 'Banana');
  printItems('Apple', 'Banana', 'Cherry');
  
  // Function with mixed parameter types
  describePerson('Dave', age: 25, height: 180);
  
  print('\n===== Function as First-class Objects =====');
  
  // Assigning function to a variable
  var multiplyFunc = multiply;
  print('Result from function variable: ${multiplyFunc(4, 5)}');
  
  // Passing function as parameter
  calculate(10, 5, add);
  calculate(10, 5, subtract);
  
  // Anonymous function (lambda)
  var doubleIt = (int x) => x * 2;
  print('Anonymous function result: ${doubleIt(5)}');
  
  // Using anonymous function with higher-order functions
  List<int> numbers = [1, 2, 3, 4, 5];
  var doubled = numbers.map((number) => number * 2).toList();
  print('Doubled list using anonymous function: $doubled');
  
  print('\n===== Function Closures =====');
  
  // Closure example - function that remembers its lexical scope
  Function counter = createCounter();
  print('Counter: ${counter()}'); // 1
  print('Counter: ${counter()}'); // 2
  print('Counter: ${counter()}'); // 3
  
  // Another closure example
  Function adder = createAdder(10);
  print('Adder(5): ${adder(5)}'); // 15
  print('Adder(7): ${adder(7)}'); // 17
  
  print('\n===== Recursive Functions =====');
  
  // Recursive function
  int factorialResult = factorial(5);
  print('Factorial of 5: $factorialResult');
  
  // Fibonacci sequence using recursion
  print('Fibonacci(8): ${fibonacci(8)}');
  
  print('\n===== Advanced Function Concepts =====');
  
  // Function with type definition
  Calculator multiply = (a, b) => a * b;
  print('Using function type: ${multiply(6, 7)}');
  
  // Immediately Invoked Function Expression (IIFE)
  var result = (() {
    var x = 10;
    var y = 20;
    return x + y;
  })();
  print('IIFE result: $result');
  
  // Function with generics
  print('Generic max of 10 and 20: ${findMax<int>(10, 20)}');
  print('Generic max of 3.5 and 2.5: ${findMax<double>(3.5, 2.5)}');
}

// Simple function with no parameters and no return value
void greet() {
  print('Hello, World!');
}

// Function with a parameter
void greetPerson(String name) {
  print('Hello, $name!');
}

// Function with parameters and return value
int addNumbers(int a, int b) {
  return a + b;
}

// Function with named parameters (using curly braces)
void printPersonDetails({required String name, int age = 25}) {
  print('Name: $name, Age: $age');
}

// Function with optional positional parameters (using square brackets)
void printItems(String item1, String item2, [String? item3]) {
  print('Item 1: $item1');
  print('Item 2: $item2');
  if (item3 != null) {
    print('Item 3: $item3');
  }
}

// Function with mixed parameter types
void describePerson(String name, {required int age, double? height}) {
  String description = '$name is $age years old';
  if (height != null) {
    description += ' and is $height cm tall';
  }
  print(description);
}

// Functions for demonstration of passing functions as parameters
int multiply(int a, int b) {
  return a * b;
}

int add(int a, int b) {
  return a + b;
}

int subtract(int a, int b) {
  return a - b;
}

// Higher-order function (function that accepts another function)
void calculate(int x, int y, int Function(int, int) operation) {
  int result = operation(x, y);
  print('Calculate result: $result');
}

// Closure example - function that returns a function
Function createCounter() {
  int count = 0;
  
  // This inner function has access to the count variable
  return () {
    count++;
    return count;
  };
}

// Another closure example
Function createAdder(int addValue) {
  // Returns a function that adds addValue to its argument
  return (int i) => addValue + i;
}

// Recursive function
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Another recursive function
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// Function type definition
typedef Calculator = int Function(int a, int b);

// Function with generics
T findMax<T extends Comparable>(T a, T b) {
  return a.compareTo(b) > 0 ? a : b;
}