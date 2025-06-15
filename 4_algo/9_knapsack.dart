/*
 * KNAPSACK PROBLEM ALGORITHMS IN DART
 * 
 * The Knapsack Problem is a classic optimization problem where you have:
 * - A knapsack with limited weight capacity
 * - Items with different weights and values
 * - Goal: Maximize value while staying within weight limit
 * 
 * Two main variants:
 * 1. 0/1 Knapsack: Each item can be taken at most once
 * 2. Unbounded Knapsack: Each item can be taken multiple times
 * 
 * Solutions:
 * - Dynamic Programming: O(n * capacity)
 * - Greedy (approximation): O(n log n)
 * - Brute Force: O(2^n)
 */

import 'dart:math';

// Item class to represent knapsack items
class Item {
  String name;
  int weight;
  int value;
  double ratio; // value-to-weight ratio

  Item(this.name, this.weight, this.value) : ratio = value / weight;

  @override
  String toString() => '$name(w:$weight, v:$value, r:${ratio.toStringAsFixed(2)})';
}

class KnapsackSolver {
  List<Item> items;
  int capacity;

  KnapsackSolver(this.items, this.capacity);

  // 0/1 Knapsack using Dynamic Programming
  Map<String, dynamic> knapsack01DP() {
    int n = items.length;
    
    // Create DP table: dp[i][w] = max value with first i items and weight w
    List<List<int>> dp = List.generate(n + 1, (_) => List.filled(capacity + 1, 0));
    
    print("=== 0/1 KNAPSACK DYNAMIC PROGRAMMING ===");
    print("Items: ${items.map((item) => item.toString()).join(', ')}");
    print("Capacity: $capacity");
    print("\nBuilding DP table...");
    
    // Fill DP table
    for (int i = 1; i <= n; i++) {
      Item currentItem = items[i - 1];
      print("\nProcessing item $i: ${currentItem.name}");
      
      for (int w = 1; w <= capacity; w++) {
        // Option 1: Don't take current item
        dp[i][w] = dp[i - 1][w];
        
        // Option 2: Take current item (if it fits)
        if (currentItem.weight <= w) {
          int valueWithItem = currentItem.value + dp[i - 1][w - currentItem.weight];
          if (valueWithItem > dp[i][w]) {
            dp[i][w] = valueWithItem;
          }
        }
      }
    }
    
    // Print DP table
    _printDPTable(dp, n);
    
    // Backtrack to find selected items
    List<Item> selectedItems = _backtrackDP(dp, n);
    
    return {
      'maxValue': dp[n][capacity],
      'selectedItems': selectedItems,
      'totalWeight': selectedItems.fold(0, (sum, item) => sum + item.weight),
      'dpTable': dp
    };
  }

  // Unbounded Knapsack using Dynamic Programming
  Map<String, dynamic> knapsackUnboundedDP() {
    List<int> dp = List.filled(capacity + 1, 0);
    List<int> itemUsed = List.filled(capacity + 1, -1);
    
    print("\n=== UNBOUNDED KNAPSACK DYNAMIC PROGRAMMING ===");
    print("Items: ${items.map((item) => item.toString()).join(', ')}");
    print("Capacity: $capacity");
    
    // Fill DP array
    for (int w = 1; w <= capacity; w++) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].weight <= w) {
          int newValue = items[i].value + dp[w - items[i].weight];
          if (newValue > dp[w]) {
            dp[w] = newValue;
            itemUsed[w] = i;
          }
        }
      }
    }
    
    // Reconstruct solution
    List<Item> selectedItems = [];
    Map<String, int> itemCounts = {};
    int remainingCapacity = capacity;
    
    while (remainingCapacity > 0 && itemUsed[remainingCapacity] != -1) {
      int itemIndex = itemUsed[remainingCapacity];
      Item item = items[itemIndex];
      selectedItems.add(item);
      itemCounts[item.name] = (itemCounts[item.name] ?? 0) + 1;
      remainingCapacity -= item.weight;
    }
    
    return {
      'maxValue': dp[capacity],
      'selectedItems': selectedItems,
      'itemCounts': itemCounts,
      'totalWeight': selectedItems.fold(0, (sum, item) => sum + item.weight)
    };
  }

  // Greedy approach (approximation for fractional knapsack)
  Map<String, dynamic> knapsackGreedy() {
    print("\n=== GREEDY KNAPSACK (FRACTIONAL) ===");
    
    // Sort items by value-to-weight ratio in descending order
    List<Item> sortedItems = List.from(items);
    sortedItems.sort((a, b) => b.ratio.compareTo(a.ratio));
    
    print("Items sorted by value/weight ratio:");
    for (Item item in sortedItems) {
      print("  $item");
    }
    
    List<Map<String, dynamic>> selectedItems = [];
    int remainingCapacity = capacity;
    double totalValue = 0;
    
    for (Item item in sortedItems) {
      if (remainingCapacity >= item.weight) {
        // Take whole item
        selectedItems.add({
          'item': item,
          'fraction': 1.0,
          'weight': item.weight,
          'value': item.value
        });
        remainingCapacity -= item.weight;
        totalValue += item.value;
        print("Take full ${item.name}: +${item.value} value");
      } else if (remainingCapacity > 0) {
        // Take fraction of item
        double fraction = remainingCapacity / item.weight;
        double fractionalValue = item.value * fraction;
        selectedItems.add({
          'item': item,
          'fraction': fraction,
          'weight': remainingCapacity,
          'value': fractionalValue
        });
        totalValue += fractionalValue;
        print("Take ${(fraction * 100).toStringAsFixed(1)}% of ${item.name}: +${fractionalValue.toStringAsFixed(2)} value");
        remainingCapacity = 0;
        break;
      }
    }
    
    return {
      'maxValue': totalValue,
      'selectedItems': selectedItems,
      'totalWeight': capacity - remainingCapacity
    };
  }

  // Brute force approach (for small instances)
  Map<String, dynamic> knapsackBruteForce() {
    print("\n=== BRUTE FORCE KNAPSACK ===");
    print("Checking all ${pow(2, items.length)} possible combinations...");
    
    int maxValue = 0;
    List<Item> bestSelection = [];
    int bestWeight = 0;
    
    // Check all possible combinations (2^n)
    for (int mask = 0; mask < (1 << items.length); mask++) {
      List<Item> currentSelection = [];
      int currentWeight = 0;
      int currentValue = 0;
      
      for (int i = 0; i < items.length; i++) {
        if ((mask & (1 << i)) != 0) {
          currentSelection.add(items[i]);
          currentWeight += items[i].weight;
          currentValue += items[i].value;
        }
      }
      
      if (currentWeight <= capacity && currentValue > maxValue) {
        maxValue = currentValue;
        bestSelection = List.from(currentSelection);
        bestWeight = currentWeight;
      }
    }
    
    return {
      'maxValue': maxValue,
      'selectedItems': bestSelection,
      'totalWeight': bestWeight
    };
  }

  // Helper method to print DP table
  void _printDPTable(List<List<int>> dp, int n) {
    print("\nDP Table (rows: items, columns: weight capacity):");
    
    // Print header
    String header = "Item".padRight(8);
    for (int w = 0; w <= min(capacity, 15); w++) {
      header += w.toString().padLeft(4);
    }
    if (capacity > 15) header += " ...";
    print(header);
    
    // Print rows
    for (int i = 0; i <= min(n, 8); i++) {
      String row = (i == 0 ? "Base" : items[i-1].name).padRight(8);
      for (int w = 0; w <= min(capacity, 15); w++) {
        row += dp[i][w].toString().padLeft(4);
      }
      if (capacity > 15) row += " ...";
      print(row);
    }
    if (n > 8) print("...");
  }

  // Helper method to backtrack and find selected items
  List<Item> _backtrackDP(List<List<int>> dp, int n) {
    List<Item> selected = [];
    int w = capacity;
    
    print("\nBacktracking to find selected items:");
    
    for (int i = n; i > 0 && w > 0; i--) {
      // If value comes from including current item
      if (dp[i][w] != dp[i-1][w]) {
        Item item = items[i-1];
        selected.add(item);
        w -= item.weight;
        print("Selected: ${item.name}");
      }
    }
    
    return selected.reversed.toList();
  }
}

// Performance comparison function
void performanceComparison() {
  print("\n" + "="*60);
  print("PERFORMANCE COMPARISON");
  print("="*60);
  
  // Small test case for comparison
  List<Item> testItems = [
    Item("Laptop", 3, 2000),
    Item("Camera", 1, 1000),
    Item("Book", 1, 300),
    Item("Headphones", 2, 800),
    Item("Watch", 1, 1500),
  ];
  
  int testCapacity = 5;
  KnapsackSolver solver = KnapsackSolver(testItems, testCapacity);
  
  // Measure execution times
  Stopwatch sw1 = Stopwatch()..start();
  var dpResult = solver.knapsack01DP();
  sw1.stop();
  
  Stopwatch sw2 = Stopwatch()..start();
  var greedyResult = solver.knapsackGreedy();
  sw2.stop();
  
  Stopwatch sw3 = Stopwatch()..start();
  var bruteResult = solver.knapsackBruteForce();
  sw3.stop();
  
  print("\nExecution Times:");
  print("Dynamic Programming: ${sw1.elapsedMicroseconds} microseconds");
  print("Greedy Algorithm: ${sw2.elapsedMicroseconds} microseconds");
  print("Brute Force: ${sw3.elapsedMicroseconds} microseconds");
  
  print("\nResults Comparison:");
  print("DP Max Value: ${dpResult['maxValue']}");
  print("Greedy Max Value: ${greedyResult['maxValue'].toStringAsFixed(2)}");
  print("Brute Force Max Value: ${bruteResult['maxValue']}");
}

// Practical examples
void practicalExamples() {
  print("\n" + "="*60);
  print("PRACTICAL EXAMPLES");
  print("="*60);
  
  // Example 1: Camping trip
  print("\n🏕️ Example 1: Camping Trip (Weight limit: 15kg)");
  List<Item> campingItems = [
    Item("Tent", 5, 8),
    Item("Sleeping_Bag", 3, 6),
    Item("Food", 4, 7),
    Item("Water", 6, 9),
    Item("Flashlight", 1, 3),
    Item("First_Aid", 2, 5),
    Item("Map", 1, 2),
    Item("Compass", 1, 4),
  ];
  
  KnapsackSolver campingSolver = KnapsackSolver(campingItems, 15);
  var campingResult = campingSolver.knapsack01DP();
  
  print("\nOptimal camping gear:");
  for (Item item in campingResult['selectedItems']) {
    print("  ${item.name} (${item.weight}kg, value: ${item.value})");
  }
  print("Total value: ${campingResult['maxValue']}");
  print("Total weight: ${campingResult['totalWeight']}kg");
  
  // Example 2: Investment portfolio
  print("\n💰 Example 2: Investment Portfolio (Budget: \$10,000)");
  List<Item> investments = [
    Item("Stocks", 3000, 400),
    Item("Bonds", 2000, 150),
    Item("Real_Estate", 5000, 600),
    Item("Crypto", 1000, 200),
    Item("Gold", 2500, 250),
    Item("Savings", 1500, 50),
  ];
  
  KnapsackSolver investmentSolver = KnapsackSolver(investments, 10000);
  var investmentResult = investmentSolver.knapsack01DP();
  
  print("\nOptimal investment portfolio:");
  for (Item item in investmentResult['selectedItems']) {
    print("  ${item.name} (\$${item.weight}, expected return: \$${item.value})");
  }
  print("Total expected return: \$${investmentResult['maxValue']}");
  print("Total investment: \$${investmentResult['totalWeight']}");
}

void main() {
  print("🎒 KNAPSACK PROBLEM COMPREHENSIVE GUIDE 🎒");
  print("="*60);
  
  // Basic example
  List<Item> items = [
    Item("Gold", 2, 3),
    Item("Silver", 3, 4),
    Item("Diamond", 1, 2),
    Item("Ruby", 4, 7),
    Item("Emerald", 5, 9),
  ];
  
  int capacity = 8;
  KnapsackSolver solver = KnapsackSolver(items, capacity);
  
  // Test different algorithms
  var dpResult = solver.knapsack01DP();
  var unboundedResult = solver.knapsackUnboundedDP();
  var greedyResult = solver.knapsackGreedy();
  var bruteResult = solver.knapsackBruteForce();
  
  // Summary
  print("\n" + "="*60);
  print("ALGORITHM COMPARISON SUMMARY");
  print("="*60);
  print("0/1 Knapsack (DP): Value = ${dpResult['maxValue']}, Weight = ${dpResult['totalWeight']}");
  print("Unbounded Knapsack: Value = ${unboundedResult['maxValue']}, Weight = ${unboundedResult['totalWeight']}");
  print("Greedy (Fractional): Value = ${greedyResult['maxValue'].toStringAsFixed(2)}, Weight = ${greedyResult['totalWeight']}");
  print("Brute Force: Value = ${bruteResult['maxValue']}, Weight = ${bruteResult['totalWeight']}");
  
  // Performance and practical examples
  performanceComparison();
  practicalExamples();
  
  print("\n" + "="*60);
  print("ALGORITHM CHARACTERISTICS");
  print("="*60);
  print("📊 0/1 Knapsack DP:");
  print("   • Time: O(n×W), Space: O(n×W)");
  print("   • Optimal solution, each item used once");
  print("   • Best for discrete items");
  
  print("\n📊 Unbounded Knapsack:");
  print("   • Time: O(n×W), Space: O(W)");
  print("   • Optimal solution, items can be reused");
  print("   • Best for unlimited supply scenarios");
  
  print("\n📊 Greedy Algorithm:");
  print("   • Time: O(n log n), Space: O(1)");
  print("   • Approximation for fractional knapsack");
  print("   • Best when items can be divided");
  
  print("\n📊 Brute Force:");
  print("   • Time: O(2^n), Space: O(n)");
  print("   • Optimal but exponential time");
  print("   • Only for very small instances");
}

/**
 * KNAPSACK PROBLEM VARIANTS:
 * 
 * 1. 0/1 KNAPSACK (BINARY):
 *    - Each item can be taken at most once
 *    - Most common variant
 *    - Used in resource allocation, project selection
 * 
 * 2. UNBOUNDED KNAPSACK:
 *    - Each item can be taken multiple times
 *    - Used in coin change, cutting stock problems
 * 
 * 3. FRACTIONAL KNAPSACK:
 *    - Items can be divided into fractions
 *    - Greedy algorithm gives optimal solution
 *    - Used in continuous resource problems
 * 
 * 4. MULTIPLE KNAPSACK:
 *    - Multiple knapsacks with different capacities
 *    - More complex optimization
 * 
 * 5. MULTI-DIMENSIONAL KNAPSACK:
 *    - Multiple constraints (weight, volume, etc.)
 *    - Real-world applications often have multiple constraints
 * 
 * REAL-WORLD APPLICATIONS:
 * • Portfolio optimization
 * • Resource allocation
 * • Cutting stock problems
 * • CPU scheduling
 * • Memory management
 * • Network bandwidth allocation
 * • Cargo loading
 * • Budget planning
 */