// Advanced Dart OOP Concepts
// - Mixins
// - Static Members 
// - Enums
// - Object Equality
// - Extension Methods
// - SOLID Principles & Design Patterns

// =================== MIXINS ===================
// Mixins allow reusing code in multiple class hierarchies
// Use 'with' keyword to apply a mixin to a class

// Define a mixin - a class that provides methods/properties to be used by other classes
mixin Swimming {
  void swim() {
    print('Swimming in water');
  }
  
  int calculateSwimSpeed(int baseSpeed) {
    return baseSpeed * 2;
  }
}

mixin Flying {
  void fly() {
    print('Flying high in the sky');
  }
  
  int calculateFlyHeight(int baseHeight) {
    return baseHeight * 3;
  }
}

// Base class
class Animal {
  String name;
  
  Animal(this.name);
  
  void breathe() {
    print('$name is breathing');
  }
}

// Using mixins with classes
class Duck extends Animal with Swimming, Flying {
  Duck(String name) : super(name);
  
  void quack() {
    print('$name: Quack! Quack!');
  }
}

class Fish extends Animal with Swimming {
  Fish(String name) : super(name);
}

class Bird extends Animal with Flying {
  Bird(String name) : super(name);
}

// Using 'on' keyword to restrict mixin use
mixin Poisonous on Animal {
  void poisonAttack() {
    print('$name released poison!');
  }
}

class PoisonousFrog extends Animal with Swimming, Poisonous {
  PoisonousFrog(String name) : super(name);
}

// Mixin examples
void mixinExample() {
  print('\n===== MIXIN EXAMPLE =====');
  
  var duck = Duck('Donald');
  duck.breathe();  // From Animal
  duck.swim();     // From Swimming mixin
  duck.fly();      // From Flying mixin
  duck.quack();    // Duck's own method
  
  var fish = Fish('Nemo');
  fish.swim();
  
  var bird = Bird('Tweety');
  bird.fly();
  
  var frog = PoisonousFrog('Kermit');
  frog.swim();
  frog.poisonAttack();
}

// =================== STATIC MEMBERS ===================
// Static members belong to the class itself, not to instances
// Accessed via ClassName.member, not instance.member

class MathUtils {
  // Static variable
  static double pi = 3.14159;
  
  // Static method
  static int add(int a, int b) {
    return a + b;
  }
  
  // Static method using static variable
  static double calculateCircleArea(double radius) {
    return pi * radius * radius;
  }
  
  // Instance method (requires an instance to call)
  void printMathInfo() {
    print('MathUtils contains useful math functions');
  }
}

class Counter {
  // Static variable shared across all instances
  static int totalCount = 0;
  
  // Instance variable unique to each instance
  int instanceCount = 0;
  
  Counter() {
    totalCount++;
    instanceCount++;
  }
  
  // Static method can only access static members
  static void printTotalCount() {
    print('Total counters created: $totalCount');
    // Cannot access instanceCount here
  }
  
  // Instance method can access both static and instance members
  void printCounts() {
    print('Instance count: $instanceCount, Total count: $totalCount');
  }
}

void staticMembersExample() {
  print('\n===== STATIC MEMBERS EXAMPLE =====');
  
  // Access static members without creating an instance
  print('Pi value: ${MathUtils.pi}');
  print('5 + 3 = ${MathUtils.add(5, 3)}');
  print('Circle area with radius 4: ${MathUtils.calculateCircleArea(4)}');
  
  // Need instance for non-static methods
  var utils = MathUtils();
  utils.printMathInfo();
  
  // Static variable is shared across instances
  var counter1 = Counter();
  var counter2 = Counter();
  var counter3 = Counter();
  
  counter1.printCounts();
  counter2.printCounts();
  
  // Static method access
  Counter.printTotalCount();
}

// =================== ENUMS ===================
// Enum is a special kind of class used to represent a fixed number of constants

// Basic enum declaration
enum Color {
  red,
  green,
  blue,
  yellow,
  purple
}

// Enhanced enums (Dart 2.17+)
enum VehicleType {
  car(4, 'Road'),
  bicycle(2, 'Road/Trail'),
  boat(0, 'Water'),
  plane(3, 'Air');
  
  // Fields
  final int wheels;
  final String terrain;
  
  // Constructor
  const VehicleType(this.wheels, this.terrain);
  
  // Methods
  bool canDriveOnRoad() {
    return terrain.contains('Road');
  }
  
  String getDescription() {
    return 'A $name has $wheels wheels and travels on $terrain';
  }
}

void enumExample() {
  print('\n===== ENUM EXAMPLE =====');
  
  // Basic enum usage
  var favoriteColor = Color.blue;
  
  // Switch with enums
  switch (favoriteColor) {
    case Color.red:
      print('Your favorite color is red');
      break;
    case Color.green:
      print('Your favorite color is green');
      break;
    case Color.blue:
      print('Your favorite color is blue');
      break;
    default:
      print('Your favorite color is something else');
  }
  
  // Using enum values
  print('Available colors:');
  for (var color in Color.values) {
    print('- $color');
  }
  
  // Enhanced enum usage
  print('\nVehicle types:');
  for (var vehicle in VehicleType.values) {
    print(vehicle.getDescription());
    print('Can drive on road: ${vehicle.canDriveOnRoad()}');
  }
  
  // Enum comparison
  var myVehicle = VehicleType.car;
  if (myVehicle == VehicleType.car) {
    print('You have a car with ${myVehicle.wheels} wheels');
  }
}

// =================== OBJECT EQUALITY ===================
// == operator by default compares references, not content
// For content comparison, override == and hashCode

class Person {
  final String name;
  final int age;
  
  Person(this.name, this.age);
  
  // Without overriding == and hashCode:
  // Two Person objects with same name and age would be considered different
}

class Student {
  final String name;
  final int age;
  final String id;
  
  Student(this.name, this.age, this.id);
  
  // Override == operator for value equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Student && 
           other.name == name && 
           other.age == age && 
           other.id == id;
  }
  
  // Override hashCode to ensure HashMap/HashSet work correctly
  // Objects that are equal must have same hashCode
  @override
  int get hashCode => Object.hash(name, age, id);
  
  @override
  String toString() => 'Student($name, $age, $id)';
}

void equalityExample() {
  print('\n===== OBJECT EQUALITY EXAMPLE =====');
  
  // Without overridden equality
  var person1 = Person('Alice', 25);
  var person2 = Person('Alice', 25);
  
  print('person1 == person2: ${person1 == person2}'); // false - reference equality
  
  // With overridden equality
  var student1 = Student('Bob', 20, 'S001');
  var student2 = Student('Bob', 20, 'S001');
  var student3 = Student('Bob', 21, 'S001');
  
  print('student1 == student2: ${student1 == student2}'); // true - value equality
  print('student1 == student3: ${student1 == student3}'); // false - different values
  
  // HashSet uses hashCode and ==
  var studentSet = <Student>{};
  studentSet.add(student1);
  studentSet.add(student2); // Won't be added as it's considered equal
  
  print('studentSet size: ${studentSet.length}'); // 1, not 2
}

// =================== EXTENSION METHODS ===================
// Add functionality to existing classes without modifying them
// Introduced in Dart 2.7

// Extension on String class
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

// Extension on int class
extension IntExtension on int {
  int square() {
    return this * this;
  }
  
  bool get isEven => this % 2 == 0;
  bool get isOdd => this % 2 != 0;
  
  String times(String str) {
    return str * this;
  }
}

// Extension with generics
extension ListExtension<T> on List<T> {
  T? firstOrNull() {
    return isEmpty ? null : first;
  }
  
  List<T> distinct() {
    return toSet().toList();
  }
}

void extensionMethodsExample() {
  print('\n===== EXTENSION METHODS EXAMPLE =====');
  
  // String extensions
  String name = 'john';
  print('Original: $name');
  print('Capitalized: ${name.capitalize()}');
  
  String email = 'test@example.com';
  print('Is valid email: ${email.isValidEmail}');
  
  String longText = 'This is a very long text that needs to be truncated';
  print('Truncated: ${longText.truncate(20)}');
  
  // Int extensions
  int number = 5;
  print('$number squared: ${number.square()}');
  print('Is $number even? ${number.isEven}');
  print('Stars: ${3.times('*')}');
  
  // List extensions
  var numbers = [1, 2, 3, 3, 4, 5, 5];
  print('Original list: $numbers');
  print('Distinct values: ${numbers.distinct()}');
  
  var emptyList = <int>[];
  print('First or null: ${emptyList.firstOrNull()}');
}

// =================== SOLID PRINCIPLES & DESIGN PATTERNS ===================
// Brief overview of SOLID principles and common design patterns in Dart

void solidAndPatternsExample() {
  print('\n===== SOLID PRINCIPLES & DESIGN PATTERNS =====');
  
  print('\nSOLID Principles in Dart:');
  print('S - Single Responsibility Principle:');
  print('   Each class should have only one reason to change.');
  print('   Example: Separate data models from UI logic in Flutter apps');
  
  print('\nO - Open/Closed Principle:');
  print('   Software entities should be open for extension but closed for modification.');
  print('   Example: Use abstract classes and implement new functionality in subclasses');
  
  print('\nL - Liskov Substitution Principle:');
  print('   Objects of a superclass should be replaceable with objects of its subclasses.');
  print('   Example: Any Shape subclass should work where a Shape is expected');
  
  print('\nI - Interface Segregation Principle:');
  print('   Clients should not be forced to depend on methods they don\'t use.');
  print('   Example: Create specific interfaces rather than one general-purpose interface');
  
  print('\nD - Dependency Inversion Principle:');
  print('   High-level modules should not depend on low-level modules. Both should depend on abstractions.');
  print('   Example: Use dependency injection in Flutter apps');
  
  print('\nCommon Design Patterns in Dart:');
  print('1. Singleton: Ensure a class has only one instance');
  print('   Example: Shared preferences/settings manager');
  
  print('\n2. Factory: Create objects without exposing instantiation logic');
  print('   Example: ThemeData.light() and ThemeData.dark() in Flutter');
  
  print('\n3. Observer: Define a one-to-many dependency between objects');
  print('   Example: StreamController/StreamBuilder in Flutter');
  
  print('\n4. Builder: Construct complex objects step by step');
  print('   Example: AlertDialog.builder in Flutter');
  
  print('\n5. Strategy: Define a family of algorithms, encapsulate each one');
  print('   Example: Different sorting strategies selectable at runtime');
}

// Main function to run all examples
void main() {
  print('ADVANCED DART OOP CONCEPTS DEMONSTRATION\n');
  
  mixinExample();
  staticMembersExample();
  enumExample();
  equalityExample();
  extensionMethodsExample();
  solidAndPatternsExample();
  
  print('\nLearning Outcomes:');
  print('✓ Understanding Mixins for code reuse across class hierarchies');
  print('✓ Working with static members at the class level');
  print('✓ Creating and using enums for type-safe constants');
  print('✓ Implementing proper object equality with == and hashCode');
  print('✓ Extending existing classes with extension methods');
  print('✓ Applying SOLID principles and design patterns in Dart applications');
}