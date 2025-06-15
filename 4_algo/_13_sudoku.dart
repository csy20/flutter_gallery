/*
 * SUDOKU SOLVER USING BACKTRACKING ALGORITHM IN DART
 * 
 * Sudoku is a logic-based number placement puzzle. The objective is to fill
 * a 9×9 grid with digits 1-9 such that each column, row, and 3×3 subgrid
 * contains all digits from 1 to 9 without repetition.
 * 
 * Backtracking Algorithm:
 * 1. Find an empty cell
 * 2. Try placing digits 1-9 in that cell
 * 3. Check if the placement is valid (no conflicts)
 * 4. If valid, recursively solve the rest
 * 5. If no valid solution found, backtrack and try next digit
 * 
 * Time Complexity: O(9^(n*n)) in worst case, where n=9 for standard Sudoku
 * Space Complexity: O(n*n) for the grid + O(n*n) for recursion stack
 */

void main() {
  print("=== SUDOKU SOLVER USING BACKTRACKING ===\n");
  
  SudokuSolver solver = SudokuSolver();
  
  // Example 1: Easy Sudoku puzzle
  print("--- Example 1: Easy Puzzle ---");
  List<List<int>> easyPuzzle = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
  ];
  solver.demonstrateSolving(easyPuzzle, "Easy");
  
  print("\n" + "="*60 + "\n");
  
  // Example 2: Medium difficulty puzzle
  print("--- Example 2: Medium Puzzle ---");
  List<List<int>> mediumPuzzle = [
    [0, 0, 0, 6, 0, 0, 4, 0, 0],
    [7, 0, 0, 0, 0, 3, 6, 0, 0],
    [0, 0, 0, 0, 9, 1, 0, 8, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 5, 0, 1, 8, 0, 0, 0, 3],
    [0, 0, 0, 3, 0, 6, 0, 4, 5],
    [0, 4, 0, 2, 0, 0, 0, 6, 0],
    [9, 0, 3, 0, 0, 0, 0, 0, 0],
    [0, 2, 0, 0, 0, 0, 1, 0, 0]
  ];
  solver.demonstrateSolving(mediumPuzzle, "Medium");
  
  print("\n" + "="*60 + "\n");
  
  // Example 3: Hard puzzle
  print("--- Example 3: Hard Puzzle ---");
  List<List<int>> hardPuzzle = [
    [0, 0, 0, 0, 0, 0, 0, 1, 0],
    [4, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 6, 0, 2],
    [0, 0, 0, 0, 0, 3, 0, 7, 0],
    [5, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 8, 0, 0, 4, 0],
    [0, 0, 0, 2, 0, 0, 0, 0, 0]
  ];
  solver.demonstrateSolving(hardPuzzle, "Hard");
  
  print("\n" + "="*60 + "\n");
  
  // Example 4: Invalid puzzle (no solution)
  print("--- Example 4: Invalid Puzzle ---");
  List<List<int>> invalidPuzzle = [
    [1, 1, 0, 0, 0, 0, 0, 0, 0],  // Two 1's in same row
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  solver.demonstrateSolving(invalidPuzzle, "Invalid");
  
  print("\n--- Backtracking Steps Visualization ---");
  solver.solveWithSteps(easyPuzzle);
  
  print("\n--- Performance Analysis ---");
  solver.performanceAnalysis();
  
  print("\n--- Sudoku Generation ---");
  solver.demonstrateGeneration();
}

/**
 * Sudoku Solver Class
 * Implements backtracking algorithm to solve Sudoku puzzles
 */
class SudokuSolver {
  static const int GRID_SIZE = 9;
  static const int BOX_SIZE = 3;
  static const int EMPTY_CELL = 0;
  
  int _backtrackCount = 0;
  int _callCount = 0;
  
  /**
   * Main solving function using backtracking
   * 
   * @param grid: 9x9 Sudoku grid (0 represents empty cells)
   * @return: true if solved, false if no solution exists
   */
  bool solveSudoku(List<List<int>> grid) {
    _callCount++;
    
    // Find next empty cell
    for (int row = 0; row < GRID_SIZE; row++) {
      for (int col = 0; col < GRID_SIZE; col++) {
        if (grid[row][col] == EMPTY_CELL) {
          // Try digits 1-9
          for (int num = 1; num <= 9; num++) {
            if (isValidPlacement(grid, row, col, num)) {
              grid[row][col] = num;  // Place the number
              
              // Recursively solve the rest
              if (solveSudoku(grid)) {
                return true;  // Solution found
              }
              
              // Backtrack: remove the number and try next
              grid[row][col] = EMPTY_CELL;
              _backtrackCount++;
            }
          }
          
          return false;  // No valid number found for this cell
        }
      }
    }
    
    return true;  // All cells filled successfully
  }
  
  /**
   * Check if placing a number at given position is valid
   * 
   * @param grid: Current Sudoku grid
   * @param row: Row position
   * @param col: Column position
   * @param num: Number to place (1-9)
   * @return: true if placement is valid
   */
  bool isValidPlacement(List<List<int>> grid, int row, int col, int num) {
    // Check row constraint
    for (int x = 0; x < GRID_SIZE; x++) {
      if (grid[row][x] == num) {
        return false;
      }
    }
    
    // Check column constraint
    for (int x = 0; x < GRID_SIZE; x++) {
      if (grid[x][col] == num) {
        return false;
      }
    }
    
    // Check 3x3 box constraint
    int boxStartRow = row - row % BOX_SIZE;
    int boxStartCol = col - col % BOX_SIZE;
    
    for (int i = 0; i < BOX_SIZE; i++) {
      for (int j = 0; j < BOX_SIZE; j++) {
        if (grid[boxStartRow + i][boxStartCol + j] == num) {
          return false;
        }
      }
    }
    
    return true;  // All constraints satisfied
  }
  
  /**
   * Check if the initial puzzle is valid
   */
  bool isValidPuzzle(List<List<int>> grid) {
    for (int row = 0; row < GRID_SIZE; row++) {
      for (int col = 0; col < GRID_SIZE; col++) {
        int num = grid[row][col];
        if (num != EMPTY_CELL) {
          grid[row][col] = EMPTY_CELL;  // Temporarily remove
          if (!isValidPlacement(grid, row, col, num)) {
            grid[row][col] = num;  // Restore
            return false;
          }
          grid[row][col] = num;  // Restore
        }
      }
    }
    return true;
  }
  
  /**
   * Print the Sudoku grid in a formatted way
   */
  void printGrid(List<List<int>> grid, [String title = ""]) {
    if (title.isNotEmpty) {
      print("$title:");
    }
    
    print("┌───────┬───────┬───────┐");
    
    for (int i = 0; i < GRID_SIZE; i++) {
      if (i == 3 || i == 6) {
        print("├───────┼───────┼───────┤");
      }
      
      String row = "│ ";
      for (int j = 0; j < GRID_SIZE; j++) {
        if (j == 3 || j == 6) {
          row += "│ ";
        }
        
        String cell = grid[i][j] == EMPTY_CELL ? "." : grid[i][j].toString();
        row += "$cell ";
      }
      row += "│";
      print(row);
    }
    
    print("└───────┴───────┴───────┘");
  }
  
  /**
   * Count empty cells in the grid
   */
  int countEmptyCells(List<List<int>> grid) {
    int count = 0;
    for (int i = 0; i < GRID_SIZE; i++) {
      for (int j = 0; j < GRID_SIZE; j++) {
        if (grid[i][j] == EMPTY_CELL) {
          count++;
        }
      }
    }
    return count;
  }
  
  /**
   * Create a deep copy of the grid
   */
  List<List<int>> copyGrid(List<List<int>> original) {
    return original.map((row) => List<int>.from(row)).toList();
  }
  
  /**
   * Demonstrate solving process
   */
  void demonstrateSolving(List<List<int>> puzzle, String difficulty) {
    print("Solving $difficulty Sudoku Puzzle:");
    
    // Create a copy to preserve original
    List<List<int>> grid = copyGrid(puzzle);
    
    printGrid(grid, "Original Puzzle");
    
    int emptyCells = countEmptyCells(grid);
    print("Empty cells: $emptyCells");
    
    // Check if puzzle is valid
    if (!isValidPuzzle(grid)) {
      print("❌ Invalid puzzle - contains contradictions");
      return;
    }
    
    // Reset counters
    _backtrackCount = 0;
    _callCount = 0;
    
    // Solve the puzzle
    DateTime startTime = DateTime.now();
    bool solved = solveSudoku(grid);
    DateTime endTime = DateTime.now();
    
    if (solved) {
      print("\n✅ Puzzle solved successfully!");
      printGrid(grid, "Solution");
      
      int duration = endTime.difference(startTime).inMilliseconds;
      print("Solving time: ${duration}ms");
      print("Recursive calls: $_callCount");
      print("Backtracks: $_backtrackCount");
    } else {
      print("\n❌ No solution exists for this puzzle");
    }
  }
  
  /**
   * Solve with step-by-step visualization (limited steps)
   */
  void solveWithSteps(List<List<int>> puzzle) {
    print("Backtracking Steps Visualization (first 10 steps):");
    
    List<List<int>> grid = copyGrid(puzzle);
    printGrid(grid, "Initial State");
    
    _solveWithStepsHelper(grid, 0, 1);
  }
  
  bool _solveWithStepsHelper(List<List<int>> grid, int position, int step) {
    if (step > 10) return solveSudoku(grid);  // Continue without steps
    
    if (position == GRID_SIZE * GRID_SIZE) {
      return true;  // All cells filled
    }
    
    int row = position ~/ GRID_SIZE;
    int col = position % GRID_SIZE;
    
    if (grid[row][col] != EMPTY_CELL) {
      return _solveWithStepsHelper(grid, position + 1, step);
    }
    
    print("\nStep $step: Trying cell ($row, $col)");
    
    for (int num = 1; num <= 9; num++) {
      if (isValidPlacement(grid, row, col, num)) {
        print("  Placing $num at ($row, $col)");
        grid[row][col] = num;
        
        if (step <= 5) {  // Show grid for first few steps
          printGrid(grid);
        }
        
        if (_solveWithStepsHelper(grid, position + 1, step + 1)) {
          return true;
        }
        
        print("  Backtracking from ($row, $col), removing $num");
        grid[row][col] = EMPTY_CELL;
      }
    }
    
    return false;
  }
  
  /**
   * Performance analysis with different puzzle difficulties
   */
  void performanceAnalysis() {
    print("Performance Analysis:");
    print("Difficulty | Empty Cells | Time (ms) | Backtracks | Calls");
    print("-" * 60);
    
    List<Map<String, dynamic>> testCases = [
      {
        "name": "Easy",
        "puzzle": [
          [5, 3, 0, 0, 7, 0, 0, 0, 0],
          [6, 0, 0, 1, 9, 5, 0, 0, 0],
          [0, 9, 8, 0, 0, 0, 0, 6, 0],
          [8, 0, 0, 0, 6, 0, 0, 0, 3],
          [4, 0, 0, 8, 0, 3, 0, 0, 1],
          [7, 0, 0, 0, 2, 0, 0, 0, 6],
          [0, 6, 0, 0, 0, 0, 2, 8, 0],
          [0, 0, 0, 4, 1, 9, 0, 0, 5],
          [0, 0, 0, 0, 8, 0, 0, 7, 9]
        ]
      },
      {
        "name": "Medium",
        "puzzle": [
          [0, 0, 0, 6, 0, 0, 4, 0, 0],
          [7, 0, 0, 0, 0, 3, 6, 0, 0],
          [0, 0, 0, 0, 9, 1, 0, 8, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 5, 0, 1, 8, 0, 0, 0, 3],
          [0, 0, 0, 3, 0, 6, 0, 4, 5],
          [0, 4, 0, 2, 0, 0, 0, 6, 0],
          [9, 0, 3, 0, 0, 0, 0, 0, 0],
          [0, 2, 0, 0, 0, 0, 1, 0, 0]
        ]
      }
    ];
    
    for (var testCase in testCases) {
      List<List<int>> grid = copyGrid(testCase["puzzle"]);
      int emptyCells = countEmptyCells(grid);
      
      _backtrackCount = 0;
      _callCount = 0;
      
      DateTime start = DateTime.now();
      solveSudoku(grid);
      DateTime end = DateTime.now();
      
      int duration = end.difference(start).inMilliseconds;
      
      print("${testCase['name']!.padRight(10)} | "
            "${emptyCells.toString().padLeft(11)} | "
            "${duration.toString().padLeft(9)} | "
            "${_backtrackCount.toString().padLeft(10)} | "
            "${_callCount.toString().padLeft(5)}");
    }
  }
  
  /**
   * Generate a valid Sudoku puzzle (simplified version)
   */
  void demonstrateGeneration() {
    print("Generating a Sudoku Puzzle:");
    
    // Start with empty grid
    List<List<int>> grid = List.generate(GRID_SIZE, (_) => List.filled(GRID_SIZE, EMPTY_CELL));
    
    // Fill some random cells to create a base
    _fillRandomCells(grid, 15);
    
    // Solve to create a complete grid
    if (solveSudoku(grid)) {
      printGrid(grid, "Complete Solution");
      
      // Remove cells to create puzzle
      List<List<int>> puzzle = _removeCells(grid, 45);
      printGrid(puzzle, "Generated Puzzle");
      
      print("Generated puzzle has ${countEmptyCells(puzzle)} empty cells");
    }
  }
  
  void _fillRandomCells(List<List<int>> grid, int count) {
    int filled = 0;
    while (filled < count) {
      int row = (DateTime.now().millisecondsSinceEpoch * 7 + filled) % GRID_SIZE;
      int col = (DateTime.now().millisecondsSinceEpoch * 11 + filled) % GRID_SIZE;
      int num = (DateTime.now().millisecondsSinceEpoch * 13 + filled) % 9 + 1;
      
      if (grid[row][col] == EMPTY_CELL && isValidPlacement(grid, row, col, num)) {
        grid[row][col] = num;
        filled++;
      }
    }
  }
  
  List<List<int>> _removeCells(List<List<int>> grid, int count) {
    List<List<int>> puzzle = copyGrid(grid);
    int removed = 0;
    
    while (removed < count) {
      int row = (DateTime.now().millisecondsSinceEpoch * 17 + removed) % GRID_SIZE;
      int col = (DateTime.now().millisecondsSinceEpoch * 19 + removed) % GRID_SIZE;
      
      if (puzzle[row][col] != EMPTY_CELL) {
        puzzle[row][col] = EMPTY_CELL;
        removed++;
      }
    }
    
    return puzzle;
  }
}

/**
 * SUDOKU SOLVING WITH BACKTRACKING - ALGORITHM SUMMARY:
 * 
 * PROBLEM DEFINITION:
 * Fill a 9×9 grid with digits 1-9 such that each row, column, and 3×3 box
 * contains all digits exactly once.
 * 
 * BACKTRACKING APPROACH:
 * 1. Find empty cell (row, col)
 * 2. For each digit 1-9:
 *    a. Check if digit can be placed (no conflicts)
 *    b. If valid, place digit and recursively solve
 *    c. If recursive call succeeds, return true
 *    d. If no solution found, remove digit (backtrack)
 * 3. If no digit works, return false
 * 
 * CONSTRAINT CHECKING:
 * - Row constraint: No duplicate in same row
 * - Column constraint: No duplicate in same column  
 * - Box constraint: No duplicate in same 3×3 box
 * 
 * OPTIMIZATIONS:
 * 1. Most Constrained Variable: Choose cell with fewest possibilities
 * 2. Least Constraining Value: Try values that eliminate fewest options
 * 3. Forward Checking: Eliminate impossible values early
 * 4. Arc Consistency: Maintain consistency between constraints
 * 
 * TIME COMPLEXITY:
 * - Worst case: O(9^(n×n)) where n=9
 * - Average case: Much better due to constraint propagation
 * - Best case: O(n×n) for easy puzzles
 * 
 * SPACE COMPLEXITY:
 * - O(n×n) for the grid
 * - O(n×n) for recursion stack in worst case
 * 
 * APPLICATIONS:
 * - Puzzle solving and generation
 * - Constraint satisfaction problems
 * - Logic game solvers
 * - AI and automated reasoning
 * - Educational tools for algorithm learning
 */