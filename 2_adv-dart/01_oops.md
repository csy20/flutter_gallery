# Object-Oriented Programming (OOP) in Dart

## Table of Contents
1. [What is OOP?](#what-is-oop)
2. [Classes and Objects](#classes-and-objects)
3. [Encapsulation](#encapsulation)
4. [Inheritance](#inheritance)
5. [Polymorphism](#polymorphism)
6. [Abstraction](#abstraction)
7. [Constructors](#constructors)
8. [Getters and Setters](#getters-and-setters)
9. [Static Members](#static-members)
10. [Mixins](#mixins)
11. [Interfaces](#interfaces)
12. [Advanced OOP Concepts](#advanced-oop-concepts)

## What is OOP?

Object-Oriented Programming (OOP) is a programming paradigm that organizes code around objects and classes rather than functions and logic. It helps in creating modular, reusable, and maintainable code.

The four main pillars of OOP are:
- **Encapsulation**: Bundling data and methods together
- **Inheritance**: Creating new classes based on existing ones
- **Polymorphism**: Objects of different types responding to the same interface
- **Abstraction**: Hiding complex implementation details

## Classes and Objects

### Basic Class Definition

```dart
// Basic class definition
class Person {
  // Properties (attributes)
  String name;
  int age;
  String email;
  
  // Constructor
  Person(this.name, this.age, this.email);
  
  // Methods
  void introduce() {
    print('Hi, I am $name, $age years old.');
  }
  
  void sendEmail(String message) {
    print('Sending email to $email: $message');
  }
  
  // Method with return type
  bool isAdult() {
    return age >= 18;
  }
}

// Creating objects (instances)
void demonstrateBasicClass() {
  // Creating objects
  Person person1 = Person('Alice', 25, 'alice@email.com');
  Person person2 = Person('Bob', 17, 'bob@email.com');
  
  // Using object methods
  person1.introduce();
  person2.introduce();
  
  print('Alice is adult: ${person1.isAdult()}');
  print('Bob is adult: ${person2.isAdult()}');
  
  person1.sendEmail('Hello from Dart!');
}
```

## Encapsulation

Encapsulation is about bundling data and methods together and controlling access to them using access modifiers.

```dart
class BankAccount {
  // Private properties (using underscore)
  String _accountNumber;
  double _balance;
  String _accountHolderName;
  
  // Constructor
  BankAccount(this._accountNumber, this._accountHolderName, [this._balance = 0.0]);
  
  // Public getters
  String get accountNumber => _accountNumber;
  String get accountHolderName => _accountHolderName;
  double get balance => _balance;
  
  // Public methods
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited: \$${amount.toStringAsFixed(2)}');
      print('New balance: \$${_balance.toStringAsFixed(2)}');
    } else {
      print('Invalid deposit amount');
    }
  }
  
  bool withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrawn: \$${amount.toStringAsFixed(2)}');
      print('Remaining balance: \$${_balance.toStringAsFixed(2)}');
      return true;
    } else {
      print('Insufficient funds or invalid amount');
      return false;
    }
  }
  
  // Private method
  void _logTransaction(String type, double amount) {
    print('Transaction: $type of \$${amount.toStringAsFixed(2)} at ${DateTime.now()}');
  }
  
  void transfer(BankAccount targetAccount, double amount) {
    if (withdraw(amount)) {
      targetAccount.deposit(amount);
      _logTransaction('Transfer', amount);
    }
  }
}

void demonstrateEncapsulation() {
  BankAccount account1 = BankAccount('ACC001', 'John Doe', 1000.0);
  BankAccount account2 = BankAccount('ACC002', 'Jane Smith', 500.0);
  
  print('Account holder: ${account1.accountHolderName}');
  print('Initial balance: \$${account1.balance}');
  
  account1.deposit(200.0);
  account1.withdraw(150.0);
  account1.transfer(account2, 300.0);
  
  // account1._balance = 10000; // This would cause an error - private property
}
```

## Inheritance

Inheritance allows a class to inherit properties and methods from another class.

```dart
// Base class (Parent class)
class Animal {
  String name;
  int age;
  String species;
  
  Animal(this.name, this.age, this.species);
  
  void eat() {
    print('$name is eating');
  }
  
  void sleep() {
    print('$name is sleeping');
  }
  
  void makeSound() {
    print('$name makes a sound');
  }
  
  void displayInfo() {
    print('Name: $name, Age: $age, Species: $species');
  }
}

// Derived class (Child class)
class Dog extends Animal {
  String breed;
  
  // Constructor calling parent constructor
  Dog(String name, int age, this.breed) : super(name, age, 'Canine');
  
  // Override parent method
  @override
  void makeSound() {
    print('$name barks: Woof! Woof!');
  }
  
  // New methods specific to Dog
  void fetch() {
    print('$name is fetching the ball');
  }
  
  void wagTail() {
    print('$name is wagging tail happily');
  }
  
  @override
  void displayInfo() {
    super.displayInfo(); // Call parent method
    print('Breed: $breed');
  }
}

class Cat extends Animal {
  bool isIndoor;
  
  Cat(String name, int age, this.isIndoor) : super(name, age, 'Feline');
  
  @override
  void makeSound() {
    print('$name meows: Meow! Meow!');
  }
  
  void climb() {
    print('$name is climbing');
  }
  
  void purr() {
    print('$name is purring contentedly');
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Indoor cat: $isIndoor');
  }
}

class Bird extends Animal {
  double wingSpan;
  bool canFly;
  
  Bird(String name, int age, this.wingSpan, this.canFly) : super(name, age, 'Avian');
  
  @override
  void makeSound() {
    print('$name chirps: Tweet! Tweet!');
  }
  
  void fly() {
    if (canFly) {
      print('$name is flying with ${wingSpan}m wingspan');
    } else {
      print('$name cannot fly');
    }
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Wingspan: ${wingSpan}m, Can fly: $canFly');
  }
}

void demonstrateInheritance() {
  Dog dog = Dog('Buddy', 3, 'Golden Retriever');
  Cat cat = Cat('Whiskers', 2, true);
  Bird eagle = Bird('Eagle', 5, 2.3, true);
  Bird penguin = Bird('Pingu', 4, 0.6, false);
  
  List<Animal> animals = [dog, cat, eagle, penguin];
  
  for (Animal animal in animals) {
    print('\n--- ${animal.name} ---');
    animal.displayInfo();
    animal.eat();
    animal.makeSound();
    
    // Type checking and casting
    if (animal is Dog) {
      animal.fetch();
      animal.wagTail();
    } else if (animal is Cat) {
      animal.purr();
      animal.climb();
    } else if (animal is Bird) {
      animal.fly();
    }
  }
}
```

## Polymorphism

Polymorphism allows objects of different types to be treated as instances of the same type through inheritance.

```dart
// Base class for demonstration
abstract class Shape {
  String color;
  
  Shape(this.color);
  
  // Abstract method - must be implemented by subclasses
  double calculateArea();
  double calculatePerimeter();
  
  // Concrete method
  void displayInfo() {
    print('Shape: ${runtimeType}, Color: $color');
    print('Area: ${calculateArea().toStringAsFixed(2)}');
    print('Perimeter: ${calculatePerimeter().toStringAsFixed(2)}');
  }
}

class Circle extends Shape {
  double radius;
  
  Circle(String color, this.radius) : super(color);
  
  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * radius;
  }
}

class Rectangle extends Shape {
  double width;
  double height;
  
  Rectangle(String color, this.width, this.height) : super(color);
  
  @override
  double calculateArea() {
    return width * height;
  }
  
  @override
  double calculatePerimeter() {
    return 2 * (width + height);
  }
}

class Triangle extends Shape {
  double base;
  double height;
  double side1, side2, side3;
  
  Triangle(String color, this.base, this.height, this.side1, this.side2, this.side3) 
      : super(color);
  
  @override
  double calculateArea() {
    return 0.5 * base * height;
  }
  
  @override
  double calculatePerimeter() {
    return side1 + side2 + side3;
  }
}

// Polymorphism in action
void demonstratePolymorphism() {
  List<Shape> shapes = [
    Circle('Red', 5.0),
    Rectangle('Blue', 4.0, 6.0),
    Triangle('Green', 6.0, 4.0, 5.0, 6.0, 7.0),
    Circle('Yellow', 3.0),
    Rectangle('Purple', 8.0, 3.0),
  ];
  
  print('=== Polymorphism Demo ===');
  
  double totalArea = 0;
  for (Shape shape in shapes) {
    print('\n--- Shape ${shapes.indexOf(shape) + 1} ---');
    shape.displayInfo(); // Calls the appropriate overridden method
    totalArea += shape.calculateArea();
  }
  
  print('\nTotal area of all shapes: ${totalArea.toStringAsFixed(2)}');
  
  // Method that works with any Shape
  printShapeDetails(shapes[0]);
  printShapeDetails(shapes[1]);
}

void printShapeDetails(Shape shape) {
  print('\nShape details:');
  print('Type: ${shape.runtimeType}');
  print('Color: ${shape.color}');
  print('Area: ${shape.calculateArea()}');
}
```

## Abstraction

Abstraction hides complex implementation details and shows only essential features.

```dart
// Abstract class for vehicle
abstract class Vehicle {
  String brand;
  String model;
  int year;
  
  Vehicle(this.brand, this.model, this.year);
  
  // Abstract methods
  void startEngine();
  void stopEngine();
  double getFuelEfficiency();
  
  // Concrete methods
  void displayInfo() {
    print('Vehicle: $brand $model ($year)');
    print('Fuel Efficiency: ${getFuelEfficiency()} km/l');
  }
  
  void honk() {
    print('$brand $model is honking!');
  }
}

// Interface-like abstract class
abstract class Drivable {
  void accelerate();
  void brake();
  void steer(String direction);
}

abstract class Flyable {
  void takeOff();
  void land();
  double getAltitude();
}

// Concrete implementations
class Car extends Vehicle implements Drivable {
  int numberOfDoors;
  String fuelType;
  
  Car(String brand, String model, int year, this.numberOfDoors, this.fuelType) 
      : super(brand, model, year);
  
  @override
  void startEngine() {
    print('$brand $model: Engine started with key ignition');
  }
  
  @override
  void stopEngine() {
    print('$brand $model: Engine stopped');
  }
  
  @override
  double getFuelEfficiency() {
    return fuelType == 'Electric' ? 100.0 : 15.0; // km/l equivalent
  }
  
  @override
  void accelerate() {
    print('$brand $model: Accelerating on road');
  }
  
  @override
  void brake() {
    print('$brand $model: Braking');
  }
  
  @override
  void steer(String direction) {
    print('$brand $model: Steering $direction');
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Doors: $numberOfDoors, Fuel Type: $fuelType');
  }
}

class Motorcycle extends Vehicle implements Drivable {
  int engineCapacity;
  
  Motorcycle(String brand, String model, int year, this.engineCapacity) 
      : super(brand, model, year);
  
  @override
  void startEngine() {
    print('$brand $model: Engine started with kick/button');
  }
  
  @override
  void stopEngine() {
    print('$brand $model: Engine stopped');
  }
  
  @override
  double getFuelEfficiency() {
    return 35.0; // km/l
  }
  
  @override
  void accelerate() {
    print('$brand $model: Accelerating on two wheels');
  }
  
  @override
  void brake() {
    print('$brand $model: Braking carefully');
  }
  
  @override
  void steer(String direction) {
    print('$brand $model: Leaning $direction');
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Engine Capacity: ${engineCapacity}cc');
  }
}

class Airplane extends Vehicle implements Flyable {
  int passengerCapacity;
  double maxAltitude;
  double currentAltitude = 0;
  
  Airplane(String brand, String model, int year, this.passengerCapacity, this.maxAltitude) 
      : super(brand, model, year);
  
  @override
  void startEngine() {
    print('$brand $model: Jet engines started');
  }
  
  @override
  void stopEngine() {
    print('$brand $model: Jet engines stopped');
  }
  
  @override
  double getFuelEfficiency() {
    return 3.0; // km/l
  }
  
  @override
  void takeOff() {
    print('$brand $model: Taking off...');
    currentAltitude = 1000;
    print('Current altitude: ${currentAltitude}m');
  }
  
  @override
  void land() {
    print('$brand $model: Landing...');
    currentAltitude = 0;
    print('Landed successfully');
  }
  
  @override
  double getAltitude() {
    return currentAltitude;
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Passenger Capacity: $passengerCapacity');
    print('Max Altitude: ${maxAltitude}m');
    print('Current Altitude: ${currentAltitude}m');
  }
}

void demonstrateAbstraction() {
  List<Vehicle> vehicles = [
    Car('Toyota', 'Camry', 2023, 4, 'Petrol'),
    Motorcycle('Honda', 'CBR600RR', 2022, 600),
    Airplane('Boeing', '737', 2021, 180, 12000),
    Car('Tesla', 'Model 3', 2023, 4, 'Electric'),
  ];
  
  print('=== Abstraction Demo ===');
  
  for (Vehicle vehicle in vehicles) {
    print('\n--- ${vehicle.brand} ${vehicle.model} ---');
    vehicle.displayInfo();
    vehicle.startEngine();
    
    if (vehicle is Drivable) {
      vehicle.accelerate();
      vehicle.steer('left');
      vehicle.brake();
    }
    
    if (vehicle is Flyable) {
      vehicle.takeOff();
      print('Flying at altitude: ${vehicle.getAltitude()}m');
      vehicle.land();
    }
    
    vehicle.stopEngine();
  }
}
```

## Constructors

Dart provides various types of constructors for flexible object initialization.

```dart
class Student {
  String name;
  int age;
  String studentId;
  List<String> subjects;
  double gpa;
  
  // Default constructor
  Student(this.name, this.age, this.studentId, this.subjects, this.gpa);
  
  // Named constructor
  Student.withDefaults(this.name, this.age)
      : studentId = 'STU${DateTime.now().millisecondsSinceEpoch}',
        subjects = [],
        gpa = 0.0;
  
  // Named constructor for transfer student
  Student.transfer(this.name, this.age, this.studentId, this.gpa)
      : subjects = [];
  
  // Factory constructor
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['name'],
      json['age'],
      json['studentId'],
      List<String>.from(json['subjects']),
      json['gpa'].toDouble(),
    );
  }
  
  // Const constructor
  const Student.guest()
      : name = 'Guest',
        age = 0,
        studentId = 'GUEST',
        subjects = const [],
        gpa = 0.0;
  
  void addSubject(String subject) {
    subjects.add(subject);
  }
  
  void updateGPA(double newGPA) {
    gpa = newGPA;
  }
  
  void displayInfo() {
    print('Name: $name');
    print('Age: $age');
    print('Student ID: $studentId');
    print('Subjects: ${subjects.join(', ')}');
    print('GPA: ${gpa.toStringAsFixed(2)}');
  }
}

// Constructor with initialization list
class Point {
  final double x;
  final double y;
  final double distance;
  
  // Constructor with initialization list
  Point(this.x, this.y) : distance = _calculateDistance(x, y);
  
  // Named constructor for origin
  Point.origin() : x = 0, y = 0, distance = 0;
  
  // Static method for initialization list
  static double _calculateDistance(double x, double y) {
    return (x * x + y * y).sqrt();
  }
  
  @override
  String toString() {
    return 'Point($x, $y) - Distance from origin: ${distance.toStringAsFixed(2)}';
  }
}

void demonstrateConstructors() {
  print('=== Constructor Demo ===');
  
  // Default constructor
  Student student1 = Student('Alice Johnson', 20, 'STU001', ['Math', 'Physics'], 3.8);
  
  // Named constructor
  Student student2 = Student.withDefaults('Bob Smith', 19);
  student2.addSubject('Computer Science');
  student2.updateGPA(3.5);
  
  // Transfer student
  Student student3 = Student.transfer('Carol Davis', 21, 'TRANS001', 3.9);
  student3.addSubject('Biology');
  student3.addSubject('Chemistry');
  
  // Factory constructor
  Map<String, dynamic> jsonData = {
    'name': 'David Wilson',
    'age': 22,
    'studentId': 'STU002',
    'subjects': ['History', 'Literature'],
    'gpa': 3.7
  };
  Student student4 = Student.fromJson(jsonData);
  
  // Const constructor
  const Student guestStudent = Student.guest();
  
  List<Student> students = [student1, student2, student3, student4];
  
  for (int i = 0; i < students.length; i++) {
    print('\n--- Student ${i + 1} ---');
    students[i].displayInfo();
  }
  
  print('\n--- Guest Student ---');
  guestStudent.displayInfo();
  
  // Point examples
  print('\n=== Point Examples ===');
  Point p1 = Point(3, 4);
  Point p2 = Point.origin();
  print(p1);
  print(p2);
}
```

## Getters and Setters

Getters and setters provide controlled access to object properties.

```dart
class Temperature {
  double _celsius;
  
  Temperature(this._celsius);
  
  // Getter for Celsius
  double get celsius => _celsius;
  
  // Setter for Celsius with validation
  set celsius(double value) {
    if (value < -273.15) {
      throw ArgumentError('Temperature cannot be below absolute zero');
    }
    _celsius = value;
  }
  
  // Getter for Fahrenheit
  double get fahrenheit => (_celsius * 9 / 5) + 32;
  
  // Setter for Fahrenheit
  set fahrenheit(double value) {
    celsius = (value - 32) * 5 / 9;
  }
  
  // Getter for Kelvin
  double get kelvin => _celsius + 273.15;
  
  // Setter for Kelvin
  set kelvin(double value) {
    celsius = value - 273.15;
  }
  
  // Read-only property
  String get temperatureStatus {
    if (_celsius < 0) return 'Freezing';
    if (_celsius < 10) return 'Very Cold';
    if (_celsius < 20) return 'Cold';
    if (_celsius < 30) return 'Comfortable';
    if (_celsius < 40) return 'Hot';
    return 'Very Hot';
  }
  
  void displayAll() {
    print('Temperature:');
    print('  Celsius: ${celsius.toStringAsFixed(1)}°C');
    print('  Fahrenheit: ${fahrenheit.toStringAsFixed(1)}°F');
    print('  Kelvin: ${kelvin.toStringAsFixed(1)}K');
    print('  Status: $temperatureStatus');
  }
}

// Property validation example
class Product {
  String _name;
  double _price;
  int _quantity;
  
  Product(this._name, this._price, this._quantity);
  
  // Name getter/setter
  String get name => _name;
  set name(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Product name cannot be empty');
    }
    _name = value;
  }
  
  // Price getter/setter with validation
  double get price => _price;
  set price(double value) {
    if (value < 0) {
      throw ArgumentError('Price cannot be negative');
    }
    _price = value;
  }
  
  // Quantity getter/setter
  int get quantity => _quantity;
  set quantity(int value) {
    if (value < 0) {
      throw ArgumentError('Quantity cannot be negative');
    }
    _quantity = value;
  }
  
  // Computed property
  double get totalValue => _price * _quantity;
  
  // Read-only property
  bool get isInStock => _quantity > 0;
  
  // Property with complex logic
  String get stockStatus {
    if (_quantity == 0) return 'Out of Stock';
    if (_quantity < 5) return 'Low Stock';
    if (_quantity < 20) return 'Medium Stock';
    return 'High Stock';
  }
  
  void displayInfo() {
    print('Product: $_name');
    print('Price: \$${_price.toStringAsFixed(2)}');
    print('Quantity: $_quantity');
    print('Total Value: \$${totalValue.toStringAsFixed(2)}');
    print('Stock Status: $stockStatus');
    print('In Stock: $isInStock');
  }
}

void demonstrateGettersSetters() {
  print('=== Getters and Setters Demo ===');
  
  // Temperature example
  Temperature temp = Temperature(25.0);
  print('--- Temperature Conversion ---');
  temp.displayAll();
  
  print('\nChanging to 100°F:');
  temp.fahrenheit = 100;
  temp.displayAll();
  
  print('\nChanging to 300K:');
  temp.kelvin = 300;
  temp.displayAll();
  
  // Product example
  print('\n--- Product Management ---');
  Product product = Product('Laptop', 999.99, 15);
  product.displayInfo();
  
  print('\nUpdating product:');
  product.price = 899.99;
  product.quantity = 3;
  product.displayInfo();
  
  // Error handling example
  try {
    product.price = -100; // This will throw an error
  } catch (e) {
    print('\nError: $e');
  }
  
  try {
    temp.celsius = -300; // This will throw an error
  } catch (e) {
    print('Error: $e');
  }
}
```

## Static Members

Static members belong to the class rather than instances of the class.

```dart
class MathUtils {
  // Static constants
  static const double pi = 3.14159265359;
  static const double e = 2.71828182846;
  
  // Static variables
  static int _calculationCount = 0;
  
  // Static getter
  static int get calculationCount => _calculationCount;
  
  // Static methods
  static double circleArea(double radius) {
    _calculationCount++;
    return pi * radius * radius;
  }
  
  static double circleCircumference(double radius) {
    _calculationCount++;
    return 2 * pi * radius;
  }
  
  static double rectangleArea(double width, double height) {
    _calculationCount++;
    return width * height;
  }
  
  static double power(double base, int exponent) {
    _calculationCount++;
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
  
  static double factorial(int n) {
    _calculationCount++;
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }
  
  static void resetCalculationCount() {
    _calculationCount = 0;
  }
  
  static void printCalculationStats() {
    print('Total calculations performed: $_calculationCount');
  }
}

class Counter {
  // Static variable shared by all instances
  static int _globalCount = 0;
  
  // Instance variable
  int _instanceCount = 0;
  String name;
  
  Counter(this.name);
  
  void increment() {
    _globalCount++;
    _instanceCount++;
  }
  
  void decrement() {
    _globalCount--;
    _instanceCount--;
  }
  
  // Static method
  static int getGlobalCount() => _globalCount;
  
  // Static method to reset global count
  static void resetGlobalCount() {
    _globalCount = 0;
  }
  
  // Instance method
  int getInstanceCount() => _instanceCount;
  
  void displayCounts() {
    print('Counter "$name":');
    print('  Instance count: $_instanceCount');
    print('  Global count: $_globalCount');
  }
}

// Singleton pattern using static members
class DatabaseConnection {
  static DatabaseConnection? _instance;
  static int _connectionCount = 0;
  
  String _connectionString;
  bool _isConnected = false;
  
  // Private constructor
  DatabaseConnection._internal(this._connectionString);
  
  // Factory constructor that returns singleton instance
  factory DatabaseConnection(String connectionString) {
    _instance ??= DatabaseConnection._internal(connectionString);
    return _instance!;
  }
  
  // Static method to get instance
  static DatabaseConnection? getInstance() => _instance;
  
  void connect() {
    if (!_isConnected) {
      _isConnected = true;
      _connectionCount++;
      print('Connected to database: $_connectionString');
      print('Total connections made: $_connectionCount');
    } else {
      print('Already connected');
    }
  }
  
  void disconnect() {
    if (_isConnected) {
      _isConnected = false;
      print('Disconnected from database');
    } else {
      print('Not connected');
    }
  }
  
  static int getConnectionCount() => _connectionCount;
  
  bool get isConnected => _isConnected;
}

void demonstrateStaticMembers() {
  print('=== Static Members Demo ===');
  
  // MathUtils example
  print('--- Math Utilities ---');
  print('Circle area (r=5): ${MathUtils.circleArea(5)}');
  print('Circle circumference (r=5): ${MathUtils.circleCircumference(5)}');
  print('Rectangle area (4x6): ${MathUtils.rectangleArea(4, 6)}');
  print('2^8 = ${MathUtils.power(2, 8)}');
  print('5! = ${MathUtils.factorial(5)}');
  
  MathUtils.printCalculationStats();
  
  // Counter example
  print('\n--- Counter Example ---');
  Counter counter1 = Counter('Counter1');
  Counter counter2 = Counter('Counter2');
  Counter counter3 = Counter('Counter3');
  
  counter1.increment();
  counter1.increment();
  counter2.increment();
  counter3.increment();
  counter3.increment();
  counter3.increment();
  
  counter1.displayCounts();
  counter2.displayCounts();
  counter3.displayCounts();
  
  print('Global count from static method: ${Counter.getGlobalCount()}');
  
  // Singleton example
  print('\n--- Singleton Database Connection ---');
  DatabaseConnection db1 = DatabaseConnection('server1.database.com');
  DatabaseConnection db2 = DatabaseConnection('server2.database.com'); // Same instance
  
  print('db1 == db2: ${identical(db1, db2)}'); // true
  
  db1.connect();
  db2.connect(); // Already connected message
  
  print('Connection count: ${DatabaseConnection.getConnectionCount()}');
  
  db1.disconnect();
  print('db2 connected: ${db2.isConnected}'); // false, same instance
}
```

## Mixins

Mixins provide a way to reuse code in multiple class hierarchies.

```dart
// Mixin for flyable behavior
mixin Flyable {
  double altitude = 0;
  double maxAltitude = 1000;
  
  void takeOff() {
    if (altitude == 0) {
      altitude = 100;
      print('Taking off... Current altitude: ${altitude}m');
    } else {
      print('Already in the air at ${altitude}m');
    }
  }
  
  void land() {
    if (altitude > 0) {
      altitude = 0;
      print('Landing... Safely on the ground');
    } else {
      print('Already on the ground');
    }
  }
  
  void increaseAltitude(double meters) {
    if (altitude + meters <= maxAltitude) {
      altitude += meters;
      print('Climbing to ${altitude}m');
    } else {
      print('Cannot exceed maximum altitude of ${maxAltitude}m');
    }
  }
  
  void decreaseAltitude(double meters) {
    if (altitude - meters >= 0) {
      altitude -= meters;
      print('Descending to ${altitude}m');
    } else {
      print('Cannot go below ground level');
    }
  }
}

// Mixin for swimming behavior
mixin Swimmable {
  double depth = 0;
  double maxDepth = 100;
  
  void dive() {
    depth = 5;
    print('Diving underwater... Current depth: ${depth}m');
  }
  
  void surface() {
    depth = 0;
    print('Surfacing... Back at water surface');
  }
  
  void goDeeper(double meters) {
    if (depth + meters <= maxDepth) {
      depth += meters;
      print('Swimming deeper to ${depth}m');
    } else {
      print('Cannot exceed maximum depth of ${maxDepth}m');
    }
  }
  
  void goShallower(double meters) {
    if (depth - meters >= 0) {
      depth -= meters;
      print('Swimming up to ${depth}m');
    } else {
      print('Already at surface');
    }
  }
}

// Mixin for walking behavior
mixin Walkable {
  double speed = 0;
  double maxSpeed = 50;
  
  void startWalking(double walkSpeed) {
    if (walkSpeed <= maxSpeed) {
      speed = walkSpeed;
      print('Started walking at ${speed} km/h');
    } else {
      print('Speed too high! Maximum walking speed is ${maxSpeed} km/h');
    }
  }
  
  void stopWalking() {
    speed = 0;
    print('Stopped walking');
  }
  
  void changeSpeed(double newSpeed) {
    if (newSpeed <= maxSpeed && newSpeed >= 0) {
      speed = newSpeed;
      print('Changed walking speed to ${speed} km/h');
    } else {
      print('Invalid speed');
    }
  }
}

// Mixin with constraints
mixin Musical on Animal {
  List<String> songs = [];
  
  void learnSong(String song) {
    songs.add(song);
    print('$name learned to sing: $song');
  }
  
  void sing() {
    if (songs.isNotEmpty) {
      String song = songs[songs.length - 1];
      print('$name is singing: $song');
    } else {
      print('$name doesn\'t know any songs yet');
    }
  }
  
  void performConcert() {
    print('$name is performing a concert:');
    for (String song in songs) {
      print('  ♪ $song ♪');
    }
  }
}

// Classes using mixins
class Bird extends Animal with Flyable, Musical {
  Bird(String name, int age) : super(name, age, 'Bird') {
    maxAltitude = 3000;
  }
  
  @override
  void makeSound() {
    print('$name chirps melodiously');
  }
}

class Duck extends Animal with Flyable, Swimmable, Walkable {
  Duck(String name, int age) : super(name, age, 'Duck') {
    maxAltitude = 1000;
    maxDepth = 10;
    maxSpeed = 15;
  }
  
  @override
  void makeSound() {
    print('$name quacks: Quack! Quack!');
  }
  
  // Override mixin method
  @override
  void takeOff() {
    print('$name flaps wings rapidly');
    super.takeOff();
  }
}

class Fish extends Animal with Swimmable {
  Fish(String name, int age) : super(name, age, 'Fish') {
    maxDepth = 200;
  }
  
  @override
  void makeSound() {
    print('$name makes bubbling sounds');
  }
  
  // Fish can't really surface like other animals
  @override
  void surface() {
    if (depth > 2) {
      depth = 2;
      print('$name swims near the surface at ${depth}m depth');
    } else {
      print('$name is already near the surface');
    }
  }
}

class Penguin extends Animal with Swimmable, Walkable {
  Penguin(String name, int age) : super(name, age, 'Penguin') {
    maxDepth = 50;
    maxSpeed = 8;
  }
  
  @override
  void makeSound() {
    print('$name makes penguin sounds: *trumpet*');
  }
  
  // Penguins waddle instead of walk
  @override
  void startWalking(double walkSpeed) {
    if (walkSpeed <= maxSpeed) {
      speed = walkSpeed;
      print('$name started waddling at ${speed} km/h');
    } else {
      print('$name can\'t waddle that fast!');
    }
  }
}

void demonstrateMixins() {
  print('=== Mixins Demo ===');
  
  // Bird with flying and musical abilities
  print('--- Musical Bird ---');
  Bird canary = Bird('Canary', 2);
  canary.makeSound();
  canary.learnSong('Tweet Symphony');
  canary.learnSong('Morning Melody');
  canary.sing();
  canary.performConcert();
  canary.takeOff();
  canary.increaseAltitude(500);
  canary.land();
  
  // Duck with multiple abilities
  print('\n--- Versatile Duck ---');
  Duck mallard = Duck('Mallard', 3);
  mallard.makeSound();
  
  // Flying
  mallard.takeOff();
  mallard.increaseAltitude(200);
  
  // Landing and swimming
  mallard.land();
  mallard.dive();
  mallard.goDeeper(5);
  mallard.surface();
  
  // Walking
  mallard.startWalking(10);
  mallard.changeSpeed(5);
  mallard.stopWalking();
  
  // Fish swimming
  print('\n--- Swimming Fish ---');
  Fish salmon = Fish('Salmon', 1);
  salmon.makeSound();
  salmon.dive();
  salmon.goDeeper(50);
  salmon.goDeeper(100);
  salmon.surface();
  
  // Penguin waddle and swim
  print('\n--- Waddling Penguin ---');
  Penguin emperor = Penguin('Emperor', 5);
  emperor.makeSound();
  emperor.startWalking(6);
  emperor.stopWalking();
  emperor.dive();
  emperor.goDeeper(20);
  emperor.surface();
}
```

## Interfaces

In Dart, any class can be used as an interface using the `implements` keyword.

```dart
// Interface-like abstract class
abstract class Drawable {
  void draw();
  void erase();
  String getDescription();
}

abstract class Resizable {
  void resize(double factor);
  double getArea();
}

abstract class Colorable {
  void setColor(String color);
  String getColor();
}

// Concrete classes implementing interfaces
class Circle implements Drawable, Resizable, Colorable {
  double radius;
  String color;
  
  Circle(this.radius, this.color);
  
  @override
  void draw() {
    print('Drawing a $color circle with radius $radius');
  }
  
  @override
  void erase() {
    print('Erasing the circle');
  }
  
  @override
  String getDescription() {
    return 'A $color circle with radius $radius and area ${getArea().toStringAsFixed(2)}';
  }
  
  @override
  void resize(double factor) {
    radius *= factor;
    print('Circle resized by factor $factor. New radius: $radius');
  }
  
  @override
  double getArea() {
    return 3.14159 * radius * radius;
  }
  
  @override
  void setColor(String newColor) {
    color = newColor;
    print('Circle color changed to $color');
  }
  
  @override
  String getColor() {
    return color;
  }
}

class Rectangle implements Drawable, Resizable, Colorable {
  double width;
  double height;
  String color;
  
  Rectangle(this.width, this.height, this.color);
  
  @override
  void draw() {
    print('Drawing a $color rectangle ${width}x${height}');
  }
  
  @override
  void erase() {
    print('Erasing the rectangle');
  }
  
  @override
  String getDescription() {
    return 'A $color rectangle ${width}x${height} with area ${getArea()}';
  }
  
  @override
  void resize(double factor) {
    width *= factor;
    height *= factor;
    print('Rectangle resized by factor $factor. New dimensions: ${width}x${height}');
  }
  
  @override
  double getArea() {
    return width * height;
  }
  
  @override
  void setColor(String newColor) {
    color = newColor;
    print('Rectangle color changed to $color');
  }
  
  @override
  String getColor() {
    return color;
  }
}

// Interface for data persistence
abstract class Persistable {
  Map<String, dynamic> toJson();
  void fromJson(Map<String, dynamic> json);
  void save();
  void load();
}

// User class implementing Persistable
class User implements Persistable {
  String username;
  String email;
  int age;
  List<String> interests;
  
  User(this.username, this.email, this.age, this.interests);
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'age': age,
      'interests': interests,
    };
  }
  
  @override
  void fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    age = json['age'];
    interests = List<String>.from(json['interests']);
  }
  
  @override
  void save() {
    print('Saving user data: ${toJson()}');
    // In real implementation, this would save to database/file
  }
  
  @override
  void load() {
    print('Loading user data for $username');
    // In real implementation, this would load from database/file
  }
  
  void displayInfo() {
    print('User: $username');
    print('Email: $email');
    print('Age: $age');
    print('Interests: ${interests.join(', ')}');
  }
}

// Multiple interface implementation
abstract class Cacheable {
  void cache();
  void clearCache();
  bool isCached();
}

abstract class Validatable {
  bool isValid();
  List<String> getValidationErrors();
}

class Product implements Persistable, Cacheable, Validatable {
  String name;
  double price;
  String category;
  int stockQuantity;
  bool _isCached = false;
  
  Product(this.name, this.price, this.category, this.stockQuantity);
  
  // Persistable implementation
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'stockQuantity': stockQuantity,
    };
  }
  
  @override
  void fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'].toDouble();
    category = json['category'];
    stockQuantity = json['stockQuantity'];
  }
  
  @override
  void save() {
    if (isValid()) {
      print('Saving product: $name');
      cache();
    } else {
      print('Cannot save invalid product. Errors: ${getValidationErrors()}');
    }
  }
  
  @override
  void load() {
    print('Loading product: $name');
    _isCached = true;
  }
  
  // Cacheable implementation
  @override
  void cache() {
    _isCached = true;
    print('Product $name cached');
  }
  
  @override
  void clearCache() {
    _isCached = false;
    print('Cache cleared for product $name');
  }
  
  @override
  bool isCached() {
    return _isCached;
  }
  
  // Validatable implementation
  @override
  bool isValid() {
    return getValidationErrors().isEmpty;
  }
  
  @override
  List<String> getValidationErrors() {
    List<String> errors = [];
    
    if (name.isEmpty) {
      errors.add('Product name cannot be empty');
    }
    
    if (price < 0) {
      errors.add('Price cannot be negative');
    }
    
    if (category.isEmpty) {
      errors.add('Category cannot be empty');
    }
    
    if (stockQuantity < 0) {
      errors.add('Stock quantity cannot be negative');
    }
    
    return errors;
  }
  
  void displayInfo() {
    print('Product: $name');
    print('Price: \$${price.toStringAsFixed(2)}');
    print('Category: $category');
    print('Stock: $stockQuantity');
    print('Valid: ${isValid()}');
    print('Cached: ${isCached()}');
  }
}

void demonstrateInterfaces() {
  print('=== Interfaces Demo ===');
  
  // Shape interfaces
  print('--- Drawable Shapes ---');
  List<Drawable> drawables = [
    Circle(5.0, 'Red'),
    Rectangle(4.0, 6.0, 'Blue'),
    Circle(3.0, 'Green'),
  ];
  
  for (Drawable drawable in drawables) {
    drawable.draw();
    print('Description: ${drawable.getDescription()}');
    
    if (drawable is Resizable) {
      print('Original area: ${drawable.getArea().toStringAsFixed(2)}');
      drawable.resize(1.5);
      print('New area: ${drawable.getArea().toStringAsFixed(2)}');
    }
    
    if (drawable is Colorable) {
      print('Current color: ${drawable.getColor()}');
      drawable.setColor('Purple');
    }
    
    drawable.erase();
    print('---');
  }
  
  // User persistence
  print('\n--- User Persistence ---');
  User user = User('john_doe', 'john@example.com', 28, ['programming', 'gaming', 'reading']);
  user.displayInfo();
  user.save();
  user.load();
  
  // Product with multiple interfaces
  print('\n--- Product Management ---');
  Product product1 = Product('Laptop', 999.99, 'Electronics', 10);
  Product product2 = Product('', -50, '', -5); // Invalid product
  
  List<Product> products = [product1, product2];
  
  for (Product product in products) {
    print('\n--- Product Check ---');
    product.displayInfo();
    
    if (!product.isValid()) {
      print('Validation errors:');
      for (String error in product.getValidationErrors()) {
        print('  - $error');
      }
    }
    
    product.save();
    
    if (product.isValid()) {
      product.clearCache();
      product.load();
    }
  }
}
```

## Advanced OOP Concepts

```dart
// Extension methods
extension StringExtensions on String {
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  String get reversed {
    return split('').reversed.join();
  }
  
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
  
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  
  List<T> get distinctItems => toSet().toList();
  
  void addIfNotExists(T item) {
    if (!contains(item)) {
      add(item);
    }
  }
}

// Generic classes
class Repository<T> {
  final List<T> _items = [];
  
  void add(T item) {
    _items.add(item);
    print('Added item: $item');
  }
  
  void remove(T item) {
    if (_items.remove(item)) {
      print('Removed item: $item');
    } else {
      print('Item not found: $item');
    }
  }
  
  T? findById(int id, int Function(T) getId) {
    for (T item in _items) {
      if (getId(item) == id) {
        return item;
      }
    }
    return null;
  }
  
  List<T> findWhere(bool Function(T) predicate) {
    return _items.where(predicate).toList();
  }
  
  void clear() {
    _items.clear();
    print('Repository cleared');
  }
  
  int get count => _items.length;
  
  List<T> get all => List.unmodifiable(_items);
}

// Generic class with constraints
class Comparable<T extends num> {
  T value;
  
  Comparable(this.value);
  
  bool isGreaterThan(Comparable<T> other) {
    return value > other.value;
  }
  
  bool isLessThan(Comparable<T> other) {
    return value < other.value;
  }
  
  bool isEqualTo(Comparable<T> other) {
    return value == other.value;
  }
  
  T add(Comparable<T> other) {
    return value + other.value as T;
  }
  
  @override
  String toString() => 'Comparable($value)';
}

// Event system
class Event<T> {
  final List<void Function(T)> _listeners = [];
  
  void subscribe(void Function(T) listener) {
    _listeners.add(listener);
  }
  
  void unsubscribe(void Function(T) listener) {
    _listeners.remove(listener);
  }
  
  void emit(T data) {
    for (var listener in _listeners) {
      listener(data);
    }
  }
  
  void clear() {
    _listeners.clear();
  }
  
  int get listenerCount => _listeners.length;
}

// Observer pattern
abstract class Observer<T> {
  void update(T data);
}

class Subject<T> {
  final List<Observer<T>> _observers = [];
  
  void attach(Observer<T> observer) {
    _observers.add(observer);
  }
  
  void detach(Observer<T> observer) {
    _observers.remove(observer);
  }
  
  void notify(T data) {
    for (var observer in _observers) {
      observer.update(data);
    }
  }
}

class NewsletterSubscriber implements Observer<String> {
  String name;
  
  NewsletterSubscriber(this.name);
  
  @override
  void update(String news) {
    print('$name received news: $news');
  }
}

class NewsAgency extends Subject<String> {
  String _latestNews = '';
  
  String get latestNews => _latestNews;
  
  void publishNews(String news) {
    _latestNews = news;
    print('Publishing news: $news');
    notify(news);
  }
}

// Builder pattern
class PersonBuilder {
  String? _name;
  int? _age;
  String? _email;
  String? _phone;
  String? _address;
  List<String> _hobbies = [];
  
  PersonBuilder setName(String name) {
    _name = name;
    return this;
  }
  
  PersonBuilder setAge(int age) {
    _age = age;
    return this;
  }
  
  PersonBuilder setEmail(String email) {
    _email = email;
    return this;
  }
  
  PersonBuilder setPhone(String phone) {
    _phone = phone;
    return this;
  }
  
  PersonBuilder setAddress(String address) {
    _address = address;
    return this;
  }
  
  PersonBuilder addHobby(String hobby) {
    _hobbies.add(hobby);
    return this;
  }
  
  PersonBuilder addHobbies(List<String> hobbies) {
    _hobbies.addAll(hobbies);
    return this;
  }
  
  Person build() {
    if (_name == null || _age == null) {
      throw StateError('Name and age are required');
    }
    
    return Person._(
      _name!,
      _age!,
      _email,
      _phone,
      _address,
      List.from(_hobbies),
    );
  }
}

class Person {
  final String name;
  final int age;
  final String? email;
  final String? phone;
  final String? address;
  final List<String> hobbies;
  
  Person._(this.name, this.age, this.email, this.phone, this.address, this.hobbies);
  
  static PersonBuilder builder() => PersonBuilder();
  
  void displayInfo() {
    print('Name: $name');
    print('Age: $age');
    if (email != null) print('Email: $email');
    if (phone != null) print('Phone: $phone');
    if (address != null) print('Address: $address');
    if (hobbies.isNotEmpty) print('Hobbies: ${hobbies.join(', ')}');
  }
}

void demonstrateAdvancedOOP() {
  print('=== Advanced OOP Concepts Demo ===');
  
  // Extension methods
  print('--- Extension Methods ---');
  String email = 'test@example.com';
  String notEmail = 'invalid-email';
  
  print('$email is email: ${email.isEmail}');
  print('$notEmail is email: ${notEmail.isEmail}');
  print('Reversed: ${email.reversed}');
  print('Capitalized: ${'hello world'.capitalize()}');
  print('Truncated: ${'This is a very long string'.truncate(10)}');
  
  List<int> numbers = [1, 2, 2, 3, 3, 3, 4];
  print('Original: $numbers');
  print('Distinct: ${numbers.distinctItems}');
  numbers.addIfNotExists(5);
  numbers.addIfNotExists(3); // Won't add
  print('After adding: $numbers');
  
  // Generic Repository
  print('\n--- Generic Repository ---');
  Repository<String> stringRepo = Repository<String>();
  stringRepo.add('Item 1');
  stringRepo.add('Item 2');
  stringRepo.add('Item 3');
  print('Count: ${stringRepo.count}');
  print('All items: ${stringRepo.all}');
  
  // Generic Comparable
  print('\n--- Generic Comparable ---');
  Comparable<int> num1 = Comparable(10);
  Comparable<int> num2 = Comparable(20);
  
  print('$num1 > $num2: ${num1.isGreaterThan(num2)}');
  print('$num1 < $num2: ${num1.isLessThan(num2)}');
  print('Sum: ${num1.add(num2)}');
  
  // Event System
  print('\n--- Event System ---');
  Event<String> messageEvent = Event<String>();
  
  messageEvent.subscribe((message) => print('Listener 1: $message'));
  messageEvent.subscribe((message) => print('Listener 2: $message'));
  
  messageEvent.emit('Hello Events!');
  messageEvent.emit('Another message');
  
  // Observer Pattern
  print('\n--- Observer Pattern ---');
  NewsAgency agency = NewsAgency();
  NewsletterSubscriber subscriber1 = NewsletterSubscriber('Alice');
  NewsletterSubscriber subscriber2 = NewsletterSubscriber('Bob');
  
  agency.attach(subscriber1);
  agency.attach(subscriber2);
  
  agency.publishNews('Breaking: Dart 3.0 Released!');
  agency.publishNews('Flutter Web Updates Available');
  
  // Builder Pattern
  print('\n--- Builder Pattern ---');
  Person person1 = Person.builder()
      .setName('John Doe')
      .setAge(30)
      .setEmail('john@example.com')
      .setPhone('+1234567890')
      .addHobby('Programming')
      .addHobby('Gaming')
      .build();
  
  Person person2 = Person.builder()
      .setName('Jane Smith')
      .setAge(25)
      .setEmail('jane@example.com')
      .addHobbies(['Reading', 'Traveling', 'Photography'])
      .build();
  
  print('--- Person 1 ---');
  person1.displayInfo();
  
  print('\n--- Person 2 ---');
  person2.displayInfo();
}

// Main function to demonstrate all concepts
void main() {
  print('🎯 COMPLETE DART OOP DEMONSTRATION 🎯\n');
  
  demonstrateBasicClass();
  print('\n${'=' * 50}\n');
  
  demonstrateEncapsulation();
  print('\n${'=' * 50}\n');
  
  demonstrateInheritance();
  print('\n${'=' * 50}\n');
  
  demonstratePolymorphism();
  print('\n${'=' * 50}\n');
  
  demonstrateAbstraction();
  print('\n${'=' * 50}\n');
  
  demonstrateConstructors();
  print('\n${'=' * 50}\n');
  
  demonstrateGettersSetters();
  print('\n${'=' * 50}\n');
  
  demonstrateStaticMembers();
  print('\n${'=' * 50}\n');
  
  demonstrateMixins();
  print('\n${'=' * 50}\n');
  
  demonstrateInterfaces();
  print('\n${'=' * 50}\n');
  
  demonstrateAdvancedOOP();
  
  print('\n🎉 DART OOP DEMONSTRATION COMPLETED! 🎉');
}
```

## Summary

This comprehensive guide covers all the essential OOP concepts in Dart:

### Core OOP Principles:
1. **Encapsulation**: Data hiding with private members (`_variable`)
2. **Inheritance**: Code reuse with `extends` keyword
3. **Polymorphism**: Same interface, different implementations
4. **Abstraction**: Hiding complexity with abstract classes

### Dart-Specific Features:
- **Constructors**: Default, named, factory, and const constructors
- **Getters/Setters**: Property access control with validation
- **Static Members**: Class-level variables and methods
- **Mixins**: Code reuse across multiple inheritance hierarchies
- **Interfaces**: Implicit interfaces with `implements`

### Advanced Concepts:
- **Extension Methods**: Adding functionality to existing classes
- **Generics**: Type-safe collections and classes
- **Design Patterns**: Observer, Builder, Singleton
- **Event Systems**: Publisher-subscriber pattern

### Best Practices:
- Use private members for encapsulation
- Prefer composition over inheritance
- Use mixins for cross-cutting concerns
- Implement interfaces for contracts
- Use generics for type safety
- Follow naming conventions

This guide provides practical examples that you can run and modify to understand how OOP works in Dart. Each concept builds upon the previous ones, creating a solid foundation for object-oriented programming in Dart.