
// Unlike languages like C or C++, Dart doesn't have direct pointer manipulation.
// Instead, Dart uses references for objects, which are similar to pointers
// but with more safety and fewer complexities.

void main() {
  // In Dart, all objects are references (similar to pointers)
  // When you create a variable that holds an object, you're storing a reference
  
  print('\n=== Basic Reference Example ===');
  // Example 1: Basic reference behavior
  List<int> list1 = [1, 2, 3];
  List<int> list2 = list1; // list2 points to the same list as list1
  
  print('list1: $list1');
  print('list2: $list2');
  
  // Modifying list2 affects list1 because they reference the same object
  list2.add(4);
  print('After modifying list2:');
  print('list1: $list1');
  print('list2: $list2');
  
  print('\n=== Function Parameter Reference ===');
  // Example 2: Function parameters are passed by reference for objects
  List<String> names = ['Alice', 'Bob'];
  print('Before function call: $names');
  addName(names, 'Charlie');
  print('After function call: $names');
  
  print('\n=== Primitive Types ===');
  // Example 3: Primitive types (int, double, bool) are passed by value
  int x = 10;
  print('Before function call: x = $x');
  incrementValue(x);
  print('After function call: x = $x'); // x remains unchanged
  
  print('\n=== Object Identity ===');
  // Example 4: Checking object identity
  var a = [1, 2, 3];
  var b = [1, 2, 3];
  var c = a;
  
  print('a == b: ${identical(a, b)}'); // false - different objects with same values
  print('a == c: ${identical(a, c)}'); // true - same object
  
  print('\n=== Null Safety ===');
  // Example 5: Null safety (Dart's way of making references safer)
  // String name = null; // Error in Dart with null safety
  String? name = null; // OK - explicitly nullable
  
  // Safe navigation operator (?.): only access property if reference isn't null
  print('Length of name: ${name?.length}');
  
  // If-null operator (??): provide default value if reference is null
  print('Name or default: ${name ?? "Default Name"}');
}

// Objects are passed by reference
void addName(List<String> list, String name) {
  list.add(name);
  print('Inside function: $list');
}

// Primitive types are passed by value
void incrementValue(int value) {
  value = value + 1;
  print('Inside function: value = $value');
}