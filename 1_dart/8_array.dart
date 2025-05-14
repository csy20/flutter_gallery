// filepath: /workspaces/flutter_gallery/dart/8_array.dart

void main() {
  // Arrays in Dart are implemented using the List class
  // There are several ways to create lists in Dart

  // 1. Creating an empty list
  List<String> emptyList = [];
  print('Empty list: $emptyList');

  // 2. Creating a list with initial values
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Numbers list: $numbers');

  // 3. Creating a fixed-length list
  List<String> fixedList = List.filled(3, 'item');
  print('Fixed-length list: $fixedList');

  // 4. Creating a list using List.generate
  List<int> generatedList = List.generate(5, (index) => index * 2);
  print('Generated list: $generatedList');

  // 5. Creating a list from another iterable
  List<int> fromIterable = List.from([10, 20, 30]);
  print('List from iterable: $fromIterable');

  // Accessing elements by index
  print('First element of numbers: ${numbers[0]}');
  print('Third element of numbers: ${numbers[2]}');

  // Modifying list elements
  numbers[1] = 20; // Changing the second element
  print('Numbers after modification: $numbers');

  // Adding elements to a list
  numbers.add(6);
  print('Numbers after adding an element: $numbers');

  // Adding multiple elements
  numbers.addAll([7, 8, 9]);
  print('Numbers after adding multiple elements: $numbers');

  // Inserting an element at a specific position
  numbers.insert(2, 25);
  print('Numbers after inserting 25 at index 2: $numbers');

  // Removing elements
  numbers.remove(25); // Remove element with value 25
  print('Numbers after removing 25: $numbers');

  numbers.removeAt(0); // Remove element at index 0
  print('Numbers after removing element at index 0: $numbers');

  // Finding elements
  int indexOf3 = numbers.indexOf(3);
  print('Index of 3: $indexOf3');

  // Checking if list contains an element
  bool contains8 = numbers.contains(8);
  print('Does the list contain 8? $contains8');

  // Getting list length
  print('Length of numbers list: ${numbers.length}');

  // Sorting a list
  numbers.sort();
  print('Sorted numbers: $numbers');

  // Reversing a list
  List<int> reversedNumbers = numbers.reversed.toList();
  print('Reversed numbers: $reversedNumbers');

  // Mapping a list to another list
  List<int> multipliedBy2 = numbers.map((e) => e * 2).toList();
  print('Numbers multiplied by 2: $multipliedBy2');

  // Filtering a list
  List<int> evenNumbers = numbers.where((e) => e % 2 == 0).toList();
  print('Even numbers: $evenNumbers');

  // Reducing a list to a single value
  int sum = numbers.reduce((value, element) => value + element);
  print('Sum of numbers: $sum');

  // 2D arrays (lists of lists)
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  print('2D array (matrix): $matrix');
  print('Element at row 1, column 2: ${matrix[1][2]}');

  // Creating a 2D array dynamically
  List<List<int>> dynamicMatrix = List.generate(
      3, (i) => List.generate(3, (j) => i * 3 + j + 1));
  print('Dynamically generated matrix: $dynamicMatrix');

  // Converting between lists and other collections
  Set<int> numberSet = numbers.toSet(); // Convert to Set (removes duplicates)
  print('Numbers as a Set: $numberSet');

  List<int> backToList = numberSet.toList(); // Convert back to List
  print('Set converted back to List: $backToList');
}