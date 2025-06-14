/*
 * Binary Search Algorithm in Dart
 * 
 * Binary Search is a highly efficient searching algorithm that works on sorted arrays.
 * It follows the "divide and conquer" approach by repeatedly dividing the search 
 * space in half until the target element is found or the search space is exhausted.
 * 
 * Time Complexity: O(log n)
 * Space Complexity: O(1) for iterative, O(log n) for recursive
 * 
 * Prerequisites: The array must be sorted in ascending or descending order
 */

void main() {
  print("=== Binary Search Algorithm in Dart ===\n");
  
  // Test data - MUST be sorted for binary search to work
  List<int> sortedNumbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25];
  List<String> sortedNames = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank"];
  
  print("Sorted Array: $sortedNumbers");
  print("Array Length: ${sortedNumbers.length}\n");
  
  // Test cases
  testBinarySearch(sortedNumbers, 7);    // Found
  testBinarySearch(sortedNumbers, 25);   // Found (last element)
  testBinarySearch(sortedNumbers, 1);    // Found (first element)
  testBinarySearch(sortedNumbers, 12);   // Not found
  testBinarySearch(sortedNumbers, 0);    // Not found (smaller than min)
  testBinarySearch(sortedNumbers, 30);   // Not found (larger than max)
  
  print("\n--- Binary Search with Strings ---");
  print("Sorted Names: $sortedNames");
  testBinarySearchString(sortedNames, "Charlie");
  testBinarySearchString(sortedNames, "Zoe");
  
  print("\n--- Recursive vs Iterative Comparison ---");
  int target = 15;
  int iterativeResult = binarySearchIterative(sortedNumbers, target);
  int recursiveResult = binarySearchRecursive(sortedNumbers, target, 0, sortedNumbers.length - 1);
  print("Target: $target");
  print("Iterative result: $iterativeResult");
  print("Recursive result: $recursiveResult");
  
  // Demonstrate step-by-step process
  print("\n--- Step-by-Step Binary Search Process ---");
  binarySearchWithSteps(sortedNumbers, 13);
}

/**
 * Binary Search - Iterative Implementation
 * 
 * This is the most common and memory-efficient implementation of binary search.
 * It uses a loop instead of recursion, avoiding function call overhead.
 * 
 * Parameters:
 * - arr: Sorted array to search in
 * - target: Element to find
 * 
 * Returns: Index of target element, or -1 if not found
 */
int binarySearchIterative(List<int> arr, int target) {
  int left = 0;                    // Start of search range
  int right = arr.length - 1;      // End of search range
  
  while (left <= right) {
    // Calculate middle index (prevents integer overflow)
    int mid = left + (right - left) ~/ 2;
    
    // Check if target is at middle
    if (arr[mid] == target) {
      return mid;  // Found! Return index
    }
    
    // If target is smaller, search left half
    else if (arr[mid] > target) {
      right = mid - 1;
    }
    
    // If target is larger, search right half
    else {
      left = mid + 1;
    }
  }
  
  return -1;  // Target not found
}

/**
 * Binary Search - Recursive Implementation
 * 
 * This implementation uses recursion to divide the problem into smaller subproblems.
 * Each recursive call works on a smaller portion of the array.
 * 
 * Parameters:
 * - arr: Sorted array to search in
 * - target: Element to find
 * - left: Start index of current search range
 * - right: End index of current search range
 * 
 * Returns: Index of target element, or -1 if not found
 */
int binarySearchRecursive(List<int> arr, int target, int left, int right) {
  // Base case: search range is invalid
  if (left > right) {
    return -1;
  }
  
  // Calculate middle index
  int mid = left + (right - left) ~/ 2;
  
  // Base case: target found
  if (arr[mid] == target) {
    return mid;
  }
  
  // Recursive case: search left half
  if (arr[mid] > target) {
    return binarySearchRecursive(arr, target, left, mid - 1);
  }
  
  // Recursive case: search right half
  return binarySearchRecursive(arr, target, mid + 1, right);
}

/**
 * Binary Search for Strings
 * 
 * Demonstrates binary search with string comparison using compareTo method.
 * Strings are compared lexicographically (dictionary order).
 */
int binarySearchString(List<String> arr, String target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    int comparison = arr[mid].compareTo(target);
    
    if (comparison == 0) {
      return mid;  // Strings are equal
    } else if (comparison > 0) {
      right = mid - 1;  // arr[mid] comes after target alphabetically
    } else {
      left = mid + 1;   // arr[mid] comes before target alphabetically
    }
  }
  
  return -1;
}

/**
 * Binary Search with detailed step-by-step output
 * 
 * This function shows exactly how binary search narrows down the search space
 * in each iteration, helping visualize the algorithm's efficiency.
 */
void binarySearchWithSteps(List<int> arr, int target) {
  print("Searching for $target in array: $arr");
  print("Array indices: ${List.generate(arr.length, (i) => i)}");
  
  int left = 0;
  int right = arr.length - 1;
  int step = 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    print("\nStep $step:");
    print("  Search range: [$left, $right] (${right - left + 1} elements)");
    print("  Middle index: $mid, Middle value: ${arr[mid]}");
    
    if (arr[mid] == target) {
      print("  ✓ Target found at index $mid!");
      return;
    } else if (arr[mid] > target) {
      print("  ${arr[mid]} > $target, searching left half");
      right = mid - 1;
    } else {
      print("  ${arr[mid]} < $target, searching right half");
      left = mid + 1;
    }
    
    step++;
  }
  
  print("\n  ✗ Target $target not found in array");
}

/**
 * Helper function to test binary search with detailed output
 */
void testBinarySearch(List<int> arr, int target) {
  int result = binarySearchIterative(arr, target);
  if (result != -1) {
    print("🎯 Found $target at index $result (value: ${arr[result]})");
  } else {
    print("❌ $target not found in the array");
  }
}

/**
 * Helper function to test binary search with strings
 */
void testBinarySearchString(List<String> arr, String target) {
  int result = binarySearchString(arr, target);
  if (result != -1) {
    print("🎯 Found '$target' at index $result");
  } else {
    print("❌ '$target' not found in the array");
  }
}

/**
 * BINARY SEARCH CONCEPT EXPLANATION:
 * 
 * 1. PREREQUISITE: Array must be sorted
 *    - Binary search only works on sorted data
 *    - For unsorted data, use linear search or sort first
 * 
 * 2. DIVIDE AND CONQUER:
 *    - Start with entire array as search space
 *    - Find middle element
 *    - Compare middle with target
 *    - Eliminate half of the search space
 *    - Repeat until found or search space is empty
 * 
 * 3. THREE SCENARIOS IN EACH ITERATION:
 *    a) arr[mid] == target → Found! Return index
 *    b) arr[mid] > target → Search left half (target is smaller)
 *    c) arr[mid] < target → Search right half (target is larger)
 * 
 * 4. TIME COMPLEXITY: O(log n)
 *    - Each iteration eliminates half the elements
 *    - For array of size n, maximum log₂(n) iterations needed
 *    - Example: Array of 1000 elements needs at most 10 comparisons
 * 
 * 5. SPACE COMPLEXITY:
 *    - Iterative: O(1) - constant extra space
 *    - Recursive: O(log n) - due to function call stack
 * 
 * 6. ADVANTAGES:
 *    - Very fast for large datasets
 *    - Predictable performance
 *    - Simple to implement
 * 
 * 7. DISADVANTAGES:
 *    - Requires sorted data
 *    - Not suitable for frequently changing datasets
 *    - Only works with random access data structures (arrays, not linked lists)
 * 
 * 8. REAL-WORLD APPLICATIONS:
 *    - Database indexing
 *    - Dictionary/phone book searches
 *    - Version control systems
 *    - Game development (collision detection)
 *    - Finding insertion points in sorted arrays
 */
