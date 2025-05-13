// OOP Concepts in Dart

// What & Why OOP?
/* 
  Object-Oriented Programming (OOP) is a programming paradigm based on the concept of "objects"
  which can contain data (properties) and code (methods). OOP is used because it:
  
  1. Helps organize and structure code better
  2. Makes code reusable through inheritance
  3. Provides data security through encapsulation
  4. Makes code easier to maintain and understand
  5. Models real-world entities well
*/

void main() {
  print('===== OOP Concepts in Dart =====\n');
  
  // Creating objects (instantiating)
  print('--- Creating Objects ---');
  
  // Using the default constructor
  var person1 = Person('John', 30);
  person1.displayInfo();
  
  // Using a parameterized constructor
  var person2 = Person('Sarah', 25);
  person2.displayInfo();
  
  // Using a named constructor
  var guest = Person.guest();
  guest.displayInfo();
  
  // Accessing public properties directly
  print('\n--- Accessing Properties ---');
  print('Person name: ${person1.name}');
  
  // Using getters and setters (Encapsulation)
  print('\n--- Encapsulation with Getters & Setters ---');
  print('Current age: ${person1.age}'); // Using getter
  
  person1.age = 31; // Using setter
  print('New age after setter: ${person1.age}');
  
  // Testing the validation in setter
  person1.age = -5; // Invalid age
  print('Age after invalid input: ${person1.age}'); // Should remain 31
  
  // Accessing methods
  print('\n--- Calling Methods ---');
  person1.celebrateBirthday();
  print('Age after birthday: ${person1.age}');
}

// Class Definition
class Person {
  // Instance Variables (Properties)
  String name; // Public property
  int _age;    // Private property (with underscore prefix)
  
  // Default Constructor with parameters
  // 'this' keyword refers to the current instance of the class
  Person(this.name, this._age);
  
  // Named Constructor
  Person.guest() {
    name = 'Guest';
    _age = 18;
  }
  
  // Getter method (to access private property)
  int get age => _age;
  
  // Setter method (with validation)
  set age(int value) {
    if (value >= 0) { // Data validation
      _age = value;
    } else {
      print('Error: Age cannot be negative');
    }
  }
  
  // Method (Behavior)
  void displayInfo() {
    print('Name: $name, Age: $_age');
  }
  
  // Another method
  void celebrateBirthday() {
    _age++;
    print('$name is celebrating their birthday!');
  }
}