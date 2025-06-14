/*
 * QUICK SORT ALGORITHM IN DART
 * 
 * Quick Sort is a highly efficient divide-and-conquer sorting algorithm.
 * It works by selecting a 'pivot' element and partitioning the array around
 * the pivot such that elements smaller than pivot come before it and
 * elements greater than pivot come after it.
 * 
 * Time Complexity:
 * - Best Case: O(n log n) - when pivot divides array into equal halves
 * - Average Case: O(n log n) - random pivot selection
 * - Worst Case: O(n²) - when pivot is always smallest or largest element
 * 
 * Space Complexity: O(log n) - due to recursive call stack
 * 
 * Quick Sort is often preferred over other O(n log n) algorithms because:
 * 1. In-place sorting (requires only O(log n) extra memory)
 * 2. Cache-efficient due to good locality of reference
 * 3. Performs well in practice despite worst-case O(n²)
 */

void main() {
  print("=== QUICK SORT DEMONSTRATION ===\n");
  
  // Test arrays
  List<int> arr1 = [64, 34, 25, 12, 22, 11, 90];
  List<int> arr2 = [3, 6, 8, 10, 1, 2, 1];
  List<int> arr3 = [5, 4, 3, 2, 1]; // Worst case - reverse sorted
  List<int> arr4 = [1, 2, 3, 4, 5]; // Already sorted
  List<int> arr5 = [42]; // Single element
  List<int> arr6 = []; // Empty array
  
  print("--- Basic Quick Sort ---");
  testQuickSort("Random array", [...arr1]);
  testQuickSort("Array with duplicates", [...arr2]);
  testQuickSort("Reverse sorted (worst case)", [...arr3]);
  testQuickSort("Already sorted", [...arr4]);
  testQuickSort("Single element", [...arr5]);
  testQuickSort("Empty array", [...arr6]);
  
  print("\n--- Quick Sort with Visualization ---");
  List<int> visualArray = [38, 27, 43, 3, 9, 82, 10];
  print("Original array: $visualArray");
  quickSortWithSteps([...visualArray], 0, visualArray.length - 1, 0);
  
  print("\n--- Different Pivot Strategies ---");
  demonstratePivotStrategies();
  
  print("\n--- Performance Analysis ---");
  performanceAnalysis();
  
  print("\n--- Quick Sort Variants ---");
  demonstrateVariants();
}

/**
 * Basic Quick Sort Implementation
 * 
 * @param arr: List to be sorted
 * @param low: Starting index
 * @param high: Ending index
 */
void quickSort(List<int> arr, int low, int high) {
  if (low < high) {
    // Partition the array and get pivot index
    int pivotIndex = partition(arr, low, high);
    
    // Recursively sort elements before and after partition
    quickSort(arr, low, pivotIndex - 1);    // Sort left subarray
    quickSort(arr, pivotIndex + 1, high);   // Sort right subarray
  }
}

/**
 * Partition function using Lomuto partition scheme
 * Places pivot at its correct position and partitions array
 * 
 * @param arr: Array to partition
 * @param low: Starting index
 * @param high: Ending index
 * @return: Index of pivot after partitioning
 */
int partition(List<int> arr, int low, int high) {
  // Choose rightmost element as pivot
  int pivot = arr[high];
  
  // Index of smaller element (indicates right position of pivot)
  int i = low - 1;
  
  for (int j = low; j < high; j++) {
    // If current element is smaller than or equal to pivot
    if (arr[j] <= pivot) {
      i++; // Increment index of smaller element
      swap(arr, i, j);
    }
  }
  
  // Place pivot at correct position
  swap(arr, i + 1, high);
  return i + 1;
}

/**
 * Hoare Partition Scheme (Alternative partitioning method)
 * More efficient as it does fewer swaps on average
 */
int hoarePartition(List<int> arr, int low, int high) {
  int pivot = arr[low]; // Choose first element as pivot
  int i = low - 1;
  int j = high + 1;
  
  while (true) {
    // Find element on left that should be on right
    do {
      i++;
    } while (arr[i] < pivot);
    
    // Find element on right that should be on left
    do {
      j--;
    } while (arr[j] > pivot);
    
    // If elements crossed, partitioning is done
    if (i >= j) {
      return j;
    }
    
    // Swap elements
    swap(arr, i, j);
  }
}

/**
 * Quick Sort with Hoare Partition
 */
void quickSortHoare(List<int> arr, int low, int high) {
  if (low < high) {
    int pivotIndex = hoarePartition(arr, low, high);
    quickSortHoare(arr, low, pivotIndex);
    quickSortHoare(arr, pivotIndex + 1, high);
  }
}

/**
 * Randomized Quick Sort
 * Chooses random pivot to avoid worst-case performance
 */
void randomizedQuickSort(List<int> arr, int low, int high) {
  if (low < high) {
    // Choose random pivot and swap with last element
    int randomIndex = low + (DateTime.now().millisecondsSinceEpoch % (high - low + 1));
    swap(arr, randomIndex, high);
    
    int pivotIndex = partition(arr, low, high);
    randomizedQuickSort(arr, low, pivotIndex - 1);
    randomizedQuickSort(arr, pivotIndex + 1, high);
  }
}

/**
 * Three-Way Quick Sort (Dutch National Flag)
 * Efficient for arrays with many duplicate elements
 */
void threeWayQuickSort(List<int> arr, int low, int high) {
  if (low < high) {
    var result = threeWayPartition(arr, low, high);
    int lt = result[0]; // Elements < pivot end here
    int gt = result[1]; // Elements > pivot start here
    
    threeWayQuickSort(arr, low, lt - 1);
    threeWayQuickSort(arr, gt + 1, high);
  }
}

/**
 * Three-way partitioning for handling duplicates efficiently
 */
List<int> threeWayPartition(List<int> arr, int low, int high) {
  int pivot = arr[low];
  int lt = low;      // arr[low..lt-1] < pivot
  int i = low;       // arr[lt..i-1] == pivot
  int gt = high + 1; // arr[gt..high] > pivot
  
  while (i < gt) {
    if (arr[i] < pivot) {
      swap(arr, lt++, i++);
    } else if (arr[i] > pivot) {
      swap(arr, i, --gt);
    } else {
      i++;
    }
  }
  
  return [lt, gt];
}

/**
 * Iterative Quick Sort (avoiding recursion)
 */
void iterativeQuickSort(List<int> arr, int low, int high) {
  // Create stack for storing start and end indices
  List<int> stack = [];
  
  // Push initial values
  stack.add(low);
  stack.add(high);
  
  while (stack.isNotEmpty) {
    // Pop high and low
    high = stack.removeLast();
    low = stack.removeLast();
    
    // Set pivot element at its correct position
    int pivotIndex = partition(arr, low, high);
    
    // If there are elements on left of pivot, push left side to stack
    if (pivotIndex - 1 > low) {
      stack.add(low);
      stack.add(pivotIndex - 1);
    }
    
    // If there are elements on right of pivot, push right side to stack
    if (pivotIndex + 1 < high) {
      stack.add(pivotIndex + 1);
      stack.add(high);
    }
  }
}

/**
 * Quick Sort with step-by-step visualization
 */
void quickSortWithSteps(List<int> arr, int low, int high, int depth) {
  String indent = "  " * depth;
  
  if (low < high) {
    print("${indent}Sorting subarray: ${arr.sublist(low, high + 1)} (indices $low-$high)");
    
    int pivotIndex = partitionWithSteps(arr, low, high, depth);
    
    print("${indent}After partitioning: ${arr.sublist(low, high + 1)}");
    print("${indent}Pivot ${arr[pivotIndex]} is at correct position $pivotIndex\n");
    
    // Recursively sort left and right subarrays
    quickSortWithSteps(arr, low, pivotIndex - 1, depth + 1);
    quickSortWithSteps(arr, pivotIndex + 1, high, depth + 1);
  }
}

/**
 * Partition with step-by-step explanation
 */
int partitionWithSteps(List<int> arr, int low, int high, int depth) {
  String indent = "  " * depth;
  int pivot = arr[high];
  print("${indent}Choosing pivot: ${arr[high]} (index $high)");
  
  int i = low - 1;
  
  for (int j = low; j < high; j++) {
    if (arr[j] <= pivot) {
      i++;
      if (i != j) {
        print("${indent}Swapping ${arr[i]} and ${arr[j]}");
        swap(arr, i, j);
      }
    }
  }
  
  swap(arr, i + 1, high);
  print("${indent}Placing pivot at position ${i + 1}");
  
  return i + 1;
}

/**
 * Utility function to swap two elements
 */
void swap(List<int> arr, int i, int j) {
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/**
 * Test helper function
 */
void testQuickSort(String description, List<int> arr) {
  print("$description:");
  print("  Before: $arr");
  
  if (arr.isNotEmpty) {
    quickSort(arr, 0, arr.length - 1);
  }
  
  print("  After:  $arr");
  print("  Sorted: ${isSorted(arr) ? '✓' : '✗'}\n");
}

/**
 * Check if array is sorted
 */
bool isSorted(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] < arr[i - 1]) return false;
  }
  return true;
}

/**
 * Demonstrate different pivot selection strategies
 */
void demonstratePivotStrategies() {
  List<int> testArray = [8, 7, 6, 1, 0, 9, 2];
  
  print("Original array: $testArray");
  
  // Last element as pivot (Lomuto)
  List<int> arr1 = [...testArray];
  quickSort(arr1, 0, arr1.length - 1);
  print("Lomuto partition (last as pivot): $arr1");
  
  // First element as pivot (Hoare)
  List<int> arr2 = [...testArray];
  quickSortHoare(arr2, 0, arr2.length - 1);
  print("Hoare partition (first as pivot): $arr2");
  
  // Random pivot
  List<int> arr3 = [...testArray];
  randomizedQuickSort(arr3, 0, arr3.length - 1);
  print("Randomized quick sort: $arr3");
  
  // Three-way partitioning
  List<int> arr4 = [3, 3, 3, 1, 1, 2, 2, 3, 1];
  print("\nArray with duplicates: $arr4");
  threeWayQuickSort(arr4, 0, arr4.length - 1);
  print("Three-way quick sort: $arr4");
}

/**
 * Performance analysis of different scenarios
 */
void performanceAnalysis() {
  List<int> sizes = [1000, 5000, 10000];
  
  for (int size in sizes) {
    print("Array size: $size");
    
    // Best case: random array
    List<int> randomArray = List.generate(size, (i) => (i * 7) % size);
    Stopwatch sw1 = Stopwatch()..start();
    quickSort([...randomArray], 0, randomArray.length - 1);
    sw1.stop();
    print("  Random array: ${sw1.elapsedMilliseconds} ms");
    
    // Worst case: sorted array
    List<int> sortedArray = List.generate(size, (i) => i);
    Stopwatch sw2 = Stopwatch()..start();
    randomizedQuickSort([...sortedArray], 0, sortedArray.length - 1);
    sw2.stop();
    print("  Sorted array (randomized): ${sw2.elapsedMilliseconds} ms");
    
    // With duplicates
    List<int> duplicateArray = List.generate(size, (i) => i % 10);
    Stopwatch sw3 = Stopwatch()..start();
    threeWayQuickSort([...duplicateArray], 0, duplicateArray.length - 1);
    sw3.stop();
    print("  Array with duplicates: ${sw3.elapsedMilliseconds} ms\n");
  }
}

/**
 * Demonstrate different variants
 */
void demonstrateVariants() {
  List<int> testArray = [4, 2, 7, 1, 9, 3];
  
  print("Original array: $testArray");
  
  // Iterative version
  List<int> arr1 = [...testArray];
  iterativeQuickSort(arr1, 0, arr1.length - 1);
  print("Iterative quick sort: $arr1");
  
  // With median-of-three pivot
  List<int> arr2 = [...testArray];
  quickSortMedianPivot(arr2, 0, arr2.length - 1);
  print("Median-of-three pivot: $arr2");
}

/**
 * Quick Sort with median-of-three pivot selection
 */
void quickSortMedianPivot(List<int> arr, int low, int high) {
  if (low < high) {
    // Choose median of first, middle, and last elements as pivot
    int mid = (low + high) ~/ 2;
    
    // Sort low, mid, high
    if (arr[mid] < arr[low]) swap(arr, low, mid);
    if (arr[high] < arr[low]) swap(arr, low, high);
    if (arr[high] < arr[mid]) swap(arr, mid, high);
    
    // Place median at end
    swap(arr, mid, high);
    
    int pivotIndex = partition(arr, low, high);
    quickSortMedianPivot(arr, low, pivotIndex - 1);
    quickSortMedianPivot(arr, pivotIndex + 1, high);
  }
}

/**
 * ADVANTAGES OF QUICK SORT:
 * 1. Efficient average-case performance O(n log n)
 * 2. In-place sorting (requires only O(log n) extra space)
 * 3. Cache-efficient due to good locality of reference
 * 4. Simple to implement
 * 5. Performs well in practice
 * 
 * DISADVANTAGES OF QUICK SORT:
 * 1. Worst-case time complexity is O(n²)
 * 2. Not stable (doesn't preserve relative order of equal elements)
 * 3. Performance depends on pivot selection
 * 4. Recursive implementation can cause stack overflow for large inputs
 * 
 * OPTIMIZATIONS:
 * 1. Randomized pivot selection to avoid worst case
 * 2. Three-way partitioning for arrays with duplicates
 * 3. Median-of-three pivot selection
 * 4. Hybrid approach: use insertion sort for small subarrays
 * 5. Iterative implementation to avoid stack overflow
 * 
 * WHEN TO USE QUICK SORT:
 * 1. When average-case performance is more important than worst-case
 * 2. When memory usage is a concern (in-place sorting)
 * 3. For general-purpose sorting where stability is not required
 * 4. When data fits in memory and cache efficiency matters
 */