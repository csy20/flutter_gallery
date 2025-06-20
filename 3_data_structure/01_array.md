# Arrays in Dart: Comprehensive Guide

## Table of Contents
1. [Introduction to Arrays](#introduction-to-arrays)
2. [Array Basics in Dart](#array-basics-in-dart)
3. [Array Operations](#array-operations)
4. [Performance Analysis](#performance-analysis)
5. [Best Practices](#best-practices)

## Introduction to Arrays

An **array** is a fundamental data structure that stores elements of the same type in contiguous memory locations. Arrays provide efficient access to elements using indices and are the building blocks for more complex data structures.

### Key Characteristics:
- **Fixed or Dynamic Size**: Dart lists can grow/shrink dynamically
- **Index-based Access**: O(1) time complexity for element access
- **Memory Efficiency**: Elements stored in contiguous memory
- **Type Safety**: All elements must be of the same type (or compatible types)

### Arrays vs Lists in Dart:
In Dart, we primarily work with **Lists** which are dynamic arrays. The `List` class provides array-like functionality with additional dynamic capabilities.

```dart
// Different ways to create arrays/lists in Dart
void demonstrateArrayCreation() {
  // 1. Fixed-length list (closest to traditional array)
  List<int> fixedArray = List.filled(5, 0); // [0, 0, 0, 0, 0]
  
  // 2. Dynamic list (growable)
  List<int> dynamicArray = <int>[];
  List<int> dynamicArray2 = [1, 2, 3, 4, 5];
  
  // 3. List with specific capacity
  List<int> capacityList = List.generate(10, (index) => index * 2);
  
  // 4. Typed lists for better performance
  List<int> typedList = <int>[1, 2, 3, 4, 5];
  
  print('Fixed Array: $fixedArray');
  print('Dynamic Array: $dynamicArray2');
  print('Generated List: $capacityList');
  print('Typed List: $typedList');
}
```

## Array Basics in Dart

### Declaration and Initialization

```dart
void demonstrateArrayBasics() {
  // Empty lists
  List<int> emptyList = [];
  List<String> emptyStringList = <String>[];
  
  // Initialized lists
  List<int> numbers = [1, 2, 3, 4, 5];
  List<String> fruits = ['apple', 'banana', 'cherry'];
  
  // Fixed-length lists
  List<int> fixedList = List.filled(3, 0); // [0, 0, 0]
  List<bool> boolList = List.filled(4, false); // [false, false, false, false]
  
  // Generated lists
  List<int> squares = List.generate(5, (index) => index * index); // [0, 1, 4, 9, 16]
  List<String> alphabet = List.generate(26, (index) => String.fromCharCode(65 + index));
  
  // From other iterables
  List<int> fromSet = Set<int>{1, 2, 3, 2, 1}.toList(); // [1, 2, 3]
  List<int> fromRange = List.generate(10, (index) => index).where((x) => x % 2 == 0).toList();
  
  print('Numbers: $numbers');
  print('Fruits: $fruits');
  print('Squares: $squares');
  print('Alphabet: ${alphabet.take(5).toList()}...');
}
```

### Basic Properties and Methods

```dart
void demonstrateArrayProperties() {
  List<int> numbers = [10, 20, 30, 40, 50];
  
  // Basic properties
  print('Length: ${numbers.length}');
  print('Is empty: ${numbers.isEmpty}');
  print('Is not empty: ${numbers.isNotEmpty}');
  print('First element: ${numbers.first}');
  print('Last element: ${numbers.last}');
  print('Reversed: ${numbers.reversed.toList()}');
  
  // Element access
  print('Element at index 2: ${numbers[2]}');
  print('Elements from index 1 to 3: ${numbers.sublist(1, 4)}');
  
  // Safe access
  print('Element at index 10 (safe): ${numbers.length > 10 ? numbers[10] : 'Index out of bounds'}');
}
```

## Array Operations

### 1. Insertion Operations

```dart
void demonstrateInsertionOperations() {
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Original: $numbers');
  
  // Insert at end (most efficient - O(1) amortized)
  numbers.add(6);
  print('After add(6): $numbers');
  
  // Insert at specific position (O(n) - requires shifting)
  numbers.insert(0, 0); // Insert at beginning
  print('After insert(0, 0): $numbers');
  
  numbers.insert(3, 25); // Insert at middle
  print('After insert(3, 25): $numbers');
  
  // Insert multiple elements
  numbers.addAll([7, 8, 9]);
  print('After addAll([7, 8, 9]): $numbers');
  
  numbers.insertAll(5, [20, 21, 22]);
  print('After insertAll(5, [20, 21, 22]): $numbers');
}

// Custom insertion with capacity management
class DynamicArray<T> {
  List<T> _data;
  int _size = 0;
  
  DynamicArray([int initialCapacity = 10]) : _data = List.filled(initialCapacity, null, growable: false);
  
  void add(T element) {
    if (_size >= _data.length) {
      _resize();
    }
    _data[_size] = element;
    _size++;
  }
  
  void insert(int index, T element) {
    if (index < 0 || index > _size) {
      throw RangeError('Index $index out of range [0, $_size]');
    }
    
    if (_size >= _data.length) {
      _resize();
    }
    
    // Shift elements to the right
    for (int i = _size; i > index; i--) {
      _data[i] = _data[i - 1];
    }
    
    _data[index] = element;
    _size++;
  }
  
  void _resize() {
    List<T> newData = List.filled(_data.length * 2, null, growable: false);
    for (int i = 0; i < _size; i++) {
      newData[i] = _data[i];
    }
    _data = newData;
  }
  
  T operator [](int index) {
    if (index < 0 || index >= _size) {
      throw RangeError('Index $index out of range [0, $_size)');
    }
    return _data[index];
  }
  
  void operator []=(int index, T value) {
    if (index < 0 || index >= _size) {
      throw RangeError('Index $index out of range [0, $_size)');
    }
    _data[index] = value;
  }
  
  int get length => _size;
  int get capacity => _data.length;
  
  @override
  String toString() => _data.take(_size).toList().toString();
}
```

### 2. Deletion Operations

```dart
void demonstrateDeletionOperations() {
  List<int> numbers = [1, 2, 3, 4, 5, 3, 6, 7];
  print('Original: $numbers');
  
  // Remove by value (removes first occurrence)
  numbers.remove(3);
  print('After remove(3): $numbers');
  
  // Remove at specific index
  int removed = numbers.removeAt(2);
  print('After removeAt(2): $numbers, removed: $removed');
  
  // Remove last element (most efficient - O(1))
  int lastRemoved = numbers.removeLast();
  print('After removeLast(): $numbers, removed: $lastRemoved');
  
  // Remove range
  numbers.removeRange(1, 3);
  print('After removeRange(1, 3): $numbers');
  
  // Remove where condition is true
  List<int> moreNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  moreNumbers.removeWhere((element) => element % 2 == 0);
  print('After removing even numbers: $moreNumbers');
  
  // Clear all elements
  List<int> temp = [1, 2, 3];
  temp.clear();
  print('After clear(): $temp');
}

// Efficient deletion implementation
void efficientDeletion() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  
  // Mark and sweep approach for multiple deletions
  List<int> toDelete = [2, 4, 6, 8];
  Set<int> deleteSet = toDelete.toSet();
  
  // Single pass deletion (more efficient than multiple removeAt calls)
  numbers.removeWhere((element) => deleteSet.contains(element));
  print('After efficient deletion: $numbers');
  
  // Swap and pop for unordered deletion (O(1))
  List<int> unorderedList = [10, 20, 30, 40, 50];
  int indexToDelete = 2; // Delete element at index 2 (30)
  
  // Swap with last element and remove last
  if (indexToDelete < unorderedList.length - 1) {
    unorderedList[indexToDelete] = unorderedList.last;
  }
  unorderedList.removeLast();
  print('After swap-and-pop deletion: $unorderedList');
}
```

### 3. Update Operations

```dart
void demonstrateUpdateOperations() {
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Original: $numbers');
  
  // Direct index assignment
  numbers[2] = 30;
  print('After numbers[2] = 30: $numbers');
  
  // Bulk update with map
  List<int> doubled = numbers.map((x) => x * 2).toList();
  print('Doubled: $doubled');
  
  // In-place update using setAll
  numbers.setAll(1, [20, 30, 40]);
  print('After setAll(1, [20, 30, 40]): $numbers');
  
  // Conditional update
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 == 0) {
      numbers[i] = numbers[i] ~/ 2;
    }
  }
  print('After halving even numbers: $numbers');
  
  // Replace all occurrences
  List<String> words = ['apple', 'banana', 'apple', 'cherry', 'apple'];
  for (int i = 0; i < words.length; i++) {
    if (words[i] == 'apple') {
      words[i] = 'orange';
    }
  }
  print('After replacing apples with oranges: $words');
}
```

### 4. Search Operations

```dart
void demonstrateSearchOperations() {
  List<int> numbers = [1, 3, 5, 7, 9, 11, 13, 15];
  
  // Basic search operations
  print('Contains 7: ${numbers.contains(7)}');
  print('Index of 7: ${numbers.indexOf(7)}');
  print('Last index of 7: ${numbers.lastIndexOf(7)}');
  
  // Search with condition
  int? firstEven = numbers.firstWhere((element) => element % 2 == 0, orElse: () => -1);
  print('First even number: $firstEven');
  
  // Find all elements matching condition
  List<int> greaterThan10 = numbers.where((element) => element > 10).toList();
  print('Numbers greater than 10: $greaterThan10');
  
  // Custom search functions
  int linearSearch(List<int> arr, int target) {
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] == target) {
        return i;
      }
    }
    return -1;
  }
  
  int binarySearch(List<int> arr, int target) {
    int left = 0;
    int right = arr.length - 1;
    
    while (left <= right) {
      int mid = left + (right - left) ~/ 2;
      
      if (arr[mid] == target) {
        return mid;
      } else if (arr[mid] < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return -1;
  }
  
  print('Linear search for 9: ${linearSearch(numbers, 9)}');
  print('Binary search for 9: ${binarySearch(numbers, 9)}');
}
```

## Advanced Array Techniques

### 1. Two Pointers Technique

```dart
// Two pointers for sorted array problems
class TwoPointers {
  // Find pair with given sum in sorted array
  static List<int>? findPairWithSum(List<int> arr, int targetSum) {
    int left = 0;
    int right = arr.length - 1;
    
    while (left < right) {
      int currentSum = arr[left] + arr[right];
      
      if (currentSum == targetSum) {
        return [left, right];
      } else if (currentSum < targetSum) {
        left++;
      } else {
        right--;
      }
    }
    
    return null; // No pair found
  }
  
  // Remove duplicates from sorted array in-place
  static int removeDuplicates(List<int> arr) {
    if (arr.length <= 1) return arr.length;
    
    int writeIndex = 1;
    
    for (int readIndex = 1; readIndex < arr.length; readIndex++) {
      if (arr[readIndex] != arr[readIndex - 1]) {
        arr[writeIndex] = arr[readIndex];
        writeIndex++;
      }
    }
    
    return writeIndex; // New length
  }
}
```

### 2. Sliding Window Technique

```dart
class SlidingWindow {
  // Maximum sum of k consecutive elements
  static int maxSumSubarray(List<int> arr, int k) {
    if (arr.length < k) return 0;
    
    // Calculate sum of first window
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
      windowSum += arr[i];
    }
    
    int maxSum = windowSum;
    
    // Slide the window
    for (int i = k; i < arr.length; i++) {
      windowSum = windowSum - arr[i - k] + arr[i];
      maxSum = math.max(maxSum, windowSum);
    }
    
    return maxSum;
  }
  
  // Longest subarray with at most k distinct elements
  static int longestSubarrayKDistinct(List<int> arr, int k) {
    if (k == 0) return 0;
    
    Map<int, int> elementCount = {};
    int left = 0;
    int maxLength = 0;
    
    for (int right = 0; right < arr.length; right++) {
      elementCount[arr[right]] = (elementCount[arr[right]] ?? 0) + 1;
      
      while (elementCount.length > k) {
        elementCount[arr[left]] = elementCount[arr[left]]! - 1;
        if (elementCount[arr[left]] == 0) {
          elementCount.remove(arr[left]);
        }
        left++;
      }
      
      maxLength = math.max(maxLength, right - left + 1);
    }
    
    return maxLength;
  }
}
```

### 3. Prefix Sum Technique

```dart
class PrefixSum {
  List<int> prefixSums;
  
  PrefixSum(List<int> arr) : prefixSums = List.filled(arr.length + 1, 0) {
    for (int i = 0; i < arr.length; i++) {
      prefixSums[i + 1] = prefixSums[i] + arr[i];
    }
  }
  
  // Range sum query in O(1)
  int rangeSum(int left, int right) {
    return prefixSums[right + 1] - prefixSums[left];
  }
  
  // Find subarray with given sum
  static List<int>? subarrayWithSum(List<int> arr, int targetSum) {
    Map<int, int> sumToIndex = {0: -1};
    int currentSum = 0;
    
    for (int i = 0; i < arr.length; i++) {
      currentSum += arr[i];
      
      if (sumToIndex.containsKey(currentSum - targetSum)) {
        int startIndex = sumToIndex[currentSum - targetSum]! + 1;
        return [startIndex, i];
      }
      
      sumToIndex[currentSum] = i;
    }
    
    return null;
  }
  
  // Count subarrays with given sum
  static int countSubarraysWithSum(List<int> arr, int targetSum) {
    Map<int, int> sumCount = {0: 1};
    int currentSum = 0;
    int count = 0;
    
    for (int num in arr) {
      currentSum += num;
      count += sumCount[currentSum - targetSum] ?? 0;
      sumCount[currentSum] = (sumCount[currentSum] ?? 0) + 1;
    }
    
    return count;
  }
}
```

## Performance Analysis

### Time Complexity Comparison

| Operation | Array Access | Insertion | Deletion | Search |
|-----------|--------------|-----------|----------|---------|
| **At End** | O(1) | O(1) amortized | O(1) | O(n) |
| **At Beginning** | O(1) | O(n) | O(n) | O(n) |
| **At Middle** | O(1) | O(n) | O(n) | O(n) |

### Memory Usage Patterns

```dart
void analyzeMemoryUsage() {
  print('=== Memory Usage Analysis ===\n');
  
  // Fixed vs Dynamic arrays
  List<int> fixedArray = List.filled(1000, 0, growable: false);
  List<int> dynamicArray = <int>[];
  
  print('Fixed Array (1000 elements): ${fixedArray.length} capacity');
  print('Dynamic Array (empty): Initial capacity varies by implementation');
  
  // Demonstrate dynamic growth
  for (int i = 0; i < 1000; i++) {
    dynamicArray.add(i);
  }
  print('Dynamic Array (1000 elements): Capacity may be > 1000 due to growth strategy');
  
  // Memory-efficient operations
  print('\nMemory-Efficient Practices:');
  print('1. Pre-allocate known size: List.filled() or List.generate()');
  print('2. Use appropriate data types: int vs BigInt, double vs num');
  print('3. Clear unused references: list.clear() when done');
  print('4. Consider using specialized lists for primitives');
}
```

## Best Practices

### 1. Choosing the Right Data Structure

```dart
void arrayBestPractices() {
  print('=== Array Best Practices ===\n');
  
  // ✅ Good: Pre-allocate when size is known
  List<int> scores = List.filled(100, 0);
  
  // ❌ Bad: Growing one by one for known size
  List<int> badScores = <int>[];
  for (int i = 0; i < 100; i++) {
    badScores.add(0); // Causes multiple reallocations
  }
  
  // ✅ Good: Use appropriate collection type
  Set<int> uniqueNumbers = <int>{}; // For unique elements
  List<int> orderedNumbers = <int>[]; // For ordered elements with duplicates
  
  // ✅ Good: Batch operations
  List<int> numbers = [1, 2, 3];
  numbers.addAll([4, 5, 6]); // Better than multiple add() calls
  
  // ✅ Good: Use built-in methods
  List<int> evenNumbers = [1, 2, 3, 4, 5, 6].where((n) => n % 2 == 0).toList();
  
  // ❌ Bad: Manual filtering
  List<int> manualEven = <int>[];
  for (int n in [1, 2, 3, 4, 5, 6]) {
    if (n % 2 == 0) {
      manualEven.add(n);
    }
  }
}
```

### 2. Error Handling and Validation

```dart
class SafeArray<T> {
  final List<T> _data;
  
  SafeArray(int size, T defaultValue) : _data = List.filled(size, defaultValue);
  
  T? get(int index) {
    return isValidIndex(index) ? _data[index] : null;
  }
  
  bool set(int index, T value) {
    if (isValidIndex(index)) {
      _data[index] = value;
      return true;
    }
    return false;
  }
  
  bool isValidIndex(int index) {
    return index >= 0 && index < _data.length;
  }
  
  int get length => _data.length;
  
  List<T> toList() => List.from(_data);
}
```

### 3. Performance Optimization Tips

```dart
void performanceOptimizationTips() {
  print('=== Performance Optimization Tips ===\n');
  
  print('1. Array Access:');
  print('   - Direct indexing is O(1)');
  print('   - Avoid bounds checking in tight loops when safe');
  print('');
  
  print('2. Insertion/Deletion:');
  print('   - Prefer operations at the end (O(1))');
  print('   - Batch operations when possible');
  print('   - Use removeWhere() instead of multiple remove() calls');
  print('');
  
  print('3. Searching:');
  print('   - Keep arrays sorted for binary search O(log n)');
  print('   - Use Set for O(1) membership testing');
  print('   - Consider hash tables for frequent lookups');
  print('');
  
  print('4. Sorting:');
  print('   - Use built-in sort() method (optimized)');
  print('   - Consider stability requirements');
  print('   - For small arrays (<10 elements), insertion sort can be faster');
  print('');
  
  print('5. Memory:');
  print('   - Pre-allocate when size is known');
  print('   - Clear references when done');
  print('   - Use appropriate data types');
}
```

## Summary

Arrays are fundamental data structures that provide:

### **Core Capabilities:**
- **Efficient Access**: O(1) random access by index
- **Memory Locality**: Contiguous storage for cache efficiency
- **Type Safety**: Homogeneous element storage
- **Dynamic Growth**: Dart Lists can resize automatically

### **Essential Operations:**
- **CRUD Operations**: Create, Read, Update, Delete
- **Basic Search**: Linear search operations
- **Array Manipulation**: Insertion, deletion, updates
- **Array Techniques**: Two pointers, sliding window, prefix sums

### **Performance Considerations:**
- **Time Complexity**: Choose operations based on data size and requirements
- **Space Complexity**: Consider memory usage for large datasets
- **Memory Locality**: Arrays provide excellent cache performance

### **Best Practices:**
1. **Choose appropriate data structure** for your use case
2. **Pre-allocate memory** when size is known
3. **Use built-in methods** for better performance
4. **Handle edge cases** properly
5. **Consider algorithmic complexity** for operations

Arrays form the foundation for many other data structures and provide efficient storage and access patterns for homogeneous data collections.
