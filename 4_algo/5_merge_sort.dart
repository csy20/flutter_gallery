/*
 * MERGE SORT ALGORITHM IN DART
 * 
 * Merge Sort is a divide-and-conquer algorithm that divides the array into
 * two halves, recursively sorts them, and then merges the sorted halves.
 * It's one of the most efficient sorting algorithms.
 * 
 * Time Complexity: O(n log n) in all cases (best, average, worst)
 * Space Complexity: O(n) - requires additional space for merging
 * 
 * Characteristics:
 * - Stable: Maintains relative order of equal elements
 * - Not in-place: Requires extra memory
 * - Recursive: Uses divide-and-conquer approach
 * - Predictable: Same performance regardless of input
 */

void main() {
  print("=== MERGE SORT DEMONSTRATION ===\n");
  
  // Test cases
  List<int> array1 = [64, 34, 25, 12, 22, 11, 90, 88, 76, 45];
  List<int> array2 = [5, 2, 8, 1, 9, 3];
  List<int> array3 = [1, 2, 3, 4, 5]; // Already sorted
  List<int> array4 = [5, 4, 3, 2, 1]; // Reverse sorted
  List<int> array5 = [42]; // Single element
  List<int> array6 = []; // Empty array
  
  print("--- Basic Merge Sort ---");
  testMergeSort(array1.toList(), "Random array");
  testMergeSort(array2.toList(), "Small array");
  testMergeSort(array3.toList(), "Already sorted");
  testMergeSort(array4.toList(), "Reverse sorted");
  testMergeSort(array5.toList(), "Single element");
  testMergeSort(array6.toList(), "Empty array");
  
  print("\n--- Merge Sort with Steps ---");
  List<int> stepArray = [38, 27, 43, 3, 9, 82, 10];
  mergeSortWithSteps(stepArray);
  
  print("\n--- Merge Process Visualization ---");
  List<int> left = [1, 3, 5, 7];
  List<int> right = [2, 4, 6, 8];
  print("Merging $left and $right");
  List<int> merged = mergeWithSteps(left, right);
  print("Result: $merged");
  
  print("\n--- String Merge Sort ---");
  List<String> words = ["banana", "apple", "cherry", "date", "elderberry"];
  print("Original: $words");
  mergeSortStrings(words, 0, words.length - 1);
  print("Sorted: $words");
  
  print("\n--- Performance Analysis ---");
  performanceAnalysis();
  
  print("\n--- Bottom-Up Merge Sort ---");
  List<int> bottomUpArray = [64, 34, 25, 12, 22, 11, 90];
  print("Original: $bottomUpArray");
  bottomUpMergeSort(bottomUpArray);
  print("Sorted: $bottomUpArray");
}

/**
 * Main Merge Sort Function
 * Recursively divides the array and calls merge to combine sorted halves
 * 
 * @param arr: Array to be sorted
 * @param left: Starting index
 * @param right: Ending index
 */
void mergeSort(List<int> arr, int left, int right) {
  if (left < right) {
    // Find the middle point to divide the array into two halves
    int middle = left + (right - left) ~/ 2;
    
    // Recursively sort first and second halves
    mergeSort(arr, left, middle);
    mergeSort(arr, middle + 1, right);
    
    // Merge the sorted halves
    merge(arr, left, middle, right);
  }
}

/**
 * Merge Function
 * Merges two sorted subarrays into one sorted array
 * 
 * @param arr: Array containing both subarrays
 * @param left: Starting index of left subarray
 * @param middle: Ending index of left subarray
 * @param right: Ending index of right subarray
 */
void merge(List<int> arr, int left, int middle, int right) {
  // Sizes of the two subarrays to be merged
  int leftSize = middle - left + 1;
  int rightSize = right - middle;
  
  // Create temporary arrays
  List<int> leftArray = List<int>.filled(leftSize, 0);
  List<int> rightArray = List<int>.filled(rightSize, 0);
  
  // Copy data to temporary arrays
  for (int i = 0; i < leftSize; i++) {
    leftArray[i] = arr[left + i];
  }
  for (int j = 0; j < rightSize; j++) {
    rightArray[j] = arr[middle + 1 + j];
  }
  
  // Merge the temporary arrays back into arr[left..right]
  int i = 0; // Initial index of left subarray
  int j = 0; // Initial index of right subarray
  int k = left; // Initial index of merged subarray
  
  while (i < leftSize && j < rightSize) {
    if (leftArray[i] <= rightArray[j]) {
      arr[k] = leftArray[i];
      i++;
    } else {
      arr[k] = rightArray[j];
      j++;
    }
    k++;
  }
  
  // Copy remaining elements of leftArray[], if any
  while (i < leftSize) {
    arr[k] = leftArray[i];
    i++;
    k++;
  }
  
  // Copy remaining elements of rightArray[], if any
  while (j < rightSize) {
    arr[k] = rightArray[j];
    j++;
    k++;
  }
}

/**
 * Merge Sort with Step-by-Step Visualization
 */
void mergeSortWithSteps(List<int> arr) {
  print("Original array: $arr");
  print("\nStep-by-step merge sort process:");
  _mergeSortSteps(arr, 0, arr.length - 1, 0);
  print("\nFinal sorted array: $arr");
}

void _mergeSortSteps(List<int> arr, int left, int right, int depth) {
  String indent = "  " * depth;
  
  if (left < right) {
    int middle = left + (right - left) ~/ 2;
    
    print("${indent}Dividing: ${arr.sublist(left, right + 1)} at index $middle");
    
    // Recursively sort first and second halves
    _mergeSortSteps(arr, left, middle, depth + 1);
    _mergeSortSteps(arr, middle + 1, right, depth + 1);
    
    // Store the state before merging
    List<int> beforeMerge = arr.sublist(left, right + 1);
    
    // Merge the sorted halves
    merge(arr, left, middle, right);
    
    print("${indent}Merging: $beforeMerge → ${arr.sublist(left, right + 1)}");
  }
}

/**
 * Merge function with step-by-step visualization
 */
List<int> mergeWithSteps(List<int> left, List<int> right) {
  List<int> result = [];
  int i = 0, j = 0;
  int step = 1;
  
  print("Step-by-step merging process:");
  
  while (i < left.length && j < right.length) {
    print("Step $step: Compare ${left[i]} and ${right[j]}");
    
    if (left[i] <= right[j]) {
      result.add(left[i]);
      print("  → Add ${left[i]} from left array");
      i++;
    } else {
      result.add(right[j]);
      print("  → Add ${right[j]} from right array");
      j++;
    }
    
    print("  Current result: $result");
    step++;
  }
  
  // Add remaining elements
  while (i < left.length) {
    result.add(left[i]);
    print("Step $step: Add remaining ${left[i]} from left");
    i++;
    step++;
  }
  
  while (j < right.length) {
    result.add(right[j]);
    print("Step $step: Add remaining ${right[j]} from right");
    j++;
    step++;
  }
  
  return result;
}

/**
 * Test helper function
 */
void testMergeSort(List<int> arr, String description) {
  print("$description:");
  print("  Before: $arr");
  
  if (arr.isNotEmpty) {
    mergeSort(arr, 0, arr.length - 1);
  }
  
  print("  After:  $arr");
  print("  Sorted: ${isSorted(arr) ? 'Yes' : 'No'}");
  print("");
}

/**
 * Check if array is sorted
 */
bool isSorted(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] < arr[i - 1]) {
      return false;
    }
  }
  return true;
}

/**
 * Merge Sort for Strings
 */
void mergeSortStrings(List<String> arr, int left, int right) {
  if (left < right) {
    int middle = left + (right - left) ~/ 2;
    
    mergeSortStrings(arr, left, middle);
    mergeSortStrings(arr, middle + 1, right);
    
    mergeStrings(arr, left, middle, right);
  }
}

void mergeStrings(List<String> arr, int left, int middle, int right) {
  int leftSize = middle - left + 1;
  int rightSize = right - middle;
  
  List<String> leftArray = List<String>.filled(leftSize, '');
  List<String> rightArray = List<String>.filled(rightSize, '');
  
  for (int i = 0; i < leftSize; i++) {
    leftArray[i] = arr[left + i];
  }
  for (int j = 0; j < rightSize; j++) {
    rightArray[j] = arr[middle + 1 + j];
  }
  
  int i = 0, j = 0, k = left;
  
  while (i < leftSize && j < rightSize) {
    if (leftArray[i].compareTo(rightArray[j]) <= 0) {
      arr[k] = leftArray[i];
      i++;
    } else {
      arr[k] = rightArray[j];
      j++;
    }
    k++;
  }
  
  while (i < leftSize) {
    arr[k] = leftArray[i];
    i++;
    k++;
  }
  
  while (j < rightSize) {
    arr[k] = rightArray[j];
    j++;
    k++;
  }
}

/**
 * Bottom-Up Merge Sort (Iterative Implementation)
 * Non-recursive approach that builds up sorted subarrays
 */
void bottomUpMergeSort(List<int> arr) {
  int n = arr.length;
  
  // Start with subarrays of size 1, then 2, 4, 8, ...
  for (int size = 1; size < n; size *= 2) {
    print("Processing subarrays of size $size");
    
    // Pick starting point of left subarray
    for (int left = 0; left < n - 1; left += 2 * size) {
      // Calculate middle and right points
      int middle = (left + size - 1 < n - 1) ? left + size - 1 : n - 1;
      int right = (left + 2 * size - 1 < n - 1) ? left + 2 * size - 1 : n - 1;
      
      // Merge subarrays if middle < right
      if (middle < right) {
        merge(arr, left, middle, right);
        print("  Merged: ${arr.sublist(left, right + 1)}");
      }
    }
    
    print("  Array after size $size: $arr");
  }
}

/**
 * Performance Analysis
 */
void performanceAnalysis() {
  List<int> sizes = [100, 1000, 10000];
  
  for (int size in sizes) {
    // Random array
    List<int> randomArray = List.generate(size, (index) => (index * 7 + 13) % 1000);
    
    // Already sorted array
    List<int> sortedArray = List.generate(size, (index) => index);
    
    // Reverse sorted array
    List<int> reverseArray = List.generate(size, (index) => size - index);
    
    // Test random array
    Stopwatch sw1 = Stopwatch()..start();
    mergeSort(randomArray, 0, randomArray.length - 1);
    sw1.stop();
    
    // Test sorted array
    Stopwatch sw2 = Stopwatch()..start();
    mergeSort(sortedArray, 0, sortedArray.length - 1);
    sw2.stop();
    
    // Test reverse array
    Stopwatch sw3 = Stopwatch()..start();
    mergeSort(reverseArray, 0, reverseArray.length - 1);
    sw3.stop();
    
    print("Array size: $size");
    print("  Random:  ${sw1.elapsedMicroseconds} microseconds");
    print("  Sorted:  ${sw2.elapsedMicroseconds} microseconds");
    print("  Reverse: ${sw3.elapsedMicroseconds} microseconds");
  }
}

/**
 * Generic Merge Sort
 */
void mergeSortGeneric<T extends Comparable<T>>(List<T> arr, int left, int right) {
  if (left < right) {
    int middle = left + (right - left) ~/ 2;
    
    mergeSortGeneric(arr, left, middle);
    mergeSortGeneric(arr, middle + 1, right);
    
    mergeGeneric(arr, left, middle, right);
  }
}

void mergeGeneric<T extends Comparable<T>>(List<T> arr, int left, int middle, int right) {
  int leftSize = middle - left + 1;
  int rightSize = right - middle;
  
  List<T> leftArray = arr.sublist(left, middle + 1);
  List<T> rightArray = arr.sublist(middle + 1, right + 1);
  
  int i = 0, j = 0, k = left;
  
  while (i < leftSize && j < rightSize) {
    if (leftArray[i].compareTo(rightArray[j]) <= 0) {
      arr[k] = leftArray[i];
      i++;
    } else {
      arr[k] = rightArray[j];
      j++;
    }
    k++;
  }
  
  while (i < leftSize) {
    arr[k] = leftArray[i];
    i++;
    k++;
  }
  
  while (j < rightSize) {
    arr[k] = rightArray[j];
    j++;
    k++;
  }
}

/**
 * ADVANTAGES OF MERGE SORT:
 * 1. Stable sorting algorithm - maintains relative order of equal elements
 * 2. Guaranteed O(n log n) time complexity in all cases
 * 3. Predictable performance - same complexity for best, average, and worst cases
 * 4. Good for large datasets
 * 5. Can be easily parallelized
 * 6. Works well with linked lists (no random access needed)
 * 7. External sorting - can sort data that doesn't fit in memory
 * 
 * DISADVANTAGES OF MERGE SORT:
 * 1. Requires O(n) extra space for merging
 * 2. Not in-place sorting algorithm
 * 3. Slower than quicksort on average for small arrays
 * 4. More complex implementation compared to simple sorts
 * 5. Not adaptive - doesn't perform better on partially sorted data
 * 
 * WHEN TO USE MERGE SORT:
 * 1. When stable sorting is required
 * 2. When worst-case O(n log n) performance is needed
 * 3. For large datasets where consistent performance is important
 * 4. When sorting linked lists
 * 5. External sorting of large files
 * 6. When parallel processing is available
 * 7. When the dataset is too large to fit in memory
 * 
 * COMPARISON WITH OTHER ALGORITHMS:
 * - vs QuickSort: More predictable but uses more memory
 * - vs HeapSort: Stable but requires extra space
 * - vs Bubble/Selection/Insertion: Much faster for large datasets
 * - vs TimSort: TimSort is hybrid that uses merge sort for large runs
 */