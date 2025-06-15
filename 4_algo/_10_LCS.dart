/*
 * LONGEST COMMON SUBSEQUENCE (LCS) ALGORITHM IN DART
 * 
 * The Longest Common Subsequence problem is to find the longest subsequence
 * common to two sequences. A subsequence is a sequence that can be derived
 * from another sequence by deleting some or no elements without changing
 * the order of the remaining elements.
 * 
 * Time Complexity: O(m * n) where m and n are lengths of the sequences
 * Space Complexity: O(m * n) for the DP table
 * 
 * Applications:
 * - DNA sequence analysis in bioinformatics
 * - Version control systems (diff algorithms)
 * - File comparison tools
 * - Spell checkers and auto-correction
 * - Data compression algorithms
 */

void main() {
  print("=== LONGEST COMMON SUBSEQUENCE (LCS) DEMONSTRATION ===\n");
  
  // Test cases
  print("--- Basic String Examples ---");
  testLCS("ABCDGH", "AEDFHR", "String 1");
  testLCS("AGGTAB", "GXTXAYB", "String 2");
  testLCS("ABCD", "ACBDZ", "String 3");
  
  print("\n--- Edge Cases ---");
  testLCS("", "ABC", "Empty string 1");
  testLCS("ABC", "", "Empty string 2");
  testLCS("ABC", "ABC", "Identical strings");
  testLCS("ABC", "XYZ", "No common subsequence");
  testLCS("A", "A", "Single character match");
  
  print("\n--- Real-world Examples ---");
  testLCS("PROGRAMMING", "ALGORITHM", "Programming vs Algorithm");
  testLCS("COMPUTER", "SCIENCE", "Computer vs Science");
  
  print("\n--- DNA Sequence Analysis ---");
  testLCS("ATCGAT", "ACGCAT", "DNA Sequence 1");
  testLCS("GATTACA", "GATACA", "DNA Sequence 2");
  
  print("\n--- LCS with Steps Visualization ---");
  lcsWithSteps("ABCDE", "ACE");
  
  print("\n--- All LCS Solutions ---");
  findAllLCS("ABC", "AC");
  
  print("\n--- Performance Analysis ---");
  performanceAnalysis();
  
  print("\n--- LCS Applications Demo ---");
  applicationsDemo();
}

/**
 * LCS Class to encapsulate all LCS-related functionality
 */
class LCS {
  /**
   * Find the length of LCS using Dynamic Programming
   * 
   * @param text1: First string
   * @param text2: Second string
   * @return: Length of LCS
   */
  static int lcsLength(String text1, String text2) {
    int m = text1.length;
    int n = text2.length;
    
    // Create DP table
    List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    
    // Fill the DP table
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
        }
      }
    }
    
    return dp[m][n];
  }
  
  /**
   * Find the actual LCS string using Dynamic Programming
   * 
   * @param text1: First string
   * @param text2: Second string
   * @return: The LCS string
   */
  static String lcsString(String text1, String text2) {
    int m = text1.length;
    int n = text2.length;
    
    // Create DP table
    List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    
    // Fill the DP table
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
        }
      }
    }
    
    // Backtrack to find the LCS string
    StringBuffer lcs = StringBuffer();
    int i = m, j = n;
    
    while (i > 0 && j > 0) {
      if (text1[i - 1] == text2[j - 1]) {
        lcs.write(text1[i - 1]);
        i--;
        j--;
      } else if (dp[i - 1][j] > dp[i][j - 1]) {
        i--;
      } else {
        j--;
      }
    }
    
    // Reverse the string since we built it backwards
    return lcs.toString().split('').reversed.join('');
  }
  
  /**
   * Recursive solution with memoization
   */
  static int lcsRecursiveMemo(String text1, String text2) {
    Map<String, int> memo = {};
    return _lcsRecursiveHelper(text1, text2, text1.length, text2.length, memo);
  }
  
  static int _lcsRecursiveHelper(String text1, String text2, int m, int n, Map<String, int> memo) {
    String key = '$m,$n';
    
    if (memo.containsKey(key)) {
      return memo[key]!;
    }
    
    if (m == 0 || n == 0) {
      memo[key] = 0;
      return 0;
    }
    
    int result;
    if (text1[m - 1] == text2[n - 1]) {
      result = 1 + _lcsRecursiveHelper(text1, text2, m - 1, n - 1, memo);
    } else {
      int left = _lcsRecursiveHelper(text1, text2, m, n - 1, memo);
      int up = _lcsRecursiveHelper(text1, text2, m - 1, n, memo);
      result = (left > up) ? left : up;
    }
    
    memo[key] = result;
    return result;
  }
  
  /**
   * Space-optimized LCS (only stores current and previous row)
   */
  static int lcsSpaceOptimized(String text1, String text2) {
    int m = text1.length;
    int n = text2.length;
    
    // Use only two rows instead of full table
    List<int> prev = List.filled(n + 1, 0);
    List<int> curr = List.filled(n + 1, 0);
    
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          curr[j] = prev[j - 1] + 1;
        } else {
          curr[j] = (prev[j] > curr[j - 1]) ? prev[j] : curr[j - 1];
        }
      }
      
      // Swap rows
      List<int> temp = prev;
      prev = curr;
      curr = temp;
      curr.fillRange(0, curr.length, 0);
    }
    
    return prev[n];
  }
  
  /**
   * Print the DP table for visualization
   */
  static void printDPTable(String text1, String text2) {
    int m = text1.length;
    int n = text2.length;
    
    List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    
    // Fill the DP table
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
        }
      }
    }
    
    // Print header
    print("\nDP Table:");
    print("    ${' ' * 3}${text2.split('').map((c) => c.padLeft(3)).join('')}");
    
    // Print table
    for (int i = 0; i <= m; i++) {
      String rowLabel = i == 0 ? ' ' : text1[i - 1];
      String row = rowLabel.padLeft(3);
      
      for (int j = 0; j <= n; j++) {
        row += dp[i][j].toString().padLeft(3);
      }
      
      print(row);
    }
  }
  
  /**
   * Find all possible LCS strings
   */
  static Set<String> findAllLCS(String text1, String text2) {
    int m = text1.length;
    int n = text2.length;
    
    // Build DP table
    List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
        }
      }
    }
    
    // Find all LCS using backtracking
    Set<String> allLCS = {};
    _findAllLCSHelper(text1, text2, m, n, dp, '', allLCS);
    return allLCS;
  }
  
  static void _findAllLCSHelper(String text1, String text2, int i, int j, 
                               List<List<int>> dp, String current, Set<String> allLCS) {
    if (i == 0 || j == 0) {
      allLCS.add(current.split('').reversed.join(''));
      return;
    }
    
    if (text1[i - 1] == text2[j - 1]) {
      _findAllLCSHelper(text1, text2, i - 1, j - 1, dp, current + text1[i - 1], allLCS);
    } else {
      if (dp[i - 1][j] == dp[i][j]) {
        _findAllLCSHelper(text1, text2, i - 1, j, dp, current, allLCS);
      }
      if (dp[i][j - 1] == dp[i][j]) {
        _findAllLCSHelper(text1, text2, i, j - 1, dp, current, allLCS);
      }
    }
  }
}

/**
 * Test helper function
 */
void testLCS(String text1, String text2, String description) {
  print("$description:");
  print("  Text 1: \"$text1\"");
  print("  Text 2: \"$text2\"");
  
  int length = LCS.lcsLength(text1, text2);
  String lcsStr = LCS.lcsString(text1, text2);
  
  print("  LCS Length: $length");
  print("  LCS String: \"$lcsStr\"");
  
  // Verify with memoized recursive solution
  int recursiveLength = LCS.lcsRecursiveMemo(text1, text2);
  print("  Verified (recursive): ${length == recursiveLength ? '✅' : '❌'}");
  
  print("");
}

/**
 * Demonstrate LCS with step-by-step visualization
 */
void lcsWithSteps(String text1, String text2) {
  print("LCS Step-by-step for \"$text1\" and \"$text2\":");
  
  int m = text1.length;
  int n = text2.length;
  
  List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
  
  print("\nBuilding DP table step by step:");
  
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (text1[i - 1] == text2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
        print("Match found: '${text1[i - 1]}' at ($i,$j) -> dp[$i][$j] = ${dp[i][j]}");
      } else {
        dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
        print("No match at ($i,$j): max(${dp[i - 1][j]}, ${dp[i][j - 1]}) = ${dp[i][j]}");
      }
    }
  }
  
  LCS.printDPTable(text1, text2);
  
  String lcsStr = LCS.lcsString(text1, text2);
  print("\nFinal LCS: \"$lcsStr\" (Length: ${dp[m][n]})");
}

/**
 * Find and display all possible LCS solutions
 */
void findAllLCS(String text1, String text2) {
  print("Finding all LCS for \"$text1\" and \"$text2\":");
  
  Set<String> allLCS = LCS.findAllLCS(text1, text2);
  
  print("All possible LCS (${allLCS.length} solutions):");
  for (String lcs in allLCS) {
    print("  \"$lcs\"");
  }
}

/**
 * Performance analysis with different input sizes
 */
void performanceAnalysis() {
  List<Map<String, dynamic>> testCases = [
    {"size": 10, "text1": "ABCDEFGHIJ", "text2": "ACEGIKMOQS"},
    {"size": 20, "text1": "ABCDEFGHIJKLMNOPQRST", "text2": "ACEGIKMOQSUWYBDFHJLNPRTV"},
    {"size": 50, "text1": "A" * 25 + "B" * 25, "text2": "B" * 25 + "A" * 25},
  ];
  
  print("Performance Analysis:");
  print("Size | DP Time | Recursive Time | Space-Opt Time | LCS Length");
  print("-" * 65);
  
  for (var testCase in testCases) {
    String text1 = testCase["text1"];
    String text2 = testCase["text2"];
    int size = testCase["size"];
    
    // DP approach
    Stopwatch sw1 = Stopwatch()..start();
    int dpResult = LCS.lcsLength(text1, text2);
    sw1.stop();
    
    // Recursive with memoization
    Stopwatch sw2 = Stopwatch()..start();
    int recResult = LCS.lcsRecursiveMemo(text1, text2);
    sw2.stop();
    
    // Space optimized
    Stopwatch sw3 = Stopwatch()..start();
    int spaceOptResult = LCS.lcsSpaceOptimized(text1, text2);
    sw3.stop();
    
    print("${size.toString().padLeft(4)} | "
          "${sw1.elapsedMicroseconds.toString().padLeft(7)}μs | "
          "${sw2.elapsedMicroseconds.toString().padLeft(14)}μs | "
          "${sw3.elapsedMicroseconds.toString().padLeft(14)}μs | "
          "${dpResult.toString().padLeft(10)}");
  }
}

/**
 * Demonstrate real-world applications of LCS
 */
void applicationsDemo() {
  print("=== LCS APPLICATIONS DEMONSTRATION ===\n");
  
  // 1. Version Control (Diff)
  print("1. Version Control Diff:");
  String oldCode = "int x = 5; print(x);";
  String newCode = "int y = 5; y++; print(y);";
  demonstrateDiff(oldCode, newCode);
  
  // 2. DNA Sequence Analysis
  print("\n2. DNA Sequence Analysis:");
  String dna1 = "ATCGATCGATCG";
  String dna2 = "ATCGTTCGATCG";
  demonstrateDNAAnalysis(dna1, dna2);
  
  // 3. Spell Checking
  print("\n3. Spell Checking:");
  String misspelled = "recieve";
  String correct = "receive";
  demonstrateSpellCheck(misspelled, correct);
}

void demonstrateDiff(String oldCode, String newCode) {
  String lcs = LCS.lcsString(oldCode, newCode);
  
  print("  Old: \"$oldCode\"");
  print("  New: \"$newCode\"");
  print("  Common: \"$lcs\"");
  print("  Similarity: ${(lcs.length / (oldCode.length > newCode.length ? oldCode.length : newCode.length) * 100).toStringAsFixed(1)}%");
}

void demonstrateDNAAnalysis(String dna1, String dna2) {
  String lcs = LCS.lcsString(dna1, dna2);
  
  print("  DNA 1: \"$dna1\"");
  print("  DNA 2: \"$dna2\"");
  print("  Common subsequence: \"$lcs\"");
  print("  Conservation rate: ${(lcs.length / (dna1.length > dna2.length ? dna1.length : dna2.length) * 100).toStringAsFixed(1)}%");
}

void demonstrateSpellCheck(String misspelled, String correct) {
  String lcs = LCS.lcsString(misspelled, correct);
  
  print("  Misspelled: \"$misspelled\"");
  print("  Correct: \"$correct\"");
  print("  Common letters: \"$lcs\"");
  print("  Similarity: ${(lcs.length / (misspelled.length > correct.length ? misspelled.length : correct.length) * 100).toStringAsFixed(1)}%");
}

/**
 * LCS ALGORITHM SUMMARY:
 * 
 * PROBLEM DEFINITION:
 * Given two sequences, find the longest subsequence present in both.
 * A subsequence maintains relative order but elements need not be contiguous.
 * 
 * ALGORITHM APPROACHES:
 * 1. Dynamic Programming (Bottom-up): O(mn) time, O(mn) space
 * 2. Recursive with Memoization (Top-down): O(mn) time, O(mn) space
 * 3. Space Optimized: O(mn) time, O(min(m,n)) space
 * 
 * RECURRENCE RELATION:
 * LCS(i, j) = {
 *   0                           if i = 0 or j = 0
 *   LCS(i-1, j-1) + 1          if text1[i-1] = text2[j-1]
 *   max(LCS(i-1, j), LCS(i, j-1))  otherwise
 * }
 * 
 * APPLICATIONS:
 * - Bioinformatics: DNA/protein sequence alignment
 * - Version control: Computing file differences
 * - Data mining: Finding patterns in sequences
 * - Spell checking: Measuring string similarity
 * - Plagiarism detection: Document comparison
 * - Data compression: Finding repeated patterns
 * 
 * VARIANTS:
 * - Longest Common Substring (contiguous)
 * - Edit Distance (Levenshtein distance)
 * - Shortest Common Supersequence
 * - Longest Increasing Subsequence
 */