# Sorting Algorithms in Dart

## Introduction to Sorting

Sorting is the process of arranging elements in a specific order (ascending or descending). It's one of the most fundamental algorithms in computer science and forms the basis for many other algorithms and data structures.

### Time Complexity Overview
- **Bubble Sort**: O(n²)
- **Selection Sort**: O(n²)
- **Insertion Sort**: O(n²)
- **Merge Sort**: O(n log n)
- **Quick Sort**: O(n log n) average, O(n²) worst
- **Heap Sort**: O(n log n)
- **Counting Sort**: O(n + k)
- **Radix Sort**: O(d × (n + k))
- **Bucket Sort**: O(n + k) average

---

## 1. Bubble Sort

Bubble sort repeatedly steps through the list, compares adjacent elements and swaps them if they're in the wrong order.

**Time Complexity**: O(n²)  
**Space Complexity**: O(1)  
**Stable**: Yes

```dart
// Bubble Sort Implementation
List<int> bubbleSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  for (int i = 0; i < n - 1; i++) {
    bool swapped = false;
    
    // Last i elements are already in place
    for (int j = 0; j < n - i - 1; j++) {
      if (sortedArray[j] > sortedArray[j + 1]) {
        // Swap elements
        int temp = sortedArray[j];
        sortedArray[j] = sortedArray[j + 1];
        sortedArray[j + 1] = temp;
        swapped = true;
      }
    }
    
    // If no swapping occurred, array is sorted
    if (!swapped) break;
  }
  
  return sortedArray;
}

// Example usage
void bubbleSortExample() {
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90];
  print('Original array: $numbers');
  
  List<int> sorted = bubbleSort(numbers);
  print('Sorted array: $sorted');
}
```

### Optimized Bubble Sort with Generic Type

```dart
// Generic Bubble Sort with optimization
List<T> bubbleSortGeneric<T extends Comparable<T>>(List<T> arr) {
  List<T> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  for (int i = 0; i < n - 1; i++) {
    bool swapped = false;
    
    for (int j = 0; j < n - i - 1; j++) {
      if (sortedArray[j].compareTo(sortedArray[j + 1]) > 0) {
        T temp = sortedArray[j];
        sortedArray[j] = sortedArray[j + 1];
        sortedArray[j + 1] = temp;
        swapped = true;
      }
    }
    
    if (!swapped) break;
  }
  
  return sortedArray;
}

// Example with strings
void bubbleSortStringExample() {
  List<String> fruits = ['banana', 'apple', 'cherry', 'date'];
  print('Original: $fruits');
  print('Sorted: ${bubbleSortGeneric(fruits)}');
}
```

---

## 2. Selection Sort

Selection sort finds the minimum element and places it at the beginning, then repeats for the remaining elements.

**Time Complexity**: O(n²)  
**Space Complexity**: O(1)  
**Stable**: No

```dart
// Selection Sort Implementation
List<int> selectionSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    
    // Find the minimum element in remaining array
    for (int j = i + 1; j < n; j++) {
      if (sortedArray[j] < sortedArray[minIndex]) {
        minIndex = j;
      }
    }
    
    // Swap the found minimum element with the first element
    if (minIndex != i) {
      int temp = sortedArray[i];
      sortedArray[i] = sortedArray[minIndex];
      sortedArray[minIndex] = temp;
    }
  }
  
  return sortedArray;
}

// Example usage
void selectionSortExample() {
  List<int> numbers = [64, 25, 12, 22, 11];
  print('Original array: $numbers');
  
  List<int> sorted = selectionSort(numbers);
  print('Sorted array: $sorted');
}
```

### Selection Sort with Step-by-Step Visualization

```dart
// Selection Sort with visualization
List<int> selectionSortWithSteps(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  print('Starting Selection Sort:');
  print('Initial: $sortedArray');
  
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    
    for (int j = i + 1; j < n; j++) {
      if (sortedArray[j] < sortedArray[minIndex]) {
        minIndex = j;
      }
    }
    
    if (minIndex != i) {
      int temp = sortedArray[i];
      sortedArray[i] = sortedArray[minIndex];
      sortedArray[minIndex] = temp;
      
      print('Step ${i + 1}: $sortedArray (swapped ${sortedArray[i]} with ${temp})');
    }
  }
  
  return sortedArray;
}
```

---

## 3. Insertion Sort

Insertion sort builds the final sorted array one item at a time, inserting each element into its correct position.

**Time Complexity**: O(n²) worst case, O(n) best case  
**Space Complexity**: O(1)  
**Stable**: Yes

```dart
// Insertion Sort Implementation
List<int> insertionSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  for (int i = 1; i < n; i++) {
    int key = sortedArray[i];
    int j = i - 1;
    
    // Move elements greater than key one position ahead
    while (j >= 0 && sortedArray[j] > key) {
      sortedArray[j + 1] = sortedArray[j];
      j--;
    }
    
    sortedArray[j + 1] = key;
  }
  
  return sortedArray;
}

// Example usage
void insertionSortExample() {
  List<int> numbers = [12, 11, 13, 5, 6];
  print('Original array: $numbers');
  
  List<int> sorted = insertionSort(numbers);
  print('Sorted array: $sorted');
}
```

### Binary Insertion Sort

```dart
// Binary Insertion Sort (optimized version)
List<int> binaryInsertionSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  for (int i = 1; i < n; i++) {
    int key = sortedArray[i];
    int left = 0;
    int right = i;
    
    // Binary search for the correct position
    while (left < right) {
      int mid = (left + right) ~/ 2;
      if (sortedArray[mid] > key) {
        right = mid;
      } else {
        left = mid + 1;
      }
    }
    
    // Shift elements and insert
    for (int j = i; j > left; j--) {
      sortedArray[j] = sortedArray[j - 1];
    }
    sortedArray[left] = key;
  }
  
  return sortedArray;
}

// Example usage
void binaryInsertionSortExample() {
  List<int> numbers = [37, 23, 0, 17, 12, 72, 31, 46, 100, 88, 54];
  print('Original: $numbers');
  print('Binary Insertion Sorted: ${binaryInsertionSort(numbers)}');
}
```

---

## 4. Merge Sort

Merge sort uses divide-and-conquer approach, dividing the array into halves, sorting them, and merging back.

**Time Complexity**: O(n log n)  
**Space Complexity**: O(n)  
**Stable**: Yes

```dart
// Merge Sort Implementation
List<int> mergeSort(List<int> arr) {
  if (arr.length <= 1) return arr;
  
  int mid = arr.length ~/ 2;
  List<int> left = arr.sublist(0, mid);
  List<int> right = arr.sublist(mid);
  
  return merge(mergeSort(left), mergeSort(right));
}

// Merge function to combine two sorted arrays
List<int> merge(List<int> left, List<int> right) {
  List<int> result = [];
  int i = 0, j = 0;
  
  while (i < left.length && j < right.length) {
    if (left[i] <= right[j]) {
      result.add(left[i]);
      i++;
    } else {
      result.add(right[j]);
      j++;
    }
  }
  
  // Add remaining elements
  while (i < left.length) {
    result.add(left[i]);
    i++;
  }
  
  while (j < right.length) {
    result.add(right[j]);
    j++;
  }
  
  return result;
}

// Example usage
void mergeSortExample() {
  List<int> numbers = [38, 27, 43, 3, 9, 82, 10];
  print('Original array: $numbers');
  
  List<int> sorted = mergeSort(numbers);
  print('Sorted array: $sorted');
}
```

### In-Place Merge Sort (Space Optimized)

```dart
// In-place Merge Sort
void mergeSortInPlace(List<int> arr, int left, int right) {
  if (left < right) {
    int mid = left + (right - left) ~/ 2;
    
    mergeSortInPlace(arr, left, mid);
    mergeSortInPlace(arr, mid + 1, right);
    mergeInPlace(arr, left, mid, right);
  }
}

// In-place merge function
void mergeInPlace(List<int> arr, int left, int mid, int right) {
  List<int> temp = [];
  int i = left, j = mid + 1;
  
  while (i <= mid && j <= right) {
    if (arr[i] <= arr[j]) {
      temp.add(arr[i++]);
    } else {
      temp.add(arr[j++]);
    }
  }
  
  while (i <= mid) temp.add(arr[i++]);
  while (j <= right) temp.add(arr[j++]);
  
  for (int k = 0; k < temp.length; k++) {
    arr[left + k] = temp[k];
  }
}

// Helper function
List<int> mergeSortInPlaceHelper(List<int> arr) {
  List<int> copy = List.from(arr);
  mergeSortInPlace(copy, 0, copy.length - 1);
  return copy;
}
```

---

## 5. Quick Sort

Quick sort picks a pivot element and partitions the array around it, then recursively sorts the sub-arrays.

**Time Complexity**: O(n log n) average, O(n²) worst case  
**Space Complexity**: O(log n)  
**Stable**: No

```dart
// Quick Sort Implementation
List<int> quickSort(List<int> arr) {
  if (arr.length <= 1) return arr;
  
  List<int> sortedArray = List.from(arr);
  quickSortHelper(sortedArray, 0, sortedArray.length - 1);
  return sortedArray;
}

void quickSortHelper(List<int> arr, int low, int high) {
  if (low < high) {
    int pivotIndex = partition(arr, low, high);
    
    quickSortHelper(arr, low, pivotIndex - 1);
    quickSortHelper(arr, pivotIndex + 1, high);
  }
}

// Partition function using last element as pivot
int partition(List<int> arr, int low, int high) {
  int pivot = arr[high];
  int i = low - 1;
  
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      int temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
    }
  }
  
  int temp = arr[i + 1];
  arr[i + 1] = arr[high];
  arr[high] = temp;
  
  return i + 1;
}

// Example usage
void quickSortExample() {
  List<int> numbers = [10, 7, 8, 9, 1, 5];
  print('Original array: $numbers');
  
  List<int> sorted = quickSort(numbers);
  print('Sorted array: $sorted');
}
```

### Quick Sort with Random Pivot

```dart
import 'dart:math';

// Quick Sort with random pivot for better average performance
List<int> quickSortRandom(List<int> arr) {
  if (arr.length <= 1) return arr;
  
  List<int> sortedArray = List.from(arr);
  quickSortRandomHelper(sortedArray, 0, sortedArray.length - 1);
  return sortedArray;
}

void quickSortRandomHelper(List<int> arr, int low, int high) {
  if (low < high) {
    int pivotIndex = randomPartition(arr, low, high);
    
    quickSortRandomHelper(arr, low, pivotIndex - 1);
    quickSortRandomHelper(arr, pivotIndex + 1, high);
  }
}

int randomPartition(List<int> arr, int low, int high) {
  Random random = Random();
  int randomIndex = low + random.nextInt(high - low + 1);
  
  // Swap random element with last element
  int temp = arr[randomIndex];
  arr[randomIndex] = arr[high];
  arr[high] = temp;
  
  return partition(arr, low, high);
}
```

---

## 6. Heap Sort

Heap sort uses a binary heap data structure to sort elements by repeatedly extracting the maximum element.

**Time Complexity**: O(n log n)  
**Space Complexity**: O(1)  
**Stable**: No

```dart
// Heap Sort Implementation
List<int> heapSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  // Build max heap
  for (int i = n ~/ 2 - 1; i >= 0; i--) {
    heapify(sortedArray, n, i);
  }
  
  // Extract elements from heap one by one
  for (int i = n - 1; i > 0; i--) {
    // Move current root to end
    int temp = sortedArray[0];
    sortedArray[0] = sortedArray[i];
    sortedArray[i] = temp;
    
    // Call heapify on the reduced heap
    heapify(sortedArray, i, 0);
  }
  
  return sortedArray;
}

// Heapify a subtree rooted at index i
void heapify(List<int> arr, int n, int i) {
  int largest = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;
  
  // If left child is larger than root
  if (left < n && arr[left] > arr[largest]) {
    largest = left;
  }
  
  // If right child is larger than largest so far
  if (right < n && arr[right] > arr[largest]) {
    largest = right;
  }
  
  // If largest is not root
  if (largest != i) {
    int temp = arr[i];
    arr[i] = arr[largest];
    arr[largest] = temp;
    
    // Recursively heapify the affected sub-tree
    heapify(arr, n, largest);
  }
}

// Example usage
void heapSortExample() {
  List<int> numbers = [12, 11, 13, 5, 6, 7];
  print('Original array: $numbers');
  
  List<int> sorted = heapSort(numbers);
  print('Sorted array: $sorted');
}
```

---

## 7. Counting Sort

Counting sort is efficient for sorting integers within a specific range.

**Time Complexity**: O(n + k) where k is the range  
**Space Complexity**: O(k)  
**Stable**: Yes

```dart
// Counting Sort Implementation
List<int> countingSort(List<int> arr) {
  if (arr.isEmpty) return arr;
  
  int max = arr.reduce((a, b) => a > b ? a : b);
  int min = arr.reduce((a, b) => a < b ? a : b);
  int range = max - min + 1;
  
  List<int> count = List.filled(range, 0);
  List<int> output = List.filled(arr.length, 0);
  
  // Store count of each element
  for (int i = 0; i < arr.length; i++) {
    count[arr[i] - min]++;
  }
  
  // Change count[i] to actual position
  for (int i = 1; i < count.length; i++) {
    count[i] += count[i - 1];
  }
  
  // Build output array
  for (int i = arr.length - 1; i >= 0; i--) {
    output[count[arr[i] - min] - 1] = arr[i];
    count[arr[i] - min]--;
  }
  
  return output;
}

// Example usage
void countingSortExample() {
  List<int> numbers = [4, 2, 2, 8, 3, 3, 1];
  print('Original array: $numbers');
  
  List<int> sorted = countingSort(numbers);
  print('Sorted array: $sorted');
}
```

### Counting Sort for Characters

```dart
// Counting Sort for strings (characters)
String countingSortString(String str) {
  List<int> count = List.filled(256, 0); // ASCII characters
  List<String> chars = str.split('');
  
  // Count frequency of each character
  for (String char in chars) {
    count[char.codeUnitAt(0)]++;
  }
  
  // Build sorted string
  StringBuffer result = StringBuffer();
  for (int i = 0; i < count.length; i++) {
    for (int j = 0; j < count[i]; j++) {
      result.write(String.fromCharCode(i));
    }
  }
  
  return result.toString();
}

// Example usage
void countingSortStringExample() {
  String text = "geeksforgeeks";
  print('Original string: $text');
  print('Sorted string: ${countingSortString(text)}');
}
```

---

## 8. Radix Sort

Radix sort sorts integers by processing individual digits, starting from the least significant digit.

**Time Complexity**: O(d × (n + k)) where d is the number of digits  
**Space Complexity**: O(n + k)  
**Stable**: Yes

```dart
// Radix Sort Implementation
List<int> radixSort(List<int> arr) {
  if (arr.isEmpty) return arr;
  
  List<int> sortedArray = List.from(arr);
  int max = sortedArray.reduce((a, b) => a > b ? a : b);
  
  // Do counting sort for every digit
  for (int exp = 1; max ~/ exp > 0; exp *= 10) {
    countingSortByDigit(sortedArray, exp);
  }
  
  return sortedArray;
}

// Counting sort for a specific digit represented by exp
void countingSortByDigit(List<int> arr, int exp) {
  List<int> output = List.filled(arr.length, 0);
  List<int> count = List.filled(10, 0);
  
  // Store count of occurrences
  for (int i = 0; i < arr.length; i++) {
    count[(arr[i] ~/ exp) % 10]++;
  }
  
  // Change count[i] to actual position
  for (int i = 1; i < 10; i++) {
    count[i] += count[i - 1];
  }
  
  // Build output array
  for (int i = arr.length - 1; i >= 0; i--) {
    output[count[(arr[i] ~/ exp) % 10] - 1] = arr[i];
    count[(arr[i] ~/ exp) % 10]--;
  }
  
  // Copy output array to arr
  for (int i = 0; i < arr.length; i++) {
    arr[i] = output[i];
  }
}

// Example usage
void radixSortExample() {
  List<int> numbers = [170, 45, 75, 90, 2, 802, 24, 66];
  print('Original array: $numbers');
  
  List<int> sorted = radixSort(numbers);
  print('Sorted array: $sorted');
}
```

---

## 9. Bucket Sort

Bucket sort distributes elements into buckets, sorts individual buckets, and concatenates them.

**Time Complexity**: O(n + k) average case  
**Space Complexity**: O(n + k)  
**Stable**: Yes

```dart
// Bucket Sort Implementation
List<double> bucketSort(List<double> arr) {
  if (arr.isEmpty) return arr;
  
  int n = arr.length;
  List<List<double>> buckets = List.generate(n, (index) => <double>[]);
  
  // Put array elements in different buckets
  for (int i = 0; i < n; i++) {
    int bucketIndex = (n * arr[i]).floor();
    if (bucketIndex >= n) bucketIndex = n - 1;
    buckets[bucketIndex].add(arr[i]);
  }
  
  // Sort individual buckets using insertion sort
  for (int i = 0; i < n; i++) {
    buckets[i] = insertionSortDouble(buckets[i]);
  }
  
  // Concatenate all buckets
  List<double> result = [];
  for (int i = 0; i < n; i++) {
    result.addAll(buckets[i]);
  }
  
  return result;
}

// Insertion sort for double values
List<double> insertionSortDouble(List<double> arr) {
  for (int i = 1; i < arr.length; i++) {
    double key = arr[i];
    int j = i - 1;
    
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
    }
    
    arr[j + 1] = key;
  }
  
  return arr;
}

// Example usage
void bucketSortExample() {
  List<double> numbers = [0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434];
  print('Original array: $numbers');
  
  List<double> sorted = bucketSort(numbers);
  print('Sorted array: $sorted');
}
```

### Bucket Sort for Integers

```dart
// Bucket Sort for integers in a range
List<int> bucketSortIntegers(List<int> arr, int maxValue) {
  if (arr.isEmpty) return arr;
  
  int bucketCount = maxValue + 1;
  List<int> buckets = List.filled(bucketCount, 0);
  
  // Count frequency of each element
  for (int num in arr) {
    buckets[num]++;
  }
  
  // Build sorted array
  List<int> result = [];
  for (int i = 0; i < bucketCount; i++) {
    for (int j = 0; j < buckets[i]; j++) {
      result.add(i);
    }
  }
  
  return result;
}
```

---

## 10. Shell Sort

Shell sort is an optimization of insertion sort that allows the exchange of far apart elements.

**Time Complexity**: O(n log n) to O(n²) depending on gap sequence  
**Space Complexity**: O(1)  
**Stable**: No

```dart
// Shell Sort Implementation
List<int> shellSort(List<int> arr) {
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  // Start with a big gap, then reduce the gap
  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    // Do a gapped insertion sort
    for (int i = gap; i < n; i++) {
      int temp = sortedArray[i];
      int j;
      
      for (j = i; j >= gap && sortedArray[j - gap] > temp; j -= gap) {
        sortedArray[j] = sortedArray[j - gap];
      }
      
      sortedArray[j] = temp;
    }
  }
  
  return sortedArray;
}

// Example usage
void shellSortExample() {
  List<int> numbers = [12, 34, 54, 2, 3];
  print('Original array: $numbers');
  
  List<int> sorted = shellSort(numbers);
  print('Sorted array: $sorted');
}
```

---

## 11. Tim Sort (Hybrid Sort)

A simplified version of TimSort, which combines merge sort and insertion sort.

```dart
// Simplified Tim Sort
List<int> timSort(List<int> arr) {
  const int MIN_MERGE = 32;
  
  if (arr.length < 2) return arr;
  
  List<int> sortedArray = List.from(arr);
  int n = sortedArray.length;
  
  // Sort individual subarrays of size MIN_MERGE using insertion sort
  for (int i = 0; i < n; i += MIN_MERGE) {
    int right = (i + MIN_MERGE - 1 < n - 1) ? i + MIN_MERGE - 1 : n - 1;
    insertionSortRange(sortedArray, i, right);
  }
  
  // Start merging from size MIN_MERGE
  for (int size = MIN_MERGE; size < n; size = 2 * size) {
    for (int start = 0; start < n; start += size * 2) {
      int mid = start + size - 1;
      int end = (start + size * 2 - 1 < n - 1) ? start + size * 2 - 1 : n - 1;
      
      if (mid < end) {
        mergeRanges(sortedArray, start, mid, end);
      }
    }
  }
  
  return sortedArray;
}

// Insertion sort for a specific range
void insertionSortRange(List<int> arr, int left, int right) {
  for (int i = left + 1; i <= right; i++) {
    int keyItem = arr[i];
    int j = i - 1;
    
    while (j >= left && arr[j] > keyItem) {
      arr[j + 1] = arr[j];
      j--;
    }
    
    arr[j + 1] = keyItem;
  }
}

// Merge function for specific ranges
void mergeRanges(List<int> arr, int left, int mid, int right) {
  int len1 = mid - left + 1;
  int len2 = right - mid;
  
  List<int> leftPart = arr.sublist(left, mid + 1);
  List<int> rightPart = arr.sublist(mid + 1, right + 1);
  
  int i = 0, j = 0, k = left;
  
  while (i < len1 && j < len2) {
    if (leftPart[i] <= rightPart[j]) {
      arr[k] = leftPart[i];
      i++;
    } else {
      arr[k] = rightPart[j];
      j++;
    }
    k++;
  }
  
  while (i < len1) {
    arr[k] = leftPart[i];
    k++;
    i++;
  }
  
  while (j < len2) {
    arr[k] = rightPart[j];
    k++;
    j++;
  }
}
```

---

## 12. Sorting Custom Objects

### Sorting Students by Different Criteria

```dart
class Student {
  String name;
  int age;
  double gpa;
  
  Student(this.name, this.age, this.gpa);
  
  @override
  String toString() => 'Student(name: $name, age: $age, gpa: $gpa)';
}

// Sort students by name
List<Student> sortStudentsByName(List<Student> students) {
  List<Student> sorted = List.from(students);
  sorted.sort((a, b) => a.name.compareTo(b.name));
  return sorted;
}

// Sort students by age
List<Student> sortStudentsByAge(List<Student> students) {
  List<Student> sorted = List.from(students);
  sorted.sort((a, b) => a.age.compareTo(b.age));
  return sorted;
}

// Sort students by GPA (descending)
List<Student> sortStudentsByGPA(List<Student> students) {
  List<Student> sorted = List.from(students);
  sorted.sort((a, b) => b.gpa.compareTo(a.gpa));
  return sorted;
}

// Multi-criteria sorting (by GPA, then by name)
List<Student> sortStudentsMultiCriteria(List<Student> students) {
  List<Student> sorted = List.from(students);
  sorted.sort((a, b) {
    int gpaComparison = b.gpa.compareTo(a.gpa);
    if (gpaComparison != 0) return gpaComparison;
    return a.name.compareTo(b.name);
  });
  return sorted;
}

// Example usage
void customObjectSortingExample() {
  List<Student> students = [
    Student('Alice', 20, 3.8),
    Student('Bob', 19, 3.5),
    Student('Charlie', 21, 3.9),
    Student('Diana', 20, 3.8),
  ];
  
  print('Original students: $students');
  print('\nSorted by name: ${sortStudentsByName(students)}');
  print('\nSorted by age: ${sortStudentsByAge(students)}');
  print('\nSorted by GPA: ${sortStudentsByGPA(students)}');
  print('\nMulti-criteria sort: ${sortStudentsMultiCriteria(students)}');
}
```

---

## 13. Performance Comparison and Analysis

```dart
import 'dart:math';

// Performance testing class
class SortingPerformanceTest {
  static void runPerformanceTests() {
    print('=== SORTING PERFORMANCE COMPARISON ===\n');
    
    List<int> sizes = [1000, 5000, 10000];
    
    for (int size in sizes) {
      print('Testing with array size: $size');
      List<int> randomArray = generateRandomArray(size);
      
      testSortingAlgorithm('Bubble Sort', bubbleSort, randomArray);
      testSortingAlgorithm('Selection Sort', selectionSort, randomArray);
      testSortingAlgorithm('Insertion Sort', insertionSort, randomArray);
      testSortingAlgorithm('Merge Sort', mergeSort, randomArray);
      testSortingAlgorithm('Quick Sort', quickSort, randomArray);
      testSortingAlgorithm('Heap Sort', heapSort, randomArray);
      testSortingAlgorithm('Tim Sort', timSort, randomArray);
      
      print('');
    }
  }
  
  static List<int> generateRandomArray(int size) {
    Random random = Random();
    return List.generate(size, (index) => random.nextInt(1000));
  }
  
  static void testSortingAlgorithm(String name, Function sortFunction, List<int> array) {
    Stopwatch stopwatch = Stopwatch()..start();
    sortFunction(array);
    stopwatch.stop();
    
    print('$name: ${stopwatch.elapsedMilliseconds} ms');
  }
}

// Stability test
void testStability() {
  // Test sorting stability with custom objects
  List<Map<String, dynamic>> items = [
    {'value': 3, 'original_index': 0},
    {'value': 1, 'original_index': 1},
    {'value': 3, 'original_index': 2},
    {'value': 2, 'original_index': 3},
    {'value': 1, 'original_index': 4},
  ];
  
  print('Testing sorting stability:');
  print('Original: $items');
  
  // Using Dart's built-in stable sort
  items.sort((a, b) => a['value'].compareTo(b['value']));
  print('Stable sorted: $items');
}
```

---

## 14. Utility Functions and Helpers

```dart
// Utility functions for sorting
class SortingUtils {
  // Check if array is sorted
  static bool isSorted(List<int> arr) {
    for (int i = 1; i < arr.length; i++) {
      if (arr[i] < arr[i - 1]) return false;
    }
    return true;
  }
  
  // Shuffle array (for testing)
  static List<int> shuffleArray(List<int> arr) {
    List<int> shuffled = List.from(arr);
    Random random = Random();
    
    for (int i = shuffled.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      int temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    
    return shuffled;
  }
  
  // Generate different types of test arrays
  static List<int> generateSortedArray(int size) {
    return List.generate(size, (index) => index);
  }
  
  static List<int> generateReverseSortedArray(int size) {
    return List.generate(size, (index) => size - index);
  }
  
  static List<int> generateRandomArray(int size, int maxValue) {
    Random random = Random();
    return List.generate(size, (index) => random.nextInt(maxValue));
  }
  
  static List<int> generateArrayWithDuplicates(int size) {
    Random random = Random();
    return List.generate(size, (index) => random.nextInt(size ~/ 3));
  }
  
  // Visualize sorting steps (for small arrays)
  static void visualizeArray(List<int> arr, String title) {
    print('$title: $arr');
  }
}
```

---

## Main Function - Running All Examples

```dart
void main() {
  print('=== SORTING ALGORITHMS IN DART ===\n');
  
  print('1. Bubble Sort:');
  bubbleSortExample();
  bubbleSortStringExample();
  
  print('\n2. Selection Sort:');
  selectionSortExample();
  
  print('\n3. Insertion Sort:');
  insertionSortExample();
  binaryInsertionSortExample();
  
  print('\n4. Merge Sort:');
  mergeSortExample();
  
  print('\n5. Quick Sort:');
  quickSortExample();
  
  print('\n6. Heap Sort:');
  heapSortExample();
  
  print('\n7. Counting Sort:');
  countingSortExample();
  countingSortStringExample();
  
  print('\n8. Radix Sort:');
  radixSortExample();
  
  print('\n9. Bucket Sort:');
  bucketSortExample();
  
  print('\n10. Shell Sort:');
  shellSortExample();
  
  print('\n11. Custom Object Sorting:');
  customObjectSortingExample();
  
  print('\n12. Stability Test:');
  testStability();
  
  print('\n13. Performance Tests:');
  SortingPerformanceTest.runPerformanceTests();
  
  print('\n14. Utility Tests:');
  List<int> testArray = [5, 2, 8, 1, 9];
  print('Original: $testArray');
  print('Is sorted: ${SortingUtils.isSorted(testArray)}');
  print('Shuffled: ${SortingUtils.shuffleArray(testArray)}');
  print('Sorted with merge sort: ${mergeSort(testArray)}');
  print('Is sorted after sorting: ${SortingUtils.isSorted(mergeSort(testArray))}');
}
```

---

## Algorithm Comparison Summary

| Algorithm | Time Complexity (Best/Average/Worst) | Space Complexity | Stable | In-Place |
|-----------|--------------------------------------|------------------|--------|----------|
| Bubble Sort | O(n)/O(n²)/O(n²) | O(1) | Yes | Yes |
| Selection Sort | O(n²)/O(n²)/O(n²) | O(1) | No | Yes |
| Insertion Sort | O(n)/O(n²)/O(n²) | O(1) | Yes | Yes |
| Merge Sort | O(n log n)/O(n log n)/O(n log n) | O(n) | Yes | No |
| Quick Sort | O(n log n)/O(n log n)/O(n²) | O(log n) | No | Yes |
| Heap Sort | O(n log n)/O(n log n)/O(n log n) | O(1) | No | Yes |
| Counting Sort | O(n+k)/O(n+k)/O(n+k) | O(k) | Yes | No |
| Radix Sort | O(d(n+k))/O(d(n+k))/O(d(n+k)) | O(n+k) | Yes | No |
| Bucket Sort | O(n+k)/O(n+k)/O(n²) | O(n+k) | Yes | No |
| Shell Sort | O(n log n)/O(n log n)/O(n²) | O(1) | No | Yes |

### When to Use Which Algorithm:

- **Small arrays (< 50 elements)**: Insertion Sort
- **General purpose**: Merge Sort or Quick Sort
- **Memory constrained**: Heap Sort or In-place Quick Sort
- **Integer sorting with small range**: Counting Sort
- **Large integers**: Radix Sort
- **Nearly sorted data**: Insertion Sort or Tim Sort
- **Stability required**: Merge Sort or Tim Sort

This comprehensive guide covers all major sorting algorithms with complete Dart implementations, examples, and performance analysis!