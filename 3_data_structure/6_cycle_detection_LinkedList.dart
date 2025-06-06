void main() {
  print('=== CYCLE DETECTION IN LINKED LISTS (DART) ===\n');
  
  // ========== WHAT IS CYCLE DETECTION? ==========
  print('CYCLE DETECTION CONCEPT:');
  print('- A cycle in a linked list occurs when a node points back to a previous node');
  print('- This creates an infinite loop during traversal');
  print('- Common in interview questions and real-world debugging');
  print('- Multiple algorithms available with different trade-offs');
  print('- Floyd\'s Cycle Detection (Tortoise and Hare) is most popular\n');
  
  // ========== FLOYD'S CYCLE DETECTION ALGORITHM ==========
  print('1. FLOYD\'S CYCLE DETECTION (TORTOISE AND HARE):');
  
  // Create a linked list without cycle
  LinkedList noCycleList = LinkedList();
  noCycleList.append(1);
  noCycleList.append(2);
  noCycleList.append(3);
  noCycleList.append(4);
  noCycleList.append(5);
  
  print('List without cycle: ${noCycleList.display()}');
  print('Has cycle (Floyd\'s): ${noCycleList.hasCycleFloyd()}');
  print('Has cycle (HashSet): ${noCycleList.hasCycleHashSet()}');
  print('Has cycle (Marking): ${noCycleList.hasCycleMarking()}\n');
  
  // Create a linked list with cycle
  LinkedList cycleList = LinkedList();
  cycleList.append(1);
  cycleList.append(2);
  cycleList.append(3);
  cycleList.append(4);
  cycleList.append(5);
  cycleList.createCycle(2); // Create cycle from tail to index 2
  
  print('List with cycle (tail connects to index 2):');
  print('Has cycle (Floyd\'s): ${cycleList.hasCycleFloyd()}');
  print('Has cycle (HashSet): ${cycleList.hasCycleHashSet()}');
  print('Has cycle (Marking): ${cycleList.hasCycleMarking()}');
  
  // Find cycle start and length
  CycleInfo? cycleInfo = cycleList.findCycleInfo();
  if (cycleInfo != null) {
    print('Cycle start node value: ${cycleInfo.startNode?.data}');
    print('Cycle length: ${cycleInfo.length}');
  }
  print('');
  
  // ========== DETAILED ALGORITHM EXPLANATION ==========
  print('2. DETAILED ALGORITHM EXPLANATIONS:');
  
  print('FLOYD\'S ALGORITHM STEP-BY-STEP:');
  LinkedList detailedList = LinkedList();
  [10, 20, 30, 40, 50, 60].forEach(detailedList.append);
  detailedList.createCycle(2); // Cycle from tail to index 2 (value 30)
  
  detailedList.hasCycleFloydDetailed();
  print('');
  
  // ========== CYCLE DETECTION VARIATIONS ==========
  print('3. CYCLE DETECTION VARIATIONS:');
  
  // Test different cycle positions
  List<int> cyclePositions = [0, 1, 2, 3, 4, -1]; // -1 means no cycle
  
  for (int pos in cyclePositions) {
    LinkedList testList = LinkedList();
    [1, 2, 3, 4, 5].forEach(testList.append);
    
    if (pos >= 0) {
      testList.createCycle(pos);
      print('Cycle at position $pos:');
    } else {
      print('No cycle:');
    }
    
    bool hasCycle = testList.hasCycleFloyd();
    print('  Has cycle: $hasCycle');
    
    if (hasCycle) {
      CycleInfo? info = testList.findCycleInfo();
      if (info != null) {
        print('  Cycle start: ${info.startNode?.data}');
        print('  Cycle length: ${info.length}');
      }
    }
    print('');
  }
  
  // ========== PERFORMANCE COMPARISON ==========
  print('4. PERFORMANCE COMPARISON:');
  
  // Test with larger lists
  List<int> sizes = [1000, 5000, 10000];
  
  for (int size in sizes) {
    LinkedList largeList = LinkedList();
    
    // Create large list
    for (int i = 1; i <= size; i++) {
      largeList.append(i);
    }
    largeList.createCycle(size ~/ 2); // Cycle in middle
    
    print('List size: $size');
    
    // Test Floyd's algorithm
    Stopwatch stopwatch = Stopwatch()..start();
    bool floydResult = largeList.hasCycleFloyd();
    stopwatch.stop();
    print('  Floyd\'s algorithm: ${stopwatch.elapsedMicroseconds} μs, result: $floydResult');
    
    // Test HashSet algorithm
    stopwatch.reset();
    stopwatch.start();
    bool hashSetResult = largeList.hasCycleHashSet();
    stopwatch.stop();
    print('  HashSet algorithm: ${stopwatch.elapsedMicroseconds} μs, result: $hashSetResult');
    
    print('');
  }
  
  // ========== ADVANCED CYCLE OPERATIONS ==========
  print('5. ADVANCED CYCLE OPERATIONS:');
  
  LinkedList advancedList = LinkedList();
  [100, 200, 300, 400, 500, 600, 700].forEach(advancedList.append);
  advancedList.createCycle(3); // Cycle from tail to index 3 (value 400)
  
  print('Advanced operations on cyclic list:');
  
  // Find all nodes in cycle
  List<Node> cycleNodes = advancedList.getNodesInCycle();
  print('Nodes in cycle: ${cycleNodes.map((n) => n.data).toList()}');
  
  // Check if a specific value is in cycle
  print('Is 400 in cycle: ${advancedList.isValueInCycle(400)}');
  print('Is 200 in cycle: ${advancedList.isValueInCycle(200)}');
  
  // Get distance from head to cycle start
  int distance = advancedList.distanceToGycleStart();
  print('Distance from head to cycle start: $distance');
  
  // Remove cycle (if possible)
  bool removed = advancedList.removeCycle();
  print('Cycle removed: $removed');
  print('Has cycle after removal: ${advancedList.hasCycleFloyd()}');
  print('');
  
  // ========== REAL-WORLD APPLICATIONS ==========
  print('6. REAL-WORLD APPLICATIONS:');
  
  // Dependency Resolution
  DependencyGraph depGraph = DependencyGraph();
  print('Dependency Graph Cycle Detection:');
  
  depGraph.addDependency('A', 'B');
  depGraph.addDependency('B', 'C');
  depGraph.addDependency('C', 'D');
  print('Dependencies: A->B->C->D');
  print('Has circular dependency: ${depGraph.hasCircularDependency()}');
  
  depGraph.addDependency('D', 'A'); // Create cycle
  print('Added D->A (creates cycle)');
  print('Has circular dependency: ${depGraph.hasCircularDependency()}');
  
  List<String>? cycle = depGraph.findCircularDependency();
  if (cycle != null) {
    print('Circular dependency path: ${cycle.join(' -> ')}');
  }
  print('');
  
  // Memory Leak Detection Simulation
  MemoryLeakDetector leakDetector = MemoryLeakDetector();
  print('Memory Leak Detection:');
  
  leakDetector.createObject('Object1');
  leakDetector.createObject('Object2');
  leakDetector.createObject('Object3');
  leakDetector.addReference('Object1', 'Object2');
  leakDetector.addReference('Object2', 'Object3');
  
  print('References: Object1->Object2->Object3');
  print('Has memory leak: ${leakDetector.hasMemoryLeak()}');
  
  leakDetector.addReference('Object3', 'Object1'); // Create cycle
  print('Added Object3->Object1 (creates cycle)');
  print('Has memory leak: ${leakDetector.hasMemoryLeak()}');
  
  // ========== MATHEMATICAL APPLICATIONS ==========
  print('7. MATHEMATICAL APPLICATIONS:');
  
  // Floyd's Cycle Detection in sequences
  print('SEQUENCE CYCLE DETECTION:');
  
  // Example: Finding cycle in f(x) = (x² + 1) mod n
  int startValue = 2;
  int modulus = 13;
  
  SequenceCycleDetector seqDetector = SequenceCycleDetector();
  CycleResult result = seqDetector.findCycleInSequence(startValue, modulus);
  
  print('Sequence f(x) = (x² + 1) mod $modulus, starting with $startValue');
  print('Cycle start position: ${result.cycleStart}');
  print('Cycle length: ${result.cycleLength}');
  print('Sequence: ${result.sequence.take(15).join(', ')}...');
  
  // ========== ERROR HANDLING AND EDGE CASES ==========
  print('\n8. ERROR HANDLING AND EDGE CASES:');
  
  // Empty list
  LinkedList emptyList = LinkedList();
  print('Empty list has cycle: ${emptyList.hasCycleFloyd()}');
  
  // Single node
  LinkedList singleList = LinkedList();
  singleList.append(42);
  print('Single node list has cycle: ${singleList.hasCycleFloyd()}');
  
  // Single node with self-loop
  LinkedList selfLoopList = LinkedList();
  selfLoopList.append(42);
  selfLoopList.createCycle(0);
  print('Single node self-loop has cycle: ${selfLoopList.hasCycleFloyd()}');
  
  // Two nodes with cycle
  LinkedList twoNodeCycle = LinkedList();
  twoNodeCycle.append(1);
  twoNodeCycle.append(2);
  twoNodeCycle.createCycle(0);
  print('Two node cycle has cycle: ${twoNodeCycle.hasCycleFloyd()}');
}

// ========== NODE CLASS ==========
class Node {
  int data;
  Node? next;
  bool visited = false; // For marking algorithm
  
  Node(this.data);
  
  @override
  String toString() => 'Node($data)';
}

// ========== CYCLE INFO CLASS ==========
class CycleInfo {
  Node? startNode;
  int length;
  
  CycleInfo(this.startNode, this.length);
}

// ========== LINKED LIST CLASS ==========
class LinkedList {
  Node? head;
  
  // Append element to list
  void append(int data) {
    Node newNode = Node(data);
    
    if (head == null) {
      head = newNode;
      return;
    }
    
    Node current = head!;
    while (current.next != null) {
      current = current.next!;
    }
    current.next = newNode;
  }
  
  // Create cycle by connecting tail to node at given index
  void createCycle(int index) {
    if (head == null) return;
    
    Node? nodeAtIndex = getNodeAtIndex(index);
    if (nodeAtIndex == null) return;
    
    Node current = head!;
    while (current.next != null) {
      current = current.next!;
    }
    current.next = nodeAtIndex; // Create cycle
  }
  
  // Get node at specific index
  Node? getNodeAtIndex(int index) {
    Node? current = head;
    int count = 0;
    
    while (current != null && count < index) {
      current = current.next;
      count++;
    }
    
    return current;
  }
  
  // Display list (only works for non-cyclic lists)
  String display() {
    if (head == null) return 'Empty list';
    
    List<int> values = [];
    Node? current = head;
    Set<Node> visited = {};
    
    while (current != null && !visited.contains(current)) {
      visited.add(current);
      values.add(current.data);
      current = current.next;
    }
    
    if (current != null) {
      values.add(current.data);
      return '${values.join(' -> ')} -> [CYCLE DETECTED]';
    }
    
    return values.join(' -> ');
  }
  
  // ========== FLOYD'S CYCLE DETECTION ALGORITHM ==========
  bool hasCycleFloyd() {
    if (head == null) return false;
    
    Node slow = head!;
    Node fast = head!;
    
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
      
      if (slow == fast) {
        return true; // Cycle detected
      }
    }
    
    return false; // No cycle
  }
  
  // Floyd's algorithm with detailed steps
  bool hasCycleFloydDetailed() {
    if (head == null) {
      print('Empty list - no cycle');
      return false;
    }
    
    Node slow = head!;
    Node fast = head!;
    int step = 0;
    
    print('Starting Floyd\'s algorithm:');
    print('Step $step: slow=${slow.data}, fast=${fast.data}');
    
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
      step++;
      
      print('Step $step: slow=${slow.data}, fast=${fast.data}');
      
      if (slow == fast) {
        print('CYCLE DETECTED: Pointers met at node ${slow.data}');
        return true;
      }
    }
    
    print('No cycle detected - fast pointer reached end');
    return false;
  }
  
  // ========== HASHSET CYCLE DETECTION ==========
  bool hasCycleHashSet() {
    if (head == null) return false;
    
    Set<Node> visitedNodes = {};
    Node? current = head;
    
    while (current != null) {
      if (visitedNodes.contains(current)) {
        return true; // Cycle detected
      }
      visitedNodes.add(current);
      current = current.next;
    }
    
    return false; // No cycle
  }
  
  // ========== MARKING CYCLE DETECTION ==========
  bool hasCycleMarking() {
    if (head == null) return false;
    
    // Reset all visited flags first
    Node? current = head;
    Set<Node> allNodes = {};
    
    // Collect all reachable nodes and reset flags
    while (current != null && !allNodes.contains(current)) {
      allNodes.add(current);
      current.visited = false;
      current = current.next;
    }
    
    // Now check for cycle using marking
    current = head;
    while (current != null) {
      if (current.visited) {
        return true; // Cycle detected
      }
      current.visited = true;
      current = current.next;
    }
    
    return false; // No cycle
  }
  
  // ========== FIND CYCLE START AND LENGTH ==========
  CycleInfo? findCycleInfo() {
    if (!hasCycleFloyd()) return null;
    
    Node slow = head!;
    Node fast = head!;
    
    // Phase 1: Detect cycle
    while (fast.next != null && fast.next!.next != null) {
      slow = slow.next!;
      fast = fast.next!.next!;
      
      if (slow == fast) break;
    }
    
    // Phase 2: Find cycle start
    slow = head!;
    while (slow != fast) {
      slow = slow.next!;
      fast = fast.next!;
    }
    
    Node cycleStart = slow;
    
    // Phase 3: Find cycle length
    int length = 1;
    Node current = cycleStart.next!;
    while (current != cycleStart) {
      current = current.next!;
      length++;
    }
    
    return CycleInfo(cycleStart, length);
  }
  
  // ========== ADVANCED CYCLE OPERATIONS ==========
  
  // Get all nodes that are part of the cycle
  List<Node> getNodesInCycle() {
    CycleInfo? info = findCycleInfo();
    if (info == null) return [];
    
    List<Node> cycleNodes = [];
    Node current = info.startNode!;
    
    do {
      cycleNodes.add(current);
      current = current.next!;
    } while (current != info.startNode);
    
    return cycleNodes;
  }
  
  // Check if a specific value is part of the cycle
  bool isValueInCycle(int value) {
    List<Node> cycleNodes = getNodesInCycle();
    return cycleNodes.any((node) => node.data == value);
  }
  
  // Get distance from head to cycle start
  int distanceToGycleStart() {
    CycleInfo? info = findCycleInfo();
    if (info == null) return -1;
    
    int distance = 0;
    Node current = head!;
    
    while (current != info.startNode) {
      current = current.next!;
      distance++;
    }
    
    return distance;
  }
  
  // Remove cycle by breaking the link
  bool removeCycle() {
    CycleInfo? info = findCycleInfo();
    if (info == null) return false;
    
    Node current = info.startNode!;
    
    // Find the node that points back to cycle start
    while (current.next != info.startNode) {
      current = current.next!;
    }
    
    current.next = null; // Break the cycle
    return true;
  }
}

// ========== DEPENDENCY GRAPH FOR REAL-WORLD APPLICATION ==========
class DependencyGraph {
  Map<String, List<String>> _graph = {};
  
  void addDependency(String from, String to) {
    _graph.putIfAbsent(from, () => []).add(to);
  }
  
  bool hasCircularDependency() {
    Set<String> visited = {};
    Set<String> inPath = {};
    
    for (String node in _graph.keys) {
      if (!visited.contains(node)) {
        if (_hasCycleDFS(node, visited, inPath)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  bool _hasCycleDFS(String node, Set<String> visited, Set<String> inPath) {
    visited.add(node);
    inPath.add(node);
    
    List<String> neighbors = _graph[node] ?? [];
    for (String neighbor in neighbors) {
      if (inPath.contains(neighbor)) {
        return true; // Back edge found (cycle)
      }
      
      if (!visited.contains(neighbor) && 
          _hasCycleDFS(neighbor, visited, inPath)) {
        return true;
      }
    }
    
    inPath.remove(node);
    return false;
  }
  
  List<String>? findCircularDependency() {
    Set<String> visited = {};
    Set<String> inPath = {};
    List<String> path = [];
    
    for (String node in _graph.keys) {
      if (!visited.contains(node)) {
        List<String>? cycle = _findCycleDFS(node, visited, inPath, path);
        if (cycle != null) return cycle;
      }
    }
    
    return null;
  }
  
  List<String>? _findCycleDFS(String node, Set<String> visited, 
                              Set<String> inPath, List<String> path) {
    visited.add(node);
    inPath.add(node);
    path.add(node);
    
    List<String> neighbors = _graph[node] ?? [];
    for (String neighbor in neighbors) {
      if (inPath.contains(neighbor)) {
        // Found cycle, return path from cycle start
        int cycleStart = path.indexOf(neighbor);
        return path.sublist(cycleStart) + [neighbor];
      }
      
      if (!visited.contains(neighbor)) {
        List<String>? cycle = _findCycleDFS(neighbor, visited, inPath, path);
        if (cycle != null) return cycle;
      }
    }
    
    inPath.remove(node);
    path.removeLast();
    return null;
  }
}

// ========== MEMORY LEAK DETECTOR ==========
class MemoryLeakDetector {
  Map<String, List<String>> _references = {};
  
  void createObject(String objectId) {
    _references[objectId] = [];
  }
  
  void addReference(String from, String to) {
    _references.putIfAbsent(from, () => []).add(to);
  }
  
  bool hasMemoryLeak() {
    Set<String> visited = {};
    Set<String> inPath = {};
    
    for (String object in _references.keys) {
      if (!visited.contains(object)) {
        if (_hasLeakDFS(object, visited, inPath)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  bool _hasLeakDFS(String object, Set<String> visited, Set<String> inPath) {
    visited.add(object);
    inPath.add(object);
    
    List<String> refs = _references[object] ?? [];
    for (String ref in refs) {
      if (inPath.contains(ref)) {
        return true; // Circular reference found
      }
      
      if (!visited.contains(ref) && _hasLeakDFS(ref, visited, inPath)) {
        return true;
      }
    }
    
    inPath.remove(object);
    return false;
  }
}

// ========== SEQUENCE CYCLE DETECTOR ==========
class CycleResult {
  int cycleStart;
  int cycleLength;
  List<int> sequence;
  
  CycleResult(this.cycleStart, this.cycleLength, this.sequence);
}

class SequenceCycleDetector {
  CycleResult findCycleInSequence(int startValue, int modulus) {
    List<int> sequence = [startValue];
    int slow = startValue;
    int fast = startValue;
    
    // Phase 1: Detect cycle using Floyd's algorithm
    do {
      slow = _nextValue(slow, modulus);
      fast = _nextValue(_nextValue(fast, modulus), modulus);
      sequence.add(slow);
    } while (slow != fast);
    
    // Phase 2: Find cycle start
    slow = startValue;
    int cycleStart = 0;
    
    while (slow != fast) {
      slow = _nextValue(slow, modulus);
      fast = _nextValue(fast, modulus);
      cycleStart++;
    }
    
    // Phase 3: Find cycle length
    int cycleLength = 1;
    fast = _nextValue(slow, modulus);
    
    while (slow != fast) {
      fast = _nextValue(fast, modulus);
      cycleLength++;
    }
    
    return CycleResult(cycleStart, cycleLength, sequence);
  }
  
  int _nextValue(int x, int modulus) {
    return (x * x + 1) % modulus;
  }
}