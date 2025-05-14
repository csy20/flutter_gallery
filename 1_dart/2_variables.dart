void main() {
  // 1. Variable Declaration
  // ----------------------
  
  // Using 'var' with type inference
  var name = 'John Doe';  // Dart infers this as String
  var age = 30;           // Dart infers this as int
  var height = 1.75;      // Dart infers this as double
  var isActive = true;    // Dart infers this as bool
  
  print('\n--- Variable Declaration ---');
  print('Name: $name (${name.runtimeType})');
  print('Age: $age (${age.runtimeType})');
  print('Height: $height (${height.runtimeType})');
  print('Is Active: $isActive (${isActive.runtimeType})');
  
  // 2. Explicit Type Declaration
  // ---------------------------
  
  String country = 'USA';
  int population = 331000000;
  double gdp = 22.67;
  bool isOpen = false;
  
  print('\n--- Explicit Type Declaration ---');
  print('Country: $country');
  print('Population: $population');
  print('GDP: $gdp trillion');
  print('Is Open: $isOpen');
  
  // 3. Dynamic Type
  // --------------
  
  dynamic dynamicVar = 'This is a string';
  print('\n--- Dynamic Type ---');
  print('Dynamic var: $dynamicVar (${dynamicVar.runtimeType})');
  
  dynamicVar = 100;
  print('Dynamic var changed: $dynamicVar (${dynamicVar.runtimeType})');
  
  // 4. Final and Const
  // -----------------
  
  // 'final' - value can't be changed after initialization (runtime constant)
  final String finalName = 'Jane';
  final finalYear = 2025;  // Type inference works with final too
  
  // 'const' - compile-time constant
  const String constName = 'Mark';
  const constPi = 3.14159;  // Type inference works with const too
  
  print('\n--- Final and Const ---');
  print('Final name: $finalName, Final year: $finalYear');
  print('Const name: $constName, Const PI: $constPi');
  
  // Difference between final and const:
  final currentTime = DateTime.now();  // Works fine - evaluated at runtime
  // const currentTimeConst = DateTime.now();  // ERROR - can't be determined at compile time
  
  // 5. Late Variables
  // ---------------
  
  // 'late' - initialize the variable later
  late String lateVar;
  
  // Initialize it later
  lateVar = 'I was initialized later';
  print('\n--- Late Variables ---');
  print('Late var: $lateVar');
  
  // 6. Null Safety
  // -------------
  
  // Nullable variables (can be null)
  String? nullableString = 'This can be null';
  print('\n--- Null Safety ---');
  print('Nullable string: $nullableString');
  
  nullableString = null;
  print('Nullable string after setting to null: $nullableString');
  
  // Non-nullable variables (can't be null)
  String nonNullableString = 'This cannot be null';
  // nonNullableString = null;  // ERROR - can't assign null to non-nullable
  
  // Null-aware operators
  String? maybeNull;
  String notNull = maybeNull ?? 'Default value';  // ?? provides a default value if null
  print('Using ?? operator: $notNull');
  
  // 7. Collections with var, final, const
  // -----------------------------------
  
  var list1 = [1, 2, 3];        // Mutable list
  final list2 = [4, 5, 6];      // Can't reassign list2, but can modify its contents
  const list3 = [7, 8, 9];      // Can't modify list3 at all
  
  list1.add(4);                 // OK
  list2.add(7);                 // OK
  // list3.add(10);             // ERROR - can't modify const list
  
  print('\n--- Collections ---');
  print('var list: $list1');
  print('final list: $list2');
  print('const list: $list3');
  
  // 8. Type Promotion
  // ---------------
  
  Object someValue = 'Hello';
  
  print('\n--- Type Promotion ---');
  if (someValue is String) {
    // Within this block, Dart knows someValue is a String
    print('Length of string: ${someValue.length}');  // No need for explicit cast
  }
}