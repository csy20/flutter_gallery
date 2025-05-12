void main() {
  print('Dart If-Else Statement Examples\n');

  // ========== BASIC IF STATEMENT ==========
  print('===== Basic If Statement =====');
  int age = 20;
  
  if (age >= 18) {
    print('You are an adult.');
  }

  // ========== IF-ELSE STATEMENT ==========
  print('\n===== If-Else Statement =====');
  int temperature = 15;
  
  if (temperature > 30) {
    print('It\'s hot outside!');
  } else {
    print('It\'s not hot outside.');
  }

  // ========== IF-ELSE IF-ELSE LADDER ==========
  print('\n===== If-Else If-Else Ladder =====');
  int score = 85;
  
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else if (score >= 70) {
    print('Grade: C');
  } else if (score >= 60) {
    print('Grade: D');
  } else {
    print('Grade: F');
  }

  // ========== NESTED IF STATEMENTS ==========
  print('\n===== Nested If Statements =====');
  bool isWeekend = true;
  bool isRaining = false;
  
  if (isWeekend) {
    if (isRaining) {
      print('Watch a movie at home.');
    } else {
      print('Go outside and have fun!');
    }
  } else {
    if (isRaining) {
      print('Take an umbrella to work.');
    } else {
      print('Enjoy the weather at work.');
    }
  }

  // ========== LOGICAL OPERATORS IN CONDITIONS ==========
  print('\n===== Logical Operators in Conditions =====');
  
  // AND (&&) operator - both conditions must be true
  if (age >= 18 && isWeekend) {
    print('You can go to the weekend party!');
  }
  
  // OR (||) operator - at least one condition must be true
  if (isRaining || temperature < 10) {
    print('Consider staying indoors.');
  }
  
  // NOT (!) operator - inverts the condition
  if (!isRaining) {
    print('No need for an umbrella.');
  }

  // ========== CONDITIONAL (TERNARY) OPERATOR ==========
  print('\n===== Conditional (Ternary) Operator =====');
  // condition ? expression1 : expression2
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('Status: $status');
  
  // Nested ternary operator (can be harder to read)
  String weatherType = temperature > 30 ? 'Hot' : (temperature < 10 ? 'Cold' : 'Moderate');
  print('Weather: $weatherType');

  // ========== NULL-AWARE CONDITIONAL OPERATORS ==========
  print('\n===== Null-Aware Conditional Operators =====');
  
  String? name; // Nullable string, initially null
  
  // If-null operator (??)
  String displayName = name ?? 'Guest'; // If name is null, use 'Guest'
  print('Welcome, $displayName');
  
  // Null-aware conditional assignment (??=)
  name ??= 'New User'; // Assign only if name is null
  print('Updated name: $name');
}

// NOTES ON DART IF-ELSE STATEMENTS:
// 1. The condition in if statements must evaluate to a boolean value (true or false)
// 2. Curly braces {} are required for multiple statements but optional for single statements
// 3. Dart supports standard comparison operators: ==, !=, >, <, >=, <=
// 4. Logical operators: && (AND), || (OR), ! (NOT)
// 5. The equality check is == (not = which is assignment)
// 6. The ternary operator is a shorthand for simple if-else statements
// 7. Null safety features in Dart 2.12+ provide additional conditional operators for null handling