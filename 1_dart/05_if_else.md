# If-Else Statements in Dart

## Overview
If-else statements are fundamental control flow structures in Dart that allow you to execute different blocks of code based on conditions. They enable decision-making in your programs by evaluating boolean expressions and branching the execution path accordingly.

## Basic Syntax

### Simple If Statement
```dart
if (condition) {
  // Code to execute if condition is true
}
```

### If-Else Statement
```dart
if (condition) {
  // Code to execute if condition is true
} else {
  // Code to execute if condition is false
}
```

### If-Else If-Else Statement
```dart
if (condition1) {
  // Code to execute if condition1 is true
} else if (condition2) {
  // Code to execute if condition2 is true
} else {
  // Code to execute if all conditions are false
}
```

## Types of If-Else Statements

### 1. Simple If Statement
Used when you want to execute code only when a condition is true.

```dart
int age = 18;
if (age >= 18) {
  print('You are eligible to vote!');
}
```

### 2. If-Else Statement
Used when you have two possible execution paths.

```dart
int number = 15;
if (number % 2 == 0) {
  print('$number is even');
} else {
  print('$number is odd');
}
```

### 3. If-Else If-Else Chain
Used for multiple conditions and execution paths.

```dart
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
```

### 4. Nested If-Else
If-else statements inside other if-else statements.

```dart
int age = 25;
bool hasLicense = true;

if (age >= 18) {
  if (hasLicense) {
    print('You can drive a car');
  } else {
    print('You need a driving license');
  }
} else {
  print('You are too young to drive');
}
```

## Conditional Expressions

### Ternary Operator
A shorthand way to write simple if-else statements.

```dart
// Syntax: condition ? valueIfTrue : valueIfFalse
int age = 20;
String status = age >= 18 ? 'Adult' : 'Minor';
print('Status: $status');
```

### Null-Aware Operators
Special operators for handling null values.

```dart
String? name;
String displayName = name ?? 'Anonymous'; // If name is null, use 'Anonymous'

// Null-aware assignment
name ??= 'Default Name'; // Assign only if name is currently null
```

## Comparison Operators
Used in conditions to compare values:

| Operator | Description | Example |
|----------|-------------|---------|
| `==` | Equal to | `a == b` |
| `!=` | Not equal to | `a != b` |
| `>` | Greater than | `a > b` |
| `<` | Less than | `a < b` |
| `>=` | Greater than or equal | `a >= b` |
| `<=` | Less than or equal | `a <= b` |

## Logical Operators
Used to combine multiple conditions:

| Operator | Description | Example |
|----------|-------------|---------|
| `&&` | Logical AND | `(a > 0) && (b > 0)` |
| `\|\|` | Logical OR | `(a > 0) \|\| (b > 0)` |
| `!` | Logical NOT | `!(a > 0)` |

## Practical Examples

### Example 1: Age Category Classification
```dart
void classifyAge(int age) {
  if (age < 0) {
    print('Invalid age');
  } else if (age <= 12) {
    print('Child');
  } else if (age <= 19) {
    print('Teenager');
  } else if (age <= 59) {
    print('Adult');
  } else {
    print('Senior');
  }
}
```

### Example 2: Login Validation
```dart
void validateLogin(String username, String password) {
  if (username.isEmpty) {
    print('Username cannot be empty');
  } else if (password.isEmpty) {
    print('Password cannot be empty');
  } else if (password.length < 8) {
    print('Password must be at least 8 characters');
  } else {
    print('Login successful!');
  }
}
```

### Example 3: Weather Advice
```dart
void weatherAdvice(String weather, int temperature) {
  if (weather == 'sunny' && temperature > 25) {
    print('Perfect day for outdoor activities!');
  } else if (weather == 'rainy') {
    print('Don\'t forget your umbrella!');
  } else if (temperature < 0) {
    print('It\'s freezing! Stay warm.');
  } else {
    print('Have a nice day!');
  }
}
```

### Example 4: Grade Calculator
```dart
String calculateGrade(double percentage) {
  if (percentage >= 90) {
    return 'A+';
  } else if (percentage >= 80) {
    return 'A';
  } else if (percentage >= 70) {
    return 'B';
  } else if (percentage >= 60) {
    return 'C';
  } else if (percentage >= 50) {
    return 'D';
  } else {
    return 'F';
  }
}
```

### Example 5: Number Analysis
```dart
void analyzeNumber(int number) {
  // Check if positive, negative, or zero
  if (number > 0) {
    print('$number is positive');
    
    // Check if even or odd
    if (number % 2 == 0) {
      print('$number is even');
    } else {
      print('$number is odd');
    }
    
    // Check if it's a perfect square
    int sqrt = (number.toDouble().sqrt()).round();
    if (sqrt * sqrt == number) {
      print('$number is a perfect square');
    }
  } else if (number < 0) {
    print('$number is negative');
  } else {
    print('Number is zero');
  }
}
```

## Advanced Patterns

### Switch Statement Alternative
While not if-else, switch statements provide another way to handle multiple conditions:

```dart
void handleGrade(String grade) {
  switch (grade) {
    case 'A':
      print('Excellent!');
      break;
    case 'B':
      print('Good job!');
      break;
    case 'C':
      print('Average');
      break;
    default:
      print('Keep trying!');
  }
}
```

### Pattern Matching (Dart 3.0+)
```dart
String getStatusMessage(int code) {
  return switch (code) {
    200 => 'Success',
    404 => 'Not Found',
    500 => 'Server Error',
    _ => 'Unknown Error'
  };
}
```

### Guard Clauses
Using early returns to avoid nested if-else:

```dart
void processUser(String? name, int? age) {
  if (name == null) {
    print('Name is required');
    return;
  }
  
  if (age == null || age < 0) {
    print('Valid age is required');
    return;
  }
  
  if (age < 18) {
    print('User must be 18 or older');
    return;
  }
  
  print('Processing user: $name, age: $age');
}
```

## Best Practices

### 1. Use Descriptive Conditions
```dart
// Bad
if (x > 0 && x < 100 && y == 1) {
  // code
}

// Good
bool isValidScore = score > 0 && score <= 100;
bool isActiveUser = userStatus == 1;
if (isValidScore && isActiveUser) {
  // code
}
```

### 2. Avoid Deep Nesting
```dart
// Bad - deeply nested
if (user != null) {
  if (user.isActive) {
    if (user.hasPermission) {
      // do something
    }
  }
}

// Good - early returns
if (user == null) return;
if (!user.isActive) return;
if (!user.hasPermission) return;
// do something
```

### 3. Use Null Safety
```dart
// Handle nullable values properly
String? getValue() => someCondition ? 'value' : null;

String result = getValue() ?? 'default';
```

### 4. Consistent Formatting
```dart
// Always use braces for clarity
if (condition) {
  doSomething();
}

// Even for single statements
if (condition) {
  print('Single statement');
}
```

## Common Pitfalls

### 1. Assignment vs Comparison
```dart
int x = 5;
// Wrong - assignment instead of comparison
if (x = 10) { } // This won't compile in Dart

// Correct - comparison
if (x == 10) { }
```

### 2. Floating Point Comparison
```dart
double a = 0.1 + 0.2;
double b = 0.3;

// Wrong - may not work due to floating point precision
if (a == b) { }

// Better - use tolerance
if ((a - b).abs() < 0.0001) { }
```

### 3. String Comparison
```dart
String input = getUserInput();

// Be careful with case sensitivity
if (input == 'yes') { } // Won't match 'YES' or 'Yes'

// Better
if (input.toLowerCase() == 'yes') { }
```

## Real-World Applications

### 1. Form Validation
```dart
bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  } else if (!email.contains('@')) {
    return false;
  } else if (!email.contains('.')) {
    return false;
  }
  return true;
}
```

### 2. Game Logic
```dart
void checkGameResult(int playerScore, int computerScore) {
  if (playerScore > computerScore) {
    print('You win!');
  } else if (computerScore > playerScore) {
    print('Computer wins!');
  } else {
    print('It\'s a tie!');
  }
}
```

### 3. Access Control
```dart
bool canAccessResource(User user, Resource resource) {
  if (!user.isLoggedIn) {
    return false;
  } else if (user.role == 'admin') {
    return true;
  } else if (resource.isPublic) {
    return true;
  } else if (resource.owner == user.id) {
    return true;
  }
  return false;
}
```

## Summary
If-else statements are essential for creating dynamic, responsive programs. They allow you to:
- Make decisions based on data
- Control program flow
- Handle different scenarios
- Validate input and data
- Implement business logic

Master these concepts to write more intelligent and interactive Dart applications!