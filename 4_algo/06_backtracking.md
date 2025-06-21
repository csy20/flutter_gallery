# Backtracking in Dart

## Introduction to Backtracking

Backtracking is an algorithmic paradigm that considers searching every possible combination in order to solve computational problems. It builds solutions incrementally and abandons candidates ("backtracks") as soon as it determines they cannot lead to a valid solution.

### Key Characteristics:
- **Incremental Construction**: Build solution step by step
- **Constraint Satisfaction**: Check if current path satisfies constraints
- **Backtrack on Failure**: Undo choices when they lead to dead ends
- **Systematic Exploration**: Explore all possible paths systematically
- **Pruning**: Eliminate branches that cannot lead to solutions

### Core Algorithm Pattern:
```dart
bool backtrack(State currentState) {
  if (isComplete(currentState)) {
    return true; // Found a solution
  }
  
  for (var choice in getChoices(currentState)) {
    if (isValid(currentState, choice)) {
      makeChoice(currentState, choice);
      
      if (backtrack(currentState)) {
        return true; // Solution found in this branch
      }
      
      undoChoice(currentState, choice); // Backtrack
    }
  }
  
  return false; // No solution found
}
```

### When to Use Backtracking:
1. Problems with multiple solutions or no clear greedy choice
2. Constraint satisfaction problems
3. Combinatorial problems (permutations, combinations)
4. Puzzle solving (N-Queens, Sudoku)
5. Path finding with constraints

---

## 1. N-Queens Problem

**Problem**: Place N queens on an N×N chessboard such that no two queens attack each other.

**Constraints**: Queens attack horizontally, vertically, and diagonally.

```dart
class NQueens {
  List<List<int>> solutions = [];
  
  // Main solving function
  List<List<int>> solveNQueens(int n) {
    solutions.clear();
    List<int> board = List.filled(n, -1); // board[i] = column of queen in row i
    _backtrack(board, 0, n);
    return solutions;
  }
  
  // Backtracking function
  void _backtrack(List<int> board, int row, int n) {
    if (row == n) {
      // Found a complete solution
      solutions.add(List.from(board));
      return;
    }
    
    for (int col = 0; col < n; col++) {
      if (_isValid(board, row, col)) {
        board[row] = col; // Place queen
        _backtrack(board, row + 1, n); // Recurse
        board[row] = -1; // Backtrack (undo)
      }
    }
  }
  
  // Check if placing queen at (row, col) is valid
  bool _isValid(List<int> board, int row, int col) {
    for (int i = 0; i < row; i++) {
      int prevCol = board[i];
      
      // Check column conflict
      if (prevCol == col) return false;
      
      // Check diagonal conflicts
      if ((row - i).abs() == (col - prevCol).abs()) return false;
    }
    return true;
  }
  
  // Utility function to print board
  void printBoard(List<int> board) {
    int n = board.length;
    for (int i = 0; i < n; i++) {
      String row = '';
      for (int j = 0; j < n; j++) {
        row += (board[i] == j) ? 'Q ' : '. ';
      }
      print(row);
    }
    print('');
  }
  
  // Count total solutions
  int countSolutions(int n) {
    solutions.clear();
    List<int> board = List.filled(n, -1);
    _backtrack(board, 0, n);
    return solutions.length;
  }
}

// Example usage
void testNQueens() {
  NQueens nQueens = NQueens();
  
  print("N-Queens Solutions for n=4:");
  var solutions = nQueens.solveNQueens(4);
  
  for (int i = 0; i < solutions.length; i++) {
    print("Solution ${i + 1}:");
    nQueens.printBoard(solutions[i]);
  }
  
  print("Total solutions for n=8: ${nQueens.countSolutions(8)}");
}
```

**Time Complexity**: O(N!) in worst case  
**Space Complexity**: O(N) for recursion stack

---

## 2. Sudoku Solver

**Problem**: Fill a 9×9 grid with digits 1-9 such that each row, column, and 3×3 box contains all digits 1-9.

```dart
class SudokuSolver {
  static const int SIZE = 9;
  static const int BOX_SIZE = 3;
  static const int EMPTY = 0;
  
  // Main solving function
  bool solveSudoku(List<List<int>> board) {
    var emptyCell = _findEmptyCell(board);
    if (emptyCell == null) {
      return true; // Puzzle solved
    }
    
    int row = emptyCell[0];
    int col = emptyCell[1];
    
    for (int num = 1; num <= 9; num++) {
      if (_isValid(board, row, col, num)) {
        board[row][col] = num; // Make choice
        
        if (solveSudoku(board)) {
          return true; // Solution found
        }
        
        board[row][col] = EMPTY; // Backtrack
      }
    }
    
    return false; // No solution found
  }
  
  // Find next empty cell
  List<int>? _findEmptyCell(List<List<int>> board) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        if (board[row][col] == EMPTY) {
          return [row, col];
        }
      }
    }
    return null; // No empty cell found
  }
  
  // Check if placing num at (row, col) is valid
  bool _isValid(List<List<int>> board, int row, int col, int num) {
    // Check row
    for (int c = 0; c < SIZE; c++) {
      if (board[row][c] == num) return false;
    }
    
    // Check column
    for (int r = 0; r < SIZE; r++) {
      if (board[r][col] == num) return false;
    }
    
    // Check 3x3 box
    int boxRow = (row ~/ BOX_SIZE) * BOX_SIZE;
    int boxCol = (col ~/ BOX_SIZE) * BOX_SIZE;
    
    for (int r = boxRow; r < boxRow + BOX_SIZE; r++) {
      for (int c = boxCol; c < boxCol + BOX_SIZE; c++) {
        if (board[r][c] == num) return false;
      }
    }
    
    return true;
  }
  
  // Print sudoku board
  void printBoard(List<List<int>> board) {
    for (int row = 0; row < SIZE; row++) {
      if (row % 3 == 0 && row != 0) {
        print("------+-------+------");
      }
      
      String line = "";
      for (int col = 0; col < SIZE; col++) {
        if (col % 3 == 0 && col != 0) {
          line += "| ";
        }
        line += "${board[row][col] == 0 ? '.' : board[row][col]} ";
      }
      print(line);
    }
    print("");
  }
  
  // Validate if current board state is valid
  bool isValidBoard(List<List<int>> board) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        if (board[row][col] != EMPTY) {
          int num = board[row][col];
          board[row][col] = EMPTY; // Temporarily remove
          
          if (!_isValid(board, row, col, num)) {
            board[row][col] = num; // Restore
            return false;
          }
          
          board[row][col] = num; // Restore
        }
      }
    }
    return true;
  }
}

// Example usage
void testSudoku() {
  SudokuSolver solver = SudokuSolver();
  
  // Example puzzle (0 represents empty cells)
  List<List<int>> puzzle = [
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
  
  print("Original Puzzle:");
  solver.printBoard(puzzle);
  
  if (solver.solveSudoku(puzzle)) {
    print("Solution:");
    solver.printBoard(puzzle);
  } else {
    print("No solution exists!");
  }
}
```

---

## 3. Generate All Permutations

**Problem**: Generate all possible permutations of a given array.

```dart
class PermutationGenerator {
  List<List<T>> generatePermutations<T>(List<T> arr) {
    List<List<T>> result = [];
    _backtrack(arr, [], result);
    return result;
  }
  
  void _backtrack<T>(List<T> arr, List<T> current, List<List<T>> result) {
    if (current.length == arr.length) {
      result.add(List.from(current));
      return;
    }
    
    for (int i = 0; i < arr.length; i++) {
      if (current.contains(arr[i])) continue; // Skip used elements
      
      current.add(arr[i]); // Choose
      _backtrack(arr, current, result); // Explore
      current.removeLast(); // Unchoose (backtrack)
    }
  }
  
  // Generate permutations with repetition allowed
  List<List<T>> generatePermutationsWithRep<T>(List<T> arr, int length) {
    List<List<T>> result = [];
    _backtrackWithRep(arr, [], length, result);
    return result;
  }
  
  void _backtrackWithRep<T>(List<T> arr, List<T> current, int length, List<List<T>> result) {
    if (current.length == length) {
      result.add(List.from(current));
      return;
    }
    
    for (int i = 0; i < arr.length; i++) {
      current.add(arr[i]); // Choose
      _backtrackWithRep(arr, current, length, result); // Explore
      current.removeLast(); // Unchoose
    }
  }
  
  // Generate permutations of string
  List<String> generateStringPermutations(String str) {
    List<String> chars = str.split('');
    var perms = generatePermutations(chars);
    return perms.map((perm) => perm.join('')).toList();
  }
  
  // Count total permutations without generating them
  int countPermutations(int n) {
    if (n <= 1) return 1;
    return n * countPermutations(n - 1); // n!
  }
}

// Example usage
void testPermutations() {
  PermutationGenerator generator = PermutationGenerator();
  
  print("Permutations of [1, 2, 3]:");
  var perms = generator.generatePermutations([1, 2, 3]);
  for (var perm in perms) {
    print(perm);
  }
  
  print("\nString permutations of 'ABC':");
  var stringPerms = generator.generateStringPermutations('ABC');
  for (var perm in stringPerms) {
    print(perm);
  }
  
  print("\nPermutations with repetition [1, 2] length 3:");
  var repPerms = generator.generatePermutationsWithRep([1, 2], 3);
  for (var perm in repPerms) {
    print(perm);
  }
}
```

---

## 4. Generate All Combinations

**Problem**: Generate all possible combinations of elements from an array.

```dart
class CombinationGenerator {
  // Generate all combinations of size k from array
  List<List<T>> generateCombinations<T>(List<T> arr, int k) {
    List<List<T>> result = [];
    _backtrack(arr, k, 0, [], result);
    return result;
  }
  
  void _backtrack<T>(List<T> arr, int k, int start, List<T> current, List<List<T>> result) {
    if (current.length == k) {
      result.add(List.from(current));
      return;
    }
    
    for (int i = start; i < arr.length; i++) {
      current.add(arr[i]); // Choose
      _backtrack(arr, k, i + 1, current, result); // Explore
      current.removeLast(); // Unchoose
    }
  }
  
  // Generate all possible combinations (all sizes)
  List<List<T>> generateAllCombinations<T>(List<T> arr) {
    List<List<T>> result = [];
    
    for (int k = 0; k <= arr.length; k++) {
      result.addAll(generateCombinations(arr, k));
    }
    
    return result;
  }
  
  // Generate combinations with repetition allowed
  List<List<T>> generateCombinationsWithRep<T>(List<T> arr, int k) {
    List<List<T>> result = [];
    _backtrackWithRep(arr, k, 0, [], result);
    return result;
  }
  
  void _backtrackWithRep<T>(List<T> arr, int k, int start, List<T> current, List<List<T>> result) {
    if (current.length == k) {
      result.add(List.from(current));
      return;
    }
    
    for (int i = start; i < arr.length; i++) {
      current.add(arr[i]); // Choose
      _backtrackWithRep(arr, k, i, current, result); // Can reuse same element
      current.removeLast(); // Unchoose
    }
  }
  
  // Calculate combinations count C(n, k) = n! / (k! * (n-k)!)
  int combinationCount(int n, int k) {
    if (k > n || k < 0) return 0;
    if (k == 0 || k == n) return 1;
    
    // Use the more efficient formula
    k = k < n - k ? k : n - k; // Take advantage of symmetry
    
    int result = 1;
    for (int i = 0; i < k; i++) {
      result = result * (n - i) ~/ (i + 1);
    }
    return result;
  }
}

// Example usage
void testCombinations() {
  CombinationGenerator generator = CombinationGenerator();
  
  print("Combinations of [1, 2, 3, 4] size 2:");
  var combs = generator.generateCombinations([1, 2, 3, 4], 2);
  for (var comb in combs) {
    print(comb);
  }
  
  print("\nAll combinations of [1, 2, 3]:");
  var allCombs = generator.generateAllCombinations([1, 2, 3]);
  for (var comb in allCombs) {
    print(comb);
  }
  
  print("\nCombinations with repetition [1, 2] size 3:");
  var repCombs = generator.generateCombinationsWithRep([1, 2], 3);
  for (var comb in repCombs) {
    print(comb);
  }
  
  print("\nC(5, 2) = ${generator.combinationCount(5, 2)}");
}
```

---

## 5. Subset Sum Problem

**Problem**: Find all subsets of an array that sum to a target value.

```dart
class SubsetSum {
  // Find all subsets that sum to target
  List<List<int>> findSubsetsWithSum(List<int> arr, int target) {
    List<List<int>> result = [];
    arr.sort(); // Sort for optimization
    _backtrack(arr, target, 0, [], result);
    return result;
  }
  
  void _backtrack(List<int> arr, int remaining, int start, List<int> current, List<List<int>> result) {
    if (remaining == 0) {
      result.add(List.from(current));
      return;
    }
    
    if (remaining < 0) return; // Pruning: impossible to reach target
    
    for (int i = start; i < arr.length; i++) {
      // Skip duplicates
      if (i > start && arr[i] == arr[i - 1]) continue;
      
      current.add(arr[i]); // Choose
      _backtrack(arr, remaining - arr[i], i + 1, current, result); // Explore
      current.removeLast(); // Unchoose
    }
  }
  
  // Check if any subset exists with given sum
  bool hasSubsetWithSum(List<int> arr, int target) {
    arr.sort();
    return _hasSubset(arr, target, 0, []);
  }
  
  bool _hasSubset(List<int> arr, int remaining, int start, List<int> current) {
    if (remaining == 0) return true;
    if (remaining < 0) return false;
    
    for (int i = start; i < arr.length; i++) {
      if (i > start && arr[i] == arr[i - 1]) continue;
      
      current.add(arr[i]);
      if (_hasSubset(arr, remaining - arr[i], i + 1, current)) {
        return true;
      }
      current.removeLast();
    }
    
    return false;
  }
  
  // Find subset with sum closest to target
  List<int> findClosestSubsetSum(List<int> arr, int target) {
    List<int> bestSubset = [];
    int bestDiff = double.maxFinite.toInt();
    
    _findClosest(arr, target, 0, [], bestSubset, bestDiff);
    return bestSubset;
  }
  
  void _findClosest(List<int> arr, int target, int start, List<int> current, List<int> bestSubset, int bestDiff) {
    int currentSum = current.fold(0, (sum, val) => sum + val);
    int currentDiff = (target - currentSum).abs();
    
    if (currentDiff < bestDiff) {
      bestDiff = currentDiff;
      bestSubset.clear();
      bestSubset.addAll(current);
    }
    
    for (int i = start; i < arr.length; i++) {
      current.add(arr[i]);
      _findClosest(arr, target, i + 1, current, bestSubset, bestDiff);
      current.removeLast();
    }
  }
}

// Example usage
void testSubsetSum() {
  SubsetSum subsetSum = SubsetSum();
  
  List<int> arr = [2, 3, 6, 7, 1, 5];
  int target = 8;
  
  print("Array: $arr, Target: $target");
  
  var subsets = subsetSum.findSubsetsWithSum(arr, target);
  print("Subsets with sum $target:");
  for (var subset in subsets) {
    print(subset);
  }
  
  print("\nHas subset with sum $target: ${subsetSum.hasSubsetWithSum(arr, target)}");
  
  var closest = subsetSum.findClosestSubsetSum(arr, 10);
  int closestSum = closest.fold(0, (sum, val) => sum + val);
  print("Closest subset to sum 10: $closest (sum = $closestSum)");
}
```

---

## 6. Word Search in Grid

**Problem**: Find if a word exists in a 2D grid of characters.

```dart
class WordSearch {
  // Directions: up, down, left, right
  static const List<List<int>> directions = [
    [-1, 0], [1, 0], [0, -1], [0, 1]
  ];
  
  // Find if word exists in grid
  bool exist(List<List<String>> board, String word) {
    if (board.isEmpty || word.isEmpty) return false;
    
    int rows = board.length;
    int cols = board[0].length;
    
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (_backtrack(board, word, row, col, 0)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  bool _backtrack(List<List<String>> board, String word, int row, int col, int index) {
    if (index == word.length) return true; // Found complete word
    
    if (row < 0 || row >= board.length || col < 0 || col >= board[0].length) {
      return false; // Out of bounds
    }
    
    if (board[row][col] != word[index]) return false; // Character mismatch
    
    // Mark cell as visited
    String temp = board[row][col];
    board[row][col] = '#';
    
    // Explore all directions
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      
      if (_backtrack(board, word, newRow, newCol, index + 1)) {
        board[row][col] = temp; // Restore before returning
        return true;
      }
    }
    
    // Restore cell (backtrack)
    board[row][col] = temp;
    return false;
  }
  
  // Find all starting positions where word can be found
  List<List<int>> findAllOccurrences(List<List<String>> board, String word) {
    List<List<int>> positions = [];
    
    if (board.isEmpty || word.isEmpty) return positions;
    
    int rows = board.length;
    int cols = board[0].length;
    
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (_backtrack(board, word, row, col, 0)) {
          positions.add([row, col]);
        }
      }
    }
    
    return positions;
  }
  
  // Find all words from a dictionary that exist in the grid
  List<String> findWords(List<List<String>> board, List<String> words) {
    List<String> result = [];
    
    for (String word in words) {
      if (exist(board, word)) {
        result.add(word);
      }
    }
    
    return result;
  }
  
  // Count total paths for a word (including overlapping)
  int countWordPaths(List<List<String>> board, String word) {
    if (board.isEmpty || word.isEmpty) return 0;
    
    int count = 0;
    int rows = board.length;
    int cols = board[0].length;
    
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        count += _countPaths(board, word, row, col, 0);
      }
    }
    
    return count;
  }
  
  int _countPaths(List<List<String>> board, String word, int row, int col, int index) {
    if (index == word.length) return 1;
    
    if (row < 0 || row >= board.length || col < 0 || col >= board[0].length) {
      return 0;
    }
    
    if (board[row][col] != word[index]) return 0;
    
    String temp = board[row][col];
    board[row][col] = '#';
    
    int paths = 0;
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      paths += _countPaths(board, word, newRow, newCol, index + 1);
    }
    
    board[row][col] = temp;
    return paths;
  }
}

// Example usage
void testWordSearch() {
  WordSearch wordSearch = WordSearch();
  
  List<List<String>> board = [
    ['A', 'B', 'C', 'E'],
    ['S', 'F', 'C', 'S'],
    ['A', 'D', 'E', 'E']
  ];
  
  print("Board:");
  for (var row in board) {
    print(row.join(' '));
  }
  
  List<String> words = ['ABCCED', 'SEE', 'ABCB', 'SEED'];
  
  for (String word in words) {
    bool found = wordSearch.exist(board, word);
    print("Word '$word': ${found ? 'Found' : 'Not found'}");
    
    if (found) {
      var positions = wordSearch.findAllOccurrences(board, word);
      print("  Starting positions: $positions");
      
      int paths = wordSearch.countWordPaths(board, word);
      print("  Total paths: $paths");
    }
  }
}
```

---

## 7. Maze Path Finding

**Problem**: Find all paths from start to end in a maze.

```dart
class MazeSolver {
  static const int WALL = 1;
  static const int PATH = 0;
  static const int VISITED = 2;
  
  // Directions: up, down, left, right
  static const List<List<int>> directions = [
    [-1, 0], [1, 0], [0, -1], [0, 1]
  ];
  
  // Find if path exists from start to end
  bool hasPath(List<List<int>> maze, List<int> start, List<int> end) {
    if (maze.isEmpty) return false;
    
    // Create a copy to avoid modifying original
    var mazeCopy = maze.map((row) => List<int>.from(row)).toList();
    return _findPath(mazeCopy, start[0], start[1], end[0], end[1]);
  }
  
  bool _findPath(List<List<int>> maze, int row, int col, int endRow, int endCol) {
    // Check bounds and validity
    if (row < 0 || row >= maze.length || col < 0 || col >= maze[0].length) {
      return false;
    }
    
    if (maze[row][col] == WALL || maze[row][col] == VISITED) {
      return false;
    }
    
    // Reached destination
    if (row == endRow && col == endCol) {
      return true;
    }
    
    // Mark as visited
    maze[row][col] = VISITED;
    
    // Try all directions
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      
      if (_findPath(maze, newRow, newCol, endRow, endCol)) {
        return true;
      }
    }
    
    // Backtrack
    maze[row][col] = PATH;
    return false;
  }
  
  // Find one path from start to end
  List<List<int>>? findPath(List<List<int>> maze, List<int> start, List<int> end) {
    if (maze.isEmpty) return null;
    
    var mazeCopy = maze.map((row) => List<int>.from(row)).toList();
    List<List<int>> path = [];
    
    if (_findPathWithTrace(mazeCopy, start[0], start[1], end[0], end[1], path)) {
      return path;
    }
    
    return null;
  }
  
  bool _findPathWithTrace(List<List<int>> maze, int row, int col, int endRow, int endCol, List<List<int>> path) {
    if (row < 0 || row >= maze.length || col < 0 || col >= maze[0].length) {
      return false;
    }
    
    if (maze[row][col] == WALL || maze[row][col] == VISITED) {
      return false;
    }
    
    // Add current position to path
    path.add([row, col]);
    
    if (row == endRow && col == endCol) {
      return true; // Found destination
    }
    
    maze[row][col] = VISITED;
    
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      
      if (_findPathWithTrace(maze, newRow, newCol, endRow, endCol, path)) {
        return true;
      }
    }
    
    // Backtrack
    path.removeLast();
    maze[row][col] = PATH;
    return false;
  }
  
  // Find all paths from start to end
  List<List<List<int>>> findAllPaths(List<List<int>> maze, List<int> start, List<int> end) {
    if (maze.isEmpty) return [];
    
    var mazeCopy = maze.map((row) => List<int>.from(row)).toList();
    List<List<List<int>>> allPaths = [];
    List<List<int>> currentPath = [];
    
    _findAllPaths(mazeCopy, start[0], start[1], end[0], end[1], currentPath, allPaths);
    return allPaths;
  }
  
  void _findAllPaths(List<List<int>> maze, int row, int col, int endRow, int endCol, 
                     List<List<int>> currentPath, List<List<List<int>>> allPaths) {
    if (row < 0 || row >= maze.length || col < 0 || col >= maze[0].length) {
      return;
    }
    
    if (maze[row][col] == WALL || maze[row][col] == VISITED) {
      return;
    }
    
    currentPath.add([row, col]);
    
    if (row == endRow && col == endCol) {
      allPaths.add(List.from(currentPath));
      currentPath.removeLast();
      return;
    }
    
    maze[row][col] = VISITED;
    
    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      
      _findAllPaths(maze, newRow, newCol, endRow, endCol, currentPath, allPaths);
    }
    
    // Backtrack
    currentPath.removeLast();
    maze[row][col] = PATH;
  }
  
  // Find shortest path using backtracking with early termination
  List<List<int>>? findShortestPath(List<List<int>> maze, List<int> start, List<int> end) {
    var allPaths = findAllPaths(maze, start, end);
    
    if (allPaths.isEmpty) return null;
    
    List<List<int>> shortest = allPaths[0];
    for (var path in allPaths) {
      if (path.length < shortest.length) {
        shortest = path;
      }
    }
    
    return shortest;
  }
  
  // Print maze with path highlighted
  void printMazeWithPath(List<List<int>> maze, List<List<int>>? path) {
    var display = maze.map((row) => List<String>.from(row.map((cell) => cell == WALL ? '█' : '.'))).toList();
    
    if (path != null) {
      for (int i = 0; i < path.length; i++) {
        int row = path[i][0];
        int col = path[i][1];
        
        if (i == 0) {
          display[row][col] = 'S'; // Start
        } else if (i == path.length - 1) {
          display[row][col] = 'E'; // End
        } else {
          display[row][col] = '*'; // Path
        }
      }
    }
    
    for (var row in display) {
      print(row.join(' '));
    }
  }
}

// Example usage
void testMazeSolver() {
  MazeSolver solver = MazeSolver();
  
  // 0 = path, 1 = wall
  List<List<int>> maze = [
    [0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0]
  ];
  
  List<int> start = [0, 0];
  List<int> end = [4, 4];
  
  print("Original Maze:");
  solver.printMazeWithPath(maze, null);
  
  print("\nHas path from $start to $end: ${solver.hasPath(maze, start, end)}");
  
  var path = solver.findPath(maze, start, end);
  if (path != null) {
    print("\nOne path found:");
    solver.printMazeWithPath(maze, path);
    print("Path length: ${path.length}");
  }
  
  var allPaths = solver.findAllPaths(maze, start, end);
  print("\nTotal paths found: ${allPaths.length}");
  
  var shortestPath = solver.findShortestPath(maze, start, end);
  if (shortestPath != null) {
    print("\nShortest path (length ${shortestPath.length}):");
    solver.printMazeWithPath(maze, shortestPath);
  }
}
```

---

## 8. Graph Coloring Problem

**Problem**: Color graph vertices such that no two adjacent vertices have the same color.

```dart
class GraphColoring {
  // Adjacency list representation of graph
  Map<int, List<int>> graph = {};
  
  // Add edge to graph
  void addEdge(int u, int v) {
    graph[u] ??= [];
    graph[v] ??= [];
    graph[u]!.add(v);
    graph[v]!.add(u);
  }
  
  // Check if coloring is possible with m colors
  bool canColor(int m) {
    if (graph.isEmpty) return true;
    
    int vertices = graph.keys.reduce((a, b) => a > b ? a : b) + 1;
    List<int> colors = List.filled(vertices, -1);
    
    return _backtrackColor(0, colors, m, vertices);
  }
  
  bool _backtrackColor(int vertex, List<int> colors, int m, int vertices) {
    if (vertex == vertices) {
      return true; // All vertices colored successfully
    }
    
    // Try all colors for current vertex
    for (int color = 0; color < m; color++) {
      if (_isSafeColor(vertex, colors, color)) {
        colors[vertex] = color; // Assign color
        
        if (_backtrackColor(vertex + 1, colors, m, vertices)) {
          return true;
        }
        
        colors[vertex] = -1; // Backtrack
      }
    }
    
    return false;
  }
  
  bool _isSafeColor(int vertex, List<int> colors, int color) {
    if (!graph.containsKey(vertex)) return true;
    
    for (int neighbor in graph[vertex]!) {
      if (colors[neighbor] == color) {
        return false; // Adjacent vertex has same color
      }
    }
    return true;
  }
  
  // Find one valid coloring
  List<int>? findColoring(int m) {
    if (graph.isEmpty) return [];
    
    int vertices = graph.keys.reduce((a, b) => a > b ? a : b) + 1;
    List<int> colors = List.filled(vertices, -1);
    
    if (_backtrackColor(0, colors, m, vertices)) {
      return colors;
    }
    
    return null;
  }
  
  // Find minimum number of colors needed (chromatic number)
  int findChromaticNumber() {
    if (graph.isEmpty) return 0;
    
    int vertices = graph.keys.reduce((a, b) => a > b ? a : b) + 1;
    
    // Try with increasing number of colors
    for (int colors = 1; colors <= vertices; colors++) {
      if (canColor(colors)) {
        return colors;
      }
    }
    
    return vertices; // Worst case: each vertex needs different color
  }
  
  // Find all possible colorings with m colors
  List<List<int>> findAllColorings(int m) {
    if (graph.isEmpty) return [[]];
    
    int vertices = graph.keys.reduce((a, b) => a > b ? a : b) + 1;
    List<List<int>> allColorings = [];
    List<int> currentColoring = List.filled(vertices, -1);
    
    _findAllColorings(0, currentColoring, m, vertices, allColorings);
    return allColorings;
  }
  
  void _findAllColorings(int vertex, List<int> colors, int m, int vertices, List<List<int>> allColorings) {
    if (vertex == vertices) {
      allColorings.add(List.from(colors));
      return;
    }
    
    for (int color = 0; color < m; color++) {
      if (_isSafeColor(vertex, colors, color)) {
        colors[vertex] = color;
        _findAllColorings(vertex + 1, colors, m, vertices, allColorings);
        colors[vertex] = -1;
      }
    }
  }
  
  // Print graph structure
  void printGraph() {
    print("Graph structure:");
    for (var vertex in graph.keys) {
      print("Vertex $vertex: ${graph[vertex]}");
    }
  }
  
  // Print coloring with color names
  void printColoring(List<int> coloring) {
    List<String> colorNames = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange', 'Pink', 'Brown'];
    
    print("Graph coloring:");
    for (int i = 0; i < coloring.length; i++) {
      if (graph.containsKey(i)) {
        String colorName = coloring[i] >= 0 && coloring[i] < colorNames.length 
            ? colorNames[coloring[i]] 
            : 'Color${coloring[i]}';
        print("Vertex $i: $colorName");
      }
    }
  }
}

// Example usage
void testGraphColoring() {
  GraphColoring gc = GraphColoring();
  
  // Create a sample graph (triangle + one additional vertex)
  gc.addEdge(0, 1);
  gc.addEdge(1, 2);
  gc.addEdge(2, 0);
  gc.addEdge(1, 3);
  
  gc.printGraph();
  
  print("\nCan color with 2 colors: ${gc.canColor(2)}");
  print("Can color with 3 colors: ${gc.canColor(3)}");
  
  int chromaticNumber = gc.findChromaticNumber();
  print("Chromatic number: $chromaticNumber");
  
  var coloring = gc.findColoring(chromaticNumber);
  if (coloring != null) {
    gc.printColoring(coloring);
  }
  
  print("\nAll possible 3-colorings:");
  var allColorings = gc.findAllColorings(3);
  for (int i = 0; i < allColorings.length && i < 5; i++) {
    print("Coloring ${i + 1}: ${allColorings[i]}");
  }
  print("Total colorings with 3 colors: ${allColorings.length}");
}
```

---

## 9. Optimization Techniques for Backtracking

### 9.1 Pruning Strategies

```dart
class BacktrackingOptimizer {
  // Early termination when solution is found
  static bool findFirstSolution<T>(
    T initialState,
    bool Function(T) isComplete,
    List<dynamic> Function(T) getChoices,
    bool Function(T, dynamic) isValid,
    void Function(T, dynamic) makeChoice,
    void Function(T, dynamic) undoChoice
  ) {
    if (isComplete(initialState)) return true;
    
    var choices = getChoices(initialState);
    for (var choice in choices) {
      if (isValid(initialState, choice)) {
        makeChoice(initialState, choice);
        
        if (findFirstSolution(initialState, isComplete, getChoices, isValid, makeChoice, undoChoice)) {
          return true;
        }
        
        undoChoice(initialState, choice);
      }
    }
    
    return false;
  }
  
  // Constraint propagation example
  static bool solveSudokuWithConstraints(List<List<int>> board) {
    // Use constraint sets to track possible values
    var constraints = _initializeConstraints(board);
    return _solveWithConstraints(board, constraints);
  }
  
  static List<List<Set<int>>> _initializeConstraints(List<List<int>> board) {
    var constraints = List.generate(9, (_) => List.generate(9, (_) => <int>{1, 2, 3, 4, 5, 6, 7, 8, 9}));
    
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] != 0) {
          _updateConstraints(constraints, row, col, board[row][col]);
        }
      }
    }
    
    return constraints;
  }
  
  static void _updateConstraints(List<List<Set<int>>> constraints, int row, int col, int value) {
    // Remove value from row, column, and box
    constraints[row][col] = {value};
    
    for (int c = 0; c < 9; c++) {
      constraints[row][c].remove(value);
    }
    
    for (int r = 0; r < 9; r++) {
      constraints[r][col].remove(value);
    }
    
    int boxRow = (row ~/ 3) * 3;
    int boxCol = (col ~/ 3) * 3;
    
    for (int r = boxRow; r < boxRow + 3; r++) {
      for (int c = boxCol; c < boxCol + 3; c++) {
        constraints[r][c].remove(value);
      }
    }
  }
  
  static bool _solveWithConstraints(List<List<int>> board, List<List<Set<int>>> constraints) {
    // Find cell with minimum remaining values (MRV heuristic)
    int minChoices = 10;
    int bestRow = -1, bestCol = -1;
    
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0 && constraints[row][col].length < minChoices) {
          minChoices = constraints[row][col].length;
          bestRow = row;
          bestCol = col;
        }
      }
    }
    
    if (bestRow == -1) return true; // Solved
    if (minChoices == 0) return false; // No valid choices
    
    var possibleValues = List.from(constraints[bestRow][bestCol]);
    
    for (int value in possibleValues) {
      // Save current constraints
      var savedConstraints = _deepCopyConstraints(constraints);
      
      board[bestRow][bestCol] = value;
      _updateConstraints(constraints, bestRow, bestCol, value);
      
      if (_solveWithConstraints(board, constraints)) {
        return true;
      }
      
      // Restore
      board[bestRow][bestCol] = 0;
      constraints = savedConstraints;
    }
    
    return false;
  }
  
  static List<List<Set<int>>> _deepCopyConstraints(List<List<Set<int>>> constraints) {
    return constraints.map((row) => row.map((cell) => Set<int>.from(cell)).toList()).toList();
  }
}
```

### 9.2 Heuristics for Better Performance

```dart
class BacktrackingHeuristics {
  // Most Constrained Variable (MCV) heuristic
  static List<int>? findMostConstrainedCell(List<List<int>> board, List<List<Set<int>>> constraints) {
    int minChoices = 10;
    List<int>? bestCell;
    
    for (int row = 0; row < board.length; row++) {
      for (int col = 0; col < board[0].length; col++) {
        if (board[row][col] == 0 && constraints[row][col].length < minChoices) {
          minChoices = constraints[row][col].length;
          bestCell = [row, col];
        }
      }
    }
    
    return bestCell;
  }
  
  // Least Constraining Value (LCV) heuristic
  static List<int> orderValuesByConstraining(List<List<int>> board, int row, int col, Set<int> values) {
    var valueConstraints = <int, int>{};
    
    for (int value in values) {
      int constraintCount = 0;
      
      // Count how many cells this value would affect
      for (int c = 0; c < board[0].length; c++) {
        if (c != col && board[row][c] == 0) constraintCount++;
      }
      
      for (int r = 0; r < board.length; r++) {
        if (r != row && board[r][col] == 0) constraintCount++;
      }
      
      valueConstraints[value] = constraintCount;
    }
    
    var sortedValues = values.toList();
    sortedValues.sort((a, b) => valueConstraints[a]!.compareTo(valueConstraints[b]!));
    
    return sortedValues;
  }
  
  // Forward checking to detect early failures
  static bool forwardCheck(List<List<Set<int>>> constraints, int row, int col, int value) {
    // Check if assignment leads to any empty domains
    for (int c = 0; c < constraints[0].length; c++) {
      if (c != col && constraints[row][c].contains(value) && constraints[row][c].length == 1) {
        return false;
      }
    }
    
    for (int r = 0; r < constraints.length; r++) {
      if (r != row && constraints[r][col].contains(value) && constraints[r][col].length == 1) {
        return false;
      }
    }
    
    return true;
  }
}
```

---

## 10. Performance Analysis and Testing

```dart
class BacktrackingAnalyzer {
  static int recursiveCalls = 0;
  static int backtracks = 0;
  static DateTime? startTime;
  
  static void resetCounters() {
    recursiveCalls = 0;
    backtracks = 0;
    startTime = DateTime.now();
  }
  
  static void incrementCalls() => recursiveCalls++;
  static void incrementBacktracks() => backtracks++;
  
  static void printStatistics(String algorithm) {
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime!);
    
    print("\n=== $algorithm Performance ===");
    print("Execution time: ${duration.inMilliseconds}ms");
    print("Recursive calls: $recursiveCalls");
    print("Backtracks: $backtracks");
    print("Success rate: ${((recursiveCalls - backtracks) / recursiveCalls * 100).toStringAsFixed(2)}%");
  }
  
  // Test framework for backtracking algorithms
  static void runPerformanceTest() {
    print("=== Backtracking Performance Tests ===\n");
    
    // Test N-Queens performance
    testNQueensPerformance();
    
    // Test Sudoku performance
    testSudokuPerformance();
    
    // Test combination generation performance
    testCombinationPerformance();
  }
  
  static void testNQueensPerformance() {
    print("N-Queens Performance Test:");
    
    for (int n = 4; n <= 10; n += 2) {
      resetCounters();
      
      NQueens solver = NQueens();
      int solutions = solver.countSolutions(n);
      
      printStatistics("N-Queens n=$n");
      print("Solutions found: $solutions\n");
    }
  }
  
  static void testSudokuPerformance() {
    print("Sudoku Performance Test:");
    
    SudokuSolver solver = SudokuSolver();
    
    // Easy puzzle
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
    
    resetCounters();
    bool solved = solver.solveSudoku(easyPuzzle);
    printStatistics("Sudoku (Easy)");
    print("Solved: $solved\n");
  }
  
  static void testCombinationPerformance() {
    print("Combination Generation Performance Test:");
    
    CombinationGenerator generator = CombinationGenerator();
    
    List<int> testSizes = [5, 8, 10];
    
    for (int n in testSizes) {
      for (int k = 2; k <= n ~/ 2; k++) {
        resetCounters();
        
        var combinations = generator.generateCombinations(List.generate(n, (i) => i), k);
        
        print("C($n, $k) = ${combinations.length} combinations");
        print("Expected: ${generator.combinationCount(n, k)}");
        
        var endTime = DateTime.now();
        var duration = endTime.difference(startTime!);
        print("Time: ${duration.inMilliseconds}ms\n");
      }
    }
  }
}
```

---

## 11. Common Backtracking Patterns

### Pattern 1: Choice and Constraint
```dart
// Template for choice-based problems
bool backtrackChoice<T, C>(
  T state,
  bool Function(T) isComplete,
  List<C> Function(T) getChoices,
  bool Function(T, C) isValid,
  void Function(T, C) makeChoice,
  void Function(T, C) undoChoice
) {
  if (isComplete(state)) return true;
  
  for (var choice in getChoices(state)) {
    if (isValid(state, choice)) {
      makeChoice(state, choice);
      
      if (backtrackChoice(state, isComplete, getChoices, isValid, makeChoice, undoChoice)) {
        return true;
      }
      
      undoChoice(state, choice);
    }
  }
  
  return false;
}
```

### Pattern 2: Grid/Matrix Exploration
```dart
// Template for grid-based problems
bool backtrackGrid(
  List<List<dynamic>> grid,
  int row,
  int col,
  bool Function(List<List<dynamic>>, int, int) isValid,
  void Function(List<List<dynamic>>, int, int) makeChoice,
  void Function(List<List<dynamic>>, int, int) undoChoice
) {
  if (row >= grid.length) return true; // Processed all rows
  
  int nextRow = col + 1 >= grid[0].length ? row + 1 : row;
  int nextCol = col + 1 >= grid[0].length ? 0 : col + 1;
  
  if (isValid(grid, row, col)) {
    makeChoice(grid, row, col);
    
    if (backtrackGrid(grid, nextRow, nextCol, isValid, makeChoice, undoChoice)) {
      return true;
    }
    
    undoChoice(grid, row, col);
  }
  
  return backtrackGrid(grid, nextRow, nextCol, isValid, makeChoice, undoChoice);
}
```

### Pattern 3: Subset Generation
```dart
// Template for subset-based problems
void backtrackSubset<T>(
  List<T> items,
  int index,
  List<T> current,
  List<List<T>> result,
  bool Function(List<T>) isValid
) {
  if (index >= items.length) {
    if (isValid(current)) {
      result.add(List.from(current));
    }
    return;
  }
  
  // Include current item
  current.add(items[index]);
  backtrackSubset(items, index + 1, current, result, isValid);
  current.removeLast();
  
  // Exclude current item
  backtrackSubset(items, index + 1, current, result, isValid);
}
```

---

## Main Example and Testing

```dart
void main() {
  print("=== Backtracking Algorithms in Dart ===\n");
  
  // Test N-Queens
  print("1. N-Queens Problem:");
  testNQueens();
  print("\n" + "="*50 + "\n");
  
  // Test Sudoku
  print("2. Sudoku Solver:");
  testSudoku();
  print("\n" + "="*50 + "\n");
  
  // Test Permutations
  print("3. Permutation Generation:");
  testPermutations();
  print("\n" + "="*50 + "\n");
  
  // Test Combinations
  print("4. Combination Generation:");
  testCombinations();
  print("\n" + "="*50 + "\n");
  
  // Test Subset Sum
  print("5. Subset Sum Problem:");
  testSubsetSum();
  print("\n" + "="*50 + "\n");
  
  // Test Word Search
  print("6. Word Search:");
  testWordSearch();
  print("\n" + "="*50 + "\n");
  
  // Test Maze Solving
  print("7. Maze Solver:");
  testMazeSolver();
  print("\n" + "="*50 + "\n");
  
  // Test Graph Coloring
  print("8. Graph Coloring:");
  testGraphColoring();
  print("\n" + "="*50 + "\n");
  
  // Performance Analysis
  print("9. Performance Analysis:");
  BacktrackingAnalyzer.runPerformanceTest();
}
```

---

## Key Takeaways

### **1. Core Principles**
- **Incremental Construction**: Build solution step by step
- **Constraint Checking**: Validate choices at each step
- **Backtracking**: Undo choices that lead to dead ends
- **Systematic Exploration**: Explore all possibilities

### **2. Optimization Strategies**
- **Pruning**: Eliminate impossible branches early
- **Heuristics**: Use smart ordering (MRV, LCV)
- **Constraint Propagation**: Reduce search space
- **Memoization**: Cache results when applicable

### **3. Common Applications**
- **Puzzle Solving**: Sudoku, N-Queens, Crosswords
- **Combinatorial Problems**: Permutations, Combinations
- **Path Finding**: Maze solving, Graph traversal
- **Constraint Satisfaction**: Graph coloring, Scheduling

### **4. Performance Considerations**
- **Time Complexity**: Often exponential, but pruning helps
- **Space Complexity**: Depends on recursion depth
- **Early Termination**: Stop when first solution found
- **Iterative Deepening**: Limit search depth

### **5. Best Practices**
- **Clear State Management**: Make/undo choices cleanly
- **Efficient Constraint Checking**: Fast validity tests
- **Smart Choice Ordering**: Try most promising first
- **Early Failure Detection**: Fail fast when possible

This comprehensive guide demonstrates how backtracking systematically explores solution spaces by making choices, checking constraints, and backtracking when necessary, making it powerful for solving complex combinatorial and constraint satisfaction problems!