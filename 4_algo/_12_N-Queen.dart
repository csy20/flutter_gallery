/*
 * N-QUEEN PROBLEM ALGORITHM IN DART
 * 
 * The N-Queen problem is a classic backtracking algorithm problem where
 * we need to place N queens on an N×N chessboard such that no two queens
 * attack each other. Queens can attack horizontally, vertically, and diagonally.
 * 
 * Time Complexity: O(N!) in worst case, but pruning reduces it significantly
 * Space Complexity: O(N) for the recursion stack and board representation
 * 
 * This is a perfect example of:
 * - Backtracking algorithm
 * - Constraint satisfaction problem
 * - Recursive problem solving
 * - State space search
 */

void main() {
  print("=== N-QUEEN PROBLEM DEMONSTRATION ===\n");
  
  // Demonstrate different board sizes
  print("--- Solving N-Queen for different board sizes ---");
  for (int n = 1; n <= 8; n++) {
    solveNQueenDemo(n);
  }
  
  print("\n--- Detailed Solution for 4-Queen ---");
  NQueen nQueen4 = NQueen(4);
  nQueen4.solveWithSteps();
  
  print("\n--- All Solutions for 4-Queen ---");
  nQueen4.findAllSolutions();
  
  print("\n--- Optimized Solution for 8-Queen ---");
  NQueen nQueen8 = NQueen(8);
  nQueen8.solveOptimized();
  
  print("\n--- Performance Analysis ---");
  performanceAnalysis();
  
  print("\n--- Interactive Solver ---");
  interactiveSolver();
}

/**
 * N-Queen Solver Class
 * Implements various approaches to solve the N-Queen problem
 */
class NQueen {
  int n;
  List<int> queens; // queens[i] = column position of queen in row i
  int solutionCount = 0;
  int backtrackCount = 0;
  
  NQueen(this.n) : queens = List.filled(n, -1);
  
  /**
   * Basic solve method - finds one solution
   */
  bool solve() {
    solutionCount = 0;
    backtrackCount = 0;
    queens.fillRange(0, n, -1);
    
    bool result = _solveRecursive(0);
    
    if (result) {
      print("Solution found for $n-Queen problem:");
      printBoard();
    } else {
      print("No solution exists for $n-Queen problem");
    }
    
    return result;
  }
  
  /**
   * Recursive backtracking function
   */
  bool _solveRecursive(int row) {
    // Base case: all queens placed successfully
    if (row == n) {
      return true;
    }
    
    // Try placing queen in each column of current row
    for (int col = 0; col < n; col++) {
      if (_isSafe(row, col)) {
        // Place queen
        queens[row] = col;
        
        // Recursively place remaining queens
        if (_solveRecursive(row + 1)) {
          return true;
        }
        
        // Backtrack: remove queen if solution not found
        queens[row] = -1;
        backtrackCount++;
      }
    }
    
    return false; // No solution found for this configuration
  }
  
  /**
   * Check if placing a queen at (row, col) is safe
   */
  bool _isSafe(int row, int col) {
    // Check all previously placed queens
    for (int i = 0; i < row; i++) {
      int queenCol = queens[i];
      
      // Check column conflict
      if (queenCol == col) {
        return false;
      }
      
      // Check diagonal conflicts
      if ((i - row).abs() == (queenCol - col).abs()) {
        return false;
      }
    }
    
    return true;
  }
  
  /**
   * Solve with step-by-step visualization
   */
  void solveWithSteps() {
    print("Solving $n-Queen problem step by step:");
    queens.fillRange(0, n, -1);
    solutionCount = 0;
    backtrackCount = 0;
    
    _solveWithStepsRecursive(0, 1);
    
    if (solutionCount > 0) {
      print("\n✅ Solution found!");
      printBoard();
    } else {
      print("\n❌ No solution exists");
    }
    
    print("Total backtracks: $backtrackCount");
  }
  
  bool _solveWithStepsRecursive(int row, int step) {
    if (row == n) {
      solutionCount++;
      return true;
    }
    
    print("\nStep $step: Trying to place queen in row $row");
    
    for (int col = 0; col < n; col++) {
      print("  Attempting column $col...");
      
      if (_isSafe(row, col)) {
        queens[row] = col;
        print("  ✅ Safe! Placing queen at ($row, $col)");
        _printCurrentState();
        
        if (_solveWithStepsRecursive(row + 1, step + 1)) {
          return true;
        }
        
        print("  ⬅️ Backtracking from ($row, $col)");
        queens[row] = -1;
        backtrackCount++;
      } else {
        print("  ❌ Not safe - conflicts detected");
      }
    }
    
    return false;
  }
  
  /**
   * Find all possible solutions
   */
  void findAllSolutions() {
    print("Finding all solutions for $n-Queen problem:");
    queens.fillRange(0, n, -1);
    solutionCount = 0;
    backtrackCount = 0;
    
    List<List<int>> allSolutions = [];
    _findAllSolutionsRecursive(0, allSolutions);
    
    print("Total solutions found: ${allSolutions.length}");
    
    for (int i = 0; i < allSolutions.length && i < 3; i++) {
      print("\nSolution ${i + 1}:");
      _printSolution(allSolutions[i]);
    }
    
    if (allSolutions.length > 3) {
      print("\n... and ${allSolutions.length - 3} more solutions");
    }
    
    print("Total backtracks: $backtrackCount");
  }
  
  void _findAllSolutionsRecursive(int row, List<List<int>> solutions) {
    if (row == n) {
      solutions.add(List.from(queens));
      return;
    }
    
    for (int col = 0; col < n; col++) {
      if (_isSafe(row, col)) {
        queens[row] = col;
        _findAllSolutionsRecursive(row + 1, solutions);
        queens[row] = -1;
        backtrackCount++;
      }
    }
  }
  
  /**
   * Optimized solution using bit manipulation
   */
  void solveOptimized() {
    print("Solving $n-Queen using optimized bit manipulation:");
    
    solutionCount = 0;
    int totalSolutions = 0;
    
    Stopwatch sw = Stopwatch()..start();
    
    // Use bit manipulation for faster conflict checking
    _solveOptimizedRecursive(0, 0, 0, 0);
    
    sw.stop();
    
    print("Total solutions: $solutionCount");
    print("Time taken: ${sw.elapsedMilliseconds}ms");
  }
  
  void _solveOptimizedRecursive(int row, int cols, int diag1, int diag2) {
    if (row == n) {
      solutionCount++;
      return;
    }
    
    // Calculate available positions
    int available = ((1 << n) - 1) & ~(cols | diag1 | diag2);
    
    while (available != 0) {
      int pos = available & -available; // Get rightmost set bit
      available -= pos; // Remove this position
      
      _solveOptimizedRecursive(
        row + 1,
        cols | pos,
        (diag1 | pos) << 1,
        (diag2 | pos) >> 1
      );
    }
  }
  
  /**
   * Print the current board state
   */
  void printBoard() {
    print("\nBoard configuration:");
    _printHorizontalLine();
    
    for (int i = 0; i < n; i++) {
      String row = "|";
      for (int j = 0; j < n; j++) {
        if (queens[i] == j) {
          row += " Q |";
        } else {
          row += "   |";
        }
      }
      print(row);
      _printHorizontalLine();
    }
    
    print("\nQueen positions: ${_getQueenPositions()}");
  }
  
  void _printCurrentState() {
    print("    Current state:");
    for (int i = 0; i < n; i++) {
      String row = "    |";
      for (int j = 0; j < n; j++) {
        if (i < queens.length && queens[i] == j) {
          row += " Q |";
        } else {
          row += "   |";
        }
      }
      print(row);
    }
  }
  
  void _printSolution(List<int> solution) {
    for (int i = 0; i < n; i++) {
      String row = "|";
      for (int j = 0; j < n; j++) {
        if (solution[i] == j) {
          row += " Q |";
        } else {
          row += "   |";
        }
      }
      print(row);
    }
  }
  
  void _printHorizontalLine() {
    String line = "+";
    for (int i = 0; i < n; i++) {
      line += "---+";
    }
    print(line);
  }
  
  String _getQueenPositions() {
    List<String> positions = [];
    for (int i = 0; i < n; i++) {
      if (queens[i] != -1) {
        positions.add("($i,${queens[i]})");
      }
    }
    return positions.join(", ");
  }
  
  /**
   * Validate a solution
   */
  bool isValidSolution() {
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        // Check column conflict
        if (queens[i] == queens[j]) {
          return false;
        }
        
        // Check diagonal conflict
        if ((i - j).abs() == (queens[i] - queens[j]).abs()) {
          return false;
        }
      }
    }
    return true;
  }
}

/**
 * Demonstration function for different board sizes
 */
void solveNQueenDemo(int n) {
  print("$n-Queen Problem:");
  NQueen nQueen = NQueen(n);
  
  Stopwatch sw = Stopwatch()..start();
  bool hasSolution = nQueen.solve();
  sw.stop();
  
  if (hasSolution) {
    print("✅ Solution found in ${sw.elapsedMilliseconds}ms");
    print("Backtracks: ${nQueen.backtrackCount}");
    print("Valid: ${nQueen.isValidSolution()}");
  } else {
    print("❌ No solution exists");
  }
  
  print("");
}

/**
 * Performance analysis for different board sizes
 */
void performanceAnalysis() {
  print("Performance Analysis:");
  print("N | Time (ms) | Solutions | Backtracks | Valid");
  print("-" * 50);
  
  for (int n = 4; n <= 10; n++) {
    NQueen nQueen = NQueen(n);
    
    Stopwatch sw = Stopwatch()..start();
    nQueen.solveOptimized();
    sw.stop();
    
    print("${n.toString().padLeft(1)} | "
          "${sw.elapsedMilliseconds.toString().padLeft(9)} | "
          "${nQueen.solutionCount.toString().padLeft(9)} | "
          "${nQueen.backtrackCount.toString().padLeft(10)} | "
          "N/A");
  }
}

/**
 * Interactive solver demonstration
 */
void interactiveSolver() {
  print("Interactive N-Queen Solver Demo:");
  
  // Demonstrate manual placement validation
  NQueen nQueen = NQueen(4);
  
  print("\nManual placement demo for 4-Queen:");
  
  // Try placing queens manually and show conflicts
  List<Map<String, dynamic>> placements = [
    {"row": 0, "col": 1, "description": "Place first queen at (0,1)"},
    {"row": 1, "col": 3, "description": "Place second queen at (1,3)"},
    {"row": 2, "col": 0, "description": "Place third queen at (2,0)"},
    {"row": 3, "col": 2, "description": "Place fourth queen at (3,2)"},
  ];
  
  for (var placement in placements) {
    int row = placement["row"];
    int col = placement["col"];
    String desc = placement["description"];
    
    print("\n$desc");
    
    if (nQueen._isSafe(row, col)) {
      nQueen.queens[row] = col;
      print("✅ Safe placement!");
      nQueen._printCurrentState();
    } else {
      print("❌ Conflict detected!");
      _explainConflicts(nQueen, row, col);
    }
  }
  
  print("\nFinal solution validation: ${nQueen.isValidSolution() ? '✅ Valid' : '❌ Invalid'}");
}

/**
 * Explain why a placement causes conflicts
 */
void _explainConflicts(NQueen nQueen, int row, int col) {
  print("Conflicts with:");
  
  for (int i = 0; i < row; i++) {
    if (nQueen.queens[i] == -1) continue;
    
    int queenCol = nQueen.queens[i];
    
    // Column conflict
    if (queenCol == col) {
      print("  - Queen at ($i,$queenCol): Same column");
    }
    
    // Diagonal conflict
    if ((i - row).abs() == (queenCol - col).abs()) {
      print("  - Queen at ($i,$queenCol): Diagonal attack");
    }
  }
}

/**
 * Utility class for N-Queen problem analysis
 */
class NQueenAnalysis {
  static Map<int, int> knownSolutions = {
    1: 1, 2: 0, 3: 0, 4: 2, 5: 10, 6: 4, 7: 40, 8: 92
  };
  
  static void printKnownSolutions() {
    print("Known solutions for N-Queen problem:");
    knownSolutions.forEach((n, solutions) {
      print("$n-Queen: $solutions solutions");
    });
  }
  
  static bool verifyKnownSolution(int n, int foundSolutions) {
    if (knownSolutions.containsKey(n)) {
      return knownSolutions[n] == foundSolutions;
    }
    return true; // Unknown, assume correct
  }
}

/**
 * N-QUEEN ALGORITHM SUMMARY:
 * 
 * PROBLEM DEFINITION:
 * Place N queens on an N×N chessboard such that no two queens attack each other.
 * Queens can attack horizontally, vertically, and diagonally.
 * 
 * ALGORITHM APPROACH:
 * 1. Backtracking: Try placing queens row by row
 * 2. For each row, try all columns
 * 3. Check if placement is safe (no conflicts)
 * 4. If safe, place queen and move to next row
 * 5. If not safe or no solution found, backtrack
 * 
 * OPTIMIZATION TECHNIQUES:
 * 1. Bit manipulation for faster conflict checking
 * 2. Symmetry reduction for counting solutions
 * 3. Constraint propagation
 * 4. Forward checking
 * 
 * COMPLEXITY ANALYSIS:
 * - Time: O(N!) worst case, but pruning reduces significantly
 * - Space: O(N) for recursion stack and board state
 * 
 * REAL-WORLD APPLICATIONS:
 * 1. Constraint satisfaction problems
 * 2. Resource allocation with conflicts
 * 3. Task scheduling with dependencies
 * 4. Circuit board design
 * 5. Frequency assignment in wireless networks
 * 
 * VARIATIONS:
 * 1. Generalized N-Queen (different board shapes)
 * 2. N-Queen with obstacles
 * 3. Peaceful chess pieces problem
 * 4. Super-queen problem (queen + knight moves)
 * 
 * KEY INSIGHTS:
 * - No solution exists for N=2 and N=3
 * - For N≥4, at least one solution always exists
 * - Number of solutions grows exponentially with N
 * - Symmetrical solutions can be counted once and multiplied
 */