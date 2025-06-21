# Searching Algorithms in Dart

## Introduction to Searching

Searching is the process of finding a specific element or value within a collection of data. It's one of the fundamental operations in computer science and is used extensively in programming to locate information efficiently.

### Time Complexity Overview
- **Linear Search**: O(n)
- **Binary Search**: O(log n)
- **Jump Search**: O(√n)
- **Interpolation Search**: O(log log n) average case
- **Exponential Search**: O(log n)

---

## 1. Linear Search

Linear search is the simplest searching algorithm that checks each element sequentially until the target is found or the end of the array is reached.

**Time Complexity**: O(n)  
**Space Complexity**: O(1)

```dart
// Linear Search Implementation
int linearSearch(List<int> arr, int target) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      return i; // Return index if found
    }
  }
  return -1; // Return -1 if not found
}

// Example usage
void linearSearchExample() {
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90];
  int target = 22;
  
  int result = linearSearch(numbers, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

### Linear Search with Generic Type

```dart
// Generic Linear Search
int linearSearchGeneric<T>(List<T> arr, T target) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      return i;
    }
  }
  return -1;
}

// Example with strings
void linearSearchStringExample() {
  List<String> fruits = ['apple', 'banana', 'cherry', 'date'];
  String target = 'cherry';
  
  int result = linearSearchGeneric(fruits, target);
  print(result != -1 ? 'Found at index $result' : 'Not found');
}
```

---

## 2. Binary Search

Binary search is an efficient algorithm for searching in sorted arrays. It repeatedly divides the search interval in half.

**Time Complexity**: O(log n)  
**Space Complexity**: O(1) iterative, O(log n) recursive

### Iterative Binary Search

```dart
// Iterative Binary Search
int binarySearch(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) {
      return mid;
    }
    
    if (arr[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return -1; // Element not found
}

// Example usage
void binarySearchExample() {
  List<int> sortedNumbers = [11, 12, 22, 25, 34, 64, 90];
  int target = 25;
  
  int result = binarySearch(sortedNumbers, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

### Recursive Binary Search

```dart
// Recursive Binary Search
int binarySearchRecursive(List<int> arr, int target, int left, int right) {
  if (left > right) {
    return -1; // Base case: element not found
  }
  
  int mid = left + (right - left) ~/ 2;
  
  if (arr[mid] == target) {
    return mid;
  }
  
  if (arr[mid] > target) {
    return binarySearchRecursive(arr, target, left, mid - 1);
  } else {
    return binarySearchRecursive(arr, target, mid + 1, right);
  }
}

// Helper function for recursive binary search
int binarySearchRecursiveHelper(List<int> arr, int target) {
  return binarySearchRecursive(arr, target, 0, arr.length - 1);
}

// Example usage
void recursiveBinarySearchExample() {
  List<int> sortedNumbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  int target = 11;
  
  int result = binarySearchRecursiveHelper(sortedNumbers, target);
  print(result != -1 ? 'Found at index $result' : 'Not found');
}
```

---

## 3. Jump Search

Jump search works by jumping ahead by fixed steps and then performing a linear search in the identified block.

**Time Complexity**: O(√n)  
**Space Complexity**: O(1)

```dart
import 'dart:math';

// Jump Search Implementation
int jumpSearch(List<int> arr, int target) {
  int n = arr.length;
  int step = sqrt(n).floor();
  int prev = 0;
  
  // Finding the block where element is present
  while (arr[min(step, n) - 1] < target) {
    prev = step;
    step += sqrt(n).floor();
    if (prev >= n) {
      return -1;
    }
  }
  
  // Linear search in the identified block
  while (arr[prev] < target) {
    prev++;
    if (prev == min(step, n)) {
      return -1;
    }
  }
  
  // If element is found
  if (arr[prev] == target) {
    return prev;
  }
  
  return -1;
}

// Example usage
void jumpSearchExample() {
  List<int> sortedArray = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144];
  int target = 55;
  
  int result = jumpSearch(sortedArray, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

---

## 4. Interpolation Search

Interpolation search is an improvement over binary search for uniformly distributed sorted arrays.

**Time Complexity**: O(log log n) average, O(n) worst case  
**Space Complexity**: O(1)

```dart
// Interpolation Search Implementation
int interpolationSearch(List<int> arr, int target) {
  int low = 0;
  int high = arr.length - 1;
  
  while (low <= high && target >= arr[low] && target <= arr[high]) {
    // If there's only one element
    if (low == high) {
      if (arr[low] == target) return low;
      return -1;
    }
    
    // Calculate position using interpolation formula
    int pos = low + 
        ((target - arr[low]) * (high - low) / (arr[high] - arr[low])).floor();
    
    if (arr[pos] == target) {
      return pos;
    }
    
    if (arr[pos] < target) {
      low = pos + 1;
    } else {
      high = pos - 1;
    }
  }
  
  return -1;
}

// Example usage
void interpolationSearchExample() {
  List<int> uniformArray = [10, 12, 13, 16, 18, 19, 20, 21, 22, 23, 24, 33, 35, 42, 47];
  int target = 18;
  
  int result = interpolationSearch(uniformArray, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

---

## 5. Exponential Search

Exponential search involves two steps: first, find the range where the element might be present, then use binary search in that range.

**Time Complexity**: O(log n)  
**Space Complexity**: O(1)

```dart
// Exponential Search Implementation
int exponentialSearch(List<int> arr, int target) {
  int n = arr.length;
  
  // If target is at first position
  if (arr[0] == target) {
    return 0;
  }
  
  // Find range for binary search
  int i = 1;
  while (i < n && arr[i] <= target) {
    i = i * 2;
  }
  
  // Call binary search for the found range
  return binarySearchRange(arr, target, i ~/ 2, min(i, n - 1));
}

// Binary search in a specific range
int binarySearchRange(List<int> arr, int target, int left, int right) {
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) {
      return mid;
    }
    
    if (arr[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return -1;
}

// Example usage
void exponentialSearchExample() {
  List<int> sortedArray = [2, 3, 4, 10, 40, 50, 80, 100, 120, 150];
  int target = 40;
  
  int result = exponentialSearch(sortedArray, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

---

## 6. Ternary Search

Ternary search divides the array into three parts instead of two (like binary search).

**Time Complexity**: O(log₃ n)  
**Space Complexity**: O(1)

```dart
// Ternary Search Implementation
int ternarySearch(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid1 = left + (right - left) ~/ 3;
    int mid2 = right - (right - left) ~/ 3;
    
    if (arr[mid1] == target) {
      return mid1;
    }
    if (arr[mid2] == target) {
      return mid2;
    }
    
    if (target < arr[mid1]) {
      right = mid1 - 1;
    } else if (target > arr[mid2]) {
      left = mid2 + 1;
    } else {
      left = mid1 + 1;
      right = mid2 - 1;
    }
  }
  
  return -1;
}

// Example usage
void ternarySearchExample() {
  List<int> sortedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int target = 7;
  
  int result = ternarySearch(sortedArray, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

---

## 7. Search in Rotated Sorted Array

A special case where we need to search in a sorted array that has been rotated.

```dart
// Search in Rotated Sorted Array
int searchRotatedArray(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) {
      return mid;
    }
    
    // Check which half is sorted
    if (arr[left] <= arr[mid]) {
      // Left half is sorted
      if (target >= arr[left] && target < arr[mid]) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    } else {
      // Right half is sorted
      if (target > arr[mid] && target <= arr[right]) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
  }
  
  return -1;
}

// Example usage
void rotatedArraySearchExample() {
  List<int> rotatedArray = [4, 5, 6, 7, 0, 1, 2];
  int target = 0;
  
  int result = searchRotatedArray(rotatedArray, target);
  
  if (result != -1) {
    print('Element $target found at index $result');
  } else {
    print('Element $target not found');
  }
}
```

---

## 8. Search Utilities and Helper Functions

### Find First and Last Occurrence

```dart
// Find first occurrence of target
int findFirstOccurrence(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  int result = -1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) {
      result = mid;
      right = mid - 1; // Continue searching in left half
    } else if (arr[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return result;
}

// Find last occurrence of target
int findLastOccurrence(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  int result = -1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) {
      result = mid;
      left = mid + 1; // Continue searching in right half
    } else if (arr[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return result;
}

// Find range of target element
List<int> findRange(List<int> arr, int target) {
  int first = findFirstOccurrence(arr, target);
  int last = findLastOccurrence(arr, target);
  return [first, last];
}

// Example usage
void findRangeExample() {
  List<int> arrayWithDuplicates = [5, 7, 7, 8, 8, 8, 10];
  int target = 8;
  
  List<int> range = findRange(arrayWithDuplicates, target);
  print('First occurrence: ${range[0]}, Last occurrence: ${range[1]}');
}
```

---

## 9. Practical Examples and Usage

### Search in a List of Custom Objects

```dart
class Student {
  String name;
  int id;
  double gpa;
  
  Student(this.name, this.id, this.gpa);
  
  @override
  String toString() => 'Student(name: $name, id: $id, gpa: $gpa)';
}

// Linear search for student by ID
Student? findStudentById(List<Student> students, int targetId) {
  for (Student student in students) {
    if (student.id == targetId) {
      return student;
    }
  }
  return null;
}

// Binary search for student by ID (assuming list is sorted by ID)
Student? findStudentByIdBinary(List<Student> students, int targetId) {
  int left = 0;
  int right = students.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (students[mid].id == targetId) {
      return students[mid];
    }
    
    if (students[mid].id < targetId) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return null;
}

// Example usage
void studentSearchExample() {
  List<Student> students = [
    Student('Alice', 101, 3.8),
    Student('Bob', 102, 3.5),
    Student('Charlie', 103, 3.9),
    Student('Diana', 104, 3.7),
  ];
  
  // Linear search
  Student? found = findStudentById(students, 103);
  if (found != null) {
    print('Found: $found');
  }
  
  // Binary search (students already sorted by ID)
  Student? foundBinary = findStudentByIdBinary(students, 102);
  if (foundBinary != null) {
    print('Found with binary search: $foundBinary');
  }
}
```

---

## 10. Performance Comparison and Testing

```dart
import 'dart:math';

// Performance testing function
void performanceTest() {
  // Generate large sorted array
  List<int> largeArray = List.generate(100000, (index) => index * 2);
  int target = 50000;
  
  // Test Linear Search
  Stopwatch stopwatch = Stopwatch()..start();
  int linearResult = linearSearch(largeArray, target);
  stopwatch.stop();
  print('Linear Search: ${stopwatch.elapsedMicroseconds} microseconds');
  
  // Test Binary Search
  stopwatch.reset();
  stopwatch.start();
  int binaryResult = binarySearch(largeArray, target);
  stopwatch.stop();
  print('Binary Search: ${stopwatch.elapsedMicroseconds} microseconds');
  
  // Test Jump Search
  stopwatch.reset();
  stopwatch.start();
  int jumpResult = jumpSearch(largeArray, target);
  stopwatch.stop();
  print('Jump Search: ${stopwatch.elapsedMicroseconds} microseconds');
  
  print('All algorithms found element at index: $linearResult, $binaryResult, $jumpResult');
}
```

---

## Main Function - Running All Examples

```dart
void main() {
  print('=== SEARCHING ALGORITHMS IN DART ===\n');
  
  print('1. Linear Search:');
  linearSearchExample();
  linearSearchStringExample();
  
  print('\n2. Binary Search:');
  binarySearchExample();
  recursiveBinarySearchExample();
  
  print('\n3. Jump Search:');
  jumpSearchExample();
  
  print('\n4. Interpolation Search:');
  interpolationSearchExample();
  
  print('\n5. Exponential Search:');
  exponentialSearchExample();
  
  print('\n6. Ternary Search:');
  ternarySearchExample();
  
  print('\n7. Rotated Array Search:');
  rotatedArraySearchExample();
  
  print('\n8. Find Range:');
  findRangeExample();
  
  print('\n9. Student Search:');
  studentSearchExample();
  
  print('\n10. Performance Test:');
  performanceTest();
}
```

---

## Key Takeaways

1. **Linear Search**: Simple but inefficient for large datasets
2. **Binary Search**: Most efficient for sorted arrays
3. **Jump Search**: Good balance between linear and binary search
4. **Interpolation Search**: Best for uniformly distributed data
5. **Exponential Search**: Useful when the size of the array is unknown
6. **Ternary Search**: Alternative to binary search but generally not better

### When to Use Which Algorithm:

- **Unsorted data**: Linear Search
- **Sorted data**: Binary Search
- **Large sorted arrays**: Interpolation Search (if uniformly distributed)
- **Unknown array size**: Exponential Search
- **Memory constraints**: Any iterative implementation

Remember to always consider the nature of your data and the frequency of search operations when choosing an algorithm!