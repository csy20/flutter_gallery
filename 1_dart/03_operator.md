# Operators in Dart

## Overview
Operators in Dart are special symbols that perform operations on operands (variables, values, expressions). Dart provides a rich set of operators that allow you to manipulate data and control program flow.

## Types of Operators

### 1. Arithmetic Operators
Perform mathematical operations on numeric values.

| Operator | Description | Example |
|----------|-------------|---------|
| `+` | Addition | `5 + 3 = 8` |
| `-` | Subtraction | `5 - 3 = 2` |
| `*` | Multiplication | `5 * 3 = 15` |
| `/` | Division (returns double) | `5 / 2 = 2.5` |
| `~/` | Integer Division | `5 ~/ 2 = 2` |
| `%` | Modulo (remainder) | `5 % 3 = 2` |
| `++` | Increment | `++x` or `x++` |
| `--` | Decrement | `--x` or `x--` |

### 2. Assignment Operators
Assign values to variables.

| Operator | Description | Example |
|----------|-------------|---------|
| `=` | Simple assignment | `x = 5` |
| `+=` | Add and assign | `x += 3` → `x = x + 3` |
| `-=` | Subtract and assign | `x -= 3` → `x = x - 3` |
| `*=` | Multiply and assign | `x *= 3` → `x = x * 3` |
| `/=` | Divide and assign | `x /= 3` → `x = x / 3` |
| `~/=` | Integer divide and assign | `x ~/= 3` → `x = x ~/ 3` |
| `%=` | Modulo and assign | `x %= 3` → `x = x % 3` |

### 3. Comparison (Relational) Operators
Compare two values and return a boolean result.

| Operator | Description | Example |
|----------|-------------|---------|
| `==` | Equal to | `5 == 5` → `true` |
| `!=` | Not equal to | `5 != 3` → `true` |
| `>` | Greater than | `5 > 3` → `true` |
| `<` | Less than | `3 < 5` → `true` |
| `>=` | Greater than or equal | `5 >= 5` → `true` |
| `<=` | Less than or equal | `3 <= 5` → `true` |

### 4. Logical Operators
Perform logical operations on boolean values.

| Operator | Description | Example |
|----------|-------------|---------|
| `&&` | Logical AND | `true && false` → `false` |
| `\|\|` | Logical OR | `true \|\| false` → `true` |
| `!` | Logical NOT | `!true` → `false` |

### 5. Bitwise Operators
Perform operations on individual bits.

| Operator | Description | Example |
|----------|-------------|---------|
| `&` | Bitwise AND | `5 & 3` → `1` |
| `\|` | Bitwise OR | `5 \| 3` → `7` |
| `^` | Bitwise XOR | `5 ^ 3` → `6` |
| `~` | Bitwise NOT | `~5` → `-6` |
| `<<` | Left shift | `5 << 1` → `10` |
| `>>` | Right shift | `5 >> 1` → `2` |

### 6. Type Test Operators
Check the type of an object.

| Operator | Description | Example |
|----------|-------------|---------|
| `is` | Type check | `x is String` |
| `is!` | Negated type check | `x is! String` |
| `as` | Type cast | `x as String` |

### 7. Conditional Operators
Provide conditional expressions.

| Operator | Description | Example |
|----------|-------------|---------|
| `? :` | Ternary operator | `condition ? value1 : value2` |
| `??` | Null-coalescing | `value ?? defaultValue` |
| `??=` | Null-aware assignment | `value ??= defaultValue` |

### 8. Cascade Operator
Allows performing multiple operations on the same object.

| Operator | Description | Example |
|----------|-------------|---------|
| `..` | Cascade | `object..method1()..method2()` |
| `?..` | Null-aware cascade | `object?..method1()..method2()` |

## Operator Precedence
Operators have different precedence levels (highest to lowest):

1. Postfix: `expr++`, `expr--`, `()`, `[]`, `.`, `?.`
2. Unary prefix: `-expr`, `!expr`, `~expr`, `++expr`, `--expr`
3. Multiplicative: `*`, `/`, `%`, `~/`
4. Additive: `+`, `-`
5. Shift: `<<`, `>>`
6. Bitwise AND: `&`
7. Bitwise XOR: `^`
8. Bitwise OR: `|`
9. Relational: `>=`, `>`, `<=`, `<`, `as`, `is`, `is!`
10. Equality: `==`, `!=`
11. Logical AND: `&&`
12. Logical OR: `||`
13. Conditional: `expr1 ? expr2 : expr3`
14. Cascade: `..`
15. Assignment: `=`, `*=`, `/=`, `+=`, `-=`, `&=`, `^=`, etc.

## Key Concepts

### Null Safety Operators
Dart's null safety feature introduces special operators:
- `??` - Returns right operand if left is null
- `??=` - Assigns value only if variable is null
- `?.` - Safe navigation operator
- `!` - Null assertion operator

### Short-circuit Evaluation
Logical operators use short-circuit evaluation:
- `&&` - If first operand is false, second is not evaluated
- `||` - If first operand is true, second is not evaluated

### Operator Overloading
Custom classes can override operators like `+`, `-`, `==`, etc.

## Best Practices

1. **Use parentheses** for clarity when mixing operators
2. **Prefer explicit comparisons** over implicit boolean conversion
3. **Use null-safe operators** to handle nullable values
4. **Be careful with operator precedence** - when in doubt, use parentheses
5. **Use meaningful variable names** with operators for readability

## Common Patterns

### Safe Navigation
```dart
String? name = getName();
int? length = name?.length;  // Returns null if name is null
```

### Default Values
```dart
String displayName = user.name ?? 'Anonymous';
```

### Chaining Operations
```dart
list
  ..add('item1')
  ..add('item2')
  ..sort();
```

### Type Checking
```dart
if (value is String) {
  print('Value is a string: $value');
}
```

This comprehensive guide covers all the essential operators in Dart programming language!