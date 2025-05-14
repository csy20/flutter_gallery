// ASYNC-AWAIT IN DART
// ===================

/*
 * Async-await is a way to handle asynchronous operations in Dart.
 * 
 * KEY CONCEPTS:
 * 1. Future: A value that will be available in the future
 * 2. async: Marks a function as asynchronous
 * 3. await: Pauses execution until a Future completes
 * 4. try-catch: Handles errors in asynchronous code
 */

import 'dart:async';

void main() {
  print('=== ASYNC-AWAIT DEMONSTRATION ===');
  
  // Calling an async function from main
  print('\n--- Basic async example ---');
  demoBasicAsync();
  
  // Sequential async operations with await
  print('\n--- Sequential async operations ---');
  demoSequentialAsync();
  
  // Error handling in async operations
  print('\n--- Error handling in async code ---');
  demoErrorHandling();
  
  // Parallel execution with Future.wait
  print('\n--- Parallel execution ---');
  demoParallelExecution();

  // This print executes immediately without waiting for async functions to complete
  print('\n--- Main function continues execution ---');
  print('Main execution finished, but async operations continue...');
}

// BASIC ASYNC EXAMPLE
// ==================
// This example shows how to define and use a simple async function
void demoBasicAsync() async {
  print('Starting basic async demo...');
  
  // Calling an async function with await
  String message = await fetchMessage();
  print('Fetched message: $message');
  
  // Calling the same function using Future API
  fetchMessage().then((message) {
    print('Fetched message using .then(): $message');
  });
  
  print('Basic async demo initiated!');
}

// A simple async function that returns a Future<String>
Future<String> fetchMessage() async {
  // Simulating network delay
  await Future.delayed(Duration(seconds: 2));
  return 'Hello from the future!';
}

// SEQUENTIAL ASYNC OPERATIONS
// =========================
// This example demonstrates how to perform async operations sequentially
void demoSequentialAsync() async {
  print('Starting sequential operations...');
  
  // Start timing
  DateTime startTime = DateTime.now();
  
  // Sequential execution - each await waits for completion before moving to next
  String step1 = await simulateNetworkRequest('Step 1 data', 1);
  print('Completed: $step1');
  
  String step2 = await simulateNetworkRequest('Step 2 data', 1);
  print('Completed: $step2');
  
  String step3 = await simulateNetworkRequest('Step 3 data', 1);
  print('Completed: $step3');
  
  // Calculate total time
  Duration elapsed = DateTime.now().difference(startTime);
  print('Sequential operations completed in ${elapsed.inSeconds} seconds');
}

// Simulate a network request that takes a certain time
Future<String> simulateNetworkRequest(String data, int seconds) async {
  print('Processing: $data (estimated time: ${seconds}s)');
  await Future.delayed(Duration(seconds: seconds));
  return 'Processed $data';
}

// ERROR HANDLING IN ASYNC CODE
// ===========================
// This example shows how to handle errors in async operations
void demoErrorHandling() async {
  print('Starting error handling demo...');
  
  // Using try-catch with await
  try {
    String result = await fetchWithError();
    print('This line will not execute if there is an error');
  } catch (e) {
    print('Caught error using try-catch: $e');
  } finally {
    print('Finally block always executes');
  }
  
  // Using Future API for error handling
  fetchWithError()
    .then((result) => print('Success: $result'))
    .catchError((error) => print('Caught error using catchError: $error'))
    .whenComplete(() => print('whenComplete always executes'));
}

// An async function that throws an error
Future<String> fetchWithError() async {
  await Future.delayed(Duration(seconds: 1));
  // Simulating an error in the async operation
  throw Exception('Network connection failed!');
}

// PARALLEL EXECUTION
// =================
// This example demonstrates running multiple async operations in parallel
void demoParallelExecution() async {
  print('Starting parallel execution demo...');
  
  // Start timing
  DateTime startTime = DateTime.now();
  
  // Create multiple futures without awaiting them
  Future<String> future1 = simulateNetworkRequest('Parallel request 1', 2);
  Future<String> future2 = simulateNetworkRequest('Parallel request 2', 2);
  Future<String> future3 = simulateNetworkRequest('Parallel request 3', 2);
  
  // Wait for all futures to complete
  List<String> results = await Future.wait([future1, future2, future3]);
  
  // Calculate total time
  Duration elapsed = DateTime.now().difference(startTime);
  print('All parallel operations completed in ${elapsed.inSeconds} seconds');
  print('Results: ${results.join(", ")}');
}

/*
 * SUMMARY OF ASYNC-AWAIT
 * ======================
 * 
 * 1. async keyword:
 *    - Marks a function as asynchronous
 *    - Always returns a Future
 *    - Allows the use of await inside the function
 * 
 * 2. await keyword:
 *    - Can only be used inside async functions
 *    - Pauses execution until the Future completes
 *    - Makes asynchronous code look synchronous
 * 
 * 3. Future API:
 *    - .then() - handles successful completion
 *    - .catchError() - handles errors
 *    - .whenComplete() - executes regardless of success/failure
 * 
 * 4. Error Handling:
 *    - Use try-catch with await
 *    - Use .catchError() with Future API
 * 
 * 5. Parallel execution:
 *    - Create futures without awaiting them
 *    - Use Future.wait() to wait for multiple futures
 */