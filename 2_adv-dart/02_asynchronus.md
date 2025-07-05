# Asynchronous Programming in Dart

## Table of Contents
1. [What is Asynchronous Programming?](#what-is-asynchronous-programming)
2. [Deep Dive: How Asynchronous Programming Works](#deep-dive-how-asynchronous-programming-works)
3. [Understanding the Event Loop](#understanding-the-event-loop)
4. [Futures](#futures)
5. [Async and Await](#async-and-await)
6. [Streams](#streams)
7. [Stream Controllers](#stream-controllers)
8. [Error Handling in Async Code](#error-handling-in-async-code)
9. [Isolates](#isolates)
10. [Advanced Async Patterns](#advanced-async-patterns)
11. [Best Practices](#best-practices)

## What is Asynchronous Programming?

Asynchronous programming allows your program to perform multiple operations simultaneously without blocking the main thread. Instead of waiting for long-running operations (like network requests, file I/O, or database queries) to complete before moving to the next line of code, asynchronous programming lets your program continue executing other code while these operations run in the background.

### Key Benefits:
- **Non-blocking**: UI remains responsive during long operations
- **Efficiency**: Better resource utilization
- **Scalability**: Handle multiple operations concurrently
- **User Experience**: Smooth, responsive applications

## Deep Dive: How Asynchronous Programming Works

### 🔍 The Fundamental Problem: Blocking vs Non-Blocking

To understand asynchronous programming, we first need to understand the problem it solves. Let's explore this with detailed examples:

```dart
import 'dart:io';
import 'dart:isolate';

// ❌ SYNCHRONOUS (Blocking) - The Problem
void demonstrateBlockingProblem() {
  print('=== Blocking Problem Demo ===');
  
  print('1. Program starts');
  print('2. About to make a blocking call...');
  
  Stopwatch stopwatch = Stopwatch()..start();
  
  // This BLOCKS the entire program for 3 seconds
  // Nothing else can happen during this time
  sleep(Duration(seconds: 3));
  
  stopwatch.stop();
  print('3. Blocking call completed after ${stopwatch.elapsedMilliseconds}ms');
  print('4. Program continues...');
  
  // Imagine if this was a UI - it would be completely frozen!
}

// ✅ ASYNCHRONOUS (Non-blocking) - The Solution
Future<void> demonstrateNonBlockingSolution() async {
  print('=== Non-Blocking Solution Demo ===');
  
  print('1. Program starts');
  print('2. About to make a non-blocking call...');
  
  Stopwatch stopwatch = Stopwatch()..start();
  
  // This DOESN'T block - the program can continue doing other things
  Future<void> delayedOperation = Future.delayed(Duration(seconds: 3));
  
  // While waiting, we can do other work
  print('3. Doing other work while waiting...');
  
  for (int i = 1; i <= 30; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    print('   Working... ${i}/30');
  }
  
  // Now wait for the original operation to complete
  await delayedOperation;
  
  stopwatch.stop();
  print('4. Non-blocking call completed after ${stopwatch.elapsedMilliseconds}ms');
  print('5. Program continues...');
}
```

### 🧠 The Mental Model: How Async Actually Works

Asynchronous programming is based on a simple but powerful concept: **cooperative multitasking**. Here's how it works:

```dart
// Understanding the async execution model
class AsyncExecutionModel {
  static void demonstrateExecutionModel() {
    print('=== Async Execution Model ===');
    
    print('Step 1: Synchronous code runs immediately');
    
    // This creates a Future but doesn't wait for it
    Future<String> futureResult = simulateAsyncWork('Task A', 2000);
    
    print('Step 2: Future created, but we continue immediately');
    print('Step 3: We can do other work while Task A runs in background');
    
    // We can create more async operations
    Future<String> anotherFuture = simulateAsyncWork('Task B', 1000);
    
    print('Step 4: Created another Future (Task B)');
    print('Step 5: Both tasks are now running concurrently');
    
    // When we need the results, we wait
    futureResult.then((result) {
      print('Step 6: $result');
    });
    
    anotherFuture.then((result) {
      print('Step 7: $result');
    });
    
    print('Step 8: This prints immediately, before the tasks complete');
  }
  
  static Future<String> simulateAsyncWork(String taskName, int milliseconds) async {
    print('  $taskName started...');
    await Future.delayed(Duration(milliseconds: milliseconds));
    return '$taskName completed after ${milliseconds}ms';
  }
}
```

### 🔧 Under the Hood: How Dart Implements Async

Dart's async implementation is built on several key components:

#### 1. **The Event Loop Architecture**

```dart
// Simulating how the event loop works conceptually
class EventLoopSimulation {
  static final Queue<Function> _eventQueue = Queue<Function>();
  static final Queue<Function> _microtaskQueue = Queue<Function>();
  static bool _isRunning = false;
  
  // Simplified event loop implementation
  static void runEventLoop() {
    if (_isRunning) return;
    _isRunning = true;
    
    print('Event Loop Started');
    
    while (_microtaskQueue.isNotEmpty || _eventQueue.isNotEmpty) {
      // 1. Process all microtasks first (highest priority)
      while (_microtaskQueue.isNotEmpty) {
        Function microtask = _microtaskQueue.removeFirst();
        print('  Executing microtask...');
        microtask();
      }
      
      // 2. Process one event from event queue
      if (_eventQueue.isNotEmpty) {
        Function event = _eventQueue.removeFirst();
        print('  Executing event...');
        event();
      }
    }
    
    print('Event Loop Finished');
    _isRunning = false;
  }
  
  // Add microtask to queue
  static void scheduleMicrotask(Function task) {
    _microtaskQueue.add(task);
    print('Microtask scheduled');
  }
  
  // Add event to queue
  static void scheduleEvent(Function event) {
    _eventQueue.add(event);
    print('Event scheduled');
  }
  
  static void demonstrate() {
    print('=== Event Loop Simulation ===');
    
    print('1. Scheduling tasks...');
    scheduleEvent(() => print('Event 1 executed'));
    scheduleMicrotask(() => print('Microtask 1 executed'));
    scheduleEvent(() => print('Event 2 executed'));
    scheduleMicrotask(() => print('Microtask 2 executed'));
    
    print('2. Running event loop...');
    runEventLoop();
    
    // Output order:
    // Microtask 1 executed
    // Microtask 2 executed  
    // Event 1 executed
    // Event 2 executed
  }
}
```

#### 2. **Future State Machine**

```dart
// Understanding how Futures work internally
enum FutureState {
  pending,
  completed,
  error
}

class FutureImplementation<T> {
  FutureState _state = FutureState.pending;
  T? _value;
  Object? _error;
  List<Function> _onCompleteCallbacks = [];
  List<Function> _onErrorCallbacks = [];
  
  // Constructor for immediate value
  FutureImplementation.value(T value) {
    _state = FutureState.completed;
    _value = value;
  }
  
  // Constructor for error
  FutureImplementation.error(Object error) {
    _state = FutureState.error;
    _error = error;
  }
  
  // Constructor for delayed completion
  FutureImplementation.delayed(Duration duration, T Function() computation) {
    Timer(duration, () {
      try {
        _value = computation();
        _state = FutureState.completed;
        _notifyCallbacks();
      } catch (e) {
        _error = e;
        _state = FutureState.error;
        _notifyErrorCallbacks();
      }
    });
  }
  
  // The .then() method
  FutureImplementation<R> then<R>(R Function(T) onValue, {Function? onError}) {
    if (_state == FutureState.completed) {
      // Already completed - execute immediately
      try {
        R result = onValue(_value as T);
        return FutureImplementation.value(result);
      } catch (e) {
        return FutureImplementation.error(e);
      }
    } else if (_state == FutureState.error) {
      // Already has error
      if (onError != null) {
        try {
          dynamic result = onError(_error);
          return FutureImplementation.value(result);
        } catch (e) {
          return FutureImplementation.error(e);
        }
      } else {
        return FutureImplementation.error(_error!);
      }
    } else {
      // Still pending - add callback
      Completer<R> completer = Completer<R>();
      
      _onCompleteCallbacks.add(() {
        try {
          R result = onValue(_value as T);
          completer.complete(result);
        } catch (e) {
          completer.completeError(e);
        }
      });
      
      if (onError != null) {
        _onErrorCallbacks.add(() {
          try {
            dynamic result = onError(_error);
            completer.complete(result);
          } catch (e) {
            completer.completeError(e);
          }
        });
      }
      
      return FutureImplementation.fromCompleter(completer);
    }
  }
  
  // Internal constructor from Completer
  FutureImplementation.fromCompleter(Completer<T> completer) {
    completer.future.then((value) {
      _value = value;
      _state = FutureState.completed;
      _notifyCallbacks();
    }).catchError((error) {
      _error = error;
      _state = FutureState.error;
      _notifyErrorCallbacks();
    });
  }
  
  void _notifyCallbacks() {
    for (Function callback in _onCompleteCallbacks) {
      scheduleMicrotask(callback);
    }
    _onCompleteCallbacks.clear();
  }
  
  void _notifyErrorCallbacks() {
    for (Function callback in _onErrorCallbacks) {
      scheduleMicrotask(callback);
    }
    _onErrorCallbacks.clear();
  }
  
  // Demonstrate the state machine
  static void demonstrateStateMachine() {
    print('=== Future State Machine Demo ===');
    
    // Create pending future
    FutureImplementation<String> pendingFuture = FutureImplementation.delayed(
      Duration(seconds: 2),
      () => 'Future completed!'
    );
    
    print('1. Future created in pending state');
    
    // Add callback before completion
    pendingFuture.then((value) {
      print('3. Callback executed: $value');
    });
    
    print('2. Callback registered, waiting for completion...');
    
    // Create immediate future
    FutureImplementation<int> immediateFuture = FutureImplementation.value(42);
    
    print('4. Immediate future created');
    
    // This callback executes immediately
    immediateFuture.then((value) {
      print('5. Immediate callback: $value');
    });
  }
}
```

#### 3. **Async/Await Transformation**

When you use `async` and `await`, Dart transforms your code behind the scenes:

```dart
// What you write
Future<String> fetchUserData() async {
  String token = await authenticate();
  String userData = await fetchUser(token);
  return userData;
}

// What Dart generates (simplified)
Future<String> fetchUserDataTransformed() {
  return authenticate().then((token) {
    return fetchUser(token).then((userData) {
      return userData;
    });
  });
}

// Let's demonstrate this transformation
class AsyncTransformation {
  static void demonstrateTransformation() {
    print('=== Async/Await Transformation ===');
    
    // Original async/await version
    processDataAsync().then((result) {
      print('Async version result: $result');
    });
    
    // Manually transformed version
    processDataManual().then((result) {
      print('Manual version result: $result');
    });
  }
  
  // Using async/await
  static Future<String> processDataAsync() async {
    print('1. Starting async process...');
    
    String step1 = await simulateStep('Step 1', 1000);
    print('2. $step1');
    
    String step2 = await simulateStep('Step 2', 1000);
    print('3. $step2');
    
    String step3 = await simulateStep('Step 3', 1000);
    print('4. $step3');
    
    return 'All steps completed';
  }
  
  // Manual transformation without async/await
  static Future<String> processDataManual() {
    print('1. Starting manual process...');
    
    return simulateStep('Step 1', 1000).then((step1) {
      print('2. $step1');
      
      return simulateStep('Step 2', 1000).then((step2) {
        print('3. $step2');
        
        return simulateStep('Step 3', 1000).then((step3) {
          print('4. $step3');
          
          return 'All steps completed';
        });
      });
    });
  }
  
  static Future<String> simulateStep(String stepName, int delay) {
    return Future.delayed(Duration(milliseconds: delay), () => '$stepName completed');
  }
}
```

### Synchronous vs Asynchronous Example:

```dart
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

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

### 🏗️ Real-World Implementation: Building an Async HTTP Client

Let's build a complete async HTTP client to understand implementation details:

```dart
import 'dart:convert';
import 'dart:io';

class AsyncHttpClient {
  static const int defaultTimeout = 30000; // 30 seconds
  
  // Basic GET request implementation
  static Future<HttpResponse> get(String url, {
    Map<String, String>? headers,
    int timeout = defaultTimeout,
  }) async {
    print('=== HTTP GET Request ===');
    print('URL: $url');
    
    Stopwatch stopwatch = Stopwatch()..start();
    
    try {
      // Parse URL
      Uri uri = Uri.parse(url);
      
      // Create HTTP client
      HttpClient client = HttpClient();
      client.connectionTimeout = Duration(milliseconds: timeout);
      
      // Open connection (async)
      HttpClientRequest request = await client.getUrl(uri);
      
      // Add headers
      if (headers != null) {
        headers.forEach((key, value) {
          request.headers.add(key, value);
        });
      }
      
      print('Request sent, waiting for response...');
      
      // Send request and get response (async)
      HttpClientResponse response = await request.close();
      
      // Read response body (async)
      String responseBody = await response.transform(utf8.decoder).join();
      
      stopwatch.stop();
      
      HttpResponse result = HttpResponse(
        statusCode: response.statusCode,
        body: responseBody,
        headers: response.headers,
        responseTime: stopwatch.elapsedMilliseconds,
      );
      
      print('Response received in ${result.responseTime}ms');
      print('Status: ${result.statusCode}');
      
      // Clean up
      client.close();
      
      return result;
      
    } catch (e) {
      stopwatch.stop();
      print('Request failed after ${stopwatch.elapsedMilliseconds}ms: $e');
      rethrow;
    }
  }
  
  // POST request with body
  static Future<HttpResponse> post(String url, {
    Map<String, String>? headers,
    String? body,
    int timeout = defaultTimeout,
  }) async {
    print('=== HTTP POST Request ===');
    print('URL: $url');
    
    try {
      Uri uri = Uri.parse(url);
      HttpClient client = HttpClient();
      client.connectionTimeout = Duration(milliseconds: timeout);
      
      HttpClientRequest request = await client.postUrl(uri);
      
      // Set content type
      request.headers.contentType = ContentType.json;
      
      // Add custom headers
      if (headers != null) {
        headers.forEach((key, value) {
          request.headers.add(key, value);
        });
      }
      
      // Add body if provided
      if (body != null) {
        request.write(body);
      }
      
      print('POST request sent with body length: ${body?.length ?? 0}');
      
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      
      HttpResponse result = HttpResponse(
        statusCode: response.statusCode,
        body: responseBody,
        headers: response.headers,
        responseTime: 0, // Would need to track this
      );
      
      client.close();
      return result;
      
    } catch (e) {
      print('POST request failed: $e');
      rethrow;
    }
  }
  
  // Concurrent requests
  static Future<List<HttpResponse>> concurrent(List<String> urls) async {
    print('=== Concurrent HTTP Requests ===');
    print('Making ${urls.length} concurrent requests...');
    
    Stopwatch stopwatch = Stopwatch()..start();
    
    // Create all requests simultaneously
    List<Future<HttpResponse>> futures = urls.map((url) => get(url)).toList();
    
    // Wait for all to complete
    List<HttpResponse> responses = await Future.wait(futures);
    
    stopwatch.stop();
    
    print('All ${urls.length} requests completed in ${stopwatch.elapsedMilliseconds}ms');
    
    return responses;
  }
  
  // Request with retry logic
  static Future<HttpResponse> getWithRetry(String url, {
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    print('=== HTTP GET with Retry ===');
    
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        print('Attempt $attempt/$maxRetries');
        return await get(url);
      } catch (e) {
        print('Attempt $attempt failed: $e');
        
        if (attempt == maxRetries) {
          print('Max retries reached, giving up');
          rethrow;
        }
        
        print('Retrying in ${retryDelay.inSeconds} seconds...');
        await Future.delayed(retryDelay);
      }
    }
    
    throw Exception('This should never be reached');
  }
}

class HttpResponse {
  final int statusCode;
  final String body;
  final HttpHeaders headers;
  final int responseTime;
  
  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.headers,
    required this.responseTime,
  });
  
  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  
  Map<String, dynamic>? get jsonBody {
    try {
      return json.decode(body);
    } catch (e) {
      return null;
    }
  }
  
  @override
  String toString() {
    return 'HttpResponse(status: $statusCode, time: ${responseTime}ms, body: ${body.length} chars)';
  }
}
```

### 🔄 Stream Implementation Deep Dive

Let's understand how Streams work internally:

```dart
// Custom Stream implementation to understand internals
class CustomStream<T> {
  final StreamController<T> _controller = StreamController<T>();
  late final Stream<T> _stream;
  
  CustomStream() {
    _stream = _controller.stream;
  }
  
  // Stream getter
  Stream<T> get stream => _stream;
  
  // Add data to stream
  void add(T data) {
    if (!_controller.isClosed) {
      _controller.add(data);
    }
  }
  
  // Add error to stream
  void addError(Object error) {
    if (!_controller.isClosed) {
      _controller.addError(error);
    }
  }
  
  // Close stream
  Future<void> close() async {
    await _controller.close();
  }
}

// Real-world example: File processing stream
class FileProcessor {
  static Stream<FileProcessingResult> processFiles(List<String> filePaths) async* {
    print('=== File Processing Stream ===');
    
    for (int i = 0; i < filePaths.length; i++) {
      String filePath = filePaths[i];
      
      try {
        print('Processing file ${i + 1}/${filePaths.length}: $filePath');
        
        // Simulate file processing
        await Future.delayed(Duration(milliseconds: 500));
        
        // Simulate reading file
        File file = File(filePath);
        bool exists = await file.exists();
        
        if (exists) {
          int size = await file.length();
          String content = await file.readAsString();
          
          yield FileProcessingResult(
            filePath: filePath,
            success: true,
            size: size,
            content: content,
            processingTime: 500,
          );
        } else {
          yield FileProcessingResult(
            filePath: filePath,
            success: false,
            error: 'File not found',
            processingTime: 500,
          );
        }
        
      } catch (e) {
        yield FileProcessingResult(
          filePath: filePath,
          success: false,
          error: e.toString(),
          processingTime: 500,
        );
      }
    }
  }
}

class FileProcessingResult {
  final String filePath;
  final bool success;
  final int? size;
  final String? content;
  final String? error;
  final int processingTime;
  
  FileProcessingResult({
    required this.filePath,
    required this.success,
    this.size,
    this.content,
    this.error,
    required this.processingTime,
  });
  
  @override
  String toString() {
    if (success) {
      return 'FileProcessingResult(${filePath}: ${size} bytes, ${processingTime}ms)';
    } else {
      return 'FileProcessingResult(${filePath}: ERROR - ${error}, ${processingTime}ms)';
    }
  }
}
```

### 🎯 Performance Considerations and Optimization

```dart
// Performance optimization techniques
class AsyncPerformanceOptimization {
  // 1. Batch processing instead of individual operations
  static Future<List<ProcessingResult>> batchProcess(List<String> items) async {
    print('=== Batch Processing ===');
    
    const int batchSize = 10;
    List<ProcessingResult> allResults = [];
    
    for (int i = 0; i < items.length; i += batchSize) {
      int end = (i + batchSize < items.length) ? i + batchSize : items.length;
      List<String> batch = items.sublist(i, end);
      
      print('Processing batch ${i ~/ batchSize + 1}: ${batch.length} items');
      
      // Process batch concurrently
      List<Future<ProcessingResult>> futures = batch.map((item) => processItem(item)).toList();
      List<ProcessingResult> batchResults = await Future.wait(futures);
      
      allResults.addAll(batchResults);
    }
    
    return allResults;
  }
  
  static Future<ProcessingResult> processItem(String item) async {
    await Future.delayed(Duration(milliseconds: 100));
    return ProcessingResult(item, 'processed');
  }
  
  // 2. Connection pooling simulation
  static Future<void> demonstrateConnectionPooling() async {
    print('=== Connection Pooling ===');
    
    ConnectionPool pool = ConnectionPool(maxConnections: 5);
    
    // Simulate multiple concurrent requests
    List<Future<String>> futures = [];
    for (int i = 1; i <= 20; i++) {
      futures.add(pool.executeRequest('Request $i'));
    }
    
    List<String> results = await Future.wait(futures);
    results.forEach(print);
    
    await pool.close();
  }
  
  // 3. Caching async results
  static final Map<String, Future<String>> _cache = {};
  
  static Future<String> cachedAsyncOperation(String key) {
    if (_cache.containsKey(key)) {
      print('Cache hit for: $key');
      return _cache[key]!;
    }
    
    print('Cache miss for: $key');
    Future<String> future = expensiveAsyncOperation(key);
    _cache[key] = future;
    return future;
  }
  
  static Future<String> expensiveAsyncOperation(String key) async {
    await Future.delayed(Duration(seconds: 2));
    return 'Result for $key';
  }
}

class ProcessingResult {
  final String input;
  final String result;
  
  ProcessingResult(this.input, this.result);
  
  @override
  String toString() => 'ProcessingResult($input -> $result)';
}

class ConnectionPool {
  final int maxConnections;
  final Queue<Completer<Connection>> _waitingQueue = Queue();
  final List<Connection> _availableConnections = [];
  final List<Connection> _busyConnections = [];
  
  ConnectionPool({required this.maxConnections}) {
    // Initialize pool with connections
    for (int i = 0; i < maxConnections; i++) {
      _availableConnections.add(Connection(i));
    }
  }
  
  Future<String> executeRequest(String request) async {
    Connection connection = await _getConnection();
    
    try {
      return await connection.execute(request);
    } finally {
      _returnConnection(connection);
    }
  }
  
  Future<Connection> _getConnection() async {
    if (_availableConnections.isNotEmpty) {
      Connection connection = _availableConnections.removeAt(0);
      _busyConnections.add(connection);
      return connection;
    }
    
    // No available connections, wait for one
    Completer<Connection> completer = Completer();
    _waitingQueue.add(completer);
    return completer.future;
  }
  
  void _returnConnection(Connection connection) {
    _busyConnections.remove(connection);
    
    if (_waitingQueue.isNotEmpty) {
      // Give connection to waiting request
      Completer<Connection> completer = _waitingQueue.removeFirst();
      _busyConnections.add(connection);
      completer.complete(connection);
    } else {
      // Return to available pool
      _availableConnections.add(connection);
    }
  }
  
  Future<void> close() async {
    // Close all connections
    for (Connection connection in _availableConnections) {
      await connection.close();
    }
    for (Connection connection in _busyConnections) {
      await connection.close();
    }
  }
}

class Connection {
  final int id;
  bool _isClosed = false;
  
  Connection(this.id);
  
  Future<String> execute(String request) async {
    if (_isClosed) throw Exception('Connection closed');
    
    print('Connection $id executing: $request');
    await Future.delayed(Duration(milliseconds: 200));
    return 'Response from connection $id for: $request';
  }
  
  Future<void> close() async {
    _isClosed = true;
    print('Connection $id closed');
  }
}
```

## Isolates

Isolates provide true parallelism in Dart by running code in separate memory spaces.

```dart
// Helper function for compute operations
Future<T> compute<T>(T Function(dynamic) callback, dynamic message) async {
  ReceivePort receivePort = ReceivePort();
  
  await Isolate.spawn<Map<String, dynamic>>(
    _computeImpl,
    {
      'callback': callback,
      'message': message,
      'sendPort': receivePort.sendPort,
    },
  );
  
  return await receivePort.first;
}

void _computeImpl<T>(Map<String, dynamic> args) {
  T Function(dynamic) callback = args['callback'];
  dynamic message = args['message'];
  SendPort sendPort = args['sendPort'];
  
  try {
    T result = callback(message);
    sendPort.send(result);
  } catch (e) {
    sendPort.send(e);
  }
}

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
```

```dart
// Can also return Future directly without async/await
Future<String> directFutureFunction() {
  return Future.delayed(Duration(seconds: 1), () => 'Direct future result');
}

// Helper functions for the examples
Future<String> authenticate() async {
  await Future.delayed(Duration(seconds: 1));
  return 'auth_token_12345';
}

Future<String> fetchUser(String token) async {
  await Future.delayed(Duration(seconds: 1));
  return 'user_data_for_$token';
}

// Helper classes for API examples
class User {
  final int id;
  final String username;
  final String email;
  
  User({required this.id, required this.username, required this.email});
}

class Post {
  final int id;
  final String title;
  final String content;
  
  Post({required this.id, required this.title, required this.content});
}

class ProcessedData {
  final List<Post> posts;
  final int totalWords;
  
  ProcessedData({required this.posts, required this.totalWords});
}

// Helper functions for examples
Future<User> fetchUser() async {
  await Future.delayed(Duration(seconds: 1));
  return User(id: 1, username: 'john_doe', email: 'john@example.com');
}

Future<List<Post>> fetchUserPosts(int userId) async {
  await Future.delayed(Duration(seconds: 1));
  return [
    Post(id: 1, title: 'First Post', content: 'Hello World'),
    Post(id: 2, title: 'Second Post', content: 'Learning Dart'),
  ];
}

Future<ProcessedData> processPosts(List<Post> posts) async {
  await Future.delayed(Duration(seconds: 1));
  int totalWords = posts.fold(0, (sum, post) => sum + post.content.split(' ').length);
  return ProcessedData(posts: posts, totalWords: totalWords);
}

Future<void> saveResult(ProcessedData data) async {
  await Future.delayed(Duration(seconds: 1));
  print('Saved ${data.posts.length} posts with ${data.totalWords} total words');
}

void handleError(dynamic error) {
  print('Error handled: $error');
}

// Helper functions for stream examples
Future<String> fetchData1() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data 1';
}

Future<String> fetchData2() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data 2';
}

Future<String> fetchData3() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data 3';
}

// Helper function for async operations
Future<String> riskyOperation() async {
  await Future.delayed(Duration(seconds: 1));
  if (Random().nextBool()) {
    return 'Success!';
  } else {
    throw Exception('Operation failed');
  }
}
```