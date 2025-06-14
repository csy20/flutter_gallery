/*
 * BUBBLE SORT ALGORITHM IN DART
 * 
 * Bubble Sort is the simplest sorting algorithm that works by repeatedly
 * stepping through the list, comparing adjacent elements and swapping them
 * if they are in the wrong order. The pass through the list is repeated
 * until the list is sorted.
 * 
 * The algorithm gets its name because smaller elements "bubble" to the
 * beginning of the list, just like air bubbles rise to the surface of water.
 * 
 * Time Complexity:
 * - Best Case: O(n) - when array is already sorted (with optimization)
 * - Average Case: O(n²) - average scenario
 * - Worst Case: O(n²) - when array is sorted in reverse order
 * 
 * Space Complexity: O(1) - in-place sorting algorithm
 */

void main() {
  print("=== BUBBLE SORT DEMONSTRATION ===\n");
  
  // Test data
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90, 88, 76, 45];
  List<int> sortedArray = [1, 2, 3, 4, 5]; // Already sorted
  List<int> reverseArray = [5, 4, 3, 2, 1]; // Reverse sorted
  List<String> words = ["banana", "apple", "cherry", "date", "elderberry"];
  
  print("--- Basic Bubble Sort ---");
  print("Original array: $numbers");
  List<int> result1 = bubbleSort([...numbers]);
  print("Sorted array: $result1\n");
  
  print("--- Bubble Sort with Steps ---");
  bubbleSortWithSteps([...numbers]);
  
  print("\n--- Optimized Bubble Sort ---");
  print("Original array: $numbers");
  List<int> result2 = bubbleSortOptimized([...numbers]);
  print("Sorted array: $result2\n");
  
  print("--- Testing on Already Sorted Array ---");
  print("Already sorted: $sortedArray");
  bubbleSortWithSteps([...sortedArray]);
  
  print("\n--- Testing on Reverse Sorted Array ---");
  print("Reverse sorted: $reverseArray");
  bubbleSortWithSteps([...reverseArray]);
  
  print("\n--- Bubble Sort for Strings ---");
  print("Original words: $words");
  List<String> sortedWords = bubbleSortStrings([...words]);
  print("Sorted words: $sortedWords\n");
  
  print("--- Descending Order Sort ---");
  print("Original array: $numbers");
  List<int> descendingResult = bubbleSortDescending([...numbers]);
  print("Descending sorted: $descendingResult\n");
  
  print("--- Performance Comparison ---");
  performanceComparison();
}

/**
 * Basic Bubble Sort Implementation
 * 
 * @param arr: List of integers to sort
 * @return: Sorted list in ascending order
 */
List<int> bubbleSort(List<int> arr) {
  int n = arr.length;
  
  // Outer loop for number of passes
  for (int i = 0; i < n - 1; i++) {
    // Inner loop for comparisons in each pass
    // After each pass, the largest element reaches its correct position
    for (int j = 0; j < n - i - 1; j++) {
      // Compare adjacent elements
      if (arr[j] > arr[j + 1]) {
        // Swap if they are in wrong order
        swap(arr, j, j + 1);
      }
    }
  }
  
  return arr;
}

/**
 * Optimized Bubble Sort with Early Termination
 * Stops early if no swaps are made in a pass (array is already sorted)
 */
List<int> bubbleSortOptimized(List<int> arr) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    bool swapped = false; // Flag to check if any swap occurred
    
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        swap(arr, j, j + 1);
        swapped = true; // Mark that a swap occurred
      }
    }
    
    // If no swapping occurred, array is sorted
    if (!swapped) {
      print("Array sorted after ${i + 1} passes (early termination)");
      break;
    }
  }
  
  return arr;
}

/**
 * Bubble Sort with Step-by-Step Visualization
 * Shows the sorting process in detail
 */
void bubbleSortWithSteps(List<int> arr) {
  int n = arr.length;
  int passCount = 0;
  int swapCount = 0;
  
  print("Step-by-step bubble sort process:");
  print("Initial array: $arr");
  
  for (int i = 0; i < n - 1; i++) {
    passCount++;
    bool swapped = false;
    print("\n--- Pass $passCount ---");
    
    for (int j = 0; j < n - i - 1; j++) {
      print("Comparing arr[$j]=${arr[j]} and arr[${j + 1}]=${arr[j + 1]}");
      
      if (arr[j] > arr[j + 1]) {
        swap(arr, j, j + 1);
        swapped = true;
        swapCount++;
        print("  → Swapped! Array: $arr");
      } else {
        print("  → No swap needed");
      }
    }
    
    print("After pass $passCount: $arr");
    print("Largest element (${arr[n - i - 1]}) is now in position ${n - i - 1}");
    
    if (!swapped) {
      print("No swaps in this pass - array is sorted!");
      break;
    }
  }
  
  print("\nSorting completed!");
  print("Total passes: $passCount");
  print("Total swaps: $swapCount");
  print("Final sorted array: $arr");
}

/**
 * Bubble Sort for Strings (Alphabetical Order)
 */
List<String> bubbleSortStrings(List<String> arr) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      // Compare strings lexicographically
      if (arr[j].compareTo(arr[j + 1]) > 0) {
        swapStrings(arr, j, j + 1);
      }
    }
  }
  
  return arr;
}

/**
 * Bubble Sort in Descending Order
 */
List<int> bubbleSortDescending(List<int> arr) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      // Change comparison for descending order
      if (arr[j] < arr[j + 1]) {
        swap(arr, j, j + 1);
      }
    }
  }
  
  return arr;
}

/**
 * Generic Bubble Sort using Dart Generics and Comparator
 */
List<T> bubbleSortGeneric<T>(List<T> arr, int Function(T, T) compare) {
  int n = arr.length;
  
  for (int i = 0; i < n - 1; i++) {
    bool swapped = false;
    
    for (int j = 0; j < n - i - 1; j++) {
      if (compare(arr[j], arr[j + 1]) > 0) {
        swapGeneric(arr, j, j + 1);
        swapped = true;
      }
    }
    
    if (!swapped) break;
  }
  
  return arr;
}

/**
 * Utility function to swap two elements in an integer array
 */
void swap(List<int> arr, int i, int j) {
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/**
 * Utility function to swap two elements in a string array
 */
void swapStrings(List<String> arr, int i, int j) {
  String temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/**
 * Generic swap function
 */
void swapGeneric<T>(List<T> arr, int i, int j) {
  T temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/**
 * Performance test to demonstrate time complexity
 */
void performanceComparison() {
  List<int> sizes = [100, 500, 1000];
  
  for (int size in sizes) {
    // Create random array
    List<int> randomArray = List.generate(size, (index) => size - index);
    
    // Test basic bubble sort
    Stopwatch stopwatch = Stopwatch()..start();
    bubbleSort([...randomArray]);
    stopwatch.stop();
    
    print("Array size: $size");
    print("Basic Bubble Sort time: ${stopwatch.elapsedMilliseconds} ms");
    
    // Test optimized bubble sort
    stopwatch.reset();
    stopwatch.start();
    bubbleSortOptimized([...randomArray]);
    stopwatch.stop();
    
    print("Optimized Bubble Sort time: ${stopwatch.elapsedMilliseconds} ms");
    print("---");
  }
}

/**
 * Demonstration of different scenarios
 */
void demonstrateScenarios() {
  print("\n=== DIFFERENT SCENARIOS ===");
  
  // Best case: Already sorted
  List<int> bestCase = [1, 2, 3, 4, 5];
  print("\nBest Case (Already sorted): $bestCase");
  bubbleSortOptimized([...bestCase]);
  
  // Worst case: Reverse sorted
  List<int> worstCase = [5, 4, 3, 2, 1];
  print("\nWorst Case (Reverse sorted): $worstCase");
  bubbleSortWithSteps([...worstCase]);
  
  // Average case: Random order
  List<int> averageCase = [3, 1, 4, 5, 2];
  print("\nAverage Case (Random order): $averageCase");
  bubbleSortWithSteps([...averageCase]);
}

/*
 * ADVANTAGES OF BUBBLE SORT:
 * 1. Simple to understand and implement
 * 2. No additional memory space needed (in-place sorting)
 * 3. Stable sorting algorithm (maintains relative order of equal elements)
 * 4. Can detect if the list is already sorted (with optimization)
 * 5. Works well for small datasets
 * 
 * DISADVANTAGES OF BUBBLE SORT:
 * 1. Poor time complexity O(n²) makes it inefficient for large datasets
 * 2. More swaps compared to other O(n²) algorithms like selection sort
 * 3. Not suitable for real-world applications with large data
 * 4. Many unnecessary comparisons even when array is nearly sorted
 * 
 * WHEN TO USE BUBBLE SORT:
 * 1. Educational purposes (easy to understand)
 * 2. Small datasets (< 50 elements)
 * 3. Nearly sorted data (with optimization)
 * 4. When simplicity is more important than efficiency
 * 5. When memory is extremely limited
 * 
 * HOW BUBBLE SORT WORKS:
 * 1. Compare adjacent elements
 * 2. Swap if they are in wrong order
 * 3. Continue until end of array
 * 4. Repeat the process (each pass puts largest element in correct position)
 * 5. Stop when no swaps are made in a complete pass
 * 
 * VISUALIZATION:
 * Pass 1: [64, 34, 25, 12, 22, 11, 90] → [34, 25, 12, 22, 11, 64, 90]
 * Pass 2: [34, 25, 12, 22, 11, 64, 90] → [25, 12, 22, 11, 34, 64, 90]
 * Pass 3: [25, 12, 22, 11, 34, 64, 90] → [12, 22, 11, 25, 34, 64, 90]
 * ...and so on until completely sorted
 */