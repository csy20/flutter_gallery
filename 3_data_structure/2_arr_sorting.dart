void main() {
  print('=== DART ARRAY SORTING CONCEPTS ===\n');
  
  // ========== BUILT-IN SORTING METHODS ==========
  print('1. BUILT-IN SORTING METHODS:');
  
  // Basic sorting with sort()
  List<int> numbers = [64, 34, 25, 12, 22, 11, 90];
  print('Original array: $numbers');
  
  // Sort in ascending order (default)
  List<int> ascending = List.from(numbers);
  ascending.sort();
  print('Ascending order: $ascending');
  
  // Sort in descending order using custom comparator
  List<int> descending = List.from(numbers);
  descending.sort((a, b) => b.compareTo(a));
  print('Descending order: $descending');
  
  // Sort strings
  List<String> names = ['Charlie', 'Alice', 'Bob', 'David', 'Eve'];
  print('\nOriginal names: $names');
  
  List<String> sortedNames = List.from(names);
  sortedNames.sort();
  print('Sorted names: $sortedNames');
  
  // Case-insensitive string sorting
  List<String> mixedCase = ['banana', 'Apple', 'cherry', 'Date'];
  print('\nMixed case: $mixedCase');
  
  List<String> caseInsensitive = List.from(mixedCase);
  caseInsensitive.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  print('Case-insensitive sort: $caseInsensitive\n');
  
  // ========== CUSTOM SORTING CRITERIA ==========
  print('2. CUSTOM SORTING CRITERIA:');
  
  // Sort by string length
  List<String> words = ['programming', 'dart', 'flutter', 'a', 'algorithm'];
  print('Original words: $words');
  
  List<String> byLength = List.from(words);
  byLength.sort((a, b) => a.length.compareTo(b.length));
  print('Sorted by length: $byLength');
  
  // Sort by multiple criteria (length first, then alphabetically)
  List<String> multiCriteria = List.from(words);
  multiCriteria.sort((a, b) {
    int lengthComparison = a.length.compareTo(b.length);
    if (lengthComparison != 0) return lengthComparison;
    return a.compareTo(b); // If same length, sort alphabetically
  });
  print('Multi-criteria sort: $multiCriteria');
  
  // Sort objects by properties
  List<Person> people = [
    Person('Alice', 25, 85000),
    Person('Bob', 30, 75000),
    Person('Charlie', 25, 90000),
    Person('David', 35, 80000),
  ];
  
  print('\nOriginal people:');
  people.forEach(print);
  
  // Sort by age
  List<Person> byAge = List.from(people);
  byAge.sort((a, b) => a.age.compareTo(b.age));
  print('\nSorted by age:');
  byAge.forEach(print);
  
  // Sort by salary (descending)
  List<Person> bySalary = List.from(people);
  bySalary.sort((a, b) => b.salary.compareTo(a.salary));
  print('\nSorted by salary (descending):');
  bySalary.forEach(print);
  
  // Sort by age first, then by salary
  List<Person> multiSort = List.from(people);
  multiSort.sort((a, b) {
    int ageComparison = a.age.compareTo(b.age);
    if (ageComparison != 0) return ageComparison;
    return b.salary.compareTo(a.salary); // If same age, sort by salary desc
  });
  print('\nSorted by age, then salary:');
  multiSort.forEach(print);
  
  print('\n' + '='*50 + '\n');
  
  // ========== SORTING ALGORITHMS IMPLEMENTATION ==========
  print('3. SORTING ALGORITHMS IMPLEMENTATION:');
  
  List<int> testArray = [64, 34, 25, 12, 22, 11, 90];
  print('Test array for algorithms: $testArray\n');
  
  // Bubble Sort
  print('BUBBLE SORT:');
  List<int> bubbleResult = bubbleSort(List.from(testArray));
  print('Result: $bubbleResult');
  print('Time Complexity: O(n²), Space Complexity: O(1)\n');
  
  // Selection Sort
  print('SELECTION SORT:');
  List<int> selectionResult = selectionSort(List.from(testArray));
  print('Result: $selectionResult');
  print('Time Complexity: O(n²), Space Complexity: O(1)\n');
  
  // Insertion Sort
  print('INSERTION SORT:');
  List<int> insertionResult = insertionSort(List.from(testArray));
  print('Result: $insertionResult');
  print('Time Complexity: O(n²), Space Complexity: O(1)\n');
  
  // Merge Sort
  print('MERGE SORT:');
  List<int> mergeResult = mergeSort(List.from(testArray));
  print('Result: $mergeResult');
  print('Time Complexity: O(n log n), Space Complexity: O(n)\n');
  
  // Quick Sort
  print('QUICK SORT:');
  List<int> quickResult = quickSort(List.from(testArray));
  print('Result: $quickResult');
  print('Time Complexity: O(n log n) avg, O(n²) worst, Space Complexity: O(log n)\n');
  
  // ========== SPECIALIZED SORTING TECHNIQUES ==========
  print('4. SPECIALIZED SORTING TECHNIQUES:');
  
  // Counting Sort (for integers with limited range)
  List<int> smallNumbers = [4, 2, 2, 8, 3, 3, 1];
  print('Small numbers: $smallNumbers');
  List<int> countingResult = countingSort(smallNumbers, 8);
  print('Counting sort result: $countingResult');
  print('Time Complexity: O(n + k), Space Complexity: O(k)\n');
  
  // Radix Sort (for non-negative integers)
  List<int> largeNumbers = [170, 45, 75, 90, 2, 802, 24, 66];
  print('Large numbers: $largeNumbers');
  List<int> radixResult = radixSort(List.from(largeNumbers));
  print('Radix sort result: $radixResult');
  print('Time Complexity: O(d × n), Space Complexity: O(n + k)\n');
  
  // ========== SORTING PERFORMANCE COMPARISON ==========
  print('5. SORTING PERFORMANCE COMPARISON:');
  
  // Test with different array sizes
  List<int> sizes = [100, 1000, 5000];
  
  for (int size in sizes) {
    print('\nArray size: $size');
    List<int> randomArray = generateRandomArray(size);
    
    // Test built-in sort
    Stopwatch stopwatch = Stopwatch()..start();
    List<int> builtInResult = List.from(randomArray);
    builtInResult.sort();
    stopwatch.stop();
    print('Built-in sort: ${stopwatch.elapsedMicroseconds} microseconds');
    
    // Test merge sort
    stopwatch.reset();
    stopwatch.start();
    List<int> mergeSortResult = mergeSort(List.from(randomArray));
    stopwatch.stop();
    print('Merge sort: ${stopwatch.elapsedMicroseconds} microseconds');
    
    // Test quick sort
    stopwatch.reset();
    stopwatch.start();
    List<int> quickSortResult = quickSort(List.from(randomArray));
    stopwatch.stop();
    print('Quick sort: ${stopwatch.elapsedMicroseconds} microseconds');
  }
  
  // ========== ADVANCED SORTING CONCEPTS ==========
  print('\n6. ADVANCED SORTING CONCEPTS:');
  
  // Stable vs Unstable sorting
  List<Student> students = [
    Student('Alice', 85, 'A'),
    Student('Bob', 90, 'B'),
    Student('Charlie', 85, 'A'),
    Student('David', 90, 'B'),
  ];
  
  print('\nOriginal students:');
  students.forEach(print);
  
  // Stable sort by grade (preserves original order for equal elements)
  List<Student> stableSort = List.from(students);
  stableSort.sort((a, b) => a.grade.compareTo(b.grade));
  print('\nStable sort by grade:');
  stableSort.forEach(print);
  
  // Partial sorting - finding top K elements
  List<int> largeArray = generateRandomArray(20);
  print('\nLarge array: $largeArray');
  List<int> topK = findTopK(largeArray, 5);
  print('Top 5 elements: $topK');
  
  // Sorting with custom objects and null safety
  List<int?> nullableNumbers = [5, null, 3, 8, null, 1];
  print('\nNullable numbers: $nullableNumbers');
  List<int?> sortedNullable = sortWithNulls(nullableNumbers);
  print('Sorted (nulls first): $sortedNullable');
}

// ========== PERSON CLASS FOR OBJECT SORTING ==========
class Person {
  final String name;
  final int age;
  final double salary;
  
  Person(this.name, this.age, this.salary);
  
  @override
  String toString() => 'Person(name: $name, age: $age, salary: \$${salary.toStringAsFixed(0)})';
}

// ========== STUDENT CLASS FOR STABLE SORTING DEMO ==========
class Student {
  final String name;
  final int grade;
  final String section;
  
  Student(this.name, this.grade, this.section);
  
  @override
  String toString() => 'Student(name: $name, grade: $grade, section: $section)';
}

// ========== SORTING ALGORITHM IMPLEMENTATIONS ==========

// Bubble Sort - O(n²) time complexity
List<int> bubbleSort(List<int> arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        // Swap elements
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
  return arr;
}

// Selection Sort - O(n²) time complexity
List<int> selectionSort(List<int> arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < n; j++) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }
    // Swap minimum element with first element
    int temp = arr[minIndex];
    arr[minIndex] = arr[i];
    arr[i] = temp;
  }
  return arr;
}

// Insertion Sort - O(n²) time complexity
List<int> insertionSort(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    int key = arr[i];
    int j = i - 1;
    
    // Move elements greater than key one position ahead
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
    }
    arr[j + 1] = key;
  }
  return arr;
}

// Merge Sort - O(n log n) time complexity
List<int> mergeSort(List<int> arr) {
  if (arr.length <= 1) return arr;
  
  int mid = arr.length ~/ 2;
  List<int> left = mergeSort(arr.sublist(0, mid));
  List<int> right = mergeSort(arr.sublist(mid));
  
  return merge(left, right);
}

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

// Quick Sort - O(n log n) average time complexity
List<int> quickSort(List<int> arr) {
  if (arr.length <= 1) return arr;
  
  int pivot = arr[arr.length ~/ 2];
  List<int> less = arr.where((x) => x < pivot).toList();
  List<int> equal = arr.where((x) => x == pivot).toList();
  List<int> greater = arr.where((x) => x > pivot).toList();
  
  return [...quickSort(less), ...equal, ...quickSort(greater)];
}

// Counting Sort - O(n + k) time complexity
List<int> countingSort(List<int> arr, int maxValue) {
  List<int> count = List.filled(maxValue + 1, 0);
  
  // Count occurrences
  for (int num in arr) {
    count[num]++;
  }
  
  // Build result array
  List<int> result = [];
  for (int i = 0; i < count.length; i++) {
    for (int j = 0; j < count[i]; j++) {
      result.add(i);
    }
  }
  
  return result;
}

// Radix Sort - O(d × n) time complexity
List<int> radixSort(List<int> arr) {
  if (arr.isEmpty) return arr;
  
  int maxValue = arr.reduce((a, b) => a > b ? a : b);
  
  for (int exp = 1; maxValue ~/ exp > 0; exp *= 10) {
    arr = countingSortByDigit(arr, exp);
  }
  
  return arr;
}

List<int> countingSortByDigit(List<int> arr, int exp) {
  List<int> output = List.filled(arr.length, 0);
  List<int> count = List.filled(10, 0);
  
  // Count occurrences of each digit
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
  
  return output;
}

// ========== UTILITY FUNCTIONS ==========

// Generate random array for testing
List<int> generateRandomArray(int size) {
  var random = DateTime.now().millisecondsSinceEpoch;
  List<int> arr = [];
  for (int i = 0; i < size; i++) {
    random = (random * 1103515245 + 12345) & 0x7fffffff;
    arr.add(random % 1000);
  }
  return arr;
}

// Find top K elements using partial sorting
List<int> findTopK(List<int> arr, int k) {
  List<int> copy = List.from(arr);
  copy.sort((a, b) => b.compareTo(a)); // Sort in descending order
  return copy.take(k).toList();
}

// Sort array with nullable values
List<int?> sortWithNulls(List<int?> arr) {
  List<int?> result = List.from(arr);
  result.sort((a, b) {
    if (a == null && b == null) return 0;
    if (a == null) return -1; // null comes first
    if (b == null) return 1;
    return a.compareTo(b);
  });
  return result;
}