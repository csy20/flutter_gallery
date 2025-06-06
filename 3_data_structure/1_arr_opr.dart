
void main() {
  print('=== DART ARRAY OPERATIONS ===\n');
  
  // Arrays in Dart are implemented as Lists
  // Lists are dynamic, ordered collections of objects
  
  // ========== BASIC OPERATIONS ==========
  print('1. BASIC OPERATIONS:');
  List<int> numbers = [10, 20, 30, 40, 50];
  print('Original array: $numbers');
  
  // Access elements
  print('First element: ${numbers.first}');
  print('Last element: ${numbers.last}');
  print('Element at index 2: ${numbers[2]}');
  
  // Modify elements
  numbers[1] = 25;
  print('After modifying index 1: $numbers\n');
  
  // ========== INSERTION OPERATIONS ==========
  print('2. INSERTION OPERATIONS:');
  List<String> fruits = ['apple', 'banana'];
  print('Original fruits: $fruits');
  
  // Add at end
  fruits.add('orange');
  print('After add(): $fruits');
  
  // Add multiple elements
  fruits.addAll(['grape', 'mango']);
  print('After addAll(): $fruits');
  
  // Insert at specific position
  fruits.insert(1, 'kiwi');
  print('After insert at index 1: $fruits');
  
  // Insert multiple at specific position
  fruits.insertAll(3, ['peach', 'plum']);
  print('After insertAll at index 3: $fruits\n');
  
  // ========== DELETION OPERATIONS ==========
  print('3. DELETION OPERATIONS:');
  List<int> nums = [1, 2, 3, 2, 4, 5, 2];
  print('Original nums: $nums');
  
  // Remove first occurrence of value
  nums.remove(2);
  print('After remove(2): $nums');
  
  // Remove at specific index
  int removed = nums.removeAt(2);
  print('Removed element $removed at index 2: $nums');
  
  // Remove last element
  int lastRemoved = nums.removeLast();
  print('Removed last element $lastRemoved: $nums');
  
  // Remove range of elements
  nums.removeRange(1, 3);
  print('After removeRange(1, 3): $nums');
  
  // Remove elements matching condition
  List<int> numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  numbers2.removeWhere((element) => element % 2 == 0);
  print('After removing even numbers: $numbers2');
  
  // Clear all elements
  List<int> temp = [1, 2, 3];
  temp.clear();
  print('After clear(): $temp\n');
  
  // ========== SEARCH OPERATIONS ==========
  print('4. SEARCH OPERATIONS:');
  List<String> colors = ['red', 'green', 'blue', 'yellow', 'green'];
  print('Colors: $colors');
  
  // Check if element exists
  print('Contains "blue": ${colors.contains("blue")}');
  
  // Find index of element
  print('Index of "green": ${colors.indexOf("green")}');
  print('Last index of "green": ${colors.lastIndexOf("green")}');
  
  // Find element matching condition
  String? foundColor = colors.firstWhere(
    (color) => color.startsWith('b'),
    orElse: () => 'Not found'
  );
  print('First color starting with "b": $foundColor');
  
  // Check if any element matches condition
  bool hasLongName = colors.any((color) => color.length > 5);
  print('Has color with more than 5 characters: $hasLongName');
  
  // Check if all elements match condition
  bool allShortNames = colors.every((color) => color.length < 10);
  print('All colors have less than 10 characters: $allShortNames\n');
  
  // ========== TRANSFORMATION OPERATIONS ==========
  print('5. TRANSFORMATION OPERATIONS:');
  List<int> values = [1, 2, 3, 4, 5];
  print('Original values: $values');
  
  // Map - transform each element
  List<int> squared = values.map((x) => x * x).toList();
  print('Squared values: $squared');
  
  // Filter - select elements matching condition
  List<int> evenValues = values.where((x) => x % 2 == 0).toList();
  print('Even values: $evenValues');
  
  // Expand - flatten nested structures
  List<List<int>> nested = [[1, 2], [3, 4], [5]];
  List<int> flattened = nested.expand((list) => list).toList();
  print('Flattened nested list: $flattened');
  
  // Take - get first n elements
  List<int> firstThree = values.take(3).toList();
  print('First 3 elements: $firstThree');
  
  // Skip - skip first n elements
  List<int> skipTwo = values.skip(2).toList();
  print('Skip first 2 elements: $skipTwo');
  
  // Reverse
  List<int> reversed = values.reversed.toList();
  print('Reversed values: $reversed\n');
  
  // ========== AGGREGATION OPERATIONS ==========
  print('6. AGGREGATION OPERATIONS:');
  List<int> scores = [85, 92, 78, 96, 88];
  print('Scores: $scores');
  
  // Reduce - combine all elements into single value
  int sum = scores.reduce((a, b) => a + b);
  print('Sum using reduce: $sum');
  
  // Fold - like reduce but with initial value
  int sumWithInitial = scores.fold(0, (prev, current) => prev + current);
  print('Sum using fold: $sumWithInitial');
  
  // Find min and max
  int minScore = scores.reduce((a, b) => a < b ? a : b);
  int maxScore = scores.reduce((a, b) => a > b ? a : b);
  print('Min score: $minScore, Max score: $maxScore');
  
  // Calculate average
  double average = scores.reduce((a, b) => a + b) / scores.length;
  print('Average score: ${average.toStringAsFixed(2)}\n');
  
  // ========== SORTING OPERATIONS ==========
  print('7. SORTING OPERATIONS:');
  List<String> names = ['Charlie', 'Alice', 'Bob', 'David'];
  print('Original names: $names');
  
  // Sort in ascending order
  names.sort();
  print('Sorted ascending: $names');
  
  // Sort in descending order
  names.sort((a, b) => b.compareTo(a));
  print('Sorted descending: $names');
  
  // Sort by custom criteria (by length)
  names.sort((a, b) => a.length.compareTo(b.length));
  print('Sorted by length: $names\n');
  
  // ========== SET OPERATIONS ==========
  print('8. SET OPERATIONS:');
  List<int> list1 = [1, 2, 3, 4, 5];
  List<int> list2 = [4, 5, 6, 7, 8];
  
  // Union (combine without duplicates)
  Set<int> union = {...list1, ...list2};
  print('Union: $union');
  
  // Intersection (common elements)
  Set<int> intersection = list1.toSet().intersection(list2.toSet());
  print('Intersection: $intersection');
  
  // Difference (elements in first but not in second)
  Set<int> difference = list1.toSet().difference(list2.toSet());
  print('Difference (list1 - list2): $difference\n');
  
  // ========== 2D ARRAY OPERATIONS ==========
  print('9. 2D ARRAY OPERATIONS:');
  
  // Create 2D array
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  print('Matrix:');
  for (var row in matrix) {
    print('  $row');
  }
  
  // Access elements
  print('Element at [1][2]: ${matrix[1][2]}');
  
  // Modify elements
  matrix[0][0] = 10;
  print('After modifying [0][0] to 10:');
  for (var row in matrix) {
    print('  $row');
  }
  
  // Get row
  List<int> firstRow = matrix[0];
  print('First row: $firstRow');
  
  // Get column (requires iteration)
  List<int> firstColumn = matrix.map((row) => row[0]).toList();
  print('First column: $firstColumn');
  
  // Matrix transpose
  List<List<int>> transposed = List.generate(
    matrix[0].length,
    (i) => List.generate(matrix.length, (j) => matrix[j][i])
  );
  print('Transposed matrix:');
  for (var row in transposed) {
    print('  $row');
  }
  
  // ========== ADVANCED OPERATIONS ==========
  print('\n10. ADVANCED OPERATIONS:');
  
  // Chunk array into smaller arrays
  List<int> largeList = List.generate(10, (i) => i + 1);
  List<List<int>> chunks = chunkArray(largeList, 3);
  print('Original: $largeList');
  print('Chunked into groups of 3: $chunks');
  
  // Zip two arrays together
  List<String> keys = ['a', 'b', 'c'];
  List<int> vals = [1, 2, 3];
  Map<String, int> zipped = zipArrays(keys, vals);
  print('Zipped arrays: $zipped');
  
  // Array rotation
  List<int> toRotate = [1, 2, 3, 4, 5];
  List<int> rotatedLeft = rotateLeft(toRotate, 2);
  List<int> rotatedRight = rotateRight(toRotate, 2);
  print('Original: $toRotate');
  print('Rotated left by 2: $rotatedLeft');
  print('Rotated right by 2: $rotatedRight');
  
  // Find duplicates
  List<int> withDuplicates = [1, 2, 3, 2, 4, 3, 5];
  List<int> duplicates = findDuplicates(withDuplicates);
  print('Array with duplicates: $withDuplicates');
  print('Duplicates found: $duplicates');
}

// Helper functions for advanced operations

// Chunk array into smaller arrays of specified size
List<List<T>> chunkArray<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];
  for (int i = 0; i < list.length; i += chunkSize) {
    int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
    chunks.add(list.sublist(i, end));
  }
  return chunks;
}

// Zip two arrays into a Map
Map<K, V> zipArrays<K, V>(List<K> keys, List<V> values) {
  Map<K, V> result = {};
  int minLength = keys.length < values.length ? keys.length : values.length;
  for (int i = 0; i < minLength; i++) {
    result[keys[i]] = values[i];
  }
  return result;
}

// Rotate array to the left
List<T> rotateLeft<T>(List<T> list, int positions) {
  if (list.isEmpty || positions == 0) return List.from(list);
  positions = positions % list.length;
  return [...list.sublist(positions), ...list.sublist(0, positions)];
}

// Rotate array to the right
List<T> rotateRight<T>(List<T> list, int positions) {
  if (list.isEmpty || positions == 0) return List.from(list);
  positions = positions % list.length;
  return [...list.sublist(list.length - positions), ...list.sublist(0, list.length - positions)];
}

// Find duplicate elements in array
List<T> findDuplicates<T>(List<T> list) {
  Set<T> seen = {};
  Set<T> duplicates = {};
  
  for (T item in list) {
    if (seen.contains(item)) {
      duplicates.add(item);
    } else {
      seen.add(item);
    }
  }
  
  return duplicates.toList();
}