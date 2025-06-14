/*
 * TERNARY SEARCH ALGORITHM IN DART
 * 
 * Ternary Search is a divide-and-conquer search algorithm that divides the array
 * into three parts instead of two (like binary search). It works on sorted arrays
 * and finds the position of an element by comparing it with two mid-points.
 * 
 * Time Complexity: O(log₃ n) - where n is the number of elements
 * Space Complexity: O(1) for iterative, O(log n) for recursive
 * 
 * Comparison with Binary Search:
 * - Binary Search: O(log₂ n) ≈ O(log n)
 * - Ternary Search: O(log₃ n) ≈ O(log n)
 * 
 * Note: Although both have same complexity, binary search is generally faster
 * due to fewer comparisons per iteration.
 */

void main() {
  print("=== TERNARY SEARCH DEMONSTRATION ===\n");
  
  // Test data - MUST be sorted for ternary search
  List<int> sortedArray = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25];
  
  print("Sorted Array: $sortedArray");
  print("Array length: ${sortedArray.length}\n");
  
  // Test cases
  int target1 = 13;
  int target2 = 20;
  int target3 = 1;   // First element
  int target4 = 25;  // Last element
  
  print("--- Iterative Ternary Search ---");
  testTernarySearch(sortedArray, target1, "iterative");
  testTernarySearch(sortedArray, target2, "iterative");
  testTernarySearch(sortedArray, target3, "iterative");
  testTernarySearch(sortedArray, target4, "iterative");
  
  print("\n--- Recursive Ternary Search ---");
  testTernarySearchRecursive(sortedArray, target1);
  testTernarySearchRecursive(sortedArray, target2);
  
  print("\n--- Ternary Search with Steps ---");
  ternarySearchWithSteps(sortedArray, 15);
  
  print("\n--- Performance Comparison ---");
  performanceComparison();
  
  print("\n--- Finding Peak Element ---");
  List<int> peakArray = [1, 3, 8, 12, 4, 2];
  print("Array with peak: $peakArray");
  int peakIndex = findPeakElement(peakArray);
  print("Peak element found at index $peakIndex, value: ${peakArray[peakIndex]}");
  
  print("\n--- Ternary Search on Function ---");
  demonstrateFunctionSearch();
}

/**
 * Iterative Ternary Search
 * 
 * @param arr: Sorted array to search in
 * @param target: Element to search for
 * @return: Index of element if found, -1 otherwise
 */
int ternarySearch(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    // Calculate two mid points
    int mid1 = left + (right - left) ~/ 3;
    int mid2 = right - (right - left) ~/ 3;
    
    // Check if target is found at either mid point
    if (arr[mid1] == target) {
      return mid1;
    }
    if (arr[mid2] == target) {
      return mid2;
    }
    
    // Decide which third to search in
    if (target < arr[mid1]) {
      // Search in first third
      right = mid1 - 1;
    } else if (target > arr[mid2]) {
      // Search in last third
      left = mid2 + 1;
    } else {
      // Search in middle third
      left = mid1 + 1;
      right = mid2 - 1;
    }
  }
  
  return -1; // Element not found
}

/**
 * Recursive Ternary Search
 * 
 * @param arr: Sorted array to search in
 * @param target: Element to search for
 * @param left: Left boundary
 * @param right: Right boundary
 * @return: Index of element if found, -1 otherwise
 */
int ternarySearchRecursive(List<int> arr, int target, int left, int right) {
  if (left > right) {
    return -1; // Base case: element not found
  }
  
  // Calculate two mid points
  int mid1 = left + (right - left) ~/ 3;
  int mid2 = right - (right - left) ~/ 3;
  
  // Check if target is found at either mid point
  if (arr[mid1] == target) {
    return mid1;
  }
  if (arr[mid2] == target) {
    return mid2;
  }
  
  // Recursive calls for appropriate third
  if (target < arr[mid1]) {
    return ternarySearchRecursive(arr, target, left, mid1 - 1);
  } else if (target > arr[mid2]) {
    return ternarySearchRecursive(arr, target, mid2 + 1, right);
  } else {
    return ternarySearchRecursive(arr, target, mid1 + 1, mid2 - 1);
  }
}

/**
 * Ternary Search with Step-by-Step Visualization
 */
void ternarySearchWithSteps(List<int> arr, int target) {
  print("Searching for $target in ${arr.sublist(0, 10)}...");
  print("Step-by-step process:");
  
  int left = 0;
  int right = arr.length - 1;
  int step = 1;
  
  while (left <= right) {
    int mid1 = left + (right - left) ~/ 3;
    int mid2 = right - (right - left) ~/ 3;
    
    print("Step $step:");
    print("  Range: [$left, $right] = ${arr.sublist(left, right + 1)}");
    print("  Mid1: index $mid1, value ${arr[mid1]}");
    print("  Mid2: index $mid2, value ${arr[mid2]}");
    
    if (arr[mid1] == target) {
      print("  ✓ Found at mid1! Target $target is at index $mid1");
      return;
    }
    if (arr[mid2] == target) {
      print("  ✓ Found at mid2! Target $target is at index $mid2");
      return;
    }
    
    if (target < arr[mid1]) {
      print("  → Target < ${arr[mid1]}, search in first third");
      right = mid1 - 1;
    } else if (target > arr[mid2]) {
      print("  → Target > ${arr[mid2]}, search in last third");
      left = mid2 + 1;
    } else {
      print("  → ${arr[mid1]} < Target < ${arr[mid2]}, search in middle third");
      left = mid1 + 1;
      right = mid2 - 1;
    }
    
    step++;
    print("");
  }
  
  print("✗ Element $target not found in the array");
}

/**
 * Test helper function
 */
void testTernarySearch(List<int> arr, int target, String type) {
  int result = ternarySearch(arr, target);
  print("Searching for $target: ${result != -1 ? 'Found at index $result' : 'Not found'}");
}

void testTernarySearchRecursive(List<int> arr, int target) {
  int result = ternarySearchRecursive(arr, target, 0, arr.length - 1);
  print("Searching for $target: ${result != -1 ? 'Found at index $result' : 'Not found'}");
}

/**
 * Performance Comparison between Binary and Ternary Search
 */
void performanceComparison() {
  List<int> sizes = [1000, 10000, 100000];
  
  for (int size in sizes) {
    List<int> testArray = List.generate(size, (index) => index * 2);
    int target = size - 2; // Search for an element near the end
    
    // Ternary Search
    Stopwatch stopwatch1 = Stopwatch()..start();
    ternarySearch(testArray, target);
    stopwatch1.stop();
    
    // Binary Search (for comparison)
    Stopwatch stopwatch2 = Stopwatch()..start();
    binarySearch(testArray, target);
    stopwatch2.stop();
    
    print("Array size: $size");
    print("  Ternary Search: ${stopwatch1.elapsedMicroseconds} microseconds");
    print("  Binary Search:  ${stopwatch2.elapsedMicroseconds} microseconds");
  }
}

/**
 * Binary Search for comparison
 */
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

/**
 * Finding Peak Element using Ternary Search
 * A peak element is greater than its neighbors
 */
int findPeakElement(List<int> arr) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left < right) {
    int mid1 = left + (right - left) ~/ 3;
    int mid2 = right - (right - left) ~/ 3;
    
    if (arr[mid1] < arr[mid2]) {
      left = mid1 + 1;
    } else {
      right = mid2 - 1;
    }
  }
  
  return left;
}

/**
 * Ternary Search on Mathematical Functions
 * Find minimum/maximum of unimodal functions
 */
void demonstrateFunctionSearch() {
  print("Finding minimum of function f(x) = (x-5)² in range [0, 10]");
  
  double left = 0.0;
  double right = 10.0;
  double precision = 1e-6;
  
  while (right - left > precision) {
    double mid1 = left + (right - left) / 3;
    double mid2 = right - (right - left) / 3;
    
    double f1 = (mid1 - 5) * (mid1 - 5); // f(mid1)
    double f2 = (mid2 - 5) * (mid2 - 5); // f(mid2)
    
    if (f1 > f2) {
      left = mid1;
    } else {
      right = mid2;
    }
  }
  
  double minimum = (left + right) / 2;
  print("Minimum found at x = ${minimum.toStringAsFixed(6)}");
  print("Function value = ${((minimum - 5) * (minimum - 5)).toStringAsFixed(6)}");
}

/**
 * Generic Ternary Search
 */
int ternarySearchGeneric<T extends Comparable<T>>(List<T> arr, T target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid1 = left + (right - left) ~/ 3;
    int mid2 = right - (right - left) ~/ 3;
    
    int cmp1 = arr[mid1].compareTo(target);
    int cmp2 = arr[mid2].compareTo(target);
    
    if (cmp1 == 0) return mid1;
    if (cmp2 == 0) return mid2;
    
    if (cmp1 > 0) {
      right = mid1 - 1;
    } else if (cmp2 < 0) {
      left = mid2 + 1;
    } else {
      left = mid1 + 1;
      right = mid2 - 1;
    }
  }
  
  return -1;
}

/**
 * ADVANTAGES OF TERNARY SEARCH:
 * 1. Divides search space into three parts (better than linear)
 * 2. Works well for finding extrema in unimodal functions
 * 3. Can be used for optimization problems
 * 4. Logarithmic time complexity
 * 
 * DISADVANTAGES OF TERNARY SEARCH:
 * 1. More comparisons per iteration than binary search
 * 2. Only works on sorted data
 * 3. Generally slower than binary search for searching
 * 4. More complex implementation
 * 
 * WHEN TO USE TERNARY SEARCH:
 * 1. Finding minimum/maximum of unimodal functions
 * 2. Optimization problems where you need to find extrema
 * 3. When you have a ternary decision problem
 * 4. Mathematical applications requiring function analysis
 * 
 * COMPARISON WITH BINARY SEARCH:
 * - Binary Search: 1 comparison per iteration, log₂(n) iterations
 * - Ternary Search: 2 comparisons per iteration, log₃(n) iterations
 * - Total comparisons: Binary ≈ log₂(n), Ternary ≈ 2×log₃(n) ≈ 1.26×log₂(n)
 * - Therefore, Binary Search is generally more efficient for searching
 */