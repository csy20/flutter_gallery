// Dart OOP Concepts: Inheritance, Polymorphism, Abstract Classes and Interfaces

// =================== INHERITANCE ===================
// Inheritance allows a class to inherit properties and methods from another class
// In Dart, we use the 'extends' keyword to create inheritance

void inheritanceExample() {
  print('\n===== INHERITANCE EXAMPLE =====');
  
  // Create instances
  var dog = Dog('Buddy', 3);
  var cat = Cat('Whiskers', 2);
  
  // Call methods
  dog.makeSound(); // Uses overridden method
  dog.sleep();     // Uses parent method
  
  cat.makeSound(); // Uses overridden method
  cat.sleep();     // Uses parent method
  
  // Call method with super
  dog.showDetails();
}

// Parent class
class Animal {
  String name;
  int age;
  
  // Constructor
  Animal(this.name, this.age);
  
  // Methods
  void makeSound() {
    print('Animal makes a sound');
  }
  
  void sleep() {
    print('$name is sleeping');
  }
  
  String getInfo() {
    return 'Name: $name, Age: $age';
  }
}

// Child class that extends Animal
class Dog extends Animal {
  // Use super to call the parent constructor
  Dog(String name, int age) : super(name, age);
  
  // Method overriding - changing behavior of parent method
  @override
  void makeSound() {
    print('$name barks: Woof! Woof!');
  }
  
  // Using super to access parent method
  void showDetails() {
    print('Dog Details: ${super.getInfo()}');
    print('This is a dog!');
  }
}

// Another child class
class Cat extends Animal {
  Cat(String name, int age) : super(name, age);
  
  // Method overriding
  @override
  void makeSound() {
    print('$name meows: Meow! Meow!');
  }
}

// =================== POLYMORPHISM ===================
// Polymorphism means "many forms" - same object taking different forms
// In Dart, achieved through inheritance and method overriding

void polymorphismExample() {
  print('\n===== POLYMORPHISM EXAMPLE =====');
  
  // Create animal list with different animal types
  List<Animal> animals = [
    Dog('Rex', 4),
    Cat('Felix', 3),
    Dog('Max', 2),
    Cat('Luna', 1),
  ];
  
  // Polymorphism in action - same method call, different behaviors
  for (var animal in animals) {
    print('Animal: ${animal.name}');
    animal.makeSound(); // Each animal makes its own sound
  }
}

// =================== ABSTRACT CLASSES & METHODS ===================
// Abstract classes can't be instantiated, used as blueprints
// Abstract methods must be implemented by concrete subclasses

// Abstract class with abstract method
abstract class Shape {
  // Abstract method (no body) - must be implemented by subclasses
  double calculateArea();
  
  // Regular method with implementation - inherited as is
  void printArea() {
    print('Area: ${calculateArea()}');
  }
}

class Circle extends Shape {
  double radius;
  
  Circle(this.radius);
  
  // Must implement abstract method
  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }
}

class Rectangle extends Shape {
  double width;
  double height;
  
  Rectangle(this.width, this.height);
  
  // Must implement abstract method
  @override
  double calculateArea() {
    return width * height;
  }
}

void abstractClassExample() {
  print('\n===== ABSTRACT CLASS EXAMPLE =====');
  
  var circle = Circle(5);
  var rectangle = Rectangle(4, 6);
  
  // Using abstract class methods
  circle.printArea();     // Area: 78.5
  rectangle.printArea();  // Area: 24.0
}

// =================== INTERFACES ===================
// Dart doesn't have an explicit 'interface' keyword
// Any class can be used as an interface using 'implements'
// When a class implements another, it must implement all methods

// Class used as interface
class DatabaseConnection {
  void connect() {
    print('Connecting to database');
  }
  
  void disconnect() {
    print('Disconnecting from database');
  }
  
  void query(String sql) {
    print('Executing query: $sql');
  }
}

// Multiple interfaces can be implemented
class Logger {
  void log(String message) {
    print('LOG: $message');
  }
}

// Class implementing interfaces
class MySQLDatabase implements DatabaseConnection, Logger {
  // Must implement all methods from DatabaseConnection
  @override
  void connect() {
    print('MySQL: Establishing connection...');
  }
  
  @override
  void disconnect() {
    print('MySQL: Closing connection...');
  }
  
  @override
  void query(String sql) {
    print('MySQL: Running query: $sql');
  }
  
  // Must implement all methods from Logger
  @override
  void log(String message) {
    print('MySQL Log: $message');
  }
}

// Another implementation
class PostgreSQLDatabase implements DatabaseConnection {
  @override
  void connect() {
    print('PostgreSQL: Connecting to server...');
  }
  
  @override
  void disconnect() {
    print('PostgreSQL: Disconnecting from server...');
  }
  
  @override
  void query(String sql) {
    print('PostgreSQL: Executing: $sql');
  }
}

void interfaceExample() {
  print('\n===== INTERFACE EXAMPLE =====');
  
  var mysql = MySQLDatabase();
  var postgres = PostgreSQLDatabase();
  
  // Both classes implement the same interface but behave differently
  mysql.connect();
  mysql.query('SELECT * FROM users');
  mysql.log('Query executed');
  mysql.disconnect();
  
  postgres.connect();
  postgres.query('SELECT * FROM products');
  postgres.disconnect();
  
  // Polymorphism with interfaces
  DatabaseConnection db = MySQLDatabase();
  db.connect();  // Uses MySQLDatabase implementation
  db.query('SELECT * FROM orders');
  db.disconnect();
}

// Main function to run all examples
void main() {
  print('DART OOP CONCEPTS DEMONSTRATION\n');
  
  inheritanceExample();
  polymorphismExample();
  abstractClassExample();
  interfaceExample();
}