void main() {
  // ----------------------------------------
  // 1. For Loop
  // ----------------------------------------
  // Standard for loop with initialization, condition, and increment
  print('\n--- Standard For Loop ---');
  for (int i = 0; i < 5; i++) {
    print('Index: $i');
  }

  // For loop with multiple variables
  print('\n--- For Loop with Multiple Variables ---');
  for (int i = 0, j = 5; i < 5; i++, j--) {
    print('i = $i, j = $j');
  }

  // ----------------------------------------
  // 2. While Loop
  // ----------------------------------------
  // Executes as long as the condition is true
  print('\n--- While Loop ---');
  int counter = 0;
  while (counter < 5) {
    print('Counter: $counter');
    counter++;
  }

  // ----------------------------------------
  // 3. Do-While Loop
  // ----------------------------------------
  // Similar to while loop, but guarantees at least one execution
  print('\n--- Do-While Loop ---');
  int num = 0;
  do {
    print('Number: $num');
    num++;
  } while (num < 5);

  // Example showing the difference between while and do-while
  print('\n--- While vs Do-While Difference ---');
  int a = 10;
  
  // This while loop won't execute as the condition is false immediately
  while (a < 5) {
    print('This will not print in while loop');
    a++;
  }
  
  // This do-while loop will execute once regardless of the condition
  do {
    print('This will print once in do-while loop even though condition is false');
    a++;
  } while (a < 5);

  // ----------------------------------------
  // 4. For-in Loop (for collections)
  // ----------------------------------------
  // Used to iterate over collections like lists, sets, maps
  print('\n--- For-in Loop with List ---');
  List<String> fruits = ['Apple', 'Banana', 'Orange', 'Mango'];
  for (String fruit in fruits) {
    print('Fruit: $fruit');
  }

  // For-in loop with Map
  print('\n--- For-in Loop with Map ---');
  Map<String, int> ages = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35,
  };
  
  // Iterating over entries
  for (MapEntry entry in ages.entries) {
    print('${entry.key} is ${entry.value} years old');
  }
  
  // Iterating over keys
  print('\n--- Iterating over Map keys ---');
  for (String name in ages.keys) {
    print('Name: $name');
  }
  
  // Iterating over values
  print('\n--- Iterating over Map values ---');
  for (int age in ages.values) {
    print('Age: $age');
  }

  // ----------------------------------------
  // 5. forEach Method (for collections)
  // ----------------------------------------
  // Another way to iterate through collections using anonymous functions
  print('\n--- forEach Method with List ---');
  fruits.forEach((fruit) {
    print('Fruit (from forEach): $fruit');
  });
  
  // Using arrow function for conciseness
  print('\n--- forEach with Arrow Function ---');
  fruits.forEach((fruit) => print('Fruit (arrow): $fruit'));

  // ----------------------------------------
  // Loop Control Statements
  // ----------------------------------------
  // Break - exits the loop
  print('\n--- Break Statement ---');
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      print('Breaking at i = $i');
      break;
    }
    print('i = $i');
  }

  // Continue - skips current iteration
  print('\n--- Continue Statement ---');
  for (int i = 0; i < 5; i++) {
    if (i == 2) {
      print('Skipping i = $i');
      continue;
    }
    print('i = $i');
  }

  // ----------------------------------------
  // Labeled Loops
  // ----------------------------------------
  // Labels can be used with break and continue for nested loops
  print('\n--- Labeled Loops ---');
  outerLoop: for (int i = 0; i < 3; i++) {
    print('Outer loop: i = $i');
    
    innerLoop: for (int j = 0; j < 3; j++) {
      if (i == 1 && j == 1) {
        print('Breaking out of outer loop when i = $i and j = $j');
        break outerLoop; // Breaks out of the outer loop
      }
      
      if (i == 0 && j == 1) {
        print('Continuing to next iteration of inner loop when i = $i and j = $j');
        continue innerLoop; // Skips current iteration of inner loop
      }
      
      print('  Inner loop: j = $j');
    }
  }
}