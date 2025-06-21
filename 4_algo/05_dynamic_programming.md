# Dynamic Programming in Dart

## Introduction to Dynamic Programming

Dynamic Programming (DP) is an algorithmic paradigm that solves complex problems by breaking them down into simpler subproblems. It's a method for solving optimization problems by combining the solutions of overlapping subproblems.

### Key Characteristics:
- **Optimal Substructure**: Optimal solution contains optimal solutions to subproblems
- **Overlapping Subproblems**: Subproblems are repeated multiple times
- **Memoization**: Store solutions to avoid recomputation
- **Bottom-up or Top-down**: Can be implemented iteratively or recursively

### DP vs Other Approaches:
- **vs Divide & Conquer**: DP has overlapping subproblems, D&C has independent subproblems
- **vs Greedy**: DP considers all possibilities, Greedy makes local optimal choices
- **vs Brute Force**: DP avoids redundant calculations through memoization

### When to Use DP:
1. Problem can be broken into overlapping subproblems
2. Optimal substructure property exists
3. Choices made at each step depend on solutions to subproblems
4. Problem involves optimization (min/max)

---

## 1. Fibonacci Sequence - Introduction to DP

The classic example to understand memoization and optimization.

**Problem**: Calculate the nth Fibonacci number.

**Subproblems**: F(n) = F(n-1) + F(n-2)

```dart
// Naive recursive approach (exponential time)
int fibonacciNaive(int n) {
  if (n <= 1) return n;
  return fibonacciNaive(n - 1) + fibonacciNaive(n - 2);
}

// Memoized approach (top-down DP)
Map<int, int> fibMemo = {};

int fibonacciMemoized(int n) {
  if (n <= 1) return n;
  
  if (fibMemo.containsKey(n)) {
    return fibMemo[n]!;
  }
  
  fibMemo[n] = fibonacciMemoized(n - 1) + fibonacciMemoized(n - 2);
  return fibMemo[n]!;
}

// Tabulated approach (bottom-up DP)
int fibonacciTabulated(int n) {
  if (n <= 1) return n;
  
  List<int> dp = List.filled(n + 1, 0);
  dp[0] = 0;
  dp[1] = 1;
  
  for (int i = 2; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];
  }
  
  return dp[n];
}

// Space-optimized approach
int fibonacciOptimized(int n) {
  if (n <= 1) return n;
  
  int prev2 = 0, prev1 = 1;
  int current = 0;
  
  for (int i = 2; i <= n; i++) {
    current = prev1 + prev2;
    prev2 = prev1;
    prev1 = current;
  }
  
  return current;
}

// Example usage with performance comparison
void fibonacciExample() {
  int n = 35;
  
  print('Calculating Fibonacci($n):');
  
  // Memoized approach
  fibMemo.clear();
  Stopwatch sw = Stopwatch()..start();
  int memoResult = fibonacciMemoized(n);
  sw.stop();
  print('Memoized: $memoResult (${sw.elapsedMilliseconds} ms)');
  
  // Tabulated approach
  sw.reset();
  sw.start();
  int tabulatedResult = fibonacciTabulated(n);
  sw.stop();
  print('Tabulated: $tabulatedResult (${sw.elapsedMicroseconds} μs)');
  
  // Optimized approach
  sw.reset();
  sw.start();
  int optimizedResult = fibonacciOptimized(n);
  sw.stop();
  print('Optimized: $optimizedResult (${sw.elapsedMicroseconds} μs)');
  
  print('\nDP Approach Benefits:');
  print('• Reduces time complexity from O(2^n) to O(n)');
  print('• Space can be optimized from O(n) to O(1)');
  print('• Demonstrates both top-down and bottom-up approaches');
}
```

---

## 2. 0/1 Knapsack Problem

Classic optimization problem where items cannot be fractioned.

**Problem**: Given weights and values of items, maximize value in knapsack with weight limit.

**Subproblems**: For each item, decide to include or exclude it.

```dart
// Item class for knapsack
class KnapsackItem {
  int weight;
  int value;
  String name;
  
  KnapsackItem(this.name, this.weight, this.value);
  
  @override
  String toString() => '$name(w:$weight, v:$value)';
}

// Recursive approach with memoization (top-down)
Map<String, int> knapsackMemo = {};

int knapsack01Memoized(List<KnapsackItem> items, int capacity, int index) {
  // Base case
  if (index >= items.length || capacity <= 0) {
    return 0;
  }
  
  String key = '${index}_$capacity';
  if (knapsackMemo.containsKey(key)) {
    return knapsackMemo[key]!;
  }
  
  // If current item's weight exceeds capacity, skip it
  if (items[index].weight > capacity) {
    knapsackMemo[key] = knapsack01Memoized(items, capacity, index + 1);
  } else {
    // Choose maximum of including or excluding current item
    int includeItem = items[index].value + 
                     knapsack01Memoized(items, capacity - items[index].weight, index + 1);
    int excludeItem = knapsack01Memoized(items, capacity, index + 1);
    
    knapsackMemo[key] = includeItem > excludeItem ? includeItem : excludeItem;
  }
  
  return knapsackMemo[key]!;
}

// Tabulated approach (bottom-up)
class KnapsackResult {
  int maxValue;
  List<KnapsackItem> selectedItems;
  
  KnapsackResult(this.maxValue, this.selectedItems);
  
  @override
  String toString() {
    return 'Max Value: $maxValue\n'
           'Selected Items: ${selectedItems.map((item) => item.name).join(", ")}\n'
           'Total Weight: ${selectedItems.fold(0, (sum, item) => sum + item.weight)}';
  }
}

KnapsackResult knapsack01Tabulated(List<KnapsackItem> items, int capacity) {
  int n = items.length;
  
  // Create DP table
  List<List<int>> dp = List.generate(n + 1, (_) => List.filled(capacity + 1, 0));
  
  // Fill DP table
  for (int i = 1; i <= n; i++) {
    for (int w = 1; w <= capacity; w++) {
      if (items[i - 1].weight <= w) {
        // Max of including or excluding current item
        int includeValue = items[i - 1].value + dp[i - 1][w - items[i - 1].weight];
        int excludeValue = dp[i - 1][w];
        dp[i][w] = includeValue > excludeValue ? includeValue : excludeValue;
      } else {
        dp[i][w] = dp[i - 1][w];
      }
    }
  }
  
  // Backtrack to find selected items
  List<KnapsackItem> selectedItems = [];
  int w = capacity;
  for (int i = n; i > 0 && w > 0; i--) {
    if (dp[i][w] != dp[i - 1][w]) {
      selectedItems.add(items[i - 1]);
      w -= items[i - 1].weight;
    }
  }
  
  return KnapsackResult(dp[n][capacity], selectedItems.reversed.toList());
}

// Space-optimized version (1D array)
int knapsack01Optimized(List<KnapsackItem> items, int capacity) {
  List<int> dp = List.filled(capacity + 1, 0);
  
  for (KnapsackItem item in items) {
    // Traverse backwards to avoid using updated values
    for (int w = capacity; w >= item.weight; w--) {
      dp[w] = dp[w] > dp[w - item.weight] + item.value 
              ? dp[w] 
              : dp[w - item.weight] + item.value;
    }
  }
  
  return dp[capacity];
}

// Example usage
void knapsackExample() {
  List<KnapsackItem> items = [
    KnapsackItem('Diamond', 1, 15),
    KnapsackItem('Gold', 3, 20),
    KnapsackItem('Silver', 4, 30),
    KnapsackItem('Emerald', 2, 12),
    KnapsackItem('Ruby', 5, 25),
  ];
  
  int capacity = 8;
  
  print('0/1 Knapsack Problem:');
  print('Items: ${items.join(", ")}');
  print('Capacity: $capacity');
  
  // Memoized approach
  knapsackMemo.clear();
  int memoResult = knapsack01Memoized(items, capacity, 0);
  print('\nMemoized result: $memoResult');
  
  // Tabulated approach with item tracking
  KnapsackResult result = knapsack01Tabulated(items, capacity);
  print('\nTabulated result:');
  print(result);
  
  // Optimized approach
  int optimizedResult = knapsack01Optimized(items, capacity);
  print('\nOptimized result: $optimizedResult');
  
  print('\nDP Strategy:');
  print('• State: dp[i][w] = maximum value using first i items with weight limit w');
  print('• Transition: dp[i][w] = max(dp[i-1][w], dp[i-1][w-weight[i]] + value[i])');
  print('• Time: O(n×W), Space: O(n×W) or O(W) optimized');
}
```

---

## 3. Longest Common Subsequence (LCS)

Find the longest subsequence common to two sequences.

**Problem**: Given two strings, find length of longest common subsequence.

**Subproblems**: Compare characters and build solution incrementally.

```dart
// LCS with memoization (top-down)
Map<String, int> lcsMemo = {};

int lcsRecursive(String text1, String text2, int i, int j) {
  if (i >= text1.length || j >= text2.length) {
    return 0;
  }
  
  String key = '${i}_$j';
  if (lcsMemo.containsKey(key)) {
    return lcsMemo[key]!;
  }
  
  int result;
  if (text1[i] == text2[j]) {
    result = 1 + lcsRecursive(text1, text2, i + 1, j + 1);
  } else {
    int option1 = lcsRecursive(text1, text2, i + 1, j);
    int option2 = lcsRecursive(text1, text2, i, j + 1);
    result = option1 > option2 ? option1 : option2;
  }
  
  lcsMemo[key] = result;
  return result;
}

// LCS with tabulation (bottom-up)
class LCSResult {
  int length;
  String subsequence;
  List<List<int>> dpTable;
  
  LCSResult(this.length, this.subsequence, this.dpTable);
  
  @override
  String toString() {
    return 'LCS Length: $length\n'
           'LCS: "$subsequence"';
  }
}

LCSResult lcsTabulated(String text1, String text2) {
  int m = text1.length;
  int n = text2.length;
  
  // Create DP table
  List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
  
  // Fill DP table
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (text1[i - 1] == text2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }
  
  // Reconstruct LCS
  String lcs = _reconstructLCS(text1, text2, dp);
  
  return LCSResult(dp[m][n], lcs, dp);
}

// Helper function to reconstruct actual LCS
String _reconstructLCS(String text1, String text2, List<List<int>> dp) {
  int i = text1.length;
  int j = text2.length;
  List<String> lcs = [];
  
  while (i > 0 && j > 0) {
    if (text1[i - 1] == text2[j - 1]) {
      lcs.add(text1[i - 1]);
      i--;
      j--;
    } else if (dp[i - 1][j] > dp[i][j - 1]) {
      i--;
    } else {
      j--;
    }
  }
  
  return lcs.reversed.join('');
}

// Space-optimized LCS (only length)
int lcsOptimized(String text1, String text2) {
  int m = text1.length;
  int n = text2.length;
  
  // Use only two rows
  List<int> prev = List.filled(n + 1, 0);
  List<int> curr = List.filled(n + 1, 0);
  
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (text1[i - 1] == text2[j - 1]) {
        curr[j] = prev[j - 1] + 1;
      } else {
        curr[j] = prev[j] > curr[j - 1] ? prev[j] : curr[j - 1];
      }
    }
    
    // Swap rows
    List<int> temp = prev;
    prev = curr;
    curr = temp;
  }
  
  return prev[n];
}

// Visualize DP table
void _printDPTable(List<List<int>> dp, String text1, String text2) {
  print('\nDP Table:');
  print('    ""  ${text2.split('').join('  ')}');
  
  for (int i = 0; i < dp.length; i++) {
    String rowLabel = i == 0 ? '""' : text1[i - 1];
    String row = '$rowLabel   ${dp[i].join('  ')}';
    print(row);
  }
}

// Example usage
void lcsExample() {
  String text1 = "AGGTAB";
  String text2 = "GXTXAYB";
  
  print('Longest Common Subsequence:');
  print('Text 1: "$text1"');
  print('Text 2: "$text2"');
  
  // Memoized approach
  lcsMemo.clear();
  int memoResult = lcsRecursive(text1, text2, 0, 0);
  print('\nMemoized LCS length: $memoResult');
  
  // Tabulated approach
  LCSResult result = lcsTabulated(text1, text2);
  print('\nTabulated result:');
  print(result);
  
  _printDPTable(result.dpTable, text1, text2);
  
  // Optimized approach
  int optimizedResult = lcsOptimized(text1, text2);
  print('\nOptimized LCS length: $optimizedResult');
  
  print('\nDP Strategy:');
  print('• If characters match: dp[i][j] = dp[i-1][j-1] + 1');
  print('• If different: dp[i][j] = max(dp[i-1][j], dp[i][j-1])');
  print('• Time: O(m×n), Space: O(m×n) or O(min(m,n)) optimized');
}
```

---

## 4. Edit Distance (Levenshtein Distance)

Find minimum operations to transform one string into another.

**Problem**: Convert string1 to string2 using insert, delete, replace operations.

**Subproblems**: Consider all possible operations at each position.

```dart
// Edit Distance with memoization
Map<String, int> editMemo = {};

int editDistanceRecursive(String str1, String str2, int i, int j) {
  // Base cases
  if (i >= str1.length) return str2.length - j;
  if (j >= str2.length) return str1.length - i;
  
  String key = '${i}_$j';
  if (editMemo.containsKey(key)) {
    return editMemo[key]!;
  }
  
  int result;
  if (str1[i] == str2[j]) {
    result = editDistanceRecursive(str1, str2, i + 1, j + 1);
  } else {
    int insertOp = 1 + editDistanceRecursive(str1, str2, i, j + 1);
    int deleteOp = 1 + editDistanceRecursive(str1, str2, i + 1, j);
    int replaceOp = 1 + editDistanceRecursive(str1, str2, i + 1, j + 1);
    
    result = [insertOp, deleteOp, replaceOp].reduce((a, b) => a < b ? a : b);
  }
  
  editMemo[key] = result;
  return result;
}

// Edit Distance with tabulation and operation tracking
class EditDistanceResult {
  int distance;
  List<String> operations;
  List<List<int>> dpTable;
  
  EditDistanceResult(this.distance, this.operations, this.dpTable);
  
  @override
  String toString() {
    return 'Edit Distance: $distance\n'
           'Operations: ${operations.join(" → ")}';
  }
}

EditDistanceResult editDistanceTabulated(String str1, String str2) {
  int m = str1.length;
  int n = str2.length;
  
  // Create DP table
  List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
  
  // Initialize base cases
  for (int i = 0; i <= m; i++) dp[i][0] = i;
  for (int j = 0; j <= n; j++) dp[0][j] = j;
  
  // Fill DP table
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (str1[i - 1] == str2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 + [
          dp[i - 1][j],     // Delete
          dp[i][j - 1],     // Insert
          dp[i - 1][j - 1]  // Replace
        ].reduce((a, b) => a < b ? a : b);
      }
    }
  }
  
  // Reconstruct operations
  List<String> operations = _reconstructOperations(str1, str2, dp);
  
  return EditDistanceResult(dp[m][n], operations, dp);
}

// Helper function to reconstruct operations
List<String> _reconstructOperations(String str1, String str2, List<List<int>> dp) {
  List<String> operations = [];
  int i = str1.length;
  int j = str2.length;
  
  while (i > 0 || j > 0) {
    if (i > 0 && j > 0 && str1[i - 1] == str2[j - 1]) {
      operations.add('Match ${str1[i - 1]}');
      i--;
      j--;
    } else if (i > 0 && j > 0 && dp[i][j] == dp[i - 1][j - 1] + 1) {
      operations.add('Replace ${str1[i - 1]} with ${str2[j - 1]}');
      i--;
      j--;
    } else if (i > 0 && dp[i][j] == dp[i - 1][j] + 1) {
      operations.add('Delete ${str1[i - 1]}');
      i--;
    } else if (j > 0 && dp[i][j] == dp[i][j - 1] + 1) {
      operations.add('Insert ${str2[j - 1]}');
      j--;
    }
  }
  
  return operations.reversed.toList();
}

// Example usage
void editDistanceExample() {
  String str1 = "INTENTION";
  String str2 = "EXECUTION";
  
  print('Edit Distance (Levenshtein Distance):');
  print('String 1: "$str1"');
  print('String 2: "$str2"');
  
  // Memoized approach
  editMemo.clear();
  int memoResult = editDistanceRecursive(str1, str2, 0, 0);
  print('\nMemoized edit distance: $memoResult');
  
  // Tabulated approach with operations
  EditDistanceResult result = editDistanceTabulated(str1, str2);
  print('\nTabulated result:');
  print(result);
  
  print('\nOperations needed:');
  for (int i = 0; i < result.operations.length; i++) {
    print('${i + 1}. ${result.operations[i]}');
  }
  
  print('\nDP Strategy:');
  print('• If characters match: dp[i][j] = dp[i-1][j-1]');
  print('• If different: dp[i][j] = 1 + min(insert, delete, replace)');
  print('• Time: O(m×n), Space: O(m×n)');
}
```

---

## 5. Coin Change Problem

Find minimum coins needed or count total ways to make change.

**Problem**: Given coin denominations, find minimum coins or count ways to make amount.

**Two Variants**: Minimum coins and count ways.

```dart
// Minimum Coins using DP
Map<int, int> coinMemo = {};

int minCoinsRecursive(List<int> coins, int amount) {
  if (amount == 0) return 0;
  if (amount < 0) return -1;
  
  if (coinMemo.containsKey(amount)) {
    return coinMemo[amount]!;
  }
  
  int minCoins = double.maxFinite.toInt();
  
  for (int coin in coins) {
    int result = minCoinsRecursive(coins, amount - coin);
    if (result != -1) {
      minCoins = minCoins < result + 1 ? minCoins : result + 1;
    }
  }
  
  int finalResult = minCoins == double.maxFinite.toInt() ? -1 : minCoins;
  coinMemo[amount] = finalResult;
  return finalResult;
}

// Minimum Coins with tabulation
class CoinChangeResult {
  int minCoins;
  List<int> coinCombination;
  
  CoinChangeResult(this.minCoins, this.coinCombination);
  
  @override
  String toString() {
    if (minCoins == -1) return 'No solution possible';
    return 'Minimum coins: $minCoins\n'
           'Coins used: $coinCombination';
  }
}

CoinChangeResult minCoinsTabulated(List<int> coins, int amount) {
  List<int> dp = List.filled(amount + 1, amount + 1);
  List<int> coinUsed = List.filled(amount + 1, -1);
  dp[0] = 0;
  
  for (int i = 1; i <= amount; i++) {
    for (int coin in coins) {
      if (coin <= i && dp[i - coin] + 1 < dp[i]) {
        dp[i] = dp[i - coin] + 1;
        coinUsed[i] = coin;
      }
    }
  }
  
  // Reconstruct coin combination
  List<int> combination = [];
  if (dp[amount] <= amount) {
    int curr = amount;
    while (curr > 0) {
      int coin = coinUsed[curr];
      combination.add(coin);
      curr -= coin;
    }
  }
  
  int result = dp[amount] > amount ? -1 : dp[amount];
  return CoinChangeResult(result, combination);
}

// Count Ways to make change
int countWaysRecursive(List<int> coins, int amount, int index) {
  if (amount == 0) return 1;
  if (amount < 0 || index >= coins.length) return 0;
  
  // Include current coin + Exclude current coin
  return countWaysRecursive(coins, amount - coins[index], index) +
         countWaysRecursive(coins, amount, index + 1);
}

// Count Ways with tabulation
int countWaysTabulated(List<int> coins, int amount) {
  List<int> dp = List.filled(amount + 1, 0);
  dp[0] = 1;
  
  for (int coin in coins) {
    for (int i = coin; i <= amount; i++) {
      dp[i] += dp[i - coin];
    }
  }
  
  return dp[amount];
}

// Example usage
void coinChangeExample() {
  List<int> coins = [1, 3, 4];
  int amount = 6;
  
  print('Coin Change Problem:');
  print('Coins: $coins');
  print('Amount: $amount');
  
  print('\n=== MINIMUM COINS ===');
  
  // Memoized approach
  coinMemo.clear();
  int memoResult = minCoinsRecursive(coins, amount);
  print('Memoized minimum coins: $memoResult');
  
  // Tabulated approach
  CoinChangeResult result = minCoinsTabulated(coins, amount);
  print('Tabulated result:');
  print(result);
  
  print('\n=== COUNT WAYS ===');
  
  int waysRecursive = countWaysRecursive(coins, amount, 0);
  print('Recursive count ways: $waysRecursive');
  
  int waysTabulated = countWaysTabulated(coins, amount);
  print('Tabulated count ways: $waysTabulated');
  
  print('\nDP Strategy:');
  print('• Min coins: dp[i] = min(dp[i], dp[i-coin] + 1)');
  print('• Count ways: dp[i] += dp[i-coin]');
  print('• Time: O(amount × coins), Space: O(amount)');
}
```

---

## 6. Longest Increasing Subsequence (LIS)

Find the length of longest increasing subsequence.

**Problem**: Given array, find length of longest strictly increasing subsequence.

**Subproblems**: For each element, find LIS ending at that element.

```dart
// LIS using DP (O(n²) approach)
class LISResult {
  int length;
  List<int> subsequence;
  List<int> lengths;
  
  LISResult(this.length, this.subsequence, this.lengths);
  
  @override
  String toString() {
    return 'LIS Length: $length\n'
           'LIS: $subsequence\n'
           'Lengths at each position: $lengths';
  }
}

LISResult lisDP(List<int> arr) {
  if (arr.isEmpty) return LISResult(0, [], []);
  
  int n = arr.length;
  List<int> dp = List.filled(n, 1);
  List<int> parent = List.filled(n, -1);
  
  // Fill DP array
  for (int i = 1; i < n; i++) {
    for (int j = 0; j < i; j++) {
      if (arr[j] < arr[i] && dp[j] + 1 > dp[i]) {
        dp[i] = dp[j] + 1;
        parent[i] = j;
      }
    }
  }
  
  // Find maximum length and its index
  int maxLength = dp[0];
  int maxIndex = 0;
  for (int i = 1; i < n; i++) {
    if (dp[i] > maxLength) {
      maxLength = dp[i];
      maxIndex = i;
    }
  }
  
  // Reconstruct LIS
  List<int> lis = [];
  int current = maxIndex;
  while (current != -1) {
    lis.add(arr[current]);
    current = parent[current];
  }
  
  return LISResult(maxLength, lis.reversed.toList(), dp);
}

// LIS using Binary Search (O(n log n) approach)
int lisBinarySearch(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  List<int> tails = []; // tails[i] = smallest tail of increasing subsequence of length i+1
  
  for (int num in arr) {
    int left = 0, right = tails.length;
    
    // Binary search for position to insert/replace
    while (left < right) {
      int mid = (left + right) ~/ 2;
      if (tails[mid] < num) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    
    if (left == tails.length) {
      tails.add(num);
    } else {
      tails[left] = num;
    }
  }
  
  return tails.length;
}

// Count LIS
int countLIS(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  int n = arr.length;
  List<int> lengths = List.filled(n, 1);
  List<int> counts = List.filled(n, 1);
  
  for (int i = 1; i < n; i++) {
    for (int j = 0; j < i; j++) {
      if (arr[j] < arr[i]) {
        if (lengths[j] + 1 > lengths[i]) {
          lengths[i] = lengths[j] + 1;
          counts[i] = counts[j];
        } else if (lengths[j] + 1 == lengths[i]) {
          counts[i] += counts[j];
        }
      }
    }
  }
  
  int maxLength = lengths.reduce((a, b) => a > b ? a : b);
  int totalCount = 0;
  
  for (int i = 0; i < n; i++) {
    if (lengths[i] == maxLength) {
      totalCount += counts[i];
    }
  }
  
  return totalCount;
}

// Example usage
void lisExample() {
  List<int> arr = [10, 9, 2, 5, 3, 7, 101, 18];
  
  print('Longest Increasing Subsequence:');
  print('Array: $arr');
  
  // DP approach (O(n²))
  LISResult result = lisDP(arr);
  print('\nDP approach (O(n²)):');
  print(result);
  
  // Binary search approach (O(n log n))
  int binarySearchResult = lisBinarySearch(arr);
  print('\nBinary search approach (O(n log n)):');
  print('LIS Length: $binarySearchResult');
  
  // Count LIS
  int countResult = countLIS(arr);
  print('\nCount of LIS: $countResult');
  
  print('\nDP Strategy:');
  print('• dp[i] = length of LIS ending at index i');
  print('• dp[i] = max(dp[j] + 1) for all j < i where arr[j] < arr[i]');
  print('• Time: O(n²) DP, O(n log n) with binary search');
}
```

---

## 7. Matrix Chain Multiplication

Find optimal order to multiply chain of matrices.

**Problem**: Given chain of matrices, find minimum scalar multiplications needed.

**Subproblems**: Optimal way to multiply matrices from i to j.

```dart
// Matrix Chain Multiplication with memoization
Map<String, int> mcmMemo = {};

int matrixChainRecursive(List<int> dimensions, int i, int j) {
  if (i >= j) return 0;
  
  String key = '${i}_$j';
  if (mcmMemo.containsKey(key)) {
    return mcmMemo[key]!;
  }
  
  int minCost = double.maxFinite.toInt();
  
  for (int k = i; k < j; k++) {
    int cost = matrixChainRecursive(dimensions, i, k) +
               matrixChainRecursive(dimensions, k + 1, j) +
               dimensions[i - 1] * dimensions[k] * dimensions[j];
    
    minCost = minCost < cost ? minCost : cost;
  }
  
  mcmMemo[key] = minCost;
  return minCost;
}

// Matrix Chain Multiplication with tabulation
class MCMResult {
  int minCost;
  String optimalParentheses;
  List<List<int>> dpTable;
  List<List<int>> splitPoints;
  
  MCMResult(this.minCost, this.optimalParentheses, this.dpTable, this.splitPoints);
  
  @override
  String toString() {
    return 'Minimum scalar multiplications: $minCost\n'
           'Optimal parentheses: $optimalParentheses';
  }
}

MCMResult matrixChainTabulated(List<int> dimensions) {
  int n = dimensions.length - 1; // Number of matrices
  
  List<List<int>> dp = List.generate(n + 1, (_) => List.filled(n + 1, 0));
  List<List<int>> split = List.generate(n + 1, (_) => List.filled(n + 1, 0));
  
  // l is chain length
  for (int l = 2; l <= n; l++) {
    for (int i = 1; i <= n - l + 1; i++) {
      int j = i + l - 1;
      dp[i][j] = double.maxFinite.toInt();
      
      for (int k = i; k < j; k++) {
        int cost = dp[i][k] + dp[k + 1][j] + 
                   dimensions[i - 1] * dimensions[k] * dimensions[j];
        
        if (cost < dp[i][j]) {
          dp[i][j] = cost;
          split[i][j] = k;
        }
      }
    }
  }
  
  String parentheses = _getOptimalParentheses(split, 1, n);
  
  return MCMResult(dp[1][n], parentheses, dp, split);
}

// Helper function to get optimal parentheses
String _getOptimalParentheses(List<List<int>> split, int i, int j) {
  if (i == j) {
    return 'M$i';
  } else {
    int k = split[i][j];
    return '(${_getOptimalParentheses(split, i, k)} × ${_getOptimalParentheses(split, k + 1, j)})';
  }
}

// Example usage
void matrixChainExample() {
  // Matrices: A1(40×20), A2(20×30), A3(30×10), A4(10×30)
  List<int> dimensions = [40, 20, 30, 10, 30];
  
  print('Matrix Chain Multiplication:');
  print('Matrix dimensions: $dimensions');
  print('Matrices:');
  for (int i = 0; i < dimensions.length - 1; i++) {
    print('  A${i + 1}: ${dimensions[i]} × ${dimensions[i + 1]}');
  }
  
  // Memoized approach
  mcmMemo.clear();
  int memoResult = matrixChainRecursive(dimensions, 1, dimensions.length - 1);
  print('\nMemoized minimum cost: $memoResult');
  
  // Tabulated approach
  MCMResult result = matrixChainTabulated(dimensions);
  print('\nTabulated result:');
  print(result);
  
  print('\nDP Strategy:');
  print('• dp[i][j] = minimum cost to multiply matrices from i to j');
  print('• dp[i][j] = min(dp[i][k] + dp[k+1][j] + cost of multiplying two chains)');
  print('• Time: O(n³), Space: O(n²)');
}
```

---

## 8. Palindrome Partitioning

Find minimum cuts needed to partition string into palindromes.

**Problem**: Given string, find minimum cuts to make all substrings palindromes.

**Subproblems**: Minimum cuts for substring and palindrome checking.

```dart
// Palindrome Partitioning with memoization
Map<String, int> palindromeMemo = {};
Map<String, bool> isPalindromeMemo = {};

bool isPalindrome(String s, int start, int end) {
  String key = '${start}_$end';
  if (isPalindromeMemo.containsKey(key)) {
    return isPalindromeMemo[key]!;
  }
  
  bool result = true;
  while (start < end) {
    if (s[start] != s[end]) {
      result = false;
      break;
    }
    start++;
    end--;
  }
  
  isPalindromeMemo[key] = result;
  return result;
}

int minCutsRecursive(String s, int start) {
  if (start >= s.length) return 0;
  
  String key = start.toString();
  if (palindromeMemo.containsKey(key)) {
    return palindromeMemo[key]!;
  }
  
  int minCuts = double.maxFinite.toInt();
  
  for (int end = start; end < s.length; end++) {
    if (isPalindrome(s, start, end)) {
      int cuts = (end == s.length - 1) ? 0 : 1 + minCutsRecursive(s, end + 1);
      minCuts = minCuts < cuts ? minCuts : cuts;
    }
  }
  
  palindromeMemo[key] = minCuts;
  return minCuts;
}

// Palindrome Partitioning with tabulation
class PalindromePartitionResult {
  int minCuts;
  List<String> partitions;
  List<List<bool>> isPalindromeTable;
  
  PalindromePartitionResult(this.minCuts, this.partitions, this.isPalindromeTable);
  
  @override
  String toString() {
    return 'Minimum cuts: $minCuts\n'
           'Partitions: ${partitions.join(" | ")}';
  }
}

PalindromePartitionResult palindromePartitionTabulated(String s) {
  int n = s.length;
  
  // Build palindrome table
  List<List<bool>> isPalindromeTable = List.generate(n, (_) => List.filled(n, false));
  
  // Single characters are palindromes
  for (int i = 0; i < n; i++) {
    isPalindromeTable[i][i] = true;
  }
  
  // Check for 2-character palindromes
  for (int i = 0; i < n - 1; i++) {
    isPalindromeTable[i][i + 1] = (s[i] == s[i + 1]);
  }
  
  // Check for palindromes of length 3 and more
  for (int len = 3; len <= n; len++) {
    for (int i = 0; i <= n - len; i++) {
      int j = i + len - 1;
      isPalindromeTable[i][j] = (s[i] == s[j]) && isPalindromeTable[i + 1][j - 1];
    }
  }
  
  // DP for minimum cuts
  List<int> cuts = List.filled(n, 0);
  List<int> partition = List.filled(n, -1);
  
  for (int i = 0; i < n; i++) {
    if (isPalindromeTable[0][i]) {
      cuts[i] = 0;
    } else {
      cuts[i] = double.maxFinite.toInt();
      for (int j = 0; j < i; j++) {
        if (isPalindromeTable[j + 1][i] && cuts[j] + 1 < cuts[i]) {
          cuts[i] = cuts[j] + 1;
          partition[i] = j;
        }
      }
    }
  }
  
  // Reconstruct partitions
  List<String> partitions = _reconstructPartitions(s, partition, n - 1);
  
  return PalindromePartitionResult(cuts[n - 1], partitions, isPalindromeTable);
}

// Helper function to reconstruct partitions
List<String> _reconstructPartitions(String s, List<int> partition, int index) {
  List<String> result = [];
  
  while (index >= 0) {
    int prevIndex = partition[index];
    String palindrome = s.substring(prevIndex + 1, index + 1);
    result.add(palindrome);
    index = prevIndex;
  }
  
  return result.reversed.toList();
}

// Example usage
void palindromePartitionExample() {
  String s = "AABCCBAA";
  
  print('Palindrome Partitioning:');
  print('String: "$s"');
  
  // Memoized approach
  palindromeMemo.clear();
  isPalindromeMemo.clear();
  int memoResult = minCutsRecursive(s, 0);
  print('\nMemoized minimum cuts: $memoResult');
  
  // Tabulated approach
  PalindromePartitionResult result = palindromePartitionTabulated(s);
  print('\nTabulated result:');
  print(result);
  
  print('\nDP Strategy:');
  print('• Precompute palindrome table for all substrings');
  print('• cuts[i] = minimum cuts needed for s[0...i]');
  print('• cuts[i] = min(cuts[j] + 1) for all j where s[j+1...i] is palindrome');
  print('• Time: O(n³) or O(n²), Space: O(n²)');
}
```

---

## 9. Maximum Sum Subarray (Kadane's Algorithm)

Find contiguous subarray with maximum sum.

**Problem**: Given array, find contiguous subarray with largest sum.

**DP Approach**: At each position, decide to extend or start new subarray.

```dart
// Maximum Sum Subarray with positions
class MaxSubarrayResult {
  int maxSum;
  int startIndex;
  int endIndex;
  List<int> subarray;
  
  MaxSubarrayResult(this.maxSum, this.startIndex, this.endIndex, this.subarray);
  
  @override
  String toString() {
    return 'Maximum sum: $maxSum\n'
           'Subarray: $subarray\n'
           'Indices: [$startIndex, $endIndex]';
  }
}

MaxSubarrayResult maxSubarrayKadane(List<int> arr) {
  if (arr.isEmpty) return MaxSubarrayResult(0, -1, -1, []);
  
  int maxSoFar = arr[0];
  int maxEndingHere = arr[0];
  int start = 0, end = 0, tempStart = 0;
  
  for (int i = 1; i < arr.length; i++) {
    if (maxEndingHere < 0) {
      maxEndingHere = arr[i];
      tempStart = i;
    } else {
      maxEndingHere += arr[i];
    }
    
    if (maxEndingHere > maxSoFar) {
      maxSoFar = maxEndingHere;
      start = tempStart;
      end = i;
    }
  }
  
  List<int> subarray = arr.sublist(start, end + 1);
  return MaxSubarrayResult(maxSoFar, start, end, subarray);
}

// Maximum Sum Subarray with DP table
List<int> maxSubarrayDP(List<int> arr) {
  if (arr.isEmpty) return [];
  
  List<int> dp = List.filled(arr.length, 0);
  dp[0] = arr[0];
  
  for (int i = 1; i < arr.length; i++) {
    dp[i] = arr[i] > dp[i - 1] + arr[i] ? arr[i] : dp[i - 1] + arr[i];
  }
  
  return dp;
}

// 2D Maximum Sum Subarray (Rectangle)
int maxSumRectangle(List<List<int>> matrix) {
  if (matrix.isEmpty || matrix[0].isEmpty) return 0;
  
  int rows = matrix.length;
  int cols = matrix[0].length;
  int maxSum = double.negativeInfinity.toInt();
  
  for (int top = 0; top < rows; top++) {
    List<int> temp = List.filled(cols, 0);
    
    for (int bottom = top; bottom < rows; bottom++) {
      // Add current row to temp array
      for (int i = 0; i < cols; i++) {
        temp[i] += matrix[bottom][i];
      }
      
      // Find maximum sum subarray in temp array
      MaxSubarrayResult result = maxSubarrayKadane(temp);
      maxSum = maxSum > result.maxSum ? maxSum : result.maxSum;
    }
  }
  
  return maxSum;
}

// Example usage
void maxSubarrayExample() {
  List<int> arr = [-2, -3, 4, -1, -2, 1, 5, -3];
  
  print('Maximum Sum Subarray (Kadane\'s Algorithm):');
  print('Array: $arr');
  
  MaxSubarrayResult result = maxSubarrayKadane(arr);
  print('\nResult:');
  print(result);
  
  List<int> dpTable = maxSubarrayDP(arr);
  print('\nDP table: $dpTable');
  
  print('\n2D Maximum Sum Rectangle:');
  List<List<int>> matrix = [
    [1, 2, -1, -4, -20],
    [-8, -3, 4, 2, 1],
    [3, 8, 10, 1, 3],
    [-4, -1, 1, 7, -6]
  ];
  
  print('Matrix:');
  for (var row in matrix) {
    print(row);
  }
  
  int maxRectSum = maxSumRectangle(matrix);
  print('\nMaximum sum rectangle: $maxRectSum');
  
  print('\nDP Strategy:');
  print('• dp[i] = maximum sum ending at index i');
  print('• dp[i] = max(arr[i], dp[i-1] + arr[i])');
  print('• Time: O(n), Space: O(1) optimized');
}
```

---

## 10. Dynamic Programming Patterns and Analysis

```dart
// DP Pattern Analysis
class DPPatterns {
  static void analyzePatterns() {
    print('=== DYNAMIC PROGRAMMING PATTERNS ===\n');
    
    Map<String, Map<String, String>> patterns = {
      'Linear DP': {
        'Description': 'State depends on previous states in sequence',
        'Examples': 'Fibonacci, Climbing Stairs, House Robber',
        'Time': 'O(n)',
        'Space': 'O(n) or O(1) optimized'
      },
      'Grid DP': {
        'Description': 'State depends on adjacent cells in 2D grid',
        'Examples': 'Unique Paths, Min Path Sum, Edit Distance',
        'Time': 'O(m×n)',
        'Space': 'O(m×n) or O(min(m,n)) optimized'
      },
      'Interval DP': {
        'Description': 'State represents optimal solution for interval [i,j]',
        'Examples': 'Matrix Chain Multiplication, Palindrome Partitioning',
        'Time': 'O(n³)',
        'Space': 'O(n²)'
      },
      'Knapsack DP': {
        'Description': 'State represents capacity and items considered',
        'Examples': '0/1 Knapsack, Coin Change, Subset Sum',
        'Time': 'O(n×W)',
        'Space': 'O(n×W) or O(W) optimized'
      },
      'String DP': {
        'Description': 'State compares positions in strings',
        'Examples': 'LCS, Edit Distance, String Matching',
        'Time': 'O(m×n)',
        'Space': 'O(m×n) or O(min(m,n)) optimized'
      },
      'Tree DP': {
        'Description': 'State represents subtree solutions',
        'Examples': 'House Robber III, Binary Tree Diameter',
        'Time': 'O(n)',
        'Space': 'O(h) where h is height'
      }
    };
    
    patterns.forEach((pattern, details) {
      print('$pattern:');
      details.forEach((key, value) {
        print('  $key: $value');
      });
      print('');
    });
  }
  
  static void optimizationTechniques() {
    print('=== DP OPTIMIZATION TECHNIQUES ===\n');
    
    print('1. Space Optimization:');
    print('   • Rolling Array: Use only last few states');
    print('   • 1D Array: Reduce 2D to 1D when possible');
    print('   • Variables: Use variables instead of arrays');
    print('');
    
    print('2. Time Optimization:');
    print('   • Memoization: Cache recursive results');
    print('   • Bottom-up: Avoid recursion overhead');
    print('   • Early Termination: Stop when answer found');
    print('');
    
    print('3. Implementation Tips:');
    print('   • Clear State Definition: What does dp[i] represent?');
    print('   • Base Cases: Handle boundary conditions');
    print('   • Transition: How to compute dp[i] from previous states?');
    print('   • Answer: Where is the final answer stored?');
  }
  
  static void complexityAnalysis() {
    print('\n=== COMPLEXITY ANALYSIS ===\n');
    
    Map<String, Map<String, String>> problems = {
      'Fibonacci': {'Time': 'O(n)', 'Space': 'O(1)', 'Pattern': 'Linear'},
      '0/1 Knapsack': {'Time': 'O(n×W)', 'Space': 'O(W)', 'Pattern': 'Knapsack'},
      'LCS': {'Time': 'O(m×n)', 'Space': 'O(min(m,n))', 'Pattern': 'String'},
      'Edit Distance': {'Time': 'O(m×n)', 'Space': 'O(min(m,n))', 'Pattern': 'String'},
      'Coin Change': {'Time': 'O(n×amount)', 'Space': 'O(amount)', 'Pattern': 'Knapsack'},
      'LIS': {'Time': 'O(n²) or O(n log n)', 'Space': 'O(n)', 'Pattern': 'Linear'},
      'Matrix Chain': {'Time': 'O(n³)', 'Space': 'O(n²)', 'Pattern': 'Interval'},
      'Palindrome Partition': {'Time': 'O(n³)', 'Space': 'O(n²)', 'Pattern': 'Interval'},
    };
    
    problems.forEach((problem, complexity) {
      print('$problem:');
      complexity.forEach((metric, value) {
        print('  $metric: $value');
      });
      print('');
    });
  }
}

// Performance Testing Framework
class DPPerformanceTester {
  static void testFibonacci() {
    print('=== FIBONACCI PERFORMANCE TEST ===\n');
    
    List<int> inputs = [30, 35, 40];
    
    for (int n in inputs) {
      print('Fibonacci($n):');
      
      // Memoized
      fibMemo.clear();
      Stopwatch sw = Stopwatch()..start();
      int memoResult = fibonacciMemoized(n);
      sw.stop();
      print('  Memoized: $memoResult (${sw.elapsedMicroseconds} μs)');
      
      // Tabulated
      sw.reset();
      sw.start();
      int tabulatedResult = fibonacciTabulated(n);
      sw.stop();
      print('  Tabulated: $tabulatedResult (${sw.elapsedMicroseconds} μs)');
      
      // Optimized
      sw.reset();
      sw.start();
      int optimizedResult = fibonacciOptimized(n);
      sw.stop();
      print('  Optimized: $optimizedResult (${sw.elapsedMicroseconds} μs)');
      
      print('');
    }
  }
  
  static void testKnapsack() {
    print('=== KNAPSACK PERFORMANCE TEST ===\n');
    
    List<KnapsackItem> items = List.generate(20, (i) => 
      KnapsackItem('Item$i', i + 1, (i + 1) * 2));
    
    List<int> capacities = [10, 20, 30];
    
    for (int capacity in capacities) {
      print('Knapsack capacity: $capacity');
      
      // Memoized
      knapsackMemo.clear();
      Stopwatch sw = Stopwatch()..start();
      int memoResult = knapsack01Memoized(items, capacity, 0);
      sw.stop();
      print('  Memoized: $memoResult (${sw.elapsedMicroseconds} μs)');
      
      // Tabulated
      sw.reset();
      sw.start();
      KnapsackResult tabulatedResult = knapsack01Tabulated(items, capacity);
      sw.stop();
      print('  Tabulated: ${tabulatedResult.maxValue} (${sw.elapsedMicroseconds} μs)');
      
      print('');
    }
  }
}
```

---

## Main Function - Running All Examples

```dart
void main() {
  print('=== DYNAMIC PROGRAMMING IN DART ===\n');
  
  print('1. Fibonacci Sequence:');
  fibonacciExample();
  
  print('\n' + '='*60 + '\n');
  print('2. 0/1 Knapsack Problem:');
  knapsackExample();
  
  print('\n' + '='*60 + '\n');
  print('3. Longest Common Subsequence:');
  lcsExample();
  
  print('\n' + '='*60 + '\n');
  print('4. Edit Distance:');
  editDistanceExample();
  
  print('\n' + '='*60 + '\n');
  print('5. Coin Change Problem:');
  coinChangeExample();
  
  print('\n' + '='*60 + '\n');
  print('6. Longest Increasing Subsequence:');
  lisExample();
  
  print('\n' + '='*60 + '\n');
  print('7. Matrix Chain Multiplication:');
  matrixChainExample();
  
  print('\n' + '='*60 + '\n');
  print('8. Palindrome Partitioning:');
  palindromePartitionExample();
  
  print('\n' + '='*60 + '\n');
  print('9. Maximum Sum Subarray:');
  maxSubarrayExample();
  
  print('\n' + '='*60 + '\n');
  print('10. DP Patterns Analysis:');
  DPPatterns.analyzePatterns();
  DPPatterns.optimizationTechniques();
  DPPatterns.complexityAnalysis();
  
  print('\n' + '='*60 + '\n');
  print('11. Performance Testing:');
  DPPerformanceTester.testFibonacci();
  DPPerformanceTester.testKnapsack();
}
```

---

## Key Principles of Dynamic Programming

### 1. **Problem Characteristics**
- **Optimal Substructure**: Optimal solution contains optimal solutions to subproblems
- **Overlapping Subproblems**: Same subproblems are solved multiple times
- **No Aftereffect**: Future decisions don't affect past decisions

### 2. **Design Steps**
1. **Define State**: What does dp[i] represent?
2. **State Transition**: How to compute dp[i] from previous states?
3. **Base Cases**: Handle boundary conditions
4. **Order**: In what order to fill the DP table?
5. **Answer**: Where is the final answer?

### 3. **Implementation Approaches**
- **Top-Down (Memoization)**: Recursive with caching
- **Bottom-Up (Tabulation)**: Iterative table filling
- **Space Optimization**: Reduce space complexity

### 4. **Optimization Techniques**
- **Rolling Array**: Use only necessary previous states
- **Dimension Reduction**: Convert 2D to 1D when possible
- **Early Termination**: Stop when answer is found

### 5. **Common Patterns**
- **Linear DP**: Fibonacci, Climbing Stairs
- **Grid DP**: Unique Paths, Min Path Sum
- **Interval DP**: Matrix Chain, Palindrome Partitioning
- **Knapsack DP**: 0/1 Knapsack, Coin Change
- **String DP**: LCS, Edit Distance

This comprehensive guide demonstrates the power of dynamic programming in solving optimization problems efficiently by avoiding redundant calculations and building solutions incrementally!