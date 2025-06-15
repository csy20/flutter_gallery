/*
 * SUBSET SUM PROBLEM USING BACKTRACKING IN DART
 * 
 * The Subset Sum problem is to determine if there exists a subset of the given
 * set of integers that adds up to a given target sum. This is a classic example
 * of backtracking where we explore all possible combinations.
 * 
 * Problem Statement:
 * Given a set of non-negative integers and a target sum, determine whether
 * there exists a subset of the given set with sum equal to given target sum.
 * 
 * Time Complexity: O(2^n) in worst case - exponential
 * Space Complexity: O(n) for recursion stack
 * 
 * Applications:
 * - Partition problems
 * - Resource allocation
 * - Cryptocurrency transactions
 * - Load balancing
 * - Budget planning
 */

void main() {
  print("=== SUBSET SUM PROBLEM USING BACKTRACKING ===\n");
  
  // Test cases
  print("--- Basic Examples ---");
  testSubsetSum([3, 34, 4, 12, 5, 2], 9, "Example 1");
  testSubsetSum([3, 34, 4, 12, 5, 2], 30, "Example 2");
  testSubsetSum([1, 2, 3, 4, 5], 10, "Example 3");
  testSubsetSum([1, 2, 3, 4, 5], 15, "Example 4");
  
  print("\n--- Edge Cases ---");
  testSubsetSum([], 0, "Empty set, sum 0");
  testSubsetSum([], 5, "Empty set, sum > 0");
  testSubsetSum([5], 5, "Single element match");
  testSubsetSum([5], 3, "Single element no match");
  testSubsetSum([1, 1, 1, 1], 2, "Duplicate elements");
  
  print("\n--- Detailed Solution with Steps ---");
  SubsetSum solver = SubsetSum();
  List<int> set1 = [2, 3, 7, 8, 10];
  int target1 = 11;
  solver.findSubsetWithSteps(set1, target1);
  
  print("\n--- Find All Possible Subsets ---");
  solver.findAllSubsets([1, 2, 3, 4], 5);
  
  print("\n--- Large Dataset Performance ---");
  performanceTest();
  
  print("\n--- Real-world Applications ---");
  realWorldExamples();
}

/**
 * Subset Sum Solver Class
 * Implements various approaches to solve the subset sum problem
 */
class SubsetSum {
  int _recursiveCalls = 0;
  List<List<int>> _allSolutions = [];
  
  /**
   * Main function to check if subset sum exists using backtracking
   * 
   * @param set: Array of integers
   * @param targetSum: Target sum to achieve
   * @return: true if subset exists, false otherwise
   */
  bool hasSubsetSum(List<int> set, int targetSum) {
    _recursiveCalls = 0;
    return _backtrack(set, targetSum, 0, 0, []);
  }
  
  /**
   * Backtracking helper function
   * 
   * @param set: Original set of numbers
   * @param targetSum: Target sum to achieve
   * @param currentIndex: Current index being considered
   * @param currentSum: Sum of elements selected so far
   * @param currentSubset: Current subset being built
   * @return: true if solution found, false otherwise
   */
  bool _backtrack(List<int> set, int targetSum, int currentIndex, 
                  int currentSum, List<int> currentSubset) {
    _recursiveCalls++;
    
    // Base case: found the target sum
    if (currentSum == targetSum) {
      return true;
    }
    
    // Base case: exceeded target sum or no more elements
    if (currentSum > targetSum || currentIndex >= set.length) {
      return false;
    }
    
    // Choice 1: Include current element
    currentSubset.add(set[currentIndex]);
    if (_backtrack(set, targetSum, currentIndex + 1, 
                   currentSum + set[currentIndex], currentSubset)) {
      return true;
    }
    currentSubset.removeLast(); // Backtrack
    
    // Choice 2: Exclude current element
    if (_backtrack(set, targetSum, currentIndex + 1, 
                   currentSum, currentSubset)) {
      return true;
    }
    
    return false;
  }
  
  /**
   * Find a subset that sums to target and return the actual subset
   */
  List<int>? findSubset(List<int> set, int targetSum) {
    _recursiveCalls = 0;
    List<int> result = [];
    
    if (_findSubsetHelper(set, targetSum, 0, 0, [], result)) {
      return result;
    }
    
    return null;
  }
  
  bool _findSubsetHelper(List<int> set, int targetSum, int currentIndex,
                        int currentSum, List<int> currentSubset, List<int> result) {
    _recursiveCalls++;
    
    if (currentSum == targetSum) {
      result.addAll(currentSubset);
      return true;
    }
    
    if (currentSum > targetSum || currentIndex >= set.length) {
      return false;
    }
    
    // Include current element
    currentSubset.add(set[currentIndex]);
    if (_findSubsetHelper(set, targetSum, currentIndex + 1,
                         currentSum + set[currentIndex], currentSubset, result)) {
      return true;
    }
    currentSubset.removeLast();
    
    // Exclude current element
    if (_findSubsetHelper(set, targetSum, currentIndex + 1,
                         currentSum, currentSubset, result)) {
      return true;
    }
    
    return false;
  }
  
  /**
   * Find subset with detailed step-by-step visualization
   */
  void findSubsetWithSteps(List<int> set, int targetSum) {
    print("Finding subset for set $set with target sum $targetSum");
    print("Step-by-step backtracking process:\n");
    
    _recursiveCalls = 0;
    _findWithSteps(set, targetSum, 0, 0, [], 0);
    
    print("Total recursive calls made: $_recursiveCalls");
  }
  
  bool _findWithSteps(List<int> set, int targetSum, int currentIndex,
                     int currentSum, List<int> currentSubset, int depth) {
    _recursiveCalls++;
    String indent = "  " * depth;
    
    print("${indent}Step $_recursiveCalls: Index=$currentIndex, Sum=$currentSum, Subset=$currentSubset");
    
    // Base cases
    if (currentSum == targetSum) {
      print("${indent}✅ SUCCESS! Found subset: $currentSubset = $currentSum");
      return true;
    }
    
    if (currentSum > targetSum) {
      print("${indent}❌ Sum exceeded target ($currentSum > $targetSum)");
      return false;
    }
    
    if (currentIndex >= set.length) {
      print("${indent}❌ No more elements to consider");
      return false;
    }
    
    int currentElement = set[currentIndex];
    
    // Try including current element
    print("${indent}🔄 Trying to include ${currentElement}");
    currentSubset.add(currentElement);
    
    if (_findWithSteps(set, targetSum, currentIndex + 1,
                      currentSum + currentElement, currentSubset, depth + 1)) {
      return true;
    }
    
    // Backtrack - remove current element
    currentSubset.removeLast();
    print("${indent}⬅️ Backtracking: removed $currentElement");
    
    // Try excluding current element
    print("${indent}🔄 Trying to exclude $currentElement");
    if (_findWithSteps(set, targetSum, currentIndex + 1,
                      currentSum, currentSubset, depth + 1)) {
      return true;
    }
    
    print("${indent}❌ Neither including nor excluding $currentElement worked");
    return false;
  }
  
  /**
   * Find all possible subsets that sum to target
   */
  void findAllSubsets(List<int> set, int targetSum) {
    print("Finding ALL subsets for set $set with target sum $targetSum");
    
    _allSolutions.clear();
    _findAllSubsetsHelper(set, targetSum, 0, 0, []);
    
    print("Found ${_allSolutions.length} solution(s):");
    for (int i = 0; i < _allSolutions.length; i++) {
      print("  Solution ${i + 1}: ${_allSolutions[i]} = ${_allSolutions[i].fold(0, (sum, element) => sum + element)}");
    }
    
    if (_allSolutions.isEmpty) {
      print("  No solutions found!");
    }
  }
  
  void _findAllSubsetsHelper(List<int> set, int targetSum, int currentIndex,
                            int currentSum, List<int> currentSubset) {
    if (currentSum == targetSum) {
      _allSolutions.add(List.from(currentSubset));
      return;
    }
    
    if (currentSum > targetSum || currentIndex >= set.length) {
      return;
    }
    
    // Include current element
    currentSubset.add(set[currentIndex]);
    _findAllSubsetsHelper(set, targetSum, currentIndex + 1,
                         currentSum + set[currentIndex], currentSubset);
    currentSubset.removeLast();
    
    // Exclude current element
    _findAllSubsetsHelper(set, targetSum, currentIndex + 1,
                         currentSum, currentSubset);
  }
  
  /**
   * Optimized version with early pruning
   */
  bool hasSubsetSumOptimized(List<int> set, int targetSum) {
    // Sort the array for better pruning
    set.sort();
    _recursiveCalls = 0;
    
    return _backtrackOptimized(set, targetSum, 0, 0);
  }
  
  bool _backtrackOptimized(List<int> set, int targetSum, int currentIndex, int currentSum) {
    _recursiveCalls++;
    
    if (currentSum == targetSum) {
      return true;
    }
    
    if (currentSum > targetSum || currentIndex >= set.length) {
      return false;
    }
    
    // Early pruning: if remaining sum of all elements is less than needed
    int remainingSum = 0;
    for (int i = currentIndex; i < set.length; i++) {
      remainingSum += set[i];
    }
    
    if (currentSum + remainingSum < targetSum) {
      return false;
    }
    
    // Include current element
    if (_backtrackOptimized(set, targetSum, currentIndex + 1, currentSum + set[currentIndex])) {
      return true;
    }
    
    // Exclude current element
    return _backtrackOptimized(set, targetSum, currentIndex + 1, currentSum);
  }
  
  /**
   * Get the number of recursive calls made in last operation
   */
  int get recursiveCalls => _recursiveCalls;
}

/**
 * Test helper function
 */
void testSubsetSum(List<int> set, int targetSum, String description) {
  SubsetSum solver = SubsetSum();
  
  print("$description:");
  print("  Set: $set");
  print("  Target: $targetSum");
  
  Stopwatch sw = Stopwatch()..start();
  bool exists = solver.hasSubsetSum(set, targetSum);
  sw.stop();
  
  print("  Result: ${exists ? '✅ EXISTS' : '❌ NOT EXISTS'}");
  print("  Recursive calls: ${solver.recursiveCalls}");
  print("  Time: ${sw.elapsedMicroseconds} microseconds");
  
  if (exists) {
    List<int>? subset = solver.findSubset(set, targetSum);
    if (subset != null) {
      print("  Example subset: $subset");
    }
  }
  
  print("");
}

/**
 * Performance testing with different input sizes
 */
void performanceTest() {
  print("Performance comparison (Basic vs Optimized):");
  print("Size | Basic Calls | Optimized Calls | Basic Time | Optimized Time");
  print("-" * 70);
  
  List<List<int>> testSets = [
    [1, 2, 3, 4, 5],
    [2, 4, 6, 8, 10, 12],
    [1, 3, 5, 7, 9, 11, 13, 15],
    [2, 4, 6, 8, 10, 12, 14, 16, 18, 20],
  ];
  
  for (List<int> set in testSets) {
    int target = set.fold(0, (sum, element) => sum + element) ~/ 2; // Half of total sum
    
    SubsetSum solver1 = SubsetSum();
    SubsetSum solver2 = SubsetSum();
    
    // Basic approach
    Stopwatch sw1 = Stopwatch()..start();
    solver1.hasSubsetSum(List.from(set), target);
    sw1.stop();
    
    // Optimized approach
    Stopwatch sw2 = Stopwatch()..start();
    solver2.hasSubsetSumOptimized(List.from(set), target);
    sw2.stop();
    
    print("${set.length.toString().padLeft(4)} | "
          "${solver1.recursiveCalls.toString().padLeft(11)} | "
          "${solver2.recursiveCalls.toString().padLeft(15)} | "
          "${sw1.elapsedMicroseconds.toString().padLeft(10)}μs | "
          "${sw2.elapsedMicroseconds.toString().padLeft(14)}μs");
  }
}

/**
 * Real-world application examples
 */
void realWorldExamples() {
  print("=== REAL-WORLD APPLICATIONS ===\n");
  
  // 1. Budget Planning
  print("1. Budget Planning:");
  List<int> expenses = [250, 100, 75, 50, 125, 200];
  int budget = 300;
  budgetPlanningExample(expenses, budget);
  
  // 2. Load Balancing
  print("\n2. Server Load Balancing:");
  List<int> taskLoads = [10, 20, 15, 25, 30];
  int serverCapacity = 50;
  loadBalancingExample(taskLoads, serverCapacity);
  
  // 3. Coin Change Problem
  print("\n3. Exact Change Problem:");
  List<int> coins = [1, 5, 10, 25]; // penny, nickel, dime, quarter
  int amount = 30;
  coinChangeExample(coins, amount);
}

void budgetPlanningExample(List<int> expenses, int budget) {
  SubsetSum solver = SubsetSum();
  
  print("  Available expenses: $expenses");
  print("  Budget limit: \$${budget}");
  
  List<int>? selectedExpenses = solver.findSubset(expenses, budget);
  
  if (selectedExpenses != null) {
    print("  ✅ Perfect budget allocation found!");
    print("  Selected expenses: $selectedExpenses");
    print("  Total: \$${selectedExpenses.fold(0, (sum, expense) => sum + expense)}");
  } else {
    print("  ❌ No exact budget allocation possible");
  }
}

void loadBalancingExample(List<int> taskLoads, int serverCapacity) {
  SubsetSum solver = SubsetSum();
  
  print("  Task loads: $taskLoads");
  print("  Server capacity: ${serverCapacity} units");
  
  List<int>? assignedTasks = solver.findSubset(taskLoads, serverCapacity);
  
  if (assignedTasks != null) {
    print("  ✅ Perfect load distribution found!");
    print("  Assigned tasks: $assignedTasks");
    print("  Total load: ${assignedTasks.fold(0, (sum, load) => sum + load)} units");
  } else {
    print("  ❌ No perfect load distribution possible");
  }
}

void coinChangeExample(List<int> coins, int amount) {
  SubsetSum solver = SubsetSum();
  
  print("  Available coins: $coins cents");
  print("  Target amount: ${amount} cents");
  
  solver.findAllSubsets(coins, amount);
}

/**
 * SUBSET SUM PROBLEM SUMMARY:
 * 
 * PROBLEM DEFINITION:
 * Given a set of non-negative integers and a target sum, determine if there
 * exists a subset of the given set with sum equal to the target sum.
 * 
 * BACKTRACKING APPROACH:
 * 1. For each element, we have two choices: include it or exclude it
 * 2. Recursively explore both choices
 * 3. Backtrack when sum exceeds target or no solution found
 * 4. Base case: sum equals target (success) or no more elements (failure)
 * 
 * ALGORITHM STEPS:
 * 1. Start with empty subset and sum = 0
 * 2. For current element: try including it in subset
 * 3. If including leads to solution, return true
 * 4. Otherwise, backtrack and try excluding the element
 * 5. If excluding also fails, return false
 * 
 * OPTIMIZATIONS:
 * 1. Sort array for better pruning
 * 2. Early termination when remaining sum < needed
 * 3. Memoization (Dynamic Programming approach)
 * 4. Skip duplicate elements efficiently
 * 
 * TIME COMPLEXITY:
 * - Worst case: O(2^n) - exponential
 * - With optimizations: Often much better in practice
 * - DP approach: O(n × target_sum)
 * 
 * SPACE COMPLEXITY:
 * - Recursive: O(n) for call stack
 * - DP approach: O(n × target_sum)
 * 
 * APPLICATIONS:
 * - Partition problems (equal sum partition)
 * - Budget planning and resource allocation
 * - Load balancing in distributed systems
 * - Cryptocurrency transaction verification
 * - Game theory and optimization problems
 * - Bin packing and scheduling problems
 * 
 * VARIANTS:
 * - Subset sum with repetition allowed
 * - Count number of subsets with given sum
 * - Minimum subset sum difference
 * - Target sum with positive and negative numbers
 */