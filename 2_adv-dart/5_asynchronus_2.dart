// UNDERSTANDING FUTURES IN DART
// ===========================

/*
 * A Future in Dart represents a value or error that will be available 
 * at some time in the future. It's Dart's way of handling asynchronous operations.
 */

import 'dart:async';

void main() {
  print('=== FUTURES DEMONSTRATION ===\n');
  
  // SECTION 1: BASIC FUTURE CONCEPTS
  print('--- BASIC FUTURE CONCEPTS ---');
  basicFutureConcepts();
  
  // SECTION 2: CREATING FUTURES
  print('\n--- CREATING FUTURES ---');
  creatingFutures();
  
  // SECTION 3: CHAINING FUTURES
  print('\n--- CHAINING FUTURES ---');
  chainingFutures();
  
  // SECTION 4: HANDLING ERRORS
  print('\n--- HANDLING ERRORS ---');
  errorHandling();
  
  // SECTION 5: FUTURE TRANSFORMATIONS
  print('\n--- FUTURE TRANSFORMATIONS ---');
  futureTransformations();
  
  // SECTION 6: FUTURE COMPLETION
  print('\n--- FUTURE COMPLETION ---');
  futureCompletion();
  
  print('\nMain function execution completed.');
  print('Note: Asynchronous operations may still be running...');
}

// SECTION 1: BASIC FUTURE CONCEPTS
void basicFutureConcepts() {
  print('Futures represent values that will be available in the future.');
  
  // Creating a simple future
  Future<String> myFuture = Future<String>.delayed(
    Duration(seconds: 2),
    () => 'Future completed after 2 seconds',
  );
  
  // Future is pending at this point
  print('Future status: pending');
  
  // Registering a callback to execute when the future completes
  myFuture.then((value) {
    print('Future completed with value: $value');
  });
  
  print('Code after future continues to execute immediately');
}

// SECTION 2: CREATING FUTURES
void creatingFutures() {
  // Method 1: Using Future constructor
  Future<String> future1 = Future<String>(() {
    // This runs asynchronously
    return 'Future created with constructor';
  });
  future1.then(print);
  
  // Method 2: Using Future.value for immediate values
  Future<int> future2 = Future.value(42);
  future2.then((value) => print('Future.value: $value'));
  
  // Method 3: Using Future.delayed for delayed execution
  Future<String> future3 = Future.delayed(
    Duration(seconds: 1),
    () => 'Future.delayed completed',
  );
  future3.then(print);
  
  // Method 4: Using Future.microtask for execution in microtask queue
  Future<String> future4 = Future.microtask(
    () => 'Future.microtask executed',
  );
  future4.then(print);
  
  // Method 5: Creating a Completer for manual future completion
  final completer = Completer<String>();
  Future<String> future5 = completer.future;
  future5.then(print);
  
  // Complete the future after a delay
  Future.delayed(Duration(milliseconds: 1500), () {
    completer.complete('Future completed via Completer');
  });
}

// SECTION 3: CHAINING FUTURES
void chainingFutures() {
  // Starting with a simple future
  Future<int> future = Future.value(1);
  
  // Chaining multiple operations with then()
  future
    .then((value) {
      print('First then: $value');
      return value + 1;  // Returns a new Future<int>
    })
    .then((value) {
      print('Second then: $value');
      // Let's return a different type
      return 'Value: $value';  // Returns a Future<String>
    })
    .then((value) {
      print('Third then: $value');
      // Returning a Future from a then() callback
      return Future.delayed(
        Duration(milliseconds: 500),
        () => 'Delayed $value',
      );
    })
    .then((value) => print('Fourth then: $value'));
}

// SECTION 4: HANDLING ERRORS
void errorHandling() {
  // Creating a future that completes with an error
  Future<String> errorFuture = Future.delayed(
    Duration(milliseconds: 300),
    () => throw Exception('Something went wrong!'),
  );
  
  // Method 1: Using catchError
  errorFuture
    .then((value) => print('This won\'t execute'))
    .catchError((error) => print('Caught error: $error'));
  
  // Method 2: Using onError parameter of then()
  Future.delayed(
    Duration(milliseconds: 600),
    () => throw Exception('Another error!'),
  ).then(
    (value) => print('This won\'t execute'),
    onError: (error) => print('onError caught: $error'),
  );
  
  // Method 3: try-catch with async/await
  handleErrorWithAsyncAwait();
  
  // Method 4: Recovering from errors
  Future.error('Initial error')
    .catchError((error) {
      print('Recovering from: $error');
      return 'Recovered value';  // This becomes the new future value
    })
    .then((value) => print('After recovery: $value'));
}

// Helper for Method 3 of error handling
Future<void> handleErrorWithAsyncAwait() async {
  try {
    await Future.delayed(
      Duration(milliseconds: 900),
      () => throw Exception('Error in async function'),
    );
    print('This won\'t execute after error');
  } catch (e) {
    print('try-catch caught: $e');
  }
}

// SECTION 5: FUTURE TRANSFORMATIONS
void futureTransformations() {
  Future<int> initialFuture = Future.value(10);
  
  // Using timeout to limit waiting time
  initialFuture
    .timeout(
      Duration(milliseconds: 500),
      onTimeout: () => -1,  // Fallback value on timeout
    )
    .then((value) => print('After timeout: $value'));
  
  // Mapping a future to a different type
  Future<String> mappedFuture = initialFuture.then((value) => 'Number: $value');
  mappedFuture.then((value) => print('Mapped future: $value'));
  
  // Adding a delay before accessing the value
  Future.value('Delayed access')
    .delayed(Duration(milliseconds: 1200))
    .then((value) => print('$value after delay'));
}

// SECTION 6: FUTURE COMPLETION
void futureCompletion() {
  final completer = Completer<String>();
  Future<String> future = completer.future;
  
  // Register callbacks
  future.then((value) => print('Future completed with: $value'));
  
  // Simulate async operation
  Future.delayed(Duration(milliseconds: 800), () {
    // Complete the future with a value
    if (!completer.isCompleted) {
      completer.complete('Success result');
    }
  });
  
  // You can also complete with an error
  final errorCompleter = Completer<String>();
  errorCompleter.future.catchError((error) => print('Completer error: $error'));
  
  Future.delayed(Duration(milliseconds: 1000), () {
    errorCompleter.completeError('Something failed');
  });
  
  // whenComplete executes regardless of success or failure
  Future.value(42)
    .then((value) => print('Value before whenComplete: $value'))
    .whenComplete(() => print('whenComplete executed'))
    .then((value) => print('Value after whenComplete: $value'));
}

/*
 * KEY CONCEPTS ABOUT FUTURES:
 * 
 * 1. A Future represents a value that will be available later
 * 
 * 2. Futures operate in two states:
 *    - Uncompleted: The future is waiting for a value or error
 *    - Completed: The future has a value or an error
 * 
 * 3. You can interact with Futures using:
 *    - .then() to handle the value when it's available
 *    - .catchError() to handle errors
 *    - async/await syntax for more readable asynchronous code
 * 
 * 4. Futures are used extensively in Dart for:
 *    - File I/O
 *    - Network requests
 *    - Database operations
 *    - Any operation that might take time to complete
 * 
 * 5. Future<void> is used when you don't need to return a value but 
 *    want to indicate when the operation is complete
 */