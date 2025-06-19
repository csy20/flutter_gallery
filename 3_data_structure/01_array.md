# Arrays in Dart: Comprehensive Guide

## Table of Contents
1. [Introduction to Arrays](#introduction-to-arrays)
2. [Array Basics in Dart](#array-basics-in-dart)
3. [Array Operations](#array-operations)
4. [Searching Algorithms](#searching-algorithms)
5. [Sorting Algorithms](#sorting-algorithms)
6. [Kadane's Algorithm](#kadanes-algorithm)
7. [Advanced Array Techniques](#advanced-array-techniques)
8. [Performance Analysis](#performance-analysis)
9. [Best Practices](#best-practices)

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

## Searching Algorithms

### Linear Search
**Time Complexity**: O(n)  
**Space Complexity**: O(1)  
**Best for**: Unsorted arrays, small datasets

```dart
int linearSearch<T>(List<T> arr, T target) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      return i;
    }
  }
  return -1; // Not found
}

// Enhanced linear search with multiple results
List<int> linearSearchAll<T>(List<T> arr, T target) {
  List<int> indices = [];
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      indices.add(i);
    }
  }
  return indices;
}

// Linear search with custom comparator
int linearSearchWithComparator<T>(
  List<T> arr, 
  T target, 
  bool Function(T, T) comparator
) {
  for (int i = 0; i < arr.length; i++) {
    if (comparator(arr[i], target)) {
      return i;
    }
  }
  return -1;
}
```

### Binary Search
**Time Complexity**: O(log n)  
**Space Complexity**: O(1) iterative, O(log n) recursive  
**Prerequisite**: Array must be sorted

```dart
// Iterative binary search
int binarySearch<T extends Comparable<T>>(List<T> arr, T target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    int comparison = arr[mid].compareTo(target);
    
    if (comparison == 0) {
      return mid;
    } else if (comparison < 0) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  return -1;
}

// Recursive binary search
int binarySearchRecursive<T extends Comparable<T>>(
  List<T> arr, 
  T target, 
  [int? left, 
  int? right]
) {
  left ??= 0;
  right ??= arr.length - 1;
  
  if (left > right) {
    return -1;
  }
  
  int mid = left + (right - left) ~/ 2;
  int comparison = arr[mid].compareTo(target);
  
  if (comparison == 0) {
    return mid;
  } else if (comparison < 0) {
    return binarySearchRecursive(arr, target, mid + 1, right);
  } else {
    return binarySearchRecursive(arr, target, left, mid - 1);
  }
}

// Binary search variations
int findFirstOccurrence<T extends Comparable<T>>(List<T> arr, T target) {
  int left = 0;
  int right = arr.length - 1;
  int result = -1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    int comparison = arr[mid].compareTo(target);
    
    if (comparison == 0) {
      result = mid;
      right = mid - 1; // Continue searching in left half
    } else if (comparison < 0) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  return result;
}

int findLastOccurrence<T extends Comparable<T>>(List<T> arr, T target) {
  int left = 0;
  int right = arr.length - 1;
  int result = -1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    int comparison = arr[mid].compareTo(target);
    
    if (comparison == 0) {
      result = mid;
      left = mid + 1; // Continue searching in right half
    } else if (comparison < 0) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  return result;
}

// Search for insertion point
int searchInsertPosition<T extends Comparable<T>>(List<T> arr, T target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    int comparison = arr[mid].compareTo(target);
    
    if (comparison < 0) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  return left;
}
```

## Sorting Algorithms

### 1. Bubble Sort
**Time Complexity**: O(n²)  
**Space Complexity**: O(1)  
**Stable**: Yes  
**Adaptive**: Yes (O(n) for nearly sorted arrays)

```dart
void bubbleSort<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    bool swapped = false;
    
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j].compareTo(arr[j + 1]) > 0) {
        // Swap elements
        T temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
        swapped = true;
      }
    }
    
    // If no swapping occurred, array is sorted
    if (!swapped) break;
  }
}

void demonstrateBubbleSort() {
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90];
  print('Original: $numbers');
  
  bubbleSort(numbers);
  print('Bubble sorted: $numbers');
}
```

### 2. Selection Sort
**Time Complexity**: O(n²)  
**Space Complexity**: O(1)  
**Stable**: No  
**Adaptive**: No

```dart
void selectionSort<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    
    // Find the minimum element in remaining unsorted array
    for (int j = i + 1; j < n; j++) {
      if (arr[j].compareTo(arr[minIndex]) < 0) {
        minIndex = j;
      }
    }
    
    // Swap the found minimum element with the first element
    if (minIndex != i) {
      T temp = arr[i];
      arr[i] = arr[minIndex];
      arr[minIndex] = temp;
    }
  }
}

void demonstrateSelectionSort() {
  List<String> words = ['banana', 'apple', 'cherry', 'date'];
  print('Original: $words');
  
  selectionSort(words);
  print('Selection sorted: $words');
}
```

### 3. Insertion Sort
**Time Complexity**: O(n²) worst case, O(n) best case  
**Space Complexity**: O(1)  
**Stable**: Yes  
**Adaptive**: Yes

```dart
void insertionSort<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  
  for (int i = 1; i < n; i++) {
    T key = arr[i];
    int j = i - 1;
    
    // Move elements greater than key one position ahead
    while (j >= 0 && arr[j].compareTo(key) > 0) {
      arr[j + 1] = arr[j];
      j--;
    }
    
    arr[j + 1] = key;
  }
}

// Binary insertion sort (reduces comparisons)
void binaryInsertionSort<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  
  for (int i = 1; i < n; i++) {
    T key = arr[i];
    int insertPos = binarySearchInsertionPoint(arr, key, 0, i);
    
    // Shift elements to make space
    for (int j = i; j > insertPos; j--) {
      arr[j] = arr[j - 1];
    }
    
    arr[insertPos] = key;
  }
}

int binarySearchInsertionPoint<T extends Comparable<T>>(
  List<T> arr, 
  T target, 
  int left, 
  int right
) {
  while (left < right) {
    int mid = left + (right - left) ~/ 2;
    if (arr[mid].compareTo(target) > 0) {
      right = mid;
    } else {
      left = mid + 1;
    }
  }
  return left;
}
```

### 4. Merge Sort
**Time Complexity**: O(n log n)  
**Space Complexity**: O(n)  
**Stable**: Yes  
**Adaptive**: No

```dart
void mergeSort<T extends Comparable<T>>(List<T> arr) {
  if (arr.length <= 1) return;
  
  _mergeSortHelper(arr, 0, arr.length - 1);
}

void _mergeSortHelper<T extends Comparable<T>>(List<T> arr, int left, int right) {
  if (left < right) {
    int mid = left + (right - left) ~/ 2;
    
    _mergeSortHelper(arr, left, mid);
    _mergeSortHelper(arr, mid + 1, right);
    _merge(arr, left, mid, right);
  }
}

void _merge<T extends Comparable<T>>(List<T> arr, int left, int mid, int right) {
  List<T> leftArr = arr.sublist(left, mid + 1);
  List<T> rightArr = arr.sublist(mid + 1, right + 1);
  
  int i = 0, j = 0, k = left;
  
  // Merge the temporary arrays back into arr[left..right]
  while (i < leftArr.length && j < rightArr.length) {
    if (leftArr[i].compareTo(rightArr[j]) <= 0) {
      arr[k] = leftArr[i];
      i++;
    } else {
      arr[k] = rightArr[j];
      j++;
    }
    k++;
  }
  
  // Copy remaining elements
  while (i < leftArr.length) {
    arr[k] = leftArr[i];
    i++;
    k++;
  }
  
  while (j < rightArr.length) {
    arr[k] = rightArr[j];
    j++;
    k++;
  }
}
```

### 5. Quick Sort
**Time Complexity**: O(n log n) average, O(n²) worst case  
**Space Complexity**: O(log n) average  
**Stable**: No  
**Adaptive**: No

```dart
void quickSort<T extends Comparable<T>>(List<T> arr, [int? low, int? high]) {
  low ??= 0;
  high ??= arr.length - 1;
  
  if (low < high) {
    int pivotIndex = _partition(arr, low, high);
    
    quickSort(arr, low, pivotIndex - 1);
    quickSort(arr, pivotIndex + 1, high);
  }
}

int _partition<T extends Comparable<T>>(List<T> arr, int low, int high) {
  T pivot = arr[high]; // Choose last element as pivot
  int i = low - 1; // Index of smaller element
  
  for (int j = low; j < high; j++) {
    if (arr[j].compareTo(pivot) <= 0) {
      i++;
      _swap(arr, i, j);
    }
  }
  
  _swap(arr, i + 1, high);
  return i + 1;
}

void _swap<T>(List<T> arr, int i, int j) {
  T temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

// Optimized quick sort with random pivot
void quickSortRandomized<T extends Comparable<T>>(List<T> arr, [int? low, int? high]) {
  low ??= 0;
  high ??= arr.length - 1;
  
  if (low < high) {
    // Randomize pivot to avoid worst case
    int randomIndex = low + (high - low) * Random().nextDouble().floor();
    _swap(arr, randomIndex, high);
    
    int pivotIndex = _partition(arr, low, high);
    
    quickSortRandomized(arr, low, pivotIndex - 1);
    quickSortRandomized(arr, pivotIndex + 1, high);
  }
}
```

### 6. Heap Sort
**Time Complexity**: O(n log n)  
**Space Complexity**: O(1)  
**Stable**: No  
**Adaptive**: No

```dart
void heapSort<T extends Comparable<T>>(List<T> arr) {
  int n = arr.length;
  
  // Build max heap
  for (int i = n ~/ 2 - 1; i >= 0; i--) {
    _heapify(arr, n, i);
  }
  
  // Extract elements from heap one by one
  for (int i = n - 1; i > 0; i--) {
    _swap(arr, 0, i); // Move current root to end
    _heapify(arr, i, 0); // Call heapify on the reduced heap
  }
}

void _heapify<T extends Comparable<T>>(List<T> arr, int n, int i) {
  int largest = i; // Initialize largest as root
  int left = 2 * i + 1; // Left child
  int right = 2 * i + 2; // Right child
  
  // If left child is larger than root
  if (left < n && arr[left].compareTo(arr[largest]) > 0) {
    largest = left;
  }
  
  // If right child is larger than largest so far
  if (right < n && arr[right].compareTo(arr[largest]) > 0) {
    largest = right;
  }
  
  // If largest is not root
  if (largest != i) {
    _swap(arr, i, largest);
    _heapify(arr, n, largest); // Recursively heapify the affected sub-tree
  }
}
```

### Sorting Comparison and Usage

```dart
void demonstrateAllSorts() {
  List<List<int>> testArrays = [
    [64, 34, 25, 12, 22, 11, 90],
    [5, 2, 8, 1, 9],
    [1], // Single element
    [], // Empty array
    [3, 3, 3, 3], // All same elements
    [5, 4, 3, 2, 1], // Reverse sorted
    [1, 2, 3, 4, 5], // Already sorted
  ];
  
  for (int i = 0; i < testArrays.length; i++) {
    print('\n--- Test Case ${i + 1}: ${testArrays[i]} ---');
    
    // Test each sorting algorithm
    List<int> bubbleTest = List.from(testArrays[i]);
    List<int> selectionTest = List.from(testArrays[i]);
    List<int> insertionTest = List.from(testArrays[i]);
    List<int> mergeTest = List.from(testArrays[i]);
    List<int> quickTest = List.from(testArrays[i]);
    List<int> heapTest = List.from(testArrays[i]);
    
    bubbleSort(bubbleTest);
    selectionSort(selectionTest);
    insertionSort(insertionTest);
    mergeSort(mergeTest);
    quickSort(quickTest);
    heapSort(heapTest);
    
    print('Bubble Sort:    $bubbleTest');
    print('Selection Sort: $selectionTest');
    print('Insertion Sort: $insertionTest');
    print('Merge Sort:     $mergeTest');
    print('Quick Sort:     $quickTest');
    print('Heap Sort:      $heapTest');
  }
}
```

## Kadane's Algorithm

**Kadane's Algorithm** is used to find the maximum sum of a contiguous subarray within a one-dimensional array. It's a classic example of dynamic programming that solves the Maximum Subarray Problem.

### Problem Statement:
Given an array of integers, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

### Algorithm Explanation:

1. **Intuition**: At each position, decide whether to extend the existing subarray or start a new one
2. **Key Insight**: If the sum becomes negative, it's better to start fresh from the current element
3. **Time Complexity**: O(n)
4. **Space Complexity**: O(1)

```dart
// Basic Kadane's Algorithm
int kadaneMaxSum(List<int> arr) {
  if (arr.isEmpty) {
    throw ArgumentError('Array cannot be empty');
  }
  
  int maxSoFar = arr[0];  // Maximum sum found so far
  int maxEndingHere = arr[0];  // Maximum sum ending at current position
  
  for (int i = 1; i < arr.length; i++) {
    // Either extend existing subarray or start new one
    maxEndingHere = math.max(arr[i], maxEndingHere + arr[i]);
    
    // Update overall maximum
    maxSoFar = math.max(maxSoFar, maxEndingHere);
  }
  
  return maxSoFar;
}

// Kadane's Algorithm with subarray indices
class MaxSubarrayResult {
  final int sum;
  final int startIndex;
  final int endIndex;
  final List<int> subarray;
  
  MaxSubarrayResult(this.sum, this.startIndex, this.endIndex, this.subarray);
  
  @override
  String toString() {
    return 'Sum: $sum, Indices: [$startIndex, $endIndex], Subarray: $subarray';
  }
}

MaxSubarrayResult kadaneWithIndices(List<int> arr) {
  if (arr.isEmpty) {
    throw ArgumentError('Array cannot be empty');
  }
  
  int maxSoFar = arr[0];
  int maxEndingHere = arr[0];
  int start = 0;  // Start of current subarray
  int end = 0;    // End of maximum subarray
  int tempStart = 0;  // Temporary start for current subarray
  
  for (int i = 1; i < arr.length; i++) {
    // If starting fresh is better
    if (arr[i] > maxEndingHere + arr[i]) {
      maxEndingHere = arr[i];
      tempStart = i;
    } else {
      maxEndingHere = maxEndingHere + arr[i];
    }
    
    // Update overall maximum
    if (maxEndingHere > maxSoFar) {
      maxSoFar = maxEndingHere;
      start = tempStart;
      end = i;
    }
  }
  
  List<int> maxSubarray = arr.sublist(start, end + 1);
  return MaxSubarrayResult(maxSoFar, start, end, maxSubarray);
}

// Enhanced Kadane's for different scenarios
class KadaneVariations {
  // 1. Handle all negative numbers
  static int kadaneAllNegative(List<int> arr) {
    if (arr.isEmpty) return 0;
    
    int maxElement = arr[0];
    int maxSum = arr[0];
    int currentSum = arr[0];
    
    for (int i = 1; i < arr.length; i++) {
      maxElement = math.max(maxElement, arr[i]);
      currentSum = math.max(arr[i], currentSum + arr[i]);
      maxSum = math.max(maxSum, currentSum);
    }
    
    // If all numbers are negative, return the least negative
    return maxSum < 0 ? maxElement : maxSum;
  }
  
  // 2. Kadane's with at least k elements
  static int kadaneAtLeastK(List<int> arr, int k) {
    if (arr.length < k) {
      throw ArgumentError('Array length must be at least k');
    }
    
    // First, find sum of first k elements
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
      windowSum += arr[i];
    }
    
    int maxSum = windowSum;
    int currentSum = windowSum;
    
    for (int i = k; i < arr.length; i++) {
      // Add current element
      currentSum += arr[i];
      maxSum = math.max(maxSum, currentSum);
      
      // Remove elements from left if sum becomes negative
      // but maintain at least k elements
      if (currentSum < 0 && i >= 2 * k - 1) {
        currentSum = 0;
        // Recalculate for next k elements
        for (int j = i - k + 1; j <= i; j++) {
          currentSum += arr[j];
        }
      }
    }
    
    return maxSum;
  }
  
  // 3. Kadane's for circular array
  static int kadaneCircular(List<int> arr) {
    if (arr.isEmpty) return 0;
    
    // Case 1: Maximum subarray is non-circular (standard Kadane's)
    int maxKadane = kadaneMaxSum(arr);
    
    // Case 2: Maximum subarray is circular
    // This equals total sum - minimum subarray sum
    int totalSum = arr.reduce((a, b) => a + b);
    
    // Find minimum subarray sum (invert signs and find max)
    List<int> invertedArr = arr.map((x) => -x).toList();
    int maxInverted = kadaneMaxSum(invertedArr);
    int minSubarraySum = -maxInverted;
    
    int maxCircular = totalSum - minSubarraySum;
    
    // Handle edge case where all elements are negative
    if (maxCircular == 0) {
      return maxKadane;
    }
    
    return math.max(maxKadane, maxCircular);
  }
  
  // 4. Kadane's for maximum product subarray
  static int maxProductSubarray(List<int> arr) {
    if (arr.isEmpty) return 0;
    
    int maxProduct = arr[0];
    int minProduct = arr[0];  // Keep track of minimum for negative numbers
    int result = arr[0];
    
    for (int i = 1; i < arr.length; i++) {
      int current = arr[i];
      
      // If current is negative, swap max and min
      if (current < 0) {
        int temp = maxProduct;
        maxProduct = minProduct;
        minProduct = temp;
      }
      
      maxProduct = math.max(current, maxProduct * current);
      minProduct = math.min(current, minProduct * current);
      
      result = math.max(result, maxProduct);
    }
    
    return result;
  }
}

// Comprehensive Kadane's demonstration
void demonstrateKadane() {
  List<List<int>> testCases = [
    [-2, -3, 4, -1, -2, 1, 5, -3],  // Mixed positive/negative
    [-2, -3, -1, -5],                // All negative
    [1, 2, 3, 4, 5],                 // All positive
    [5, -3, 5],                      // Simple case
    [-1],                            // Single negative
    [1],                             // Single positive
    [2, 1, -3, 4, -1, 2, 1, -5, 4], // Classic example
  ];
  
  print('=== Kadane\'s Algorithm Demonstration ===\n');
  
  for (int i = 0; i < testCases.length; i++) {
    List<int> arr = testCases[i];
    print('Test Case ${i + 1}: $arr');
    
    // Basic Kadane's
    int maxSum = kadaneMaxSum(arr);
    print('  Maximum Sum: $maxSum');
    
    // Kadane's with indices
    MaxSubarrayResult result = kadaneWithIndices(arr);
    print('  $result');
    
    // All negative handling
    int allNegSum = KadaneVariations.kadaneAllNegative(arr);
    print('  All Negative Sum: $allNegSum');
    
    // Circular array
    int circularSum = KadaneVariations.kadaneCircular(arr);
    print('  Circular Array Sum: $circularSum');
    
    // Maximum product
    int maxProduct = KadaneVariations.maxProductSubarray(arr);
    print('  Maximum Product: $maxProduct');
    
    print('');
  }
}

// Real-world applications of Kadane's Algorithm
void realWorldKadaneApplications() {
  print('=== Real-world Applications ===\n');
  
  // 1. Stock Trading - Maximum Profit
  List<int> stockPrices = [7, 1, 5, 3, 6, 4];
  List<int> dailyChanges = [];
  for (int i = 1; i < stockPrices.length; i++) {
    dailyChanges.add(stockPrices[i] - stockPrices[i - 1]);
  }
  
  print('Stock Prices: $stockPrices');
  print('Daily Changes: $dailyChanges');
  
  MaxSubarrayResult bestTradingPeriod = kadaneWithIndices(dailyChanges);
  print('Best Trading Period: Days ${bestTradingPeriod.startIndex + 1} to ${bestTradingPeriod.endIndex + 1}');
  print('Maximum Profit: ${bestTradingPeriod.sum}');
  print('');
  
  // 2. Game Score Analysis
  List<int> gameScores = [3, -2, 5, -1, 2, -3, 4, -2, 1];
  print('Game Scores: $gameScores');
  
  MaxSubarrayResult bestStreak = kadaneWithIndices(gameScores);
  print('Best Winning Streak: Rounds ${bestStreak.startIndex + 1} to ${bestStreak.endIndex + 1}');
  print('Total Score in Best Streak: ${bestStreak.sum}');
  print('');
  
  // 3. Weather Data - Maximum Temperature Change
  List<int> temperatureChanges = [2, -3, 1, 4, -2, 3, -1, 2];
  print('Temperature Changes: $temperatureChanges');
  
  MaxSubarrayResult maxTempIncrease = kadaneWithIndices(temperatureChanges);
  print('Maximum Temperature Increase Period: Days ${maxTempIncrease.startIndex + 1} to ${maxTempIncrease.endIndex + 1}');
  print('Total Temperature Increase: ${maxTempIncrease.sum}°');
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
  
  // Three sum problem
  static List<List<int>> threeSum(List<int> arr, int target) {
    arr.sort();
    List<List<int>> result = [];
    
    for (int i = 0; i < arr.length - 2; i++) {
      // Skip duplicates for first element
      if (i > 0 && arr[i] == arr[i - 1]) continue;
      
      int left = i + 1;
      int right = arr.length - 1;
      
      while (left < right) {
        int sum = arr[i] + arr[left] + arr[right];
        
        if (sum == target) {
          result.add([arr[i], arr[left], arr[right]]);
          
          // Skip duplicates
          while (left < right && arr[left] == arr[left + 1]) left++;
          while (left < right && arr[right] == arr[right - 1]) right--;
          
          left++;
          right--;
        } else if (sum < target) {
          left++;
        } else {
          right--;
        }
      }
    }
    
    return result;
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
  
  // Minimum window substring (simplified version)
  static String minWindowSubstring(String s, String t) {
    if (s.length < t.length) return "";
    
    Map<String, int> targetMap = {};
    for (int i = 0; i < t.length; i++) {
      targetMap[t[i]] = (targetMap[t[i]] ?? 0) + 1;
    }
    
    int left = 0, right = 0;
    int minLen = s.length + 1;
    int minStart = 0;
    int matched = 0;
    
    Map<String, int> windowMap = {};
    
    while (right < s.length) {
      String rightChar = s[right];
      windowMap[rightChar] = (windowMap[rightChar] ?? 0) + 1;
      
      if (targetMap.containsKey(rightChar) && 
          windowMap[rightChar] == targetMap[rightChar]) {
        matched++;
      }
      
      while (matched == targetMap.length) {
        if (right - left + 1 < minLen) {
          minLen = right - left + 1;
          minStart = left;
        }
        
        String leftChar = s[left];
        windowMap[leftChar] = windowMap[leftChar]! - 1;
        
        if (targetMap.containsKey(leftChar) && 
            windowMap[leftChar]! < targetMap[leftChar]!) {
          matched--;
        }
        
        left++;
      }
      
      right++;
    }
    
    return minLen > s.length ? "" : s.substring(minStart, minStart + minLen);
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
| **Binary Search** | O(1) | - | - | O(log n) |

### Sorting Algorithm Comparison

| Algorithm | Best Case | Average Case | Worst Case | Space | Stable | Adaptive |
|-----------|-----------|--------------|------------|-------|---------|----------|
| **Bubble** | O(n) | O(n²) | O(n²) | O(1) | Yes | Yes |
| **Selection** | O(n²) | O(n²) | O(n²) | O(1) | No | No |
| **Insertion** | O(n) | O(n²) | O(n²) | O(1) | Yes | Yes |
| **Merge** | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes | No |
| **Quick** | O(n log n) | O(n log n) | O(n²) | O(log n) | No | No |
| **Heap** | O(n log n) | O(n log n) | O(n log n) | O(1) | No | No |

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
- **Search Algorithms**: Linear O(n), Binary O(log n)
- **Sorting Algorithms**: Various approaches with different trade-offs
- **Advanced Techniques**: Two pointers, sliding window, prefix sums

### **Kadane's Algorithm:**
- **Purpose**: Maximum subarray sum in O(n) time
- **Applications**: Stock trading, game scores, data analysis
- **Variations**: Circular arrays, minimum subarray, product arrays

### **Performance Considerations:**
- **Time Complexity**: Choose algorithms based on data size and requirements
- **Space Complexity**: Consider memory usage for large datasets
- **Stability**: Important for maintaining relative order
- **Adaptiveness**: Some algorithms perform better on partially sorted data

### **Best Practices:**
1. **Choose appropriate data structure** for your use case
2. **Pre-allocate memory** when size is known
3. **Use built-in methods** for better performance
4. **Handle edge cases** properly
5. **Consider algorithmic complexity** for operations

Arrays form the foundation for many other data structures and algorithms. Mastering array operations, sorting techniques, and algorithms like Kadane's is essential for solving complex programming problems efficiently.
