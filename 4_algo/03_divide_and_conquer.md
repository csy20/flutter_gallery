# Divide and Conquer Algorithms in Dart

## Introduction to Divide and Conquer

Divide and conquer is a fundamental algorithmic paradigm that solves complex problems by breaking them down into smaller, more manageable subproblems. The approach follows three main steps:

1. **Divide**: Break the problem into smaller subproblems of the same type
2. **Conquer**: Solve the subproblems recursively (or directly if they're small enough)
3. **Combine**: Merge the solutions of subproblems to get the solution for the original problem

### Key Characteristics:
- **Recursive nature**: Problems are solved by solving smaller instances of the same problem
- **Optimal substructure**: The optimal solution contains optimal solutions to subproblems
- **Time complexity**: Often results in O(n log n) complexity for many problems
- **Space complexity**: Usually requires O(log n) space due to recursion stack

---

## 1. Merge Sort - Classic Divide and Conquer

Merge Sort is the quintessential example of divide and conquer sorting algorithm.

**Time Complexity**: O(n log n)  
**Space Complexity**: O(n)  
**Approach**: Divide array into halves, sort each half, then merge sorted halves

```dart
// Merge Sort Implementation
List<int> mergeSort(List<int> arr) {
  // Base case: arrays with 0 or 1 element are already sorted
  if (arr.length <= 1) return List.from(arr);
  
  // Divide: Split the array into two halves
  int mid = arr.length ~/ 2;
  List<int> left = arr.sublist(0, mid);
  List<int> right = arr.sublist(mid);
  
  // Conquer: Recursively sort both halves
  List<int> sortedLeft = mergeSort(left);
  List<int> sortedRight = mergeSort(right);
  
  // Combine: Merge the sorted halves
  return merge(sortedLeft, sortedRight);
}

// Merge function to combine two sorted arrays
List<int> merge(List<int> left, List<int> right) {
  List<int> result = [];
  int i = 0, j = 0;
  
  // Compare elements from both arrays and add smaller one to result
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

// Example with step-by-step visualization
void mergeSortExample() {
  List<int> numbers = [38, 27, 43, 3, 9, 82, 10];
  print('Original array: $numbers');
  
  List<int> sorted = mergeSort(numbers);
  print('Sorted array: $sorted');
  
  // Demonstrate the divide and conquer process
  print('\nMerge Sort Process:');
  print('1. Divide: [38,27,43,3,9,82,10] → [38,27,43,3] and [9,82,10]');
  print('2. Further divide: [38,27,43,3] → [38,27] and [43,3]');
  print('3. Continue until single elements...');
  print('4. Merge: [38] and [27] → [27,38]');
  print('5. Merge: [43] and [3] → [3,43]');
  print('6. Combine: [27,38] and [3,43] → [3,27,38,43]');
  print('7. Continue merging until final sorted array');
}
```

---

## 2. Quick Sort - Partition-based Divide and Conquer

Quick Sort uses a pivot element to partition the array and recursively sorts the partitions.

**Time Complexity**: O(n log n) average, O(n²) worst case  
**Space Complexity**: O(log n)  
**Approach**: Choose pivot, partition around it, recursively sort partitions

```dart
// Quick Sort Implementation
List<int> quickSort(List<int> arr) {
  if (arr.length <= 1) return List.from(arr);
  
  List<int> result = List.from(arr);
  quickSortHelper(result, 0, result.length - 1);
  return result;
}

void quickSortHelper(List<int> arr, int low, int high) {
  if (low < high) {
    // Divide: Partition the array and get pivot index
    int pivotIndex = partition(arr, low, high);
    
    // Conquer: Recursively sort elements before and after partition
    quickSortHelper(arr, low, pivotIndex - 1);
    quickSortHelper(arr, pivotIndex + 1, high);
  }
}

// Partition function using Lomuto partition scheme
int partition(List<int> arr, int low, int high) {
  int pivot = arr[high]; // Choose last element as pivot
  int i = low - 1; // Index of smaller element
  
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  
  swap(arr, i + 1, high);
  return i + 1;
}

void swap(List<int> arr, int i, int j) {
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

// Example usage
void quickSortExample() {
  List<int> numbers = [10, 7, 8, 9, 1, 5];
  print('Original array: $numbers');
  
  List<int> sorted = quickSort(numbers);
  print('Sorted array: $sorted');
  
  print('\nQuick Sort Process:');
  print('1. Choose pivot (last element): 5');
  print('2. Partition: elements < 5 go left, elements > 5 go right');
  print('3. Recursively sort left and right partitions');
  print('4. Combine results (already in place)');
}
```

---

## 3. Binary Search - Search using Divide and Conquer

Binary Search efficiently finds an element in a sorted array by repeatedly dividing the search space.

**Time Complexity**: O(log n)  
**Space Complexity**: O(log n) recursive, O(1) iterative  
**Approach**: Compare with middle element, eliminate half of the search space

```dart
// Recursive Binary Search
int binarySearchRecursive(List<int> arr, int target, int left, int right) {
  // Base case: element not found
  if (left > right) return -1;
  
  // Divide: Find middle element
  int mid = left + (right - left) ~/ 2;
  
  // Base case: element found
  if (arr[mid] == target) return mid;
  
  // Conquer: Search in appropriate half
  if (arr[mid] > target) {
    // Search in left half
    return binarySearchRecursive(arr, target, left, mid - 1);
  } else {
    // Search in right half
    return binarySearchRecursive(arr, target, mid + 1, right);
  }
}

// Helper function for easier usage
int binarySearch(List<int> arr, int target) {
  return binarySearchRecursive(arr, target, 0, arr.length - 1);
}

// Iterative version for comparison
int binarySearchIterative(List<int> arr, int target) {
  int left = 0;
  int right = arr.length - 1;
  
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    
    if (arr[mid] == target) return mid;
    
    if (arr[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  
  return -1;
}

// Example usage
void binarySearchExample() {
  List<int> sortedArray = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  int target = 7;
  
  print('Sorted array: $sortedArray');
  print('Searching for: $target');
  
  int result = binarySearch(sortedArray, target);
  print('Found at index: $result');
  
  print('\nBinary Search Process:');
  print('1. Check middle element (index 4): 9 > 7, search left half');
  print('2. Check middle of left half (index 1): 3 < 7, search right of this');
  print('3. Check element at index 3: 7 = 7, found!');
}
```

---

## 4. Maximum and Minimum Element Finding

Find both maximum and minimum elements in an array with fewer comparisons than naive approach.

**Time Complexity**: O(n)  
**Space Complexity**: O(log n)  
**Approach**: Divide array, find min/max in each half, combine results

```dart
class MinMax {
  int min;
  int max;
  
  MinMax(this.min, this.max);
  
  @override
  String toString() => 'Min: $min, Max: $max';
}

// Divide and Conquer approach to find min and max
MinMax findMinMax(List<int> arr, int low, int high) {
  // Base case: only one element
  if (low == high) {
    return MinMax(arr[low], arr[high]);
  }
  
  // Base case: two elements
  if (high == low + 1) {
    if (arr[low] < arr[high]) {
      return MinMax(arr[low], arr[high]);
    } else {
      return MinMax(arr[high], arr[low]);
    }
  }
  
  // Divide: Split the array
  int mid = (low + high) ~/ 2;
  
  // Conquer: Find min/max in both halves
  MinMax leftMinMax = findMinMax(arr, low, mid);
  MinMax rightMinMax = findMinMax(arr, mid + 1, high);
  
  // Combine: Merge results
  int overallMin = leftMinMax.min < rightMinMax.min ? leftMinMax.min : rightMinMax.min;
  int overallMax = leftMinMax.max > rightMinMax.max ? leftMinMax.max : rightMinMax.max;
  
  return MinMax(overallMin, overallMax);
}

// Helper function
MinMax findMinMaxHelper(List<int> arr) {
  if (arr.isEmpty) throw ArgumentError('Array cannot be empty');
  return findMinMax(arr, 0, arr.length - 1);
}

// Comparison count analysis
int comparisonCount = 0;

MinMax findMinMaxWithCount(List<int> arr, int low, int high) {
  if (low == high) {
    return MinMax(arr[low], arr[high]);
  }
  
  if (high == low + 1) {
    comparisonCount++;
    if (arr[low] < arr[high]) {
      return MinMax(arr[low], arr[high]);
    } else {
      return MinMax(arr[high], arr[low]);
    }
  }
  
  int mid = (low + high) ~/ 2;
  MinMax leftMinMax = findMinMaxWithCount(arr, low, mid);
  MinMax rightMinMax = findMinMaxWithCount(arr, mid + 1, high);
  
  comparisonCount += 2; // Two comparisons for min and max
  int overallMin = leftMinMax.min < rightMinMax.min ? leftMinMax.min : rightMinMax.min;
  int overallMax = leftMinMax.max > rightMinMax.max ? leftMinMax.max : rightMinMax.max;
  
  return MinMax(overallMin, overallMax);
}

// Example usage
void findMinMaxExample() {
  List<int> numbers = [1000, 11, 445, 1, 330, 3000];
  print('Array: $numbers');
  
  MinMax result = findMinMaxHelper(numbers);
  print('Result: $result');
  
  // Compare with naive approach
  comparisonCount = 0;
  MinMax resultWithCount = findMinMaxWithCount(numbers, 0, numbers.length - 1);
  print('Comparisons used (Divide & Conquer): $comparisonCount');
  
  // Naive approach would use 2(n-1) comparisons
  print('Comparisons in naive approach: ${2 * (numbers.length - 1)}');
  print('Efficiency gain: ${2 * (numbers.length - 1) - comparisonCount} fewer comparisons');
}
```

---

## 5. Power Calculation (Exponentiation)

Calculate x^n efficiently using divide and conquer approach.

**Time Complexity**: O(log n)  
**Space Complexity**: O(log n)  
**Approach**: Use the property x^n = (x^(n/2))^2

```dart
// Efficient power calculation using divide and conquer
double power(double x, int n) {
  // Handle negative exponents
  if (n < 0) {
    return 1.0 / powerHelper(x, -n);
  }
  
  return powerHelper(x, n);
}

double powerHelper(double x, int n) {
  // Base case
  if (n == 0) return 1.0;
  if (n == 1) return x;
  
  // Divide: Calculate x^(n/2)
  double halfPower = powerHelper(x, n ~/ 2);
  
  // Combine: Square the result
  double result = halfPower * halfPower;
  
  // If n is odd, multiply by x once more
  if (n % 2 == 1) {
    result *= x;
  }
  
  return result;
}

// Alternative implementation with step counting
int powerSteps = 0;

double powerWithSteps(double x, int n) {
  powerSteps = 0;
  return powerHelperWithSteps(x, n);
}

double powerHelperWithSteps(double x, int n) {
  powerSteps++;
  
  if (n == 0) return 1.0;
  if (n == 1) return x;
  
  double halfPower = powerHelperWithSteps(x, n ~/ 2);
  double result = halfPower * halfPower;
  
  if (n % 2 == 1) {
    result *= x;
  }
  
  return result;
}

// Naive power calculation for comparison
double powerNaive(double x, int n) {
  double result = 1.0;
  for (int i = 0; i < n; i++) {
    result *= x;
  }
  return result;
}

// Example usage
void powerExample() {
  double base = 2.0;
  int exponent = 10;
  
  print('Calculating $base^$exponent');
  
  double result = power(base, exponent);
  print('Result: $result');
  
  double resultWithSteps = powerWithSteps(base, exponent);
  print('Steps in divide & conquer: $powerSteps');
  print('Steps in naive approach: $exponent');
  
  print('\nDivide & Conquer Process:');
  print('2^10 = (2^5)^2 = (2^5) * (2^5)');
  print('2^5 = (2^2)^2 * 2 = 4^2 * 2 = 16 * 2 = 32');
  print('2^10 = 32 * 32 = 1024');
}
```

---

## 6. Matrix Multiplication (Strassen's Algorithm)

Strassen's algorithm uses divide and conquer to multiply matrices more efficiently than the naive O(n³) approach.

**Time Complexity**: O(n^2.807)  
**Space Complexity**: O(n²)  
**Approach**: Divide matrices into blocks, use 7 multiplications instead of 8

```dart
// Matrix representation
class Matrix {
  List<List<int>> data;
  int rows;
  int cols;
  
  Matrix(this.rows, this.cols) : data = List.generate(rows, (_) => List.filled(cols, 0));
  
  Matrix.fromList(List<List<int>> list) : 
    data = list,
    rows = list.length,
    cols = list[0].length;
  
  @override
  String toString() {
    return data.map((row) => row.toString()).join('\n');
  }
}

// Traditional matrix multiplication (for comparison)
Matrix multiplyMatrixTraditional(Matrix a, Matrix b) {
  if (a.cols != b.rows) {
    throw ArgumentError('Matrix dimensions incompatible for multiplication');
  }
  
  Matrix result = Matrix(a.rows, b.cols);
  
  for (int i = 0; i < a.rows; i++) {
    for (int j = 0; j < b.cols; j++) {
      for (int k = 0; k < a.cols; k++) {
        result.data[i][j] += a.data[i][k] * b.data[k][j];
      }
    }
  }
  
  return result;
}

// Simplified Strassen's algorithm (for square matrices that are powers of 2)
Matrix strassenMultiply(Matrix a, Matrix b) {
  int n = a.rows;
  
  // Base case: use traditional multiplication for small matrices
  if (n <= 2) {
    return multiplyMatrixTraditional(a, b);
  }
  
  // Divide matrices into quadrants
  int newSize = n ~/ 2;
  
  Matrix a11 = getSubMatrix(a, 0, 0, newSize);
  Matrix a12 = getSubMatrix(a, 0, newSize, newSize);
  Matrix a21 = getSubMatrix(a, newSize, 0, newSize);
  Matrix a22 = getSubMatrix(a, newSize, newSize, newSize);
  
  Matrix b11 = getSubMatrix(b, 0, 0, newSize);
  Matrix b12 = getSubMatrix(b, 0, newSize, newSize);
  Matrix b21 = getSubMatrix(b, newSize, 0, newSize);
  Matrix b22 = getSubMatrix(b, newSize, newSize, newSize);
  
  // Calculate the 7 products (Strassen's formulas)
  Matrix p1 = strassenMultiply(a11, subtractMatrix(b12, b22));
  Matrix p2 = strassenMultiply(addMatrix(a11, a12), b22);
  Matrix p3 = strassenMultiply(addMatrix(a21, a22), b11);
  Matrix p4 = strassenMultiply(a22, subtractMatrix(b21, b11));
  Matrix p5 = strassenMultiply(addMatrix(a11, a22), addMatrix(b11, b22));
  Matrix p6 = strassenMultiply(subtractMatrix(a12, a22), addMatrix(b21, b22));
  Matrix p7 = strassenMultiply(subtractMatrix(a11, a21), addMatrix(b11, b12));
  
  // Calculate result quadrants
  Matrix c11 = addMatrix(subtractMatrix(addMatrix(p5, p4), p2), p6);
  Matrix c12 = addMatrix(p1, p2);
  Matrix c21 = addMatrix(p3, p4);
  Matrix c22 = subtractMatrix(subtractMatrix(addMatrix(p5, p1), p3), p7);
  
  // Combine quadrants
  return combineMatrices(c11, c12, c21, c22);
}

// Helper functions for matrix operations
Matrix getSubMatrix(Matrix matrix, int row, int col, int size) {
  Matrix result = Matrix(size, size);
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      result.data[i][j] = matrix.data[row + i][col + j];
    }
  }
  return result;
}

Matrix addMatrix(Matrix a, Matrix b) {
  Matrix result = Matrix(a.rows, a.cols);
  for (int i = 0; i < a.rows; i++) {
    for (int j = 0; j < a.cols; j++) {
      result.data[i][j] = a.data[i][j] + b.data[i][j];
    }
  }
  return result;
}

Matrix subtractMatrix(Matrix a, Matrix b) {
  Matrix result = Matrix(a.rows, a.cols);
  for (int i = 0; i < a.rows; i++) {
    for (int j = 0; j < a.cols; j++) {
      result.data[i][j] = a.data[i][j] - b.data[i][j];
    }
  }
  return result;
}

Matrix combineMatrices(Matrix c11, Matrix c12, Matrix c21, Matrix c22) {
  int size = c11.rows * 2;
  Matrix result = Matrix(size, size);
  
  // Copy c11
  for (int i = 0; i < c11.rows; i++) {
    for (int j = 0; j < c11.cols; j++) {
      result.data[i][j] = c11.data[i][j];
    }
  }
  
  // Copy c12
  for (int i = 0; i < c12.rows; i++) {
    for (int j = 0; j < c12.cols; j++) {
      result.data[i][j + c11.cols] = c12.data[i][j];
    }
  }
  
  // Copy c21
  for (int i = 0; i < c21.rows; i++) {
    for (int j = 0; j < c21.cols; j++) {
      result.data[i + c11.rows][j] = c21.data[i][j];
    }
  }
  
  // Copy c22
  for (int i = 0; i < c22.rows; i++) {
    for (int j = 0; j < c22.cols; j++) {
      result.data[i + c11.rows][j + c11.cols] = c22.data[i][j];
    }
  }
  
  return result;
}

// Example usage
void matrixMultiplicationExample() {
  Matrix a = Matrix.fromList([
    [1, 2],
    [3, 4]
  ]);
  
  Matrix b = Matrix.fromList([
    [5, 6],
    [7, 8]
  ]);
  
  print('Matrix A:');
  print(a);
  print('\nMatrix B:');
  print(b);
  
  Matrix traditional = multiplyMatrixTraditional(a, b);
  print('\nTraditional multiplication result:');
  print(traditional);
  
  Matrix strassen = strassenMultiply(a, b);
  print('\nStrassen multiplication result:');
  print(strassen);
}
```

---

## 7. Closest Pair of Points

Find the closest pair of points in a 2D plane using divide and conquer.

**Time Complexity**: O(n log n)  
**Space Complexity**: O(n)  
**Approach**: Divide points by x-coordinate, find closest pairs in each half, check pairs across the divide

```dart
import 'dart:math';

// Point class
class Point {
  double x, y;
  
  Point(this.x, this.y);
  
  double distanceTo(Point other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }
  
  @override
  String toString() => '($x, $y)';
}

// Closest pair result
class ClosestPair {
  Point point1, point2;
  double distance;
  
  ClosestPair(this.point1, this.point2, this.distance);
  
  @override
  String toString() => 'Closest pair: $point1 and $point2, distance: $distance';
}

// Divide and conquer approach to find closest pair
ClosestPair findClosestPair(List<Point> points) {
  if (points.length < 2) {
    throw ArgumentError('Need at least 2 points');
  }
  
  // Sort points by x-coordinate
  List<Point> pointsByX = List.from(points);
  pointsByX.sort((a, b) => a.x.compareTo(b.x));
  
  // Sort points by y-coordinate (for later use)
  List<Point> pointsByY = List.from(points);
  pointsByY.sort((a, b) => a.y.compareTo(b.y));
  
  return closestPairHelper(pointsByX, pointsByY);
}

ClosestPair closestPairHelper(List<Point> pointsX, List<Point> pointsY) {
  int n = pointsX.length;
  
  // Base case: use brute force for small arrays
  if (n <= 3) {
    return bruteForceClosestPair(pointsX);
  }
  
  // Divide: Split points into left and right halves
  int mid = n ~/ 2;
  Point midPoint = pointsX[mid];
  
  List<Point> leftX = pointsX.sublist(0, mid);
  List<Point> rightX = pointsX.sublist(mid);
  
  List<Point> leftY = [];
  List<Point> rightY = [];
  
  for (Point point in pointsY) {
    if (point.x <= midPoint.x) {
      leftY.add(point);
    } else {
      rightY.add(point);
    }
  }
  
  // Conquer: Find closest pairs in both halves
  ClosestPair leftClosest = closestPairHelper(leftX, leftY);
  ClosestPair rightClosest = closestPairHelper(rightX, rightY);
  
  // Find the minimum of the two halves
  ClosestPair minPair = leftClosest.distance < rightClosest.distance ? leftClosest : rightClosest;
  double minDistance = minPair.distance;
  
  // Combine: Check for closer pairs across the divide
  List<Point> strip = [];
  for (Point point in pointsY) {
    if ((point.x - midPoint.x).abs() < minDistance) {
      strip.add(point);
    }
  }
  
  ClosestPair stripClosest = findClosestInStrip(strip, minDistance);
  
  return stripClosest.distance < minPair.distance ? stripClosest : minPair;
}

// Brute force approach for small arrays
ClosestPair bruteForceClosestPair(List<Point> points) {
  double minDistance = double.infinity;
  Point? closest1, closest2;
  
  for (int i = 0; i < points.length; i++) {
    for (int j = i + 1; j < points.length; j++) {
      double distance = points[i].distanceTo(points[j]);
      if (distance < minDistance) {
        minDistance = distance;
        closest1 = points[i];
        closest2 = points[j];
      }
    }
  }
  
  return ClosestPair(closest1!, closest2!, minDistance);
}

// Find closest pair in the strip across the divide
ClosestPair findClosestInStrip(List<Point> strip, double minDistance) {
  double min = minDistance;
  Point? closest1, closest2;
  
  for (int i = 0; i < strip.length; i++) {
    for (int j = i + 1; j < strip.length && (strip[j].y - strip[i].y) < min; j++) {
      double distance = strip[i].distanceTo(strip[j]);
      if (distance < min) {
        min = distance;
        closest1 = strip[i];
        closest2 = strip[j];
      }
    }
  }
  
  if (closest1 != null && closest2 != null) {
    return ClosestPair(closest1, closest2, min);
  } else {
    return ClosestPair(Point(0, 0), Point(0, 0), minDistance);
  }
}

// Example usage
void closestPairExample() {
  List<Point> points = [
    Point(2, 3),
    Point(12, 30),
    Point(40, 50),
    Point(5, 1),
    Point(12, 10),
    Point(3, 4),
  ];
  
  print('Points: ${points.map((p) => p.toString()).join(', ')}');
  
  ClosestPair result = findClosestPair(points);
  print('Result: $result');
  
  print('\nDivide & Conquer Process:');
  print('1. Sort points by x-coordinate');
  print('2. Divide into left and right halves');
  print('3. Recursively find closest pairs in each half');
  print('4. Check for closer pairs across the middle line');
  print('5. Return the overall closest pair');
}
```

---

## 8. Karatsuba Algorithm (Fast Integer Multiplication)

Multiply large integers efficiently using divide and conquer.

**Time Complexity**: O(n^1.585)  
**Space Complexity**: O(n)  
**Approach**: Split numbers into halves, use 3 multiplications instead of 4

```dart
import 'dart:math';

// Karatsuba algorithm for fast integer multiplication
int karatsubaMultiply(int x, int y) {
  // Base case for small numbers
  if (x < 10 || y < 10) {
    return x * y;
  }
  
  // Calculate the size of the numbers
  int size = max(x.toString().length, y.toString().length);
  int halfSize = size ~/ 2;
  
  // Split the digit sequences in the middle
  int multiplier = pow(10, halfSize).toInt();
  
  int high1 = x ~/ multiplier;
  int low1 = x % multiplier;
  
  int high2 = y ~/ multiplier;
  int low2 = y % multiplier;
  
  // Calculate the three products using recursion
  int z0 = karatsubaMultiply(low1, low2);
  int z1 = karatsubaMultiply((low1 + high1), (low2 + high2));
  int z2 = karatsubaMultiply(high1, high2);
  
  // Calculate the result using Karatsuba formula
  return (z2 * pow(10, 2 * halfSize).toInt()) + 
         ((z1 - z2 - z0) * pow(10, halfSize).toInt()) + 
         z0;
}

// Traditional multiplication for comparison
int traditionalMultiply(int x, int y) {
  return x * y;
}

// Example with step counting
int karatsubaSteps = 0;

int karatsubaWithSteps(int x, int y) {
  karatsubaSteps++;
  
  if (x < 10 || y < 10) {
    return x * y;
  }
  
  int size = max(x.toString().length, y.toString().length);
  int halfSize = size ~/ 2;
  int multiplier = pow(10, halfSize).toInt();
  
  int high1 = x ~/ multiplier;
  int low1 = x % multiplier;
  int high2 = y ~/ multiplier;
  int low2 = y % multiplier;
  
  int z0 = karatsubaWithSteps(low1, low2);
  int z1 = karatsubaWithSteps((low1 + high1), (low2 + high2));
  int z2 = karatsubaWithSteps(high1, high2);
  
  return (z2 * pow(10, 2 * halfSize).toInt()) + 
         ((z1 - z2 - z0) * pow(10, halfSize).toInt()) + 
         z0;
}

// Example usage
void karatsubaExample() {
  int num1 = 1234;
  int num2 = 5678;
  
  print('Multiplying $num1 × $num2');
  
  int result = karatsubaMultiply(num1, num2);
  print('Karatsuba result: $result');
  
  int traditional = traditionalMultiply(num1, num2);
  print('Traditional result: $traditional');
  print('Results match: ${result == traditional}');
  
  karatsubaSteps = 0;
  int resultWithSteps = karatsubaWithSteps(num1, num2);
  print('Karatsuba steps: $karatsubaSteps');
  
  print('\nKaratsuba Process:');
  print('1234 × 5678');
  print('Split: 12|34 × 56|78');
  print('Calculate: z0 = 34×78, z1 = (12+34)×(56+78), z2 = 12×56');
  print('Combine using Karatsuba formula');
}
```

---

## 9. Fibonacci Sequence using Matrix Exponentiation

Calculate Fibonacci numbers efficiently using divide and conquer with matrix exponentiation.

**Time Complexity**: O(log n)  
**Space Complexity**: O(log n)  
**Approach**: Use matrix multiplication and fast exponentiation

```dart
// Matrix representation for 2x2 matrices
class Matrix2x2 {
  int a, b, c, d;
  
  Matrix2x2(this.a, this.b, this.c, this.d);
  
  Matrix2x2 multiply(Matrix2x2 other) {
    return Matrix2x2(
      a * other.a + b * other.c,
      a * other.b + b * other.d,
      c * other.a + d * other.c,
      c * other.b + d * other.d
    );
  }
  
  @override
  String toString() => '[$a $b]\n[$c $d]';
}

// Fast Fibonacci using matrix exponentiation
int fibonacciMatrix(int n) {
  if (n <= 1) return n;
  
  Matrix2x2 baseMatrix = Matrix2x2(1, 1, 1, 0);
  Matrix2x2 result = matrixPower(baseMatrix, n - 1);
  
  return result.a;
}

// Matrix exponentiation using divide and conquer
Matrix2x2 matrixPower(Matrix2x2 matrix, int n) {
  if (n == 1) return matrix;
  
  if (n % 2 == 0) {
    Matrix2x2 half = matrixPower(matrix, n ~/ 2);
    return half.multiply(half);
  } else {
    return matrix.multiply(matrixPower(matrix, n - 1));
  }
}

// Traditional recursive Fibonacci (for comparison)
int fibonacciRecursive(int n) {
  if (n <= 1) return n;
  return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
}

// Iterative Fibonacci (for comparison)
int fibonacciIterative(int n) {
  if (n <= 1) return n;
  
  int a = 0, b = 1;
  for (int i = 2; i <= n; i++) {
    int temp = a + b;
    a = b;
    b = temp;
  }
  return b;
}

// Example usage
void fibonacciExample() {
  int n = 10;
  
  print('Calculating Fibonacci($n):');
  
  int matrixResult = fibonacciMatrix(n);
  print('Matrix exponentiation: $matrixResult');
  
  int iterativeResult = fibonacciIterative(n);
  print('Iterative approach: $iterativeResult');
  
  print('\nMatrix Exponentiation Process:');
  print('F(n) = [1 1]^(n-1) * [1]');
  print('       [1 0]         [0]');
  print('Use fast exponentiation to compute matrix power');
  
  // Performance comparison for larger numbers
  print('\nPerformance for larger numbers:');
  int largeN = 30;
  
  Stopwatch sw = Stopwatch()..start();
  int matrixLarge = fibonacciMatrix(largeN);
  sw.stop();
  print('F($largeN) matrix: $matrixLarge (${sw.elapsedMicroseconds} μs)');
  
  sw.reset();
  sw.start();
  int iterativeLarge = fibonacciIterative(largeN);
  sw.stop();
  print('F($largeN) iterative: $iterativeLarge (${sw.elapsedMicroseconds} μs)');
}
```

---

## 10. Divide and Conquer Optimization Techniques

### Memoization for Divide and Conquer

```dart
// Memoized divide and conquer example with Fibonacci
Map<int, int> fibMemo = {};

int fibonacciMemoized(int n) {
  if (n <= 1) return n;
  
  if (fibMemo.containsKey(n)) {
    return fibMemo[n]!;
  }
  
  int result = fibonacciMemoized(n - 1) + fibonacciMemoized(n - 2);
  fibMemo[n] = result;
  
  return result;
}

// Clear memoization cache
void clearFibMemo() {
  fibMemo.clear();
}

// Example of memoization benefits
void memoizationExample() {
  print('Fibonacci with memoization:');
  
  clearFibMemo();
  Stopwatch sw = Stopwatch()..start();
  int result = fibonacciMemoized(40);
  sw.stop();
  
  print('F(40) = $result');
  print('Time with memoization: ${sw.elapsedMilliseconds} ms');
  print('Cache size: ${fibMemo.length}');
}
```

### Tail Recursion Optimization

```dart
// Tail-recursive implementation of power function
double powerTailRecursive(double base, int exponent, [double accumulator = 1.0]) {
  if (exponent == 0) return accumulator;
  
  if (exponent % 2 == 0) {
    return powerTailRecursive(base * base, exponent ~/ 2, accumulator);
  } else {
    return powerTailRecursive(base, exponent - 1, accumulator * base);
  }
}

// Example usage
void tailRecursionExample() {
  double result = powerTailRecursive(2.0, 10);
  print('2^10 using tail recursion: $result');
}
```

---

## 11. Analysis and Complexity Comparison

```dart
// Complexity analysis helper
class ComplexityAnalyzer {
  static void analyzeAlgorithm(String name, Function algorithm, List<int> inputs) {
    print('\nAnalyzing $name:');
    
    for (int input in inputs) {
      Stopwatch sw = Stopwatch()..start();
      algorithm(input);
      sw.stop();
      
      print('Input size $input: ${sw.elapsedMicroseconds} μs');
    }
  }
  
  static void compareSearchAlgorithms() {
    List<int> sortedArray = List.generate(100000, (i) => i);
    int target = 50000;
    
    print('Comparing search algorithms:');
    
    // Linear search
    Stopwatch sw = Stopwatch()..start();
    linearSearch(sortedArray, target);
    sw.stop();
    print('Linear search: ${sw.elapsedMicroseconds} μs');
    
    // Binary search
    sw.reset();
    sw.start();
    binarySearch(sortedArray, target);
    sw.stop();
    print('Binary search: ${sw.elapsedMicroseconds} μs');
  }
  
  static int linearSearch(List<int> arr, int target) {
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] == target) return i;
    }
    return -1;
  }
}

// Master Theorem examples
void masterTheoremExamples() {
  print('\nMaster Theorem Examples:');
  
  print('1. Merge Sort: T(n) = 2T(n/2) + O(n)');
  print('   a=2, b=2, f(n)=n, log_b(a)=1');
  print('   Since f(n) = Θ(n^1), complexity is O(n log n)');
  
  print('\n2. Binary Search: T(n) = T(n/2) + O(1)');
  print('   a=1, b=2, f(n)=1, log_b(a)=0');
  print('   Since f(n) = O(n^0), complexity is O(log n)');
  
  print('\n3. Strassen\'s Algorithm: T(n) = 7T(n/2) + O(n^2)');
  print('   a=7, b=2, f(n)=n^2, log_b(a)≈2.807');
  print('   Since f(n) = O(n^2.807), complexity is O(n^2.807)');
}
```

---

## Main Function - Running All Examples

```dart
void main() {
  print('=== DIVIDE AND CONQUER ALGORITHMS IN DART ===\n');
  
  print('1. Merge Sort:');
  mergeSortExample();
  
  print('\n2. Quick Sort:');
  quickSortExample();
  
  print('\n3. Binary Search:');
  binarySearchExample();
  
  print('\n4. Find Min/Max:');
  findMinMaxExample();
  
  print('\n5. Power Calculation:');
  powerExample();
  
  print('\n6. Matrix Multiplication:');
  matrixMultiplicationExample();
  
  print('\n7. Closest Pair of Points:');
  closestPairExample();
  
  print('\n8. Karatsuba Multiplication:');
  karatsubaExample();
  
  print('\n9. Fibonacci with Matrix Exponentiation:');
  fibonacciExample();
  
  print('\n10. Memoization Example:');
  memoizationExample();
  
  print('\n11. Tail Recursion Example:');
  tailRecursionExample();
  
  print('\n12. Performance Comparison:');
  ComplexityAnalyzer.compareSearchAlgorithms();
  
  print('\n13. Master Theorem:');
  masterTheoremExamples();
}
```

---

## Key Principles of Divide and Conquer

### 1. **Problem Decomposition**
- Break complex problems into smaller, similar subproblems
- Ensure subproblems are independent when possible
- Identify the base case for recursion termination

### 2. **Recurrence Relations**
- Express the time complexity as a recurrence relation
- Use Master Theorem or substitution method to solve
- Common patterns: T(n) = aT(n/b) + f(n)

### 3. **Optimization Strategies**
- **Memoization**: Store results of subproblems to avoid recomputation
- **Tail Recursion**: Optimize recursive calls for better space usage
- **Iterative Conversion**: Convert to iterative when stack space is a concern

### 4. **When to Use Divide and Conquer**
- Problem has optimal substructure
- Subproblems overlap (consider memoization)
- Problem size can be reduced systematically
- Combining solutions is efficient

### 5. **Common Applications**
- **Sorting**: Merge Sort, Quick Sort
- **Searching**: Binary Search, Ternary Search
- **Mathematical**: Fast Exponentiation, Matrix Multiplication
- **Geometric**: Closest Pair, Convex Hull
- **String Processing**: Fast Fourier Transform
- **Graph Algorithms**: Finding Connected Components

This comprehensive guide demonstrates the power and versatility of divide and conquer algorithms, showing how this paradigm can be applied to solve a wide variety of computational problems efficiently!