/*
 * LINEAR SEARCH ALGORITHM IN DART
 * 
 * Linear Search is the simplest searching algorithm that searches for an element
 * in a list in sequential manner. It starts searching from the first element
 * and continues until the element is found or the list ends.
 * 
 * Time Complexity: O(n) - where n is the number of elements
 * Space Complexity: O(1) - constant space
 * 
 * Best Case: O(1) - element found at first position
 * Worst Case: O(n) - element found at last position or not found
 * Average Case: O(n/2) - element found at middle position
 */

void main() {
  print("=== LINEAR SEARCH DEMONSTRATION ===\n");
  
  // Test data
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90, 88, 76, 45];
  String word = "flutter";
  List<String> fruits = ["apple", "banana", "orange", "grape", "mango"];
  
  print("Array: $numbers");
  
  // Test cases for integer search
  int target1 = 22;
  int target2 = 99;
  
  print("\n--- Basic Linear Search ---");
  int result1 = linearSearch(numbers, target1);
  int result2 = linearSearch(numbers, target2);
  
  print("Searching for $target1: ${result1 != -1 ? 'Found at index $result1' : 'Not found'}");
  print("Searching for $target2: ${result2 != -1 ? 'Found at index $result2' : 'Not found'}");
  
  // Test string search
  print("\n--- String Linear Search ---");
  print("Fruits: $fruits");
  int fruitIndex = linearSearchString(fruits, "orange");
  print("Searching for 'orange': ${fruitIndex != -1 ? 'Found at index $fruitIndex' : 'Not found'}");
  
  // Character search in string
  print("\n--- Character Search in String ---");
  print("Word: '$word'");
  int charIndex = linearSearchChar(word, 't');
  print("Searching for 't': ${charIndex != -1 ? 'Found at index $charIndex' : 'Not found'}");
  
  // Search with detailed steps
  print("\n--- Linear Search with Steps ---");
  linearSearchWithSteps(numbers, 25);
  
  // Multiple occurrences
  print("\n--- Find All Occurrences ---");
  List<int> duplicateArray = [1, 3, 5, 3, 7, 3, 9];
  print("Array with duplicates: $duplicateArray");
  List<int> allIndices = findAllOccurrences(duplicateArray, 3);
  print("All indices of 3: $allIndices");
  
  // Performance comparison
  print("\n--- Performance Test ---");
  performanceTest();
}

/**
 * Basic Linear Search Algorithm
 * 
 * @param arr: List of integers to search in
 * @param target: The element to search for
 * @return: Index of the element if found, -1 otherwise
 */
int linearSearch(List<int> arr, int target) {
  // Iterate through each element in the array
  for (int i = 0; i < arr.length; i++) {
    // Check if current element matches the target
    if (arr[i] == target) {
      return i; // Return the index where element is found
    }
  }
  return -1; // Return -1 if element is not found
}

/**
 * Linear Search for Strings
 * 
 * @param arr: List of strings to search in
 * @param target: The string to search for
 * @return: Index of the string if found, -1 otherwise
 */
int linearSearchString(List<String> arr, String target) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      return i;
    }
  }
  return -1;
}

/**
 * Linear Search for Character in String
 * 
 * @param str: String to search in
 * @param target: Character to search for
 * @return: Index of the character if found, -1 otherwise
 */
int linearSearchChar(String str, String target) {
  for (int i = 0; i < str.length; i++) {
    if (str[i] == target) {
      return i;
    }
  }
  return -1;
}

/**
 * Linear Search with Step-by-Step Output
 * Shows how the algorithm works internally
 */
void linearSearchWithSteps(List<int> arr, int target) {
  print("Searching for $target in $arr");
  print("Step-by-step process:");
  
  for (int i = 0; i < arr.length; i++) {
    print("Step ${i + 1}: Checking arr[$i] = ${arr[i]}");
    
    if (arr[i] == target) {
      print("✓ Found! Element $target is at index $i");
      return;
    } else {
      print("✗ ${arr[i]} ≠ $target, continue searching...");
    }
  }
  
  print("✗ Element $target not found in the array");
}

/**
 * Find All Occurrences of an Element
 * Returns all indices where the target element is found
 */
List<int> findAllOccurrences(List<int> arr, int target) {
  List<int> indices = [];
  
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      indices.add(i);
    }
  }
  
  return indices;
}

/**
 * Generic Linear Search using Dart Generics
 * Can search for any comparable type
 */
int linearSearchGeneric<T>(List<T> arr, T target) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == target) {
      return i;
    }
  }
  return -1;
}

/**
 * Linear Search with Custom Comparison Function
 * Allows custom logic for comparing elements
 */
int linearSearchCustom<T>(List<T> arr, bool Function(T) predicate) {
  for (int i = 0; i < arr.length; i++) {
    if (predicate(arr[i])) {
      return i;
    }
  }
  return -1;
}

/**
 * Performance Test to demonstrate time complexity
 */
void performanceTest() {
  // Create arrays of different sizes
  List<int> sizes = [100, 1000, 10000];
  
  for (int size in sizes) {
    List<int> testArray = List.generate(size, (index) => index);
    int target = size - 1; // Worst case: search for last element
    
    Stopwatch stopwatch = Stopwatch()..start();
    int result = linearSearch(testArray, target);
    stopwatch.stop();
    
    print("Array size: $size, Time: ${stopwatch.elapsedMicroseconds} microseconds");
  }
}

/**
 * ADVANTAGES OF LINEAR SEARCH:
 * 1. Simple to understand and implement
 * 2. Works on both sorted and unsorted arrays
 * 3. No extra memory required (in-place algorithm)
 * 4. Suitable for small datasets
 * 5. Can be used on any data structure that supports sequential access
 * 
 * DISADVANTAGES OF LINEAR SEARCH:
 * 1. Inefficient for large datasets (O(n) time complexity)
 * 2. Not suitable when quick search is required
 * 3. No early termination optimization for unsorted data
 * 
 * WHEN TO USE LINEAR SEARCH:
 * 1. Small datasets (< 100 elements)
 * 2. Unsorted data where sorting cost is high
 * 3. When simplicity is more important than efficiency
 * 4. One-time searches where optimization setup cost is not justified
 * 5. When searching for multiple criteria or custom conditions
 */