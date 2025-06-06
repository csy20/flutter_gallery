void main() {
  print('=== KADANE\'S ALGORITHM IN DART ===\n');
  
  // ========== WHAT IS KADANE'S ALGORITHM? ==========
  print('KADANE\'S ALGORITHM:');
  print('- Finds the maximum sum of a contiguous subarray');
  print('- Time Complexity: O(n)');
  print('- Space Complexity: O(1)');
  print('- Dynamic Programming approach');
  print('- Named after Joseph Born Kadane\n');
  
  // ========== BASIC IMPLEMENTATION ==========
  print('1. BASIC KADANE\'S ALGORITHM:');
  List<int> arr1 = [-2, -3, 4, -1, -2, 1, 5, -3];
  print('Array: $arr1');
  
  int maxSum = kadaneBasic(arr1);
  print('Maximum subarray sum: $maxSum');
  print('Expected: 7 (subarray [4, -1, -2, 1, 5])\n');
  
  // ========== DETAILED STEP-BY-STEP IMPLEMENTATION ==========
  print('2. STEP-BY-STEP KADANE\'S ALGORITHM:');
  List<int> arr2 = [1, -3, 2, 1, -1];
  print('Array: $arr2');
  kadaneDetailed(arr2);
  print('');
  
  // ========== KADANE'S WITH SUBARRAY INDICES ==========
  print('3. KADANE\'S WITH SUBARRAY INDICES:');
  List<int> arr3 = [-2, 1, -3, 4, -1, 2, 1, -5, 4];
  print('Array: $arr3');
  
  KadaneResult result = kadaneWithIndices(arr3);
  print('Maximum sum: ${result.maxSum}');
  print('Start index: ${result.startIndex}');
  print('End index: ${result.endIndex}');
  print('Subarray: ${arr3.sublist(result.startIndex, result.endIndex + 1)}');
  print('');
  
  // ========== HANDLING ALL NEGATIVE NUMBERS ==========
  print('4. HANDLING ALL NEGATIVE NUMBERS:');
  List<int> allNegative = [-5, -2, -8, -1, -4];
  print('Array: $allNegative');
  
  int maxSumNegative = kadaneAllNegative(allNegative);
  print('Maximum subarray sum: $maxSumNegative');
  print('(Returns the least negative number)\n');
  
  // ========== KADANE'S ALGORITHM VARIATIONS ==========
  print('5. KADANE\'S ALGORITHM VARIATIONS:');
  
  // Maximum Product Subarray
  List<int> productArray = [2, 3, -2, 4];
  print('Array for max product: $productArray');
  int maxProduct = maxProductSubarray(productArray);
  print('Maximum product subarray: $maxProduct\n');
  
  // Circular Array Maximum Sum
  List<int> circularArray = [1, -2, 3, -2];
  print('Circular array: $circularArray');
  int circularMaxSum = maxCircularSubarraySum(circularArray);
  print('Maximum circular subarray sum: $circularMaxSum\n');
  
  // ========== MULTIPLE TEST CASES ==========
  print('6. MULTIPLE TEST CASES:');
  
  List<List<int>> testCases = [
    [1, 2, 3, 4, 5],              // All positive
    [-1, -2, -3, -4, -5],         // All negative
    [5, -3, 5],                   // Mixed
    [1, -1, 1, -1, 1],            // Alternating
    [10, -5, 3, -2, 8, -1],       // Complex case
    [0, 0, 0, 0],                 // All zeros
    [100],                        // Single element
    [],                           // Empty array
  ];
  
  for (int i = 0; i < testCases.length; i++) {
    List<int> testArray = testCases[i];
    print('Test ${i + 1}: $testArray');
    
    if (testArray.isEmpty) {
      print('  Result: 0 (empty array)');
    } else {
      KadaneResult testResult = kadaneWithIndices(testArray);
      print('  Max sum: ${testResult.maxSum}');
      if (testResult.startIndex != -1) {
        print('  Subarray: ${testArray.sublist(testResult.startIndex, testResult.endIndex + 1)}');
      }
    }
    print('');
  }
  
  // ========== PERFORMANCE COMPARISON ==========
  print('7. PERFORMANCE COMPARISON:');
  
  // Generate large test arrays
  List<int> sizes = [1000, 10000, 100000];
  
  for (int size in sizes) {
    List<int> largeArray = generateTestArray(size);
    
    // Time Kadane's algorithm
    Stopwatch stopwatch = Stopwatch()..start();
    int result = kadaneBasic(largeArray);
    stopwatch.stop();
    
    print('Array size: $size');
    print('Kadane\'s result: $result');
    print('Time taken: ${stopwatch.elapsedMicroseconds} microseconds');
    
    // Compare with brute force for smaller arrays
    if (size <= 1000) {
      stopwatch.reset();
      stopwatch.start();
      int bruteForceResult = maxSubarrayBruteForce(largeArray);
      stopwatch.stop();
      
      print('Brute force result: $bruteForceResult');
      print('Brute force time: ${stopwatch.elapsedMicroseconds} microseconds');
      print('Results match: ${result == bruteForceResult}');
    }
    print('');
  }
  
  // ========== REAL-WORLD APPLICATIONS ==========
  print('8. REAL-WORLD APPLICATIONS:');
  
  // Stock profit maximization
  List<int> stockPrices = [7, 1, 5, 3, 6, 4];
  print('Stock prices: $stockPrices');
  
  List<int> dailyChanges = [];
  for (int i = 1; i < stockPrices.length; i++) {
    dailyChanges.add(stockPrices[i] - stockPrices[i - 1]);
  }
  print('Daily changes: $dailyChanges');
  
  KadaneResult stockResult = kadaneWithIndices(dailyChanges);
  print('Maximum profit period: ${stockResult.maxSum}');
  print('Buy day: ${stockResult.startIndex + 1}, Sell day: ${stockResult.endIndex + 2}');
  print('');
  
  // Temperature analysis
  List<int> temperatureChanges = [2, -1, 3, -2, 1, -1, 4, -3];
  print('Temperature changes: $temperatureChanges');
  
  KadaneResult tempResult = kadaneWithIndices(temperatureChanges);
  print('Best consecutive warming period: ${tempResult.maxSum}°');
  print('Period: days ${tempResult.startIndex + 1} to ${tempResult.endIndex + 1}');
}

// ========== BASIC KADANE'S ALGORITHM ==========
int kadaneBasic(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  int maxSoFar = arr[0];
  int maxEndingHere = arr[0];
  
  for (int i = 1; i < arr.length; i++) {
    // Either extend the existing subarray or start a new one
    maxEndingHere = maxEndingHere + arr[i] > arr[i] ? maxEndingHere + arr[i] : arr[i];
    
    // Update the maximum sum found so far
    maxSoFar = maxSoFar > maxEndingHere ? maxSoFar : maxEndingHere;
  }
  
  return maxSoFar;
}

// ========== DETAILED STEP-BY-STEP KADANE'S ==========
void kadaneDetailed(List<int> arr) {
  if (arr.isEmpty) {
    print('Empty array');
    return;
  }
  
  int maxSoFar = arr[0];
  int maxEndingHere = arr[0];
  
  print('Step-by-step execution:');
  print('i=0: arr[0]=${arr[0]}, maxEndingHere=$maxEndingHere, maxSoFar=$maxSoFar');
  
  for (int i = 1; i < arr.length; i++) {
    int oldMaxEndingHere = maxEndingHere;
    
    // Either extend existing subarray or start new one
    maxEndingHere = maxEndingHere + arr[i] > arr[i] ? maxEndingHere + arr[i] : arr[i];
    
    // Update maximum sum found so far
    maxSoFar = maxSoFar > maxEndingHere ? maxSoFar : maxEndingHere;
    
    String decision = oldMaxEndingHere + arr[i] > arr[i] ? 'extend' : 'start new';
    print('i=$i: arr[$i]=${arr[i]}, decision=$decision, maxEndingHere=$maxEndingHere, maxSoFar=$maxSoFar');
  }
  
  print('Final maximum subarray sum: $maxSoFar');
}

// ========== RESULT CLASS FOR DETAILED INFORMATION ==========
class KadaneResult {
  final int maxSum;
  final int startIndex;
  final int endIndex;
  
  KadaneResult(this.maxSum, this.startIndex, this.endIndex);
}

// ========== KADANE'S WITH SUBARRAY INDICES ==========
KadaneResult kadaneWithIndices(List<int> arr) {
  if (arr.isEmpty) return KadaneResult(0, -1, -1);
  
  int maxSoFar = arr[0];
  int maxEndingHere = arr[0];
  int start = 0;
  int end = 0;
  int tempStart = 0;
  
  for (int i = 1; i < arr.length; i++) {
    if (maxEndingHere + arr[i] > arr[i]) {
      maxEndingHere = maxEndingHere + arr[i];
    } else {
      maxEndingHere = arr[i];
      tempStart = i; // New subarray starts here
    }
    
    if (maxEndingHere > maxSoFar) {
      maxSoFar = maxEndingHere;
      start = tempStart;
      end = i;
    }
  }
  
  return KadaneResult(maxSoFar, start, end);
}

// ========== KADANE'S FOR ALL NEGATIVE NUMBERS ==========
int kadaneAllNegative(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  // For all negative numbers, return the maximum (least negative) element
  int maxElement = arr[0];
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] > maxElement) {
      maxElement = arr[i];
    }
  }
  
  return maxElement;
}

// ========== MAXIMUM PRODUCT SUBARRAY ==========
int maxProductSubarray(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  int maxProduct = arr[0];
  int minProduct = arr[0];
  int result = arr[0];
  
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] < 0) {
      // Swap max and min when we encounter a negative number
      int temp = maxProduct;
      maxProduct = minProduct;
      minProduct = temp;
    }
    
    maxProduct = maxProduct * arr[i] > arr[i] ? maxProduct * arr[i] : arr[i];
    minProduct = minProduct * arr[i] < arr[i] ? minProduct * arr[i] : arr[i];
    
    result = result > maxProduct ? result : maxProduct;
  }
  
  return result;
}

// ========== CIRCULAR ARRAY MAXIMUM SUM ==========
int maxCircularSubarraySum(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  // Case 1: Maximum subarray is non-circular (normal Kadane's)
  int normalMax = kadaneBasic(arr);
  
  // Case 2: Maximum subarray is circular
  // This equals total sum - minimum subarray sum
  int totalSum = arr.reduce((a, b) => a + b);
  
  // Find minimum subarray sum by negating all elements and finding max
  List<int> negatedArr = arr.map((x) => -x).toList();
  int maxOfNegated = kadaneBasic(negatedArr);
  int circularMax = totalSum - (-maxOfNegated);
  
  // Handle the case where all elements are negative
  if (circularMax == 0) return normalMax;
  
  return normalMax > circularMax ? normalMax : circularMax;
}

// ========== BRUTE FORCE APPROACH (FOR COMPARISON) ==========
int maxSubarrayBruteForce(List<int> arr) {
  if (arr.isEmpty) return 0;
  
  int maxSum = arr[0];
  
  for (int i = 0; i < arr.length; i++) {
    int currentSum = 0;
    for (int j = i; j < arr.length; j++) {
      currentSum += arr[j];
      maxSum = maxSum > currentSum ? maxSum : currentSum;
    }
  }
  
  return maxSum;
}

// ========== UTILITY FUNCTIONS ==========

// Generate test array with random values
List<int> generateTestArray(int size) {
  List<int> arr = [];
  var seed = DateTime.now().millisecondsSinceEpoch;
  
  for (int i = 0; i < size; i++) {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff;
    arr.add((seed % 201) - 100); // Random numbers between -100 and 100
  }
  
  return arr;
}