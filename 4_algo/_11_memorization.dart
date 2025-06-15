/*
 * MEMOIZATION IN DYNAMIC PROGRAMMING - DART
 * 
 * Memoization is an optimization technique used in dynamic programming where
 * we store the results of expensive function calls and return the cached
 * result when the same inputs occur again.
 * 
 * Key Concepts:
 * - Top-down approach to dynamic programming
 * - Cache results to avoid redundant calculations
 * - Trade space for time complexity
 * - Recursive solution with memory
 * 
 * Benefits:
 * - Reduces time complexity significantly
 * - Easy to implement from recursive solutions
 * - Natural way to think about problems
 */

void main() {
  print("=== MEMOIZATION IN DYNAMIC PROGRAMMING ===\n");
  
  // Demonstrate different problems with memoization
  fibonacciDemo();
  print("\n" + "="*60 + "\n");
  
  coinChangeDemo();
  print("\n" + "="*60 + "\n");
  
  longestIncreasingSubsequenceDemo();
  print("\n" + "="*60 + "\n");
  
  editDistanceDemo();
  print("\n" + "="*60 + "\n");
  
  performanceComparison();
}

/**
 * FIBONACCI SEQUENCE - Classic Memoization Example
 * Shows the dramatic difference between naive recursion and memoization
 */

// Naive recursive approach - exponential time complexity
int fibonacciNaive(int n) {
  if (n <= 1) return n;
  return fibonacciNaive(n - 1) + fibonacciNaive(n - 2);
}

// Memoized version - linear time complexity
Map<int, int> fibMemo = {};

int fibonacciMemoized(int n) {
  // Base cases
  if (n <= 1) return n;
  
  // Check if result already computed
  if (fibMemo.containsKey(n)) {
    print("  Cache hit for fib($n) = ${fibMemo[n]}");
    return fibMemo[n]!;
  }
  
  // Compute and store result
  print("  Computing fib($n)...");
  fibMemo[n] = fibonacciMemoized(n - 1) + fibonacciMemoized(n - 2);
  
  return fibMemo[n]!;
}

// Class-based memoization for better encapsulation
class FibonacciCalculator {
  final Map<int, int> _cache = {};
  int _computationCount = 0;
  
  int calculate(int n) {
    _computationCount++;
    
    if (n <= 1) return n;
    
    if (_cache.containsKey(n)) {
      return _cache[n]!;
    }
    
    _cache[n] = calculate(n - 1) + calculate(n - 2);
    return _cache[n]!;
  }
  
  void printStats() {
    print("Cache size: ${_cache.length}");
    print("Total function calls: $_computationCount");
    print("Cache contents: $_cache");
  }
  
  void clearCache() {
    _cache.clear();
    _computationCount = 0;
  }
}

void fibonacciDemo() {
  print("--- FIBONACCI SEQUENCE MEMOIZATION ---");
  
  int n = 10;
  
  // Demonstrate naive vs memoized
  print("Calculating Fibonacci($n):");
  
  print("\n1. Naive Recursive Approach:");
  Stopwatch sw1 = Stopwatch()..start();
  int result1 = fibonacciNaive(n);
  sw1.stop();
  print("Result: $result1");
  print("Time: ${sw1.elapsedMicroseconds} microseconds");
  
  print("\n2. Memoized Approach:");
  fibMemo.clear();
  Stopwatch sw2 = Stopwatch()..start();
  int result2 = fibonacciMemoized(n);
  sw2.stop();
  print("Result: $result2");
  print("Time: ${sw2.elapsedMicroseconds} microseconds");
  print("Cache: $fibMemo");
  
  print("\n3. Class-based Memoization:");
  FibonacciCalculator calc = FibonacciCalculator();
  Stopwatch sw3 = Stopwatch()..start();
  int result3 = calc.calculate(n);
  sw3.stop();
  print("Result: $result3");
  print("Time: ${sw3.elapsedMicroseconds} microseconds");
  calc.printStats();
  
  // Show second calculation is faster
  print("\nSecond calculation (should be faster):");
  sw3.reset();
  sw3.start();
  int result4 = calc.calculate(n);
  sw3.stop();
  print("Result: $result4");
  print("Time: ${sw3.elapsedMicroseconds} microseconds");
}

/**
 * COIN CHANGE PROBLEM - Memoization Example
 * Find minimum number of coins needed to make a given amount
 */

class CoinChange {
  final List<int> _coins;
  final Map<int, int> _memo = {};
  
  CoinChange(this._coins);
  
  int minCoins(int amount) {
    // Base cases
    if (amount == 0) return 0;
    if (amount < 0) return -1;
    
    // Check memo
    if (_memo.containsKey(amount)) {
      return _memo[amount]!;
    }
    
    int minCoinsNeeded = double.maxFinite.toInt();
    
    // Try each coin
    for (int coin in _coins) {
      int subResult = minCoins(amount - coin);
      if (subResult != -1) {
        minCoinsNeeded = minCoinsNeeded < (subResult + 1) 
            ? minCoinsNeeded 
            : (subResult + 1);
      }
    }
    
    // Store result
    _memo[amount] = minCoinsNeeded == double.maxFinite.toInt() ? -1 : minCoinsNeeded;
    return _memo[amount]!;
  }
  
  // Get the actual coins used
  List<int> getCoinCombination(int amount) {
    if (minCoins(amount) == -1) return [];
    
    List<int> result = [];
    int remaining = amount;
    
    while (remaining > 0) {
      for (int coin in _coins) {
        if (remaining >= coin) {
          int withoutCoin = remaining - coin;
          if (_memo.containsKey(withoutCoin) && 
              _memo[withoutCoin]! + 1 == _memo[remaining]!) {
            result.add(coin);
            remaining = withoutCoin;
            break;
          }
        }
      }
    }
    
    return result;
  }
  
  void printMemo() {
    print("Memoization cache: $_memo");
  }
  
  void clearMemo() {
    _memo.clear();
  }
}

void coinChangeDemo() {
  print("--- COIN CHANGE PROBLEM MEMOIZATION ---");
  
  List<int> coins = [1, 3, 4];
  int amount = 6;
  
  print("Coins available: $coins");
  print("Target amount: $amount");
  
  CoinChange coinChanger = CoinChange(coins);
  
  print("\nCalculating minimum coins needed...");
  int result = coinChanger.minCoins(amount);
  
  if (result != -1) {
    print("Minimum coins needed: $result");
    List<int> combination = coinChanger.getCoinCombination(amount);
    print("Coin combination: $combination");
    print("Verification: ${combination.fold(0, (sum, coin) => sum + coin)} = $amount");
  } else {
    print("Cannot make amount $amount with given coins");
  }
  
  coinChanger.printMemo();
  
  // Test multiple amounts
  print("\nTesting multiple amounts:");
  for (int testAmount in [1, 2, 3, 4, 5, 6, 7, 8]) {
    coinChanger.clearMemo();
    int coins = coinChanger.minCoins(testAmount);
    List<int> combination = coinChanger.getCoinCombination(testAmount);
    print("Amount $testAmount: $coins coins -> $combination");
  }
}

/**
 * LONGEST INCREASING SUBSEQUENCE - Memoization
 * Find the length of the longest increasing subsequence
 */

class LongestIncreasingSubsequence {
  final List<int> _nums;
  final Map<String, int> _memo = {};
  
  LongestIncreasingSubsequence(this._nums);
  
  int lengthOfLIS() {
    if (_nums.isEmpty) return 0;
    
    int maxLength = 0;
    for (int i = 0; i < _nums.length; i++) {
      int length = _lisFromIndex(i, -1);
      maxLength = maxLength > length ? maxLength : length;
    }
    
    return maxLength;
  }
  
  int _lisFromIndex(int index, int prevIndex) {
    if (index >= _nums.length) return 0;
    
    String key = "$index,$prevIndex";
    if (_memo.containsKey(key)) {
      return _memo[key]!;
    }
    
    // Option 1: Skip current element
    int exclude = _lisFromIndex(index + 1, prevIndex);
    
    // Option 2: Include current element (if valid)
    int include = 0;
    if (prevIndex == -1 || _nums[index] > _nums[prevIndex]) {
      include = 1 + _lisFromIndex(index + 1, index);
    }
    
    _memo[key] = include > exclude ? include : exclude;
    return _memo[key]!;
  }
  
  List<int> getActualLIS() {
    // Reconstruct the actual subsequence
    List<int> result = [];
    int maxLength = lengthOfLIS();
    
    // Find the subsequence by backtracking
    _reconstructLIS(0, -1, maxLength, result);
    
    return result;
  }
  
  bool _reconstructLIS(int index, int prevIndex, int targetLength, List<int> result) {
    if (targetLength == 0) return true;
    if (index >= _nums.length) return false;
    
    // Try including current element
    if (prevIndex == -1 || _nums[index] > _nums[prevIndex]) {
      String key = "${index + 1},$index";
      if (_memo.containsKey(key) && _memo[key]! == targetLength - 1) {
        result.add(_nums[index]);
        return _reconstructLIS(index + 1, index, targetLength - 1, result);
      }
    }
    
    // Try excluding current element
    String skipKey = "${index + 1},$prevIndex";
    if (_memo.containsKey(skipKey) && _memo[skipKey]! == targetLength) {
      return _reconstructLIS(index + 1, prevIndex, targetLength, result);
    }
    
    return false;
  }
  
  void printMemo() {
    print("Memoization cache:");
    _memo.forEach((key, value) {
      print("  $key -> $value");
    });
  }
}

void longestIncreasingSubsequenceDemo() {
  print("--- LONGEST INCREASING SUBSEQUENCE MEMOIZATION ---");
  
  List<int> nums = [10, 9, 2, 5, 3, 7, 101, 18];
  print("Array: $nums");
  
  LongestIncreasingSubsequence lis = LongestIncreasingSubsequence(nums);
  
  print("\nCalculating LIS...");
  int length = lis.lengthOfLIS();
  List<int> sequence = lis.getActualLIS();
  
  print("Length of LIS: $length");
  print("Actual LIS: $sequence");
  
  // Verify the subsequence
  print("\nVerification:");
  print("Is increasing? ${_isIncreasing(sequence)}");
  print("Is subsequence? ${_isSubsequence(sequence, nums)}");
  
  lis.printMemo();
}

bool _isIncreasing(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] <= arr[i-1]) return false;
  }
  return true;
}

bool _isSubsequence(List<int> subseq, List<int> original) {
  int i = 0, j = 0;
  while (i < subseq.length && j < original.length) {
    if (subseq[i] == original[j]) {
      i++;
    }
    j++;
  }
  return i == subseq.length;
}

/**
 * EDIT DISTANCE (LEVENSHTEIN DISTANCE) - Memoization
 * Find minimum operations to transform one string into another
 */

class EditDistance {
  final String _str1;
  final String _str2;
  final Map<String, int> _memo = {};
  
  EditDistance(this._str1, this._str2);
  
  int minDistance() {
    return _editDistance(_str1.length, _str2.length);
  }
  
  int _editDistance(int i, int j) {
    // Base cases
    if (i == 0) return j;  // Insert all characters of str2
    if (j == 0) return i;  // Delete all characters of str1
    
    String key = "$i,$j";
    if (_memo.containsKey(key)) {
      return _memo[key]!;
    }
    
    int result;
    
    if (_str1[i-1] == _str2[j-1]) {
      // Characters match, no operation needed
      result = _editDistance(i-1, j-1);
    } else {
      // Try all three operations and take minimum
      int insert = _editDistance(i, j-1) + 1;      // Insert
      int delete = _editDistance(i-1, j) + 1;      // Delete
      int replace = _editDistance(i-1, j-1) + 1;   // Replace
      
      result = [insert, delete, replace].reduce((a, b) => a < b ? a : b);
    }
    
    _memo[key] = result;
    return result;
  }
  
  List<String> getOperations() {
    // Reconstruct the sequence of operations
    List<String> operations = [];
    _reconstructOperations(_str1.length, _str2.length, operations);
    return operations.reversed.toList();
  }
  
  void _reconstructOperations(int i, int j, List<String> operations) {
    if (i == 0) {
      for (int k = 0; k < j; k++) {
        operations.add("Insert '${_str2[k]}'");
      }
      return;
    }
    
    if (j == 0) {
      for (int k = 0; k < i; k++) {
        operations.add("Delete '${_str1[k]}'");
      }
      return;
    }
    
    if (_str1[i-1] == _str2[j-1]) {
      _reconstructOperations(i-1, j-1, operations);
    } else {
      String key1 = "${i-1},$j";
      String key2 = "$i,${j-1}";
      String key3 = "${i-1},${j-1}";
      
      int delete = _memo[key1] ?? double.maxFinite.toInt();
      int insert = _memo[key2] ?? double.maxFinite.toInt();
      int replace = _memo[key3] ?? double.maxFinite.toInt();
      
      if (delete <= insert && delete <= replace) {
        operations.add("Delete '${_str1[i-1]}'");
        _reconstructOperations(i-1, j, operations);
      } else if (insert <= replace) {
        operations.add("Insert '${_str2[j-1]}'");
        _reconstructOperations(i, j-1, operations);
      } else {
        operations.add("Replace '${_str1[i-1]}' with '${_str2[j-1]}'");
        _reconstructOperations(i-1, j-1, operations);
      }
    }
  }
  
  void printMemo() {
    print("Memoization cache size: ${_memo.length}");
  }
}

void editDistanceDemo() {
  print("--- EDIT DISTANCE MEMOIZATION ---");
  
  String str1 = "kitten";
  String str2 = "sitting";
  
  print("String 1: '$str1'");
  print("String 2: '$str2'");
  
  EditDistance editDist = EditDistance(str1, str2);
  
  print("\nCalculating minimum edit distance...");
  int distance = editDist.minDistance();
  List<String> operations = editDist.getOperations();
  
  print("Minimum edit distance: $distance");
  print("\nSequence of operations:");
  for (int i = 0; i < operations.length; i++) {
    print("${i+1}. ${operations[i]}");
  }
  
  editDist.printMemo();
}

/**
 * PERFORMANCE COMPARISON
 * Compare memoized vs non-memoized solutions
 */

void performanceComparison() {
  print("--- PERFORMANCE COMPARISON ---");
  
  List<int> fibNumbers = [20, 25, 30, 35];
  
  print("Fibonacci Performance Comparison:");
  print("N\tNaive (ms)\tMemoized (ms)\tSpeedup");
  print("-" * 50);
  
  for (int n in fibNumbers) {
    // Naive approach
    Stopwatch sw1 = Stopwatch()..start();
    fibonacciNaive(n);
    sw1.stop();
    
    // Memoized approach
    fibMemo.clear();
    Stopwatch sw2 = Stopwatch()..start();
    fibonacciMemoized(n);
    sw2.stop();
    
    double speedup = sw1.elapsedMicroseconds / sw2.elapsedMicroseconds;
    
    print("$n\t${sw1.elapsedMilliseconds}\t\t${sw2.elapsedMilliseconds}\t\t${speedup.toStringAsFixed(1)}x");
  }
  
  print("\nNote: Speedup increases dramatically with larger inputs!");
}

/**
 * MEMOIZATION BEST PRACTICES:
 * 
 * 1. WHEN TO USE MEMOIZATION:
 *    - Overlapping subproblems exist
 *    - Recursive solution is natural
 *    - Function is pure (same input = same output)
 *    - Time complexity improvement is significant
 * 
 * 2. IMPLEMENTATION STRATEGIES:
 *    - Use Map/Dictionary for caching
 *    - Choose appropriate key format
 *    - Consider memory constraints
 *    - Clear cache when needed
 * 
 * 3. TRADE-OFFS:
 *    - Time vs Space: Uses more memory for better performance
 *    - Setup overhead: Small problems might not benefit
 *    - Memory leaks: Long-running applications need cache management
 * 
 * 4. COMMON PATTERNS:
 *    - Top-down dynamic programming
 *    - Recursive optimization
 *    - Function result caching
 *    - Expensive computation avoidance
 * 
 * 5. ALTERNATIVES:
 *    - Bottom-up DP (tabulation)
 *    - Iterative solutions
 *    - Space-optimized DP
 *    - Lazy evaluation
 */