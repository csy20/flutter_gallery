# Object-Oriented Programming (OOP) in Dart

## Table of Contents
1. [What is OOP?](#what-is-oop)
2. [Deep Dive: OOP Philosophy and How It Works](#deep-dive-oop-philosophy-and-how-it-works)
3. [Classes and Objects](#classes-and-objects)
4. [Encapsulation](#encapsulation)
5. [Inheritance](#inheritance)
6. [Polymorphism](#polymorphism)
7. [Abstraction](#abstraction)
8. [Constructors](#constructors)
9. [Getters and Setters](#getters-and-setters)
10. [Static Members](#static-members)
11. [Mixins](#mixins)
12. [Interfaces](#interfaces)
13. [Advanced OOP Concepts](#advanced-oop-concepts)

## What is OOP?

Object-Oriented Programming (OOP) is a programming paradigm that organizes code around objects and classes rather than functions and logic. It helps in creating modular, reusable, and maintainable code.

The four main pillars of OOP are:
- **Encapsulation**: Bundling data and methods together
- **Inheritance**: Creating new classes based on existing ones
- **Polymorphism**: Objects of different types responding to the same interface
- **Abstraction**: Hiding complex implementation details

## Deep Dive: OOP Philosophy and How It Works

### 🎯 The Fundamental Philosophy of OOP

Object-Oriented Programming is more than just a programming technique—it's a way of thinking about and modeling the real world in code. The core philosophy revolves around several key concepts:

#### 1. **Modeling Real-World Entities**
OOP encourages us to think of software as a collection of objects that interact with each other, similar to how objects in the real world interact.

```dart
// Real world: A Car has properties (color, model) and behaviors (start, stop, accelerate)
class Car {
  String color;
  String model;
  bool isRunning = false;
  
  Car(this.color, this.model);
  
  void start() {
    isRunning = true;
    print('$color $model is now running');
  }
  
  void stop() {
    isRunning = false;
    print('$color $model has stopped');
  }
  
  void accelerate() {
    if (isRunning) {
      print('$color $model is accelerating');
    } else {
      print('Cannot accelerate - car is not running');
    }
  }
}
```

#### 2. **Separation of Concerns**
Each object should have a single, well-defined responsibility. This makes code easier to understand, test, and maintain.

```dart
// Bad: God class doing everything
class BadUserManager {
  void createUser() { /* ... */ }
  void deleteUser() { /* ... */ }
  void sendEmail() { /* ... */ }
  void generateReport() { /* ... */ }
  void backupDatabase() { /* ... */ }
  void processPayment() { /* ... */ }
}

// Good: Separated concerns
class User {
  String name;
  String email;
  User(this.name, this.email);
}

class UserRepository {
  void save(User user) { /* ... */ }
  void delete(User user) { /* ... */ }
  User? findById(String id) { /* ... */ }
}

class EmailService {
  void sendWelcomeEmail(User user) { /* ... */ }
  void sendPasswordReset(User user) { /* ... */ }
}

class PaymentProcessor {
  void processPayment(double amount) { /* ... */ }
}
```

#### 3. **Information Hiding and Encapsulation**
The internal workings of an object should be hidden from the outside world. Only the necessary interface should be exposed.

```dart
class BankAccount {
  String _accountNumber;
  double _balance;
  List<String> _transactionHistory = [];
  
  BankAccount(this._accountNumber, [this._balance = 0.0]);
  
  // Public interface
  double get balance => _balance;
  
  bool withdraw(double amount) {
    if (_isValidWithdrawal(amount)) {
      _balance -= amount;
      _recordTransaction('Withdrawal: -\$${amount.toStringAsFixed(2)}');
      return true;
    }
    return false;
  }
  
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      _recordTransaction('Deposit: +\$${amount.toStringAsFixed(2)}');
    }
  }
  
  // Private implementation details
  bool _isValidWithdrawal(double amount) {
    return amount > 0 && amount <= _balance && _balance >= 0;
  }
  
  void _recordTransaction(String transaction) {
    _transactionHistory.add('${DateTime.now()}: $transaction');
  }
  
  void _auditTransaction() {
    // Complex audit logic hidden from outside
    print('Performing security audit...');
  }
}
```

### 🔄 How OOP Works: The Mechanics

#### 1. **Classes as Blueprints**
A class is like a blueprint or template that defines what an object will look like and how it will behave.

```dart
// Class = Blueprint
class Smartphone {
  // Properties (What it has)
  String brand;
  String model;
  double screenSize;
  int storageGB;
  double batteryLevel;
  bool isOn = false;
  
  // Constructor (How to create it)
  Smartphone(this.brand, this.model, this.screenSize, this.storageGB, {this.batteryLevel = 100.0});
  
  // Methods (What it can do)
  void turnOn() {
    if (batteryLevel > 0) {
      isOn = true;
      print('$brand $model is now on');
    } else {
      print('Cannot turn on - battery dead');
    }
  }
  
  void turnOff() {
    isOn = false;
    print('$brand $model is now off');
  }
  
  void makeCall(String number) {
    if (isOn && batteryLevel > 5) {
      batteryLevel -= 5;
      print('Calling $number from $brand $model');
    } else {
      print('Cannot make call - phone off or low battery');
    }
  }
  
  void charge(double amount) {
    batteryLevel = (batteryLevel + amount).clamp(0, 100);
    print('$brand $model charged to ${batteryLevel.toStringAsFixed(1)}%');
  }
}

void demonstrateClassAsBlueprint() {
  // Creating objects from the blueprint
  Smartphone iPhone = Smartphone('Apple', 'iPhone 15', 6.1, 128);
  Smartphone samsung = Smartphone('Samsung', 'Galaxy S24', 6.2, 256);
  Smartphone pixel = Smartphone('Google', 'Pixel 8', 6.0, 128, batteryLevel: 50);
  
  // Each object is independent
  iPhone.turnOn();
  samsung.turnOn();
  pixel.charge(30);
  
  iPhone.makeCall('123-456-7890');
  samsung.makeCall('987-654-3210');
  
  print('iPhone battery: ${iPhone.batteryLevel}%');
  print('Samsung battery: ${samsung.batteryLevel}%');
  print('Pixel battery: ${pixel.batteryLevel}%');
}
```

#### 2. **Objects as Instances**
Objects are actual instances created from classes, each with their own state and behavior.

```dart
class Counter {
  int _count = 0;
  String name;
  
  Counter(this.name);
  
  void increment() {
    _count++;
    print('$name: Count = $_count');
  }
  
  void decrement() {
    _count--;
    print('$name: Count = $_count');
  }
  
  void reset() {
    _count = 0;
    print('$name: Reset to 0');
  }
  
  int get value => _count;
}

void demonstrateObjectIndependence() {
  // Each object has its own state
  Counter counter1 = Counter('Counter A');
  Counter counter2 = Counter('Counter B');
  Counter counter3 = Counter('Counter C');
  
  // Operations on one object don't affect others
  counter1.increment();
  counter1.increment();
  counter1.increment();
  
  counter2.increment();
  counter2.decrement();
  
  counter3.increment();
  counter3.increment();
  counter3.increment();
  counter3.increment();
  counter3.reset();
  
  print('Final values:');
  print('Counter A: ${counter1.value}');
  print('Counter B: ${counter2.value}');
  print('Counter C: ${counter3.value}');
}
```

#### 3. **Message Passing and Method Invocation**
Objects communicate by sending messages to each other (calling methods).

```dart
class Customer {
  String name;
  String email;
  double accountBalance;
  
  Customer(this.name, this.email, this.accountBalance);
  
  void receiveNotification(String message) {
    print('$name received: $message');
  }
  
  bool canAfford(double amount) {
    return accountBalance >= amount;
  }
  
  void deductAmount(double amount) {
    accountBalance -= amount;
    print('$name\'s new balance: \$${accountBalance.toStringAsFixed(2)}');
  }
}

class Product {
  String name;
  double price;
  int stock;
  
  Product(this.name, this.price, this.stock);
  
  bool isAvailable() => stock > 0;
  
  void reduceStock() {
    if (stock > 0) {
      stock--;
      print('$name stock reduced to $stock');
    }
  }
}

class NotificationService {
  void sendOrderConfirmation(Customer customer, Product product) {
    customer.receiveNotification('Order confirmed for ${product.name}');
  }
  
  void sendOutOfStockAlert(Customer customer, Product product) {
    customer.receiveNotification('Sorry, ${product.name} is out of stock');
  }
}

class OrderProcessor {
  NotificationService _notificationService = NotificationService();
  
  void processOrder(Customer customer, Product product) {
    print('\n--- Processing order for ${customer.name} ---');
    
    // Check availability
    if (!product.isAvailable()) {
      _notificationService.sendOutOfStockAlert(customer, product);
      return;
    }
    
    if (!customer.canAfford(product.price)) {
      customer.receiveNotification('Insufficient funds for ${product.name}');
      return;
    }
    
    // Process the order
    customer.deductAmount(product.price);
    product.reduceStock();
    _notificationService.sendOrderConfirmation(customer, product);
  }
}

void demonstrateMessagePassing() {
  // Create objects
  Customer alice = Customer('Alice', 'alice@email.com', 150.0);
  Customer bob = Customer('Bob', 'bob@email.com', 50.0);
  
  Product laptop = Product('Gaming Laptop', 1200.0, 3);
  Product mouse = Product('Wireless Mouse', 25.0, 10);
  
  OrderProcessor processor = OrderProcessor();
  
  // Objects interact through method calls
  processor.processOrder(alice, mouse);     // Should succeed
  processor.processOrder(bob, laptop);      // Should fail - insufficient funds
  processor.processOrder(alice, laptop);    // Should fail - insufficient funds
  processor.processOrder(bob, mouse);       // Should succeed
}
```

### 🧠 The Mental Model: How to Think in OOP

#### 1. **Identify Objects and Responsibilities**
When designing a system, ask yourself:
- What are the main entities in my problem domain?
- What data does each entity hold?
- What actions can each entity perform?
- How do these entities interact?

```dart
// Example: Library Management System
// Entities: Book, Member, Library, Transaction

class Book {
  String isbn;
  String title;
  String author;
  bool isAvailable;
  
  Book(this.isbn, this.title, this.author, {this.isAvailable = true});
  
  void checkOut() {
    if (isAvailable) {
      isAvailable = false;
      print('Book "$title" checked out');
    }
  }
  
  void returnBook() {
    isAvailable = true;
    print('Book "$title" returned');
  }
}

class Member {
  String memberId;
  String name;
  List<Book> borrowedBooks = [];
  
  Member(this.memberId, this.name);
  
  void borrowBook(Book book) {
    if (book.isAvailable) {
      borrowedBooks.add(book);
      book.checkOut();
      print('$name borrowed "${book.title}"');
    } else {
      print('Book "${book.title}" is not available');
    }
  }
  
  void returnBook(Book book) {
    if (borrowedBooks.remove(book)) {
      book.returnBook();
      print('$name returned "${book.title}"');
    }
  }
}

class Library {
  String name;
  List<Book> books = [];
  List<Member> members = [];
  
  Library(this.name);
  
  void addBook(Book book) {
    books.add(book);
    print('Added "${book.title}" to $name library');
  }
  
  void registerMember(Member member) {
    members.add(member);
    print('Registered ${member.name} as member');
  }
  
  Book? findBook(String title) {
    for (Book book in books) {
      if (book.title.toLowerCase().contains(title.toLowerCase())) {
        return book;
      }
    }
    return null;
  }
  
  void displayStatus() {
    print('\n--- $name Library Status ---');
    print('Total books: ${books.length}');
    print('Available books: ${books.where((b) => b.isAvailable).length}');
    print('Total members: ${members.length}');
  }
}
```

#### 2. **Design for Change and Extension**
OOP code should be designed to handle future changes gracefully.

```dart
// Base class for different types of employees
abstract class Employee {
  String name;
  String employeeId;
  double baseSalary;
  
  Employee(this.name, this.employeeId, this.baseSalary);
  
  // Abstract method - each employee type calculates differently
  double calculateSalary();
  
  // Common behavior
  void displayInfo() {
    print('Employee: $name (ID: $employeeId)');
    print('Base Salary: \$${baseSalary.toStringAsFixed(2)}');
    print('Total Salary: \$${calculateSalary().toStringAsFixed(2)}');
  }
}

class FullTimeEmployee extends Employee {
  double benefits;
  
  FullTimeEmployee(String name, String employeeId, double baseSalary, this.benefits)
      : super(name, employeeId, baseSalary);
  
  @override
  double calculateSalary() {
    return baseSalary + benefits;
  }
}

class PartTimeEmployee extends Employee {
  int hoursWorked;
  double hourlyRate;
  
  PartTimeEmployee(String name, String employeeId, this.hoursWorked, this.hourlyRate)
      : super(name, employeeId, 0);
  
  @override
  double calculateSalary() {
    return hoursWorked * hourlyRate;
  }
}

class ContractEmployee extends Employee {
  double contractAmount;
  double completionPercentage;
  
  ContractEmployee(String name, String employeeId, this.contractAmount, this.completionPercentage)
      : super(name, employeeId, 0);
  
  @override
  double calculateSalary() {
    return contractAmount * (completionPercentage / 100);
  }
}

// Easy to add new employee types without changing existing code
class InternEmployee extends Employee {
  double stipend;
  
  InternEmployee(String name, String employeeId, this.stipend)
      : super(name, employeeId, 0);
  
  @override
  double calculateSalary() {
    return stipend;
  }
}

class PayrollSystem {
  List<Employee> employees = [];
  
  void addEmployee(Employee employee) {
    employees.add(employee);
    print('Added ${employee.name} to payroll');
  }
  
  void processPayroll() {
    print('\n--- Processing Payroll ---');
    double totalPayroll = 0;
    
    for (Employee employee in employees) {
      employee.displayInfo();
      totalPayroll += employee.calculateSalary();
      print('---');
    }
    
    print('Total Payroll: \$${totalPayroll.toStringAsFixed(2)}');
  }
}
```

#### 3. **Composition vs Inheritance**
Understanding when to use "has-a" vs "is-a" relationships.

```dart
// Composition (has-a relationship)
class Engine {
  String type;
  int horsepower;
  bool isRunning = false;
  
  Engine(this.type, this.horsepower);
  
  void start() {
    isRunning = true;
    print('$type engine started (${horsepower}HP)');
  }
  
  void stop() {
    isRunning = false;
    print('$type engine stopped');
  }
}

class GPS {
  String currentLocation = 'Unknown';
  
  void updateLocation(String location) {
    currentLocation = location;
    print('GPS: Location updated to $location');
  }
  
  String getDirections(String destination) {
    return 'Directions from $currentLocation to $destination';
  }
}

class SoundSystem {
  bool isOn = false;
  int volume = 0;
  
  void turnOn() {
    isOn = true;
    print('Sound system turned on');
  }
  
  void turnOff() {
    isOn = false;
    print('Sound system turned off');
  }
  
  void setVolume(int level) {
    volume = level.clamp(0, 100);
    print('Volume set to $volume');
  }
}

// Car HAS-A engine, GPS, and sound system
class Vehicle {
  String brand;
  String model;
  Engine engine;
  GPS? gps;
  SoundSystem? soundSystem;
  
  Vehicle(this.brand, this.model, this.engine, {this.gps, this.soundSystem});
  
  void start() {
    print('Starting $brand $model');
    engine.start();
    gps?.updateLocation('Garage');
  }
  
  void stop() {
    print('Stopping $brand $model');
    engine.stop();
    soundSystem?.turnOff();
  }
  
  void navigateTo(String destination) {
    if (gps != null) {
      print(gps!.getDirections(destination));
    } else {
      print('No GPS available');
    }
  }
  
  void playMusic() {
    if (soundSystem != null) {
      soundSystem!.turnOn();
      soundSystem!.setVolume(50);
      print('Playing music...');
    } else {
      print('No sound system available');
    }
  }
}

void demonstrateComposition() {
  // Create components
  Engine v8Engine = Engine('V8', 450);
  GPS garmin = GPS();
  SoundSystem bose = SoundSystem();
  
  // Compose the car
  Vehicle luxuryCar = Vehicle('BMW', 'X5', v8Engine, gps: garmin, soundSystem: bose);
  Vehicle basicCar = Vehicle('Honda', 'Civic', Engine('4-cylinder', 180));
  
  print('--- Luxury Car ---');
  luxuryCar.start();
  luxuryCar.playMusic();
  luxuryCar.navigateTo('Shopping Mall');
  luxuryCar.stop();
  
  print('\n--- Basic Car ---');
  basicCar.start();
  basicCar.playMusic();  // No sound system
  basicCar.navigateTo('Office');  // No GPS
  basicCar.stop();
}
```

### 🔍 Why OOP Works: The Benefits

#### 1. **Modularity and Reusability**
```dart
// Reusable validation component
class Validator {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone);
  }
  
  static bool isValidPassword(String password) {
    return password.length >= 8 && 
           RegExp(r'[A-Z]').hasMatch(password) &&
           RegExp(r'[a-z]').hasMatch(password) &&
           RegExp(r'[0-9]').hasMatch(password);
  }
}

// Can be used in multiple forms
class UserRegistrationForm {
  String email = '';
  String phone = '';
  String password = '';
  
  bool validate() {
    if (!Validator.isValidEmail(email)) {
      print('Invalid email format');
      return false;
    }
    
    if (!Validator.isValidPhone(phone)) {
      print('Invalid phone format');
      return false;
    }
    
    if (!Validator.isValidPassword(password)) {
      print('Password must be at least 8 characters with uppercase, lowercase, and number');
      return false;
    }
    
    return true;
  }
}

class ContactForm {
  String email = '';
  String phone = '';
  
  bool validate() {
    return Validator.isValidEmail(email) && Validator.isValidPhone(phone);
  }
}
```

#### 2. **Maintainability and Extensibility**
```dart
// Easy to maintain and extend
abstract class PaymentMethod {
  String name;
  PaymentMethod(this.name);
  
  bool processPayment(double amount);
  void refund(double amount);
}

class CreditCard extends PaymentMethod {
  String cardNumber;
  String expiryDate;
  
  CreditCard(this.cardNumber, this.expiryDate) : super('Credit Card');
  
  @override
  bool processPayment(double amount) {
    print('Processing \$${amount.toStringAsFixed(2)} via Credit Card');
    // Credit card processing logic
    return true;
  }
  
  @override
  void refund(double amount) {
    print('Refunding \$${amount.toStringAsFixed(2)} to Credit Card');
  }
}

class PayPal extends PaymentMethod {
  String email;
  
  PayPal(this.email) : super('PayPal');
  
  @override
  bool processPayment(double amount) {
    print('Processing \$${amount.toStringAsFixed(2)} via PayPal');
    // PayPal processing logic
    return true;
  }
  
  @override
  void refund(double amount) {
    print('Refunding \$${amount.toStringAsFixed(2)} to PayPal account');
  }
}

// Easy to add new payment methods
class BankTransfer extends PaymentMethod {
  String accountNumber;
  String routingNumber;
  
  BankTransfer(this.accountNumber, this.routingNumber) : super('Bank Transfer');
  
  @override
  bool processPayment(double amount) {
    print('Processing \$${amount.toStringAsFixed(2)} via Bank Transfer');
    return true;
  }
  
  @override
  void refund(double amount) {
    print('Refunding \$${amount.toStringAsFixed(2)} via Bank Transfer');
  }
}

class PaymentProcessor {
  static bool processPayment(PaymentMethod method, double amount) {
    print('--- Payment Processing ---');
    print('Method: ${method.name}');
    return method.processPayment(amount);
  }
  
  static void processRefund(PaymentMethod method, double amount) {
    print('--- Refund Processing ---');
    print('Method: ${method.name}');
    method.refund(amount);
  }
}
```

### 🎯 Key Takeaways: The OOP Mindset

1. **Think in Terms of Objects**: Break down problems into entities with properties and behaviors
2. **Design for the Future**: Code should be extensible and maintainable
3. **Hide Implementation Details**: Expose only what's necessary through clean interfaces
4. **Favor Composition**: Use "has-a" relationships for flexibility
5. **Use Inheritance Wisely**: Use "is-a" relationships for true specialization
6. **Single Responsibility**: Each class should have one reason to change
7. **Message Passing**: Objects should communicate through well-defined interfaces

### 🚀 Complete Working Example: E-commerce System

```dart
// A complete example demonstrating all OOP concepts
class Product {
  String id;
  String name;
  double price;
  String category;
  int stock;
  
  Product(this.id, this.name, this.price, this.category, this.stock);
  
  bool isAvailable() => stock > 0;
  
  void reduceStock(int quantity) {
    stock = (stock - quantity).clamp(0, stock);
  }
  
  @override
  String toString() => '$name (\$${price.toStringAsFixed(2)}) - Stock: $stock';
}

class ShoppingCart {
  Map<Product, int> _items = {};
  
  void addItem(Product product, int quantity) {
    if (product.isAvailable() && quantity <= product.stock) {
      _items[product] = (_items[product] ?? 0) + quantity;
      print('Added ${quantity}x ${product.name} to cart');
    } else {
      print('Cannot add ${product.name} - insufficient stock');
    }
  }
  
  void removeItem(Product product) {
    if (_items.remove(product) != null) {
      print('Removed ${product.name} from cart');
    }
  }
  
  double getTotal() {
    return _items.entries
        .map((entry) => entry.key.price * entry.value)
        .fold(0, (sum, price) => sum + price);
  }
  
  Map<Product, int> get items => Map.unmodifiable(_items);
  
  void clear() {
    _items.clear();
    print('Cart cleared');
  }
}

abstract class User {
  String id;
  String name;
  String email;
  
  User(this.id, this.name, this.email);
  
  void displayInfo();
}

class Customer extends User {
  ShoppingCart cart = ShoppingCart();
  List<Order> orderHistory = [];
  
  Customer(String id, String name, String email) : super(id, name, email);
  
  @override
  void displayInfo() {
    print('Customer: $name ($email)');
    print('Cart total: \$${cart.getTotal().toStringAsFixed(2)}');
    print('Order history: ${orderHistory.length} orders');
  }
  
  void addToCart(Product product, int quantity) {
    cart.addItem(product, quantity);
  }
  
  Order? checkout(PaymentMethod paymentMethod) {
    if (cart.items.isEmpty) {
      print('Cart is empty');
      return null;
    }
    
    Order order = Order(
      'ORD${DateTime.now().millisecondsSinceEpoch}',
      this,
      Map.from(cart.items),
      paymentMethod
    );
    
    if (order.process()) {
      orderHistory.add(order);
      cart.clear();
      return order;
    }
    
    return null;
  }
}

class Order {
  String orderId;
  Customer customer;
  Map<Product, int> items;
  PaymentMethod paymentMethod;
  DateTime orderDate;
  OrderStatus status = OrderStatus.pending;
  
  Order(this.orderId, this.customer, this.items, this.paymentMethod)
      : orderDate = DateTime.now();
  
  double getTotal() {
    return items.entries
        .map((entry) => entry.key.price * entry.value)
        .fold(0, (sum, price) => sum + price);
  }
  
  bool process() {
    print('\n--- Processing Order $orderId ---');
    
    // Check availability
    for (var entry in items.entries) {
      if (entry.value > entry.key.stock) {
        print('Order failed: Insufficient stock for ${entry.key.name}');
        status = OrderStatus.failed;
        return false;
      }
    }
    
    // Process payment
    if (PaymentProcessor.processPayment(paymentMethod, getTotal())) {
      // Update stock
      for (var entry in items.entries) {
        entry.key.reduceStock(entry.value);
      }
      
      status = OrderStatus.confirmed;
      print('Order $orderId confirmed for ${customer.name}');
      print('Total: \$${getTotal().toStringAsFixed(2)}');
      return true;
    }
    
    status = OrderStatus.failed;
    return false;
  }
}

enum OrderStatus { pending, confirmed, shipped, delivered, failed }

void demonstrateCompleteOOPSystem() {
  print('=== Complete E-commerce System Demo ===');
  
  // Create products
  Product laptop = Product('P001', 'Gaming Laptop', 1299.99, 'Electronics', 5);
  Product mouse = Product('P002', 'Wireless Mouse', 29.99, 'Electronics', 20);
  Product keyboard = Product('P003', 'Mechanical Keyboard', 89.99, 'Electronics', 15);
  
  // Create customer
  Customer alice = Customer('C001', 'Alice Johnson', 'alice@example.com');
  
  // Create payment method
  PaymentMethod creditCard = CreditCard('**** **** **** 1234', '12/25');
  
  // Shopping experience
  alice.addToCart(laptop, 1);
  alice.addToCart(mouse, 2);
  alice.addToCart(keyboard, 1);
  
  alice.displayInfo();
  
  // Checkout
  Order? order = alice.checkout(creditCard);
  
  if (order != null) {
    print('\nOrder placed successfully!');
    alice.displayInfo();
    
    // Show updated stock
    print('\nUpdated inventory:');
    print(laptop);
    print(mouse);
    print(keyboard);
  }
}
```