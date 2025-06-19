# Asynchronous Programming in Dart

## Table of Contents
1. [What is Asynchronous Programming?](#what-is-asynchronous-programming)
2. [Understanding the Event Loop](#understanding-the-event-loop)
3. [Futures](#futures)
4. [Async and Await](#async-and-await)
5. [Streams](#streams)
6. [Stream Controllers](#stream-controllers)
7. [Error Handling in Async Code](#error-handling-in-async-code)
8. [Isolates](#isolates)
9. [Advanced Async Patterns](#advanced-async-patterns)
10. [Best Practices](#best-practices)

## What is Asynchronous Programming?

Asynchronous programming allows your program to perform multiple operations simultaneously without blocking the main thread. Instead of waiting for long-running operations (like network requests, file I/O, or database queries) to complete before moving to the next line of code, asynchronous programming lets your program continue executing other code while these operations run in the background.

### Key Benefits:
- **Non-blocking**: UI remains responsive during long operations
- **Efficiency**: Better resource utilization
- **Scalability**: Handle multiple operations concurrently
- **User Experience**: Smooth, responsive applications

### Synchronous vs Asynchronous Example:

```dart
// ❌ SYNCHRONOUS (Blocking)
void synchronousExample() {
  print('Starting operation...');
  
  // This blocks for 3 seconds - nothing else can happen
  sleep(Duration(seconds: 3));
  
  print('Operation completed');
  print('This runs after the delay');
}

// ✅ ASYNCHRONOUS (Non-blocking)
Future<void> asynchronousExample() async {
  print('Starting operation...');
  
  // This doesn't block - other code can run
  await Future.delayed(Duration(seconds: 3));
  
  print('Operation completed');
  print('This runs after the delay');
}

void demonstrateAsyncBenefit() async {
  print('=== Async Benefit Demo ===');
  
  // Start multiple async operations simultaneously
  Future<String> task1 = simulateNetworkCall('API 1', 2);
  Future<String> task2 = simulateNetworkCall('API 2', 3);
  Future<String> task3 = simulateNetworkCall('API 3', 1);
  
  print('All tasks started simultaneously...');
  
  // Wait for all to complete
  List<String> results = await Future.wait([task1, task2, task3]);
  
  print('All tasks completed:');
  for (String result in results) {
    print('  $result');
  }
}

Future<String> simulateNetworkCall(String apiName, int seconds) async {
  print('Starting $apiName request...');
  await Future.delayed(Duration(seconds: seconds));
  return '$apiName response received in ${seconds}s';
}
```

## Understanding the Event Loop

Dart runs on a single thread with an event loop that manages asynchronous operations. Understanding this is crucial for effective async programming.

### Event Loop Components:

1. **Call Stack**: Executes synchronous code
2. **Event Queue**: Holds completed async operations
3. **Microtask Queue**: High-priority tasks (Futures, scheduleMicrotask)

```dart
void demonstrateEventLoop() {
  print('=== Event Loop Demo ===');
  
  print('1. Synchronous start');
  
  // Microtask - high priority
  scheduleMicrotask(() => print('4. Microtask executed'));
  
  // Future - lower priority than microtask
  Future(() => print('6. Future from event queue'));
  
  // Timer - goes to event queue
  Timer(Duration.zero, () => print('7. Timer callback'));
  
  // Another microtask
  Future.microtask(() => print('5. Another microtask'));
  
  print('2. Synchronous middle');
  
  // Immediate Future
  Future.value('result').then((value) => print('8. Future.value: $value'));
  
  print('3. Synchronous end');
  
  // Output order:
  // 1. Synchronous start
  // 2. Synchronous middle  
  // 3. Synchronous end
  // 4. Microtask executed
  // 5. Another microtask
  // 6. Future from event queue
  // 7. Timer callback
  // 8. Future.value: result
}
```

## Futures

A `Future` represents a potential value or error that will be available at some time in the future. It's the foundation of async programming in Dart.

### Future States:
- **Uncompleted**: Operation is still running
- **Completed with value**: Operation succeeded
- **Completed with error**: Operation failed

```dart
// Basic Future creation and handling
void demonstrateFutureBasics() {
  print('=== Future Basics ===');
  
  // Creating Futures
  Future<String> simpleFuture = Future.value('Hello Future!');
  Future<String> delayedFuture = Future.delayed(
    Duration(seconds: 2), 
    () => 'Delayed result'
  );
  Future<int> errorFuture = Future.error('Something went wrong');
  
  // Handling Futures with .then()
  simpleFuture.then((value) => print('Simple: $value'));
  
  delayedFuture
    .then((value) => print('Delayed: $value'))
    .catchError((error) => print('Error: $error'));
  
  errorFuture
    .then((value) => print('Success: $value'))
    .catchError((error) => print('Caught error: $error'));
  
  // Chaining Futures
  Future.value(10)
    .then((value) => value * 2)
    .then((value) => value + 5)
    .then((value) => print('Chained result: $value')); // Output: 25
}

// Complex Future operations
Future<void> demonstrateComplexFutures() async {
  print('=== Complex Future Operations ===');
  
  // Multiple Futures with Future.wait
  List<Future<String>> futures = [
    fetchUserData('user1'),
    fetchUserData('user2'),
    fetchUserData('user3'),
  ];
  
  try {
    List<String> results = await Future.wait(futures);
    print('All users fetched:');
    results.forEach(print);
  } catch (e) {
    print('Error fetching users: $e');
  }
  
  // Timeout handling
  try {
    String result = await fetchDataWithTimeout().timeout(
      Duration(seconds: 3),
      onTimeout: () => 'Default value due to timeout',
    );
    print('Result with timeout: $result');
  } catch (e) {
    print('Timeout error: $e');
  }
  
  // Future.any - first to complete
  List<Future<String>> competingFutures = [
    simulateSlowNetwork('Server 1', 5),
    simulateSlowNetwork('Server 2', 2),
    simulateSlowNetwork('Server 3', 7),
  ];
  
  String fastest = await Future.any(competingFutures);
  print('Fastest response: $fastest');
}

Future<String> fetchUserData(String userId) async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'User data for $userId';
}

Future<String> fetchDataWithTimeout() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Data fetched successfully';
}

Future<String> simulateSlowNetwork(String server, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return 'Response from $server';
}

// Future completion and error handling patterns
Future<void> demonstrateFuturePatterns() async {
  print('=== Future Patterns ===');
  
  // Completer for manual Future control
  Completer<String> completer = Completer<String>();
  
  // Simulate async operation that completes the Future manually
  Timer(Duration(seconds: 2), () {
    if (DateTime.now().millisecond % 2 == 0) {
      completer.complete('Success!');
    } else {
      completer.completeError('Failed!');
    }
  });
  
  try {
    String result = await completer.future;
    print('Completer result: $result');
  } catch (e) {
    print('Completer error: $e');
  }
  
  // Future.forEach for sequential processing
  List<int> numbers = [1, 2, 3, 4, 5];
  await Future.forEach(numbers, (int number) async {
    await Future.delayed(Duration(milliseconds: 500));
    print('Processed number: $number');
  });
  
  // Future.doWhile for conditional loops
  int counter = 0;
  await Future.doWhile(() async {
    await Future.delayed(Duration(milliseconds: 300));
    counter++;
    print('Counter: $counter');
    return counter < 3; // Continue while counter < 3
  });
}
```

## Async and Await

The `async` and `await` keywords provide a more readable way to work with Futures, making asynchronous code look similar to synchronous code.

### Key Rules:
- Functions marked with `async` return a `Future`
- `await` can only be used inside `async` functions
- `await` pauses execution until the Future completes

```dart
// Basic async/await usage
Future<void> demonstrateAsyncAwait() async {
  print('=== Async/Await Demo ===');
  
  // Sequential execution
  print('Starting sequential operations...');
  String result1 = await simulateAsyncOperation('Operation 1', 1);
  String result2 = await simulateAsyncOperation('Operation 2', 2);
  String result3 = await simulateAsyncOperation('Operation 3', 1);
  
  print('Sequential results:');
  print('  $result1');
  print('  $result2');
  print('  $result3');
  
  // Parallel execution
  print('\nStarting parallel operations...');
  List<Future<String>> parallelFutures = [
    simulateAsyncOperation('Parallel 1', 1),
    simulateAsyncOperation('Parallel 2', 2),
    simulateAsyncOperation('Parallel 3', 1),
  ];
  
  List<String> parallelResults = await Future.wait(parallelFutures);
  print('Parallel results:');
  parallelResults.forEach((result) => print('  $result'));
}

Future<String> simulateAsyncOperation(String name, int seconds) async {
  print('  Starting $name...');
  await Future.delayed(Duration(seconds: seconds));
  return '$name completed in ${seconds}s';
}

// Real-world async/await examples
class ApiService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    print('Attempting login for $username...');
    
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    
    // Simulate authentication logic
    if (username == 'admin' && password == 'password') {
      return {
        'success': true,
        'token': 'jwt_token_12345',
        'user': {
          'id': 1,
          'username': username,
          'email': '$username@example.com'
        }
      };
    } else {
      throw Exception('Invalid credentials');
    }
  }
  
  Future<List<Map<String, dynamic>>> fetchUserPosts(String token) async {
    print('Fetching user posts...');
    
    await Future.delayed(Duration(seconds: 1));
    
    return [
      {'id': 1, 'title': 'First Post', 'content': 'Hello World!'},
      {'id': 2, 'title': 'Second Post', 'content': 'Learning Dart'},
      {'id': 3, 'title': 'Third Post', 'content': 'Async Programming'},
    ];
  }
  
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    print('Fetching user profile...');
    
    await Future.delayed(Duration(seconds: 1));
    
    return {
      'name': 'John Doe',
      'avatar': 'https://example.com/avatar.jpg',
      'followers': 150,
      'following': 75
    };
  }
}

Future<void> demonstrateRealWorldAsync() async {
  print('=== Real World Async Example ===');
  
  ApiService apiService = ApiService();
  
  try {
    // Step 1: Login
    Map<String, dynamic> loginResult = await apiService.login('admin', 'password');
    print('Login successful!');
    
    String token = loginResult['token'];
    Map<String, dynamic> user = loginResult['user'];
    print('Welcome, ${user['username']}!');
    
    // Step 2: Fetch data in parallel
    print('\nFetching user data...');
    Future<List<Map<String, dynamic>>> postsFuture = apiService.fetchUserPosts(token);
    Future<Map<String, dynamic>> profileFuture = apiService.getUserProfile(token);
    
    // Wait for both operations to complete
    List<dynamic> results = await Future.wait([postsFuture, profileFuture]);
    List<Map<String, dynamic>> posts = results[0];
    Map<String, dynamic> profile = results[1];
    
    // Display results
    print('\nUser Profile:');
    print('  Name: ${profile['name']}');
    print('  Followers: ${profile['followers']}');
    print('  Following: ${profile['following']}');
    
    print('\nUser Posts:');
    for (var post in posts) {
      print('  ${post['id']}. ${post['title']}');
    }
    
  } catch (e) {
    print('Error occurred: $e');
  }
}

// Async function return types
Future<String> asyncStringFunction() async {
  await Future.delayed(Duration(seconds: 1));
  return 'String result';
}

Future<int> asyncIntFunction() async {
  await Future.delayed(Duration(seconds: 1));
  return 42;
}

Future<void> asyncVoidFunction() async {
  await Future.delayed(Duration(seconds: 1));
  print('Void async function completed');
}

// Can also return Future directly without async/await
Future<String> directFutureFunction() {
  return Future.delayed(Duration(seconds: 1), () => 'Direct future result');
}
```

## Streams

Streams provide a way to handle asynchronous data sequences. Unlike Futures that provide a single value, Streams can emit multiple values over time.

### Stream Types:
- **Single-subscription streams**: Can only be listened to once
- **Broadcast streams**: Can have multiple listeners

```dart
import 'dart:async';
import 'dart:math';

// Basic Stream usage
void demonstrateStreamBasics() {
  print('=== Stream Basics ===');
  
  // Creating streams
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  Stream<int> periodicStream = Stream.periodic(
    Duration(seconds: 1), 
    (count) => count + 1
  ).take(5);
  
  // Listening to streams
  print('Numbers from iterable:');
  numberStream.listen(
    (number) => print('  Number: $number'),
    onDone: () => print('  Number stream completed'),
    onError: (error) => print('  Error: $error'),
  );
  
  print('\nPeriodic numbers:');
  periodicStream.listen(
    (number) => print('  Periodic: $number'),
    onDone: () => print('  Periodic stream completed'),
  );
}

// Stream transformations
Future<void> demonstrateStreamTransformations() async {
  print('=== Stream Transformations ===');
  
  // Create a stream of numbers
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  
  // Map transformation
  Stream<String> mappedStream = numberStream.map((number) => 'Number: $number');
  
  // Where filtering
  Stream<int> evenNumbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .where((number) => number % 2 == 0);
  
  // Take and skip
  Stream<int> limitedStream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .skip(3)
      .take(4);
  
  print('Mapped stream:');
  await for (String value in mappedStream) {
    print('  $value');
  }
  
  print('\nEven numbers:');
  await for (int number in evenNumbers) {
    print('  $number');
  }
  
  print('\nLimited stream (skip 3, take 4):');
  await for (int number in limitedStream) {
    print('  $number');
  }
  
  // Complex transformation chain
  print('\nComplex transformation:');
  Stream<String> complexStream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      .where((n) => n % 2 == 0)           // Filter even numbers
      .map((n) => n * n)                  // Square them
      .map((n) => 'Square: $n')           // Convert to string
      .take(3);                           // Take first 3
  
  await for (String value in complexStream) {
    print('  $value');
  }
}

// Async generators for creating streams
Stream<int> generateNumbers(int count) async* {
  print('Starting number generation...');
  for (int i = 1; i <= count; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    print('Generating number $i');
    yield i;
  }
  print('Number generation completed');
}

Stream<String> generateRandomWords() async* {
  List<String> words = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
  Random random = Random();
  
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield words[random.nextInt(words.length)];
  }
}

Future<void> demonstrateAsyncGenerators() async {
  print('=== Async Generators ===');
  
  print('Generated numbers:');
  await for (int number in generateNumbers(5)) {
    print('  Received: $number');
  }
  
  print('\nRandom words:');
  await for (String word in generateRandomWords()) {
    print('  Word: $word');
  }
}

// Real-world stream example: Chat application
class ChatMessage {
  final String user;
  final String message;
  final DateTime timestamp;
  
  ChatMessage(this.user, this.message, this.timestamp);
  
  @override
  String toString() {
    return '[$timestamp] $user: $message';
  }
}

class ChatRoom {
  final StreamController<ChatMessage> _messageController = StreamController<ChatMessage>.broadcast();
  final List<String> _users = [];
  
  Stream<ChatMessage> get messageStream => _messageController.stream;
  
  void addUser(String username) {
    _users.add(username);
    _messageController.add(ChatMessage(
      'System', 
      '$username joined the chat', 
      DateTime.now()
    ));
  }
  
  void removeUser(String username) {
    _users.remove(username);
    _messageController.add(ChatMessage(
      'System', 
      '$username left the chat', 
      DateTime.now()
    ));
  }
  
  void sendMessage(String user, String message) {
    if (_users.contains(user)) {
      _messageController.add(ChatMessage(user, message, DateTime.now()));
    }
  }
  
  void close() {
    _messageController.close();
  }
  
  List<String> get users => List.unmodifiable(_users);
}

Future<void> demonstrateChatRoom() async {
  print('=== Chat Room Simulation ===');
  
  ChatRoom chatRoom = ChatRoom();
  
  // Listen to messages
  StreamSubscription<ChatMessage> subscription = chatRoom.messageStream.listen(
    (message) => print(message),
    onDone: () => print('Chat room closed'),
  );
  
  // Add users
  chatRoom.addUser('Alice');
  chatRoom.addUser('Bob');
  chatRoom.addUser('Charlie');
  
  // Simulate conversation
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.sendMessage('Alice', 'Hello everyone!');
  
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.sendMessage('Bob', 'Hi Alice! How are you?');
  
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.sendMessage('Charlie', 'Great to see you all here!');
  
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.sendMessage('Alice', 'I\'m doing well, thanks Bob!');
  
  // User leaves
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.removeUser('Charlie');
  
  await Future.delayed(Duration(milliseconds: 100));
  chatRoom.sendMessage('Bob', 'See you later Charlie!');
  
  // Clean up
  await Future.delayed(Duration(milliseconds: 100));
  await subscription.cancel();
  chatRoom.close();
}
```

## Stream Controllers

StreamControllers provide fine-grained control over streams, allowing you to manually add data, handle listeners, and manage stream lifecycle.

```dart
// Basic StreamController usage
Future<void> demonstrateStreamController() async {
  print('=== StreamController Demo ===');
  
  // Single-subscription controller
  StreamController<String> controller = StreamController<String>();
  
  // Listen to the stream
  StreamSubscription<String> subscription = controller.stream.listen(
    (data) => print('Received: $data'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream closed'),
  );
  
  // Add data to stream
  controller.add('Hello');
  controller.add('World');
  controller.add('from');
  controller.add('StreamController');
  
  // Add error
  controller.addError('Something went wrong!');
  
  // Add more data
  controller.add('Still working after error');
  
  // Close the stream
  await Future.delayed(Duration(milliseconds: 100));
  await controller.close();
  
  // Clean up
  await subscription.cancel();
}

// Broadcast StreamController
Future<void> demonstrateBroadcastController() async {
  print('=== Broadcast StreamController ===');
  
  StreamController<int> broadcastController = StreamController<int>.broadcast();
  
  // Multiple listeners
  StreamSubscription<int> listener1 = broadcastController.stream.listen(
    (data) => print('Listener 1: $data'),
  );
  
  StreamSubscription<int> listener2 = broadcastController.stream.listen(
    (data) => print('Listener 2: $data'),
  );
  
  StreamSubscription<int> listener3 = broadcastController.stream.listen(
    (data) => print('Listener 3: $data'),
  );
  
  // Add data - all listeners receive it
  broadcastController.add(1);
  broadcastController.add(2);
  broadcastController.add(3);
  
  // Remove one listener
  await listener2.cancel();
  print('Listener 2 removed');
  
  broadcastController.add(4);
  broadcastController.add(5);
  
  // Clean up
  await Future.delayed(Duration(milliseconds: 100));
  await listener1.cancel();
  await listener3.cancel();
  await broadcastController.close();
}

// Custom stream with StreamController
class TemperatureSensor {
  final StreamController<double> _temperatureController = StreamController<double>();
  late Timer _timer;
  final Random _random = Random();
  bool _isActive = false;
  
  Stream<double> get temperatureStream => _temperatureController.stream;
  
  void startReading() {
    if (_isActive) return;
    
    _isActive = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Simulate temperature reading (20-30 degrees with some variation)
      double temperature = 20 + (_random.nextDouble() * 10);
      _temperatureController.add(temperature);
    });
  }
  
  void stopReading() {
    if (!_isActive) return;
    
    _isActive = false;
    _timer.cancel();
  }
  
  void dispose() {
    stopReading();
    _temperatureController.close();
  }
  
  bool get isActive => _isActive;
}

Future<void> demonstrateTemperatureSensor() async {
  print('=== Temperature Sensor Simulation ===');
  
  TemperatureSensor sensor = TemperatureSensor();
  
  // Listen to temperature readings
  StreamSubscription<double> subscription = sensor.temperatureStream.listen(
    (temperature) {
      print('Temperature: ${temperature.toStringAsFixed(2)}°C');
      
      // Alert for high temperature
      if (temperature > 28) {
        print('  ⚠️  HIGH TEMPERATURE ALERT!');
      }
    },
    onDone: () => print('Temperature sensor stopped'),
  );
  
  // Start reading
  print('Starting temperature sensor...');
  sensor.startReading();
  
  // Let it run for 5 seconds
  await Future.delayed(Duration(seconds: 5));
  
  // Stop reading
  print('Stopping temperature sensor...');
  sensor.stopReading();
  
  // Clean up
  await subscription.cancel();
  sensor.dispose();
}

// StreamController with custom logic
class EventBus {
  final Map<String, StreamController<dynamic>> _controllers = {};
  
  Stream<T> on<T>(String eventType) {
    _controllers[eventType] ??= StreamController<T>.broadcast();
    return _controllers[eventType]!.stream.cast<T>();
  }
  
  void emit<T>(String eventType, T data) {
    if (_controllers.containsKey(eventType)) {
      _controllers[eventType]!.add(data);
    }
  }
  
  void dispose() {
    for (var controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
  }
}

class UserLoginEvent {
  final String username;
  final DateTime timestamp;
  
  UserLoginEvent(this.username, this.timestamp);
  
  @override
  String toString() => 'UserLoginEvent($username at $timestamp)';
}

class MessageEvent {
  final String message;
  final String sender;
  
  MessageEvent(this.message, this.sender);
  
  @override
  String toString() => 'MessageEvent("$message" from $sender)';
}

Future<void> demonstrateEventBus() async {
  print('=== Event Bus Demo ===');
  
  EventBus eventBus = EventBus();
  
  // Listen to different event types
  StreamSubscription<UserLoginEvent> loginSubscription = eventBus.on<UserLoginEvent>('user_login').listen(
    (event) => print('Login: $event'),
  );
  
  StreamSubscription<MessageEvent> messageSubscription = eventBus.on<MessageEvent>('message').listen(
    (event) => print('Message: $event'),
  );
  
  StreamSubscription<String> notificationSubscription = eventBus.on<String>('notification').listen(
    (notification) => print('Notification: $notification'),
  );
  
  // Emit events
  eventBus.emit('user_login', UserLoginEvent('alice', DateTime.now()));
  eventBus.emit('message', MessageEvent('Hello everyone!', 'alice'));
  eventBus.emit('notification', 'New user joined');
  
  await Future.delayed(Duration(milliseconds: 100));
  
  eventBus.emit('user_login', UserLoginEvent('bob', DateTime.now()));
  eventBus.emit('message', MessageEvent('Hi Alice!', 'bob'));
  eventBus.emit('notification', 'Message received');
  
  // Clean up
  await Future.delayed(Duration(milliseconds: 100));
  await loginSubscription.cancel();
  await messageSubscription.cancel();
  await notificationSubscription.cancel();
  eventBus.dispose();
}
```

## Error Handling in Async Code

Proper error handling is crucial in asynchronous programming to create robust applications.

```dart
// Basic error handling patterns
Future<void> demonstrateAsyncErrorHandling() async {
  print('=== Async Error Handling ===');
  
  // Try-catch with async/await
  try {
    String result = await riskyAsyncOperation();
    print('Success: $result');
  } catch (e) {
    print('Caught error: $e');
  } finally {
    print('Finally block executed');
  }
  
  // Future.catchError
  riskyAsyncOperation()
    .then((result) => print('Then: $result'))
    .catchError((error) => print('CatchError: $error'));
  
  // Multiple error types
  try {
    await operationWithMultipleErrorTypes();
  } on NetworkException catch (e) {
    print('Network error: ${e.message}');
  } on ValidationException catch (e) {
    print('Validation error: ${e.message}');
  } catch (e) {
    print('Unknown error: $e');
  }
}

Future<String> riskyAsyncOperation() async {
  await Future.delayed(Duration(seconds: 1));
  
  // 50% chance of success
  if (Random().nextBool()) {
    return 'Operation successful!';
  } else {
    throw Exception('Operation failed!');
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

Future<void> operationWithMultipleErrorTypes() async {
  await Future.delayed(Duration(milliseconds: 500));
  
  int random = Random().nextInt(3);
  switch (random) {
    case 0:
      throw NetworkException('Network timeout');
    case 1:
      throw ValidationException('Invalid input data');
    default:
      throw Exception('Generic error');
  }
}

// Error handling in streams
Future<void> demonstrateStreamErrorHandling() async {
  print('=== Stream Error Handling ===');
  
  StreamController<int> controller = StreamController<int>();
  
  // Listen with error handler
  StreamSubscription<int> subscription = controller.stream.listen(
    (data) => print('Data: $data'),
    onError: (error) {
      print('Stream error: $error');
      // Stream continues after error handling
    },
    onDone: () => print('Stream completed'),
  );
  
  // Add data and errors
  controller.add(1);
  controller.add(2);
  controller.addError('First error');
  controller.add(3);
  controller.addError('Second error');
  controller.add(4);
  
  await Future.delayed(Duration(milliseconds: 100));
  await controller.close();
  await subscription.cancel();
}

// Retry mechanisms
Future<String> unstableNetworkCall() async {
  await Future.delayed(Duration(seconds: 1));
  
  // 70% chance of failure
  if (Random().nextDouble() < 0.7) {
    throw NetworkException('Network request failed');
  }
  
  return 'Data retrieved successfully';
}

Future<String> retryOperation(
  Future<String> Function() operation,
  {int maxRetries = 3, Duration delay = const Duration(seconds: 1)}
) async {
  int attempts = 0;
  
  while (attempts < maxRetries) {
    try {
      attempts++;
      print('Attempt $attempts...');
      return await operation();
    } catch (e) {
      print('Attempt $attempts failed: $e');
      
      if (attempts >= maxRetries) {
        print('Max retries reached. Giving up.');
        rethrow;
      }
      
      print('Retrying in ${delay.inSeconds} seconds...');
      await Future.delayed(delay);
    }
  }
  
  throw Exception('This should never be reached');
}

Future<void> demonstrateRetryMechanism() async {
  print('=== Retry Mechanism ===');
  
  try {
    String result = await retryOperation(
      unstableNetworkCall,
      maxRetries: 5,
      delay: Duration(milliseconds: 500),
    );
    print('Final result: $result');
  } catch (e) {
    print('Operation failed after all retries: $e');
  }
}

// Timeout handling
Future<String> slowOperation() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Slow operation completed';
}

Future<void> demonstrateTimeoutHandling() async {
  print('=== Timeout Handling ===');
  
  try {
    String result = await slowOperation().timeout(
      Duration(seconds: 3),
      onTimeout: () {
        print('Operation timed out!');
        return 'Default result due to timeout';
      },
    );
    print('Result: $result');
  } on TimeoutException catch (e) {
    print('Timeout exception: $e');
  }
  
  // Alternative timeout handling
  try {
    String result = await Future.any([
      slowOperation(),
      Future.delayed(Duration(seconds: 2), () => throw TimeoutException('Custom timeout', Duration(seconds: 2))),
    ]);
    print('Result: $result');
  } on TimeoutException catch (e) {
    print('Custom timeout: $e');
  }
}
```

## Isolates

Isolates provide true parallelism in Dart by running code in separate memory spaces.

```dart
import 'dart:isolate';

// Basic isolate usage
Future<void> demonstrateIsolates() async {
  print('=== Isolates Demo ===');
  
  print('Main isolate: Starting heavy computation...');
  
  // Compute in separate isolate
  int result = await compute(heavyComputation, 1000000);
  print('Computation result: $result');
  
  // Custom isolate communication
  await demonstrateIsolateCommunication();
}

// Heavy computation function
int heavyComputation(int n) {
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}

// Complex computation for isolate
Map<String, dynamic> complexComputation(Map<String, dynamic> params) {
  int start = params['start'];
  int end = params['end'];
  String operation = params['operation'];
  
  List<int> results = [];
  
  for (int i = start; i <= end; i++) {
    switch (operation) {
      case 'square':
        results.add(i * i);
        break;
      case 'cube':
        results.add(i * i * i);
        break;
      case 'factorial':
        results.add(factorial(i));
        break;
    }
  }
  
  return {
    'results': results,
    'count': results.length,
    'sum': results.reduce((a, b) => a + b),
  };
}

int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Custom isolate with two-way communication
Future<void> demonstrateIsolateCommunication() async {
  print('=== Isolate Communication ===');
  
  // Create receive port for main isolate
  ReceivePort mainReceivePort = ReceivePort();
  
  // Spawn isolate
  Isolate isolate = await Isolate.spawn(
    isolateEntryPoint,
    mainReceivePort.sendPort,
  );
  
  // Get send port from isolate
  SendPort isolateSendPort = await mainReceivePort.first;
  
  // Create new receive port for responses
  ReceivePort responsePort = ReceivePort();
  
  // Send computation request
  isolateSendPort.send({
    'command': 'compute',
    'data': {'start': 1, 'end': 10, 'operation': 'square'},
    'responsePort': responsePort.sendPort,
  });
  
  // Wait for response
  Map<String, dynamic> response = await responsePort.first;
  print('Isolate response: $response');
  
  // Send stop command
  isolateSendPort.send({'command': 'stop'});
  
  // Clean up
  responsePort.close();
  isolate.kill();
}

// Isolate entry point
void isolateEntryPoint(SendPort mainSendPort) {
  // Create receive port for isolate
  ReceivePort isolateReceivePort = ReceivePort();
  
  // Send isolate's send port to main
  mainSendPort.send(isolateReceivePort.sendPort);
  
  // Listen for messages
  isolateReceivePort.listen((message) {
    Map<String, dynamic> msg = message as Map<String, dynamic>;
    String command = msg['command'];
    
    switch (command) {
      case 'compute':
        Map<String, dynamic> data = msg['data'];
        SendPort responsePort = msg['responsePort'];
        
        // Perform computation
        Map<String, dynamic> result = complexComputation(data);
        
        // Send response
        responsePort.send(result);
        break;
        
      case 'stop':
        isolateReceivePort.close();
        break;
    }
  });
}

// Isolate pool for multiple tasks
class IsolatePool {
  final int poolSize;
  final List<IsolateWorker> _workers = [];
  int _currentWorker = 0;
  
  IsolatePool(this.poolSize);
  
  Future<void> initialize() async {
    for (int i = 0; i < poolSize; i++) {
      IsolateWorker worker = IsolateWorker();
      await worker.initialize();
      _workers.add(worker);
    }
  }
  
  Future<T> execute<T>(T Function(dynamic) computation, dynamic data) async {
    IsolateWorker worker = _workers[_currentWorker];
    _currentWorker = (_currentWorker + 1) % poolSize;
    return await worker.execute(computation, data);
  }
  
  Future<void> dispose() async {
    for (IsolateWorker worker in _workers) {
      await worker.dispose();
    }
    _workers.clear();
  }
}

class IsolateWorker {
  Isolate? _isolate;
  SendPort? _sendPort;
  ReceivePort? _receivePort;
  int _taskId = 0;
  final Map<int, Completer> _pendingTasks = {};
  
  Future<void> initialize() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_workerEntryPoint, _receivePort!.sendPort);
    
    // Get worker's send port
    _sendPort = await _receivePort!.first;
    
    // Listen for responses
    _receivePort!.listen((message) {
      Map<String, dynamic> msg = message as Map<String, dynamic>;
      int taskId = msg['taskId'];
      dynamic result = msg['result'];
      String? error = msg['error'];
      
      Completer? completer = _pendingTasks.remove(taskId);
      if (completer != null) {
        if (error != null) {
          completer.completeError(error);
        } else {
          completer.complete(result);
        }
      }
    });
  }
  
  Future<T> execute<T>(T Function(dynamic) computation, dynamic data) async {
    if (_sendPort == null) {
      throw StateError('Worker not initialized');
    }
    
    int taskId = _taskId++;
    Completer<T> completer = Completer<T>();
    _pendingTasks[taskId] = completer;
    
    _sendPort!.send({
      'taskId': taskId,
      'computation': computation,
      'data': data,
    });
    
    return completer.future;
  }
  
  Future<void> dispose() async {
    _isolate?.kill();
    _receivePort?.close();
  }
  
  static void _workerEntryPoint(SendPort mainSendPort) {
    ReceivePort workerReceivePort = ReceivePort();
    mainSendPort.send(workerReceivePort.sendPort);
    
    workerReceivePort.listen((message) {
      Map<String, dynamic> msg = message as Map<String, dynamic>;
      int taskId = msg['taskId'];
      Function computation = msg['computation'];
      dynamic data = msg['data'];
      
      try {
        dynamic result = computation(data);
        mainSendPort.send({
          'taskId': taskId,
          'result': result,
        });
      } catch (e) {
        mainSendPort.send({
          'taskId': taskId,
          'error': e.toString(),
        });
      }
    });
  }
}
```

## Advanced Async Patterns

```dart
// Debouncing and throttling
class Debouncer {
  final Duration delay;
  Timer? _timer;
  
  Debouncer(this.delay);
  
  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
  
  void dispose() {
    _timer?.cancel();
  }
}

class Throttler {
  final Duration interval;
  DateTime? _lastExecuted;
  
  Throttler(this.interval);
  
  void call(void Function() action) {
    DateTime now = DateTime.now();
    
    if (_lastExecuted == null || 
        now.difference(_lastExecuted!) >= interval) {
      _lastExecuted = now;
      action();
    }
  }
}

Future<void> demonstrateDebounceThrottle() async {
  print('=== Debounce and Throttle ===');
  
  // Debouncer example
  Debouncer debouncer = Debouncer(Duration(milliseconds: 300));
  
  print('Debouncing rapid calls...');
  for (int i = 1; i <= 5; i++) {
    debouncer(() => print('Debounced action executed: $i'));
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  // Wait for debounced action
  await Future.delayed(Duration(milliseconds: 500));
  
  // Throttler example
  Throttler throttler = Throttler(Duration(milliseconds: 300));
  
  print('\nThrottling rapid calls...');
  for (int i = 1; i <= 5; i++) {
    throttler(() => print('Throttled action executed: $i'));
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  debouncer.dispose();
}

// Async iterator pattern
class AsyncDataProcessor {
  final List<String> _data = ['item1', 'item2', 'item3', 'item4', 'item5'];
  
  Stream<String> processData() async* {
    for (String item in _data) {
      await Future.delayed(Duration(milliseconds: 500));
      
      // Simulate processing
      String processedItem = 'Processed: $item';
      yield processedItem;
    }
  }
  
  Stream<Map<String, dynamic>> processDataWithMetadata() async* {
    for (int i = 0; i < _data.length; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      
      yield {
        'item': _data[i],
        'index': i,
        'progress': (i + 1) / _data.length,
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
}

Future<void> demonstrateAsyncIterator() async {
  print('=== Async Iterator Pattern ===');
  
  AsyncDataProcessor processor = AsyncDataProcessor();
  
  print('Processing data...');
  await for (String processed in processor.processData()) {
    print('  $processed');
  }
  
  print('\nProcessing with metadata...');
  await for (Map<String, dynamic> item in processor.processDataWithMetadata()) {
    print('  ${item['item']} - Progress: ${(item['progress'] * 100).toStringAsFixed(1)}%');
  }
}

// Circuit breaker pattern
enum CircuitState { closed, open, halfOpen }

class CircuitBreaker {
  final int failureThreshold;
  final Duration timeout;
  final Duration retryPeriod;
  
  CircuitState _state = CircuitState.closed;
  int _failureCount = 0;
  DateTime? _lastFailureTime;
  
  CircuitBreaker({
    required this.failureThreshold,
    required this.timeout,
    required this.retryPeriod,
  });
  
  Future<T> execute<T>(Future<T> Function() operation) async {
    if (_state == CircuitState.open) {
      if (DateTime.now().difference(_lastFailureTime!) < retryPeriod) {
        throw Exception('Circuit breaker is OPEN');
      } else {
        _state = CircuitState.halfOpen;
      }
    }
    
    try {
      T result = await operation().timeout(timeout);
      _onSuccess();
      return result;
    } catch (e) {
      _onFailure();
      rethrow;
    }
  }
  
  void _onSuccess() {
    _failureCount = 0;
    _state = CircuitState.closed;
  }
  
  void _onFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();
    
    if (_failureCount >= failureThreshold) {
      _state = CircuitState.open;
    }
  }
  
  CircuitState get state => _state;
  int get failureCount => _failureCount;
}

Future<String> unreliableService() async {
  await Future.delayed(Duration(milliseconds: 100));
  
  // 60% chance of failure
  if (Random().nextDouble() < 0.6) {
    throw Exception('Service temporarily unavailable');
  }
  
  return 'Service response';
}

Future<void> demonstrateCircuitBreaker() async {
  print('=== Circuit Breaker Pattern ===');
  
  CircuitBreaker circuitBreaker = CircuitBreaker(
    failureThreshold: 3,
    timeout: Duration(seconds: 2),
    retryPeriod: Duration(seconds: 5),
  );
  
  for (int i = 1; i <= 10; i++) {
    try {
      print('Attempt $i...');
      String result = await circuitBreaker.execute(unreliableService);
      print('  Success: $result');
    } catch (e) {
      print('  Failed: $e');
      print('  Circuit state: ${circuitBreaker.state}');
      print('  Failure count: ${circuitBreaker.failureCount}');
    }
    
    await Future.delayed(Duration(milliseconds: 500));
  }
}
```

## Best Practices

### 1. Always Handle Errors
```dart
// ❌ Bad: No error handling
Future<void> badExample() async {
  String result = await riskyOperation();
  print(result);
}

// ✅ Good: Proper error handling
Future<void> goodExample() async {
  try {
    String result = await riskyOperation();
    print(result);
  } catch (e) {
    print('Error: $e');
    // Handle error appropriately
  }
}
```

### 2. Use async/await Instead of .then() for Readability
```dart
// ❌ Bad: Callback hell with .then()
Future<void> badChaining() {
  return fetchUser()
    .then((user) => fetchUserPosts(user.id))
    .then((posts) => processPosts(posts))
    .then((result) => saveResult(result))
    .catchError((error) => handleError(error));
}

// ✅ Good: Clean async/await
Future<void> goodChaining() async {
  try {
    User user = await fetchUser();
    List<Post> posts = await fetchUserPosts(user.id);
    ProcessedData result = await processPosts(posts);
    await saveResult(result);
  } catch (error) {
    handleError(error);
  }
}
```

### 3. Use Future.wait() for Parallel Operations
```dart
// ❌ Bad: Sequential execution when parallel is possible
Future<void> sequentialExecution() async {
  String data1 = await fetchData1();
  String data2 = await fetchData2();
  String data3 = await fetchData3();
  // Total time: time1 + time2 + time3
}

// ✅ Good: Parallel execution
Future<void> parallelExecution() async {
  List<String> results = await Future.wait([
    fetchData1(),
    fetchData2(),
    fetchData3(),
  ]);
  // Total time: max(time1, time2, time3)
}
```

### 4. Properly Dispose Resources
```dart
// ✅ Good: Always dispose StreamControllers and subscriptions
class DataService {
  StreamController<String>? _controller;
  StreamSubscription<String>? _subscription;
  
  void initialize() {
    _controller = StreamController<String>();
    _subscription = _controller!.stream.listen(handleData);
  }
  
  void dispose() {
    _subscription?.cancel();
    _controller?.close();
  }
  
  void handleData(String data) {
    // Process data
  }
}
```

### 5. Use Timeouts for Network Operations
```dart
// ✅ Good: Always use timeouts for network calls
Future<String> fetchDataWithTimeout() async {
  try {
    return await httpClient.get(url).timeout(
      Duration(seconds: 10),
      onTimeout: () => throw TimeoutException('Request timed out'),
    );
  } on TimeoutException {
    return 'Default data';
  }
}
```

### 6. Handle Stream Errors Properly
```dart
// ✅ Good: Proper stream error handling
void listenToStream() {
  stream.listen(
    (data) => processData(data),
    onError: (error) {
      print('Stream error: $error');
      // Don't let errors crash the app
    },
    onDone: () {
      print('Stream completed');
      cleanup();
    },
  );
}
```

### Summary

Asynchronous programming in Dart provides powerful tools for building responsive, efficient applications:

- **Futures** for single async operations
- **Streams** for sequences of async data
- **async/await** for readable async code
- **Isolates** for CPU-intensive tasks
- **Error handling** for robust applications
- **Advanced patterns** for complex scenarios

Key principles:
1. Always handle errors
2. Use appropriate async patterns
3. Prefer async/await over callbacks
4. Dispose resources properly
5. Use timeouts for network operations
6. Consider performance implications

Master these concepts to build scalable, responsive Dart applications!