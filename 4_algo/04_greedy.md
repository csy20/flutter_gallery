# Greedy Algorithms in Dart

## Introduction to Greedy Algorithms

Greedy algorithms are a class of algorithms that make the locally optimal choice at each step, hoping to find a global optimum. The greedy approach builds up a solution piece by piece, always choosing the next piece that offers the most immediate benefit.

### Key Characteristics:
- **Local Optimization**: Makes the best choice at each step
- **No Backtracking**: Once a choice is made, it's never reconsidered
- **Myopic Approach**: Only considers current state, not future consequences
- **Efficiency**: Usually runs in polynomial time
- **Not Always Optimal**: May not always produce the globally optimal solution

### When Greedy Works:
1. **Greedy Choice Property**: A globally optimal solution can be arrived at by making locally optimal choices
2. **Optimal Substructure**: An optimal solution contains optimal solutions to subproblems

---

## 1. Activity Selection Problem

Select the maximum number of activities that don't overlap in time.

**Problem**: Given n activities with start and finish times, select maximum number of non-overlapping activities.

**Greedy Strategy**: Always pick the activity that finishes earliest.

```dart
// Activity class to represent each activity
class Activity {
  int start;
  int finish;
  int id;
  
  Activity(this.id, this.start, this.finish);
  
  @override
  String toString() => 'Activity $id: [$start, $finish]';
}

// Activity Selection using Greedy Algorithm
List<Activity> activitySelection(List<Activity> activities) {
  if (activities.isEmpty) return [];
  
  // Sort activities by finish time (greedy choice)
  List<Activity> sortedActivities = List.from(activities);
  sortedActivities.sort((a, b) => a.finish.compareTo(b.finish));
  
  List<Activity> selectedActivities = [];
  selectedActivities.add(sortedActivities[0]); // Always select first activity
  
  int lastFinishTime = sortedActivities[0].finish;
  
  // Greedily select activities
  for (int i = 1; i < sortedActivities.length; i++) {
    if (sortedActivities[i].start >= lastFinishTime) {
      selectedActivities.add(sortedActivities[i]);
      lastFinishTime = sortedActivities[i].finish;
    }
  }
  
  return selectedActivities;
}

// Example usage
void activitySelectionExample() {
  List<Activity> activities = [
    Activity(1, 1, 4),
    Activity(2, 3, 5),
    Activity(3, 0, 6),
    Activity(4, 5, 7),
    Activity(5, 3, 9),
    Activity(6, 5, 9),
    Activity(7, 6, 10),
    Activity(8, 8, 11),
    Activity(9, 8, 12),
    Activity(10, 2, 14),
    Activity(11, 12, 16),
  ];
  
  print('All activities:');
  for (var activity in activities) {
    print(activity);
  }
  
  List<Activity> selected = activitySelection(activities);
  
  print('\nSelected activities (maximum non-overlapping):');
  for (var activity in selected) {
    print(activity);
  }
  
  print('\nTotal selected: ${selected.length}');
  
  print('\nGreedy Strategy:');
  print('1. Sort activities by finish time');
  print('2. Always select the activity that finishes earliest');
  print('3. This leaves maximum room for future activities');
}
```

---

## 2. Fractional Knapsack Problem

Maximize value in a knapsack where items can be broken into fractions.

**Problem**: Given weights and values of items, fill knapsack to maximize value (items can be fractioned).

**Greedy Strategy**: Sort items by value-to-weight ratio, take highest ratio items first.

```dart
// Item class for knapsack
class Item {
  double weight;
  double value;
  String name;
  
  Item(this.name, this.weight, this.value);
  
  double get valuePerWeight => value / weight;
  
  @override
  String toString() => '$name: weight=$weight, value=$value, ratio=${valuePerWeight.toStringAsFixed(2)}';
}

// Fractional Knapsack using Greedy Algorithm
class KnapsackResult {
  double totalValue;
  List<String> itemsSelected;
  
  KnapsackResult(this.totalValue, this.itemsSelected);
  
  @override
  String toString() => 'Total Value: $totalValue, Items: ${itemsSelected.join(", ")}';
}

KnapsackResult fractionalKnapsack(List<Item> items, double capacity) {
  // Sort items by value-to-weight ratio in descending order
  List<Item> sortedItems = List.from(items);
  sortedItems.sort((a, b) => b.valuePerWeight.compareTo(a.valuePerWeight));
  
  double totalValue = 0.0;
  double remainingCapacity = capacity;
  List<String> selectedItems = [];
  
  for (Item item in sortedItems) {
    if (remainingCapacity >= item.weight) {
      // Take the whole item
      totalValue += item.value;
      remainingCapacity -= item.weight;
      selectedItems.add('${item.name} (full)');
    } else if (remainingCapacity > 0) {
      // Take fraction of the item
      double fraction = remainingCapacity / item.weight;
      totalValue += item.value * fraction;
      selectedItems.add('${item.name} (${(fraction * 100).toStringAsFixed(1)}%)');
      remainingCapacity = 0;
      break;
    }
  }
  
  return KnapsackResult(totalValue, selectedItems);
}

// Example usage
void fractionalKnapsackExample() {
  List<Item> items = [
    Item('Diamond', 1, 100),
    Item('Gold', 3, 90),
    Item('Silver', 2, 40),
    Item('Bronze', 4, 30),
    Item('Iron', 5, 20),
  ];
  
  double knapsackCapacity = 7.0;
  
  print('Available items:');
  for (var item in items) {
    print(item);
  }
  
  KnapsackResult result = fractionalKnapsack(items, knapsackCapacity);
  
  print('\nKnapsack capacity: $knapsackCapacity');
  print('Result: $result');
  
  print('\nGreedy Strategy:');
  print('1. Calculate value-to-weight ratio for each item');
  print('2. Sort items by ratio in descending order');
  print('3. Take items with highest ratio first');
  print('4. If item doesn\'t fit completely, take fractional part');
}
```

---

## 3. Coin Change Problem (Greedy Approach)

Make change for a given amount using minimum number of coins.

**Problem**: Given coin denominations and target amount, find minimum coins needed.

**Greedy Strategy**: Always use the largest denomination possible.

**Note**: This works for standard coin systems but may not be optimal for all denominations.

```dart
// Coin Change using Greedy Algorithm
class CoinChangeResult {
  int totalCoins;
  Map<int, int> coinsUsed;
  bool isOptimal;
  
  CoinChangeResult(this.totalCoins, this.coinsUsed, this.isOptimal);
  
  @override
  String toString() {
    String result = 'Total coins: $totalCoins\n';
    result += 'Coins used: ';
    coinsUsed.forEach((denomination, count) {
      result += '$count×$denomination ';
    });
    result += '\nOptimal: $isOptimal';
    return result;
  }
}

CoinChangeResult greedyCoinChange(List<int> denominations, int amount) {
  // Sort denominations in descending order
  List<int> sortedDenominations = List.from(denominations);
  sortedDenominations.sort((a, b) => b.compareTo(a));
  
  Map<int, int> coinsUsed = {};
  int remainingAmount = amount;
  int totalCoins = 0;
  
  for (int denomination in sortedDenominations) {
    if (remainingAmount >= denomination) {
      int count = remainingAmount ~/ denomination;
      coinsUsed[denomination] = count;
      totalCoins += count;
      remainingAmount %= denomination;
    }
  }
  
  // Check if solution is possible
  bool isPossible = remainingAmount == 0;
  bool isOptimal = _isOptimalCoinSystem(denominations);
  
  if (!isPossible) {
    return CoinChangeResult(-1, {}, false);
  }
  
  return CoinChangeResult(totalCoins, coinsUsed, isOptimal);
}

// Helper function to check if coin system allows optimal greedy solution
bool _isOptimalCoinSystem(List<int> denominations) {
  // For standard systems like [1, 5, 10, 25] greedy is optimal
  // This is a simplified check
  return denominations.contains(1);
}

// Dynamic Programming solution for comparison
int coinChangeDP(List<int> denominations, int amount) {
  List<int> dp = List.filled(amount + 1, amount + 1);
  dp[0] = 0;
  
  for (int i = 1; i <= amount; i++) {
    for (int coin in denominations) {
      if (coin <= i) {
        dp[i] = dp[i] < dp[i - coin] + 1 ? dp[i] : dp[i - coin] + 1;
      }
    }
  }
  
  return dp[amount] > amount ? -1 : dp[amount];
}

// Example usage
void coinChangeExample() {
  List<int> standardCoins = [1, 5, 10, 25]; // US coins
  List<int> nonStandardCoins = [1, 3, 4]; // Non-standard system
  int amount = 30;
  
  print('=== STANDARD COIN SYSTEM ===');
  print('Denominations: $standardCoins');
  print('Amount: $amount');
  
  CoinChangeResult greedyResult = greedyCoinChange(standardCoins, amount);
  print('\nGreedy solution:');
  print(greedyResult);
  
  int dpResult = coinChangeDP(standardCoins, amount);
  print('DP solution: $dpResult coins');
  
  print('\n=== NON-STANDARD COIN SYSTEM ===');
  print('Denominations: $nonStandardCoins');
  amount = 6;
  print('Amount: $amount');
  
  CoinChangeResult greedyResult2 = greedyCoinChange(nonStandardCoins, amount);
  print('\nGreedy solution:');
  print(greedyResult2);
  
  int dpResult2 = coinChangeDP(nonStandardCoins, amount);
  print('DP solution: $dpResult2 coins');
  
  print('\nNote: Greedy may not be optimal for non-standard coin systems!');
}
```

---

## 4. Huffman Coding

Build optimal prefix-free codes for data compression.

**Problem**: Given character frequencies, build optimal binary codes.

**Greedy Strategy**: Always merge two nodes with smallest frequencies.

```dart
// Node class for Huffman Tree
class HuffmanNode {
  String? character;
  int frequency;
  HuffmanNode? left;
  HuffmanNode? right;
  
  HuffmanNode(this.character, this.frequency, [this.left, this.right]);
  
  bool get isLeaf => left == null && right == null;
  
  @override
  String toString() => character ?? 'Internal($frequency)';
}

// Priority Queue implementation for Huffman coding
class PriorityQueue<T> {
  List<T> _heap = [];
  int Function(T, T) _compare;
  
  PriorityQueue(this._compare);
  
  void add(T element) {
    _heap.add(element);
    _bubbleUp(_heap.length - 1);
  }
  
  T removeFirst() {
    if (_heap.isEmpty) throw StateError('Queue is empty');
    
    T first = _heap[0];
    T last = _heap.removeLast();
    
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    
    return first;
  }
  
  bool get isEmpty => _heap.isEmpty;
  int get length => _heap.length;
  
  void _bubbleUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (_compare(_heap[index], _heap[parentIndex]) >= 0) break;
      
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }
  
  void _bubbleDown(int index) {
    while (true) {
      int leftChild = 2 * index + 1;
      int rightChild = 2 * index + 2;
      int smallest = index;
      
      if (leftChild < _heap.length && 
          _compare(_heap[leftChild], _heap[smallest]) < 0) {
        smallest = leftChild;
      }
      
      if (rightChild < _heap.length && 
          _compare(_heap[rightChild], _heap[smallest]) < 0) {
        smallest = rightChild;
      }
      
      if (smallest == index) break;
      
      _swap(index, smallest);
      index = smallest;
    }
  }
  
  void _swap(int i, int j) {
    T temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }
}

// Huffman Coding implementation
class HuffmanCoding {
  Map<String, String> codes = {};
  HuffmanNode? root;
  
  // Build Huffman Tree using greedy algorithm
  void buildTree(Map<String, int> frequencies) {
    if (frequencies.isEmpty) return;
    
    // Create priority queue with nodes sorted by frequency
    PriorityQueue<HuffmanNode> pq = PriorityQueue<HuffmanNode>(
      (a, b) => a.frequency.compareTo(b.frequency)
    );
    
    // Add all characters as leaf nodes
    frequencies.forEach((char, freq) {
      pq.add(HuffmanNode(char, freq));
    });
    
    // Build tree by merging nodes greedily
    while (pq.length > 1) {
      HuffmanNode left = pq.removeFirst();
      HuffmanNode right = pq.removeFirst();
      
      // Create internal node with combined frequency
      HuffmanNode merged = HuffmanNode(
        null, 
        left.frequency + right.frequency,
        left,
        right
      );
      
      pq.add(merged);
    }
    
    root = pq.removeFirst();
    _generateCodes(root!, '');
  }
  
  // Generate binary codes for each character
  void _generateCodes(HuffmanNode node, String code) {
    if (node.isLeaf) {
      codes[node.character!] = code.isEmpty ? '0' : code;
      return;
    }
    
    if (node.left != null) {
      _generateCodes(node.left!, code + '0');
    }
    
    if (node.right != null) {
      _generateCodes(node.right!, code + '1');
    }
  }
  
  // Encode text using generated codes
  String encode(String text) {
    StringBuffer encoded = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (codes.containsKey(char)) {
        encoded.write(codes[char]);
      }
    }
    return encoded.toString();
  }
  
  // Decode binary string using tree
  String decode(String encoded) {
    if (root == null) return '';
    
    StringBuffer decoded = StringBuffer();
    HuffmanNode current = root!;
    
    for (int i = 0; i < encoded.length; i++) {
      if (encoded[i] == '0') {
        current = current.left!;
      } else {
        current = current.right!;
      }
      
      if (current.isLeaf) {
        decoded.write(current.character);
        current = root!;
      }
    }
    
    return decoded.toString();
  }
  
  // Calculate compression ratio
  double compressionRatio(String original, String encoded) {
    int originalBits = original.length * 8; // ASCII = 8 bits per character
    int encodedBits = encoded.length;
    return encodedBits / originalBits;
  }
}

// Example usage
void huffmanCodingExample() {
  String text = "ABRACADABRA";
  
  // Count character frequencies
  Map<String, int> frequencies = {};
  for (int i = 0; i < text.length; i++) {
    String char = text[i];
    frequencies[char] = (frequencies[char] ?? 0) + 1;
  }
  
  print('Original text: $text');
  print('Character frequencies: $frequencies');
  
  // Build Huffman tree and generate codes
  HuffmanCoding huffman = HuffmanCoding();
  huffman.buildTree(frequencies);
  
  print('\nHuffman codes:');
  huffman.codes.forEach((char, code) {
    print('$char: $code');
  });
  
  // Encode and decode
  String encoded = huffman.encode(text);
  String decoded = huffman.decode(encoded);
  
  print('\nEncoded: $encoded');
  print('Decoded: $decoded');
  print('Correct: ${text == decoded}');
  
  // Calculate compression
  double ratio = huffman.compressionRatio(text, encoded);
  print('\nCompression ratio: ${(ratio * 100).toStringAsFixed(1)}%');
  print('Space saved: ${((1 - ratio) * 100).toStringAsFixed(1)}%');
  
  print('\nGreedy Strategy:');
  print('1. Create leaf nodes for each character with frequency');
  print('2. Always merge two nodes with smallest frequencies');
  print('3. Continue until only one node remains (root)');
  print('4. Generate codes by traversing tree (0=left, 1=right)');
}
```

---

## 5. Job Scheduling Problem

Schedule jobs to minimize waiting time or maximize profit.

**Problem**: Given jobs with deadlines and profits, schedule to maximize profit.

**Greedy Strategy**: Sort jobs by profit and schedule if deadline allows.

```dart
// Job class
class Job {
  String id;
  int deadline;
  int profit;
  
  Job(this.id, this.deadline, this.profit);
  
  @override
  String toString() => 'Job $id: deadline=$deadline, profit=$profit';
}

// Job Scheduling Result
class JobSchedulingResult {
  List<Job> scheduledJobs;
  int totalProfit;
  List<String> schedule;
  
  JobSchedulingResult(this.scheduledJobs, this.totalProfit, this.schedule);
  
  @override
  String toString() {
    return 'Scheduled ${scheduledJobs.length} jobs\n'
           'Total profit: $totalProfit\n'
           'Schedule: ${schedule.join(" → ")}';
  }
}

// Job Scheduling using Greedy Algorithm
JobSchedulingResult jobScheduling(List<Job> jobs) {
  // Sort jobs by profit in descending order
  List<Job> sortedJobs = List.from(jobs);
  sortedJobs.sort((a, b) => b.profit.compareTo(a.profit));
  
  // Find maximum deadline
  int maxDeadline = jobs.map((job) => job.deadline).reduce((a, b) => a > b ? a : b);
  
  // Create schedule array
  List<Job?> schedule = List.filled(maxDeadline, null);
  List<Job> scheduledJobs = [];
  int totalProfit = 0;
  
  // Schedule jobs greedily
  for (Job job in sortedJobs) {
    // Find latest available slot before deadline
    for (int slot = job.deadline - 1; slot >= 0; slot--) {
      if (schedule[slot] == null) {
        schedule[slot] = job;
        scheduledJobs.add(job);
        totalProfit += job.profit;
        break;
      }
    }
  }
  
  // Create readable schedule
  List<String> scheduleStr = [];
  for (int i = 0; i < schedule.length; i++) {
    if (schedule[i] != null) {
      scheduleStr.add('T${i + 1}:${schedule[i]!.id}');
    } else {
      scheduleStr.add('T${i + 1}:Free');
    }
  }
  
  return JobSchedulingResult(scheduledJobs, totalProfit, scheduleStr);
}

// Example usage
void jobSchedulingExample() {
  List<Job> jobs = [
    Job('A', 2, 100),
    Job('B', 1, 19),
    Job('C', 2, 27),
    Job('D', 1, 25),
    Job('E', 3, 15),
  ];
  
  print('Available jobs:');
  for (var job in jobs) {
    print(job);
  }
  
  JobSchedulingResult result = jobScheduling(jobs);
  print('\nOptimal schedule:');
  print(result);
  
  print('\nGreedy Strategy:');
  print('1. Sort jobs by profit in descending order');
  print('2. For each job, find latest available slot before deadline');
  print('3. If slot available, schedule the job');
  print('4. This maximizes profit while meeting deadlines');
}
```

---

## 6. Minimum Spanning Tree (Kruskal's Algorithm)

Find minimum cost to connect all vertices in a graph.

**Problem**: Given weighted graph, find minimum spanning tree.

**Greedy Strategy**: Always add cheapest edge that doesn't create cycle.

```dart
// Edge class for graph
class Edge {
  int source;
  int destination;
  int weight;
  
  Edge(this.source, this.destination, this.weight);
  
  @override
  String toString() => '($source-$destination: $weight)';
}

// Union-Find (Disjoint Set) for cycle detection
class UnionFind {
  List<int> parent;
  List<int> rank;
  
  UnionFind(int n) : 
    parent = List.generate(n, (i) => i),
    rank = List.filled(n, 0);
  
  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]); // Path compression
    }
    return parent[x];
  }
  
  bool union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    
    if (rootX == rootY) return false; // Already connected (would create cycle)
    
    // Union by rank
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      parent[rootY] = rootX;
      rank[rootX]++;
    }
    
    return true;
  }
}

// Kruskal's Algorithm for Minimum Spanning Tree
class MST {
  List<Edge> edges;
  int totalWeight;
  
  MST(this.edges, this.totalWeight);
  
  @override
  String toString() {
    String result = 'MST Edges: ${edges.join(", ")}\n';
    result += 'Total Weight: $totalWeight';
    return result;
  }
}

MST kruskalMST(int vertices, List<Edge> edges) {
  // Sort edges by weight (greedy choice)
  List<Edge> sortedEdges = List.from(edges);
  sortedEdges.sort((a, b) => a.weight.compareTo(b.weight));
  
  UnionFind uf = UnionFind(vertices);
  List<Edge> mstEdges = [];
  int totalWeight = 0;
  
  // Process edges in order of increasing weight
  for (Edge edge in sortedEdges) {
    if (uf.union(edge.source, edge.destination)) {
      mstEdges.add(edge);
      totalWeight += edge.weight;
      
      // Stop when we have V-1 edges (complete MST)
      if (mstEdges.length == vertices - 1) {
        break;
      }
    }
  }
  
  return MST(mstEdges, totalWeight);
}

// Example usage
void kruskalExample() {
  int vertices = 4;
  List<Edge> edges = [
    Edge(0, 1, 10),
    Edge(0, 2, 6),
    Edge(0, 3, 5),
    Edge(1, 3, 15),
    Edge(2, 3, 4),
  ];
  
  print('Graph with $vertices vertices:');
  print('Edges: ${edges.join(", ")}');
  
  MST result = kruskalMST(vertices, edges);
  print('\nMinimum Spanning Tree:');
  print(result);
  
  print('\nGreedy Strategy (Kruskal\'s):');
  print('1. Sort all edges by weight in ascending order');
  print('2. For each edge, add to MST if it doesn\'t create cycle');
  print('3. Use Union-Find to efficiently detect cycles');
  print('4. Stop when MST has V-1 edges');
}
```

---

## 7. Dijkstra's Shortest Path Algorithm

Find shortest paths from source to all other vertices.

**Problem**: Given weighted graph, find shortest path from source.

**Greedy Strategy**: Always explore the closest unvisited vertex.

```dart
// Graph representation using adjacency list
class Graph {
  int vertices;
  List<List<Edge>> adjacencyList;
  
  Graph(this.vertices) : adjacencyList = List.generate(vertices, (_) => []);
  
  void addEdge(int source, int destination, int weight) {
    adjacencyList[source].add(Edge(source, destination, weight));
  }
  
  void addUndirectedEdge(int vertex1, int vertex2, int weight) {
    addEdge(vertex1, vertex2, weight);
    addEdge(vertex2, vertex1, weight);
  }
}

// Dijkstra's Algorithm Result
class DijkstraResult {
  List<int> distances;
  List<int?> previous;
  
  DijkstraResult(this.distances, this.previous);
  
  List<int> getPath(int destination) {
    List<int> path = [];
    int? current = destination;
    
    while (current != null) {
      path.add(current);
      current = previous[current];
    }
    
    return path.reversed.toList();
  }
  
  @override
  String toString() {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < distances.length; i++) {
      result.writeln('Vertex $i: distance=${distances[i]}, path=${getPath(i)}');
    }
    return result.toString();
  }
}

// Dijkstra's Algorithm implementation
DijkstraResult dijkstra(Graph graph, int source) {
  int vertices = graph.vertices;
  List<int> distances = List.filled(vertices, double.maxFinite.toInt());
  List<int?> previous = List.filled(vertices, null);
  List<bool> visited = List.filled(vertices, false);
  
  distances[source] = 0;
  
  for (int count = 0; count < vertices; count++) {
    // Find minimum distance vertex (greedy choice)
    int u = _findMinDistance(distances, visited);
    if (u == -1) break; // No more reachable vertices
    
    visited[u] = true;
    
    // Update distances to neighbors
    for (Edge edge in graph.adjacencyList[u]) {
      int v = edge.destination;
      int weight = edge.weight;
      
      if (!visited[v] && distances[u] + weight < distances[v]) {
        distances[v] = distances[u] + weight;
        previous[v] = u;
      }
    }
  }
  
  return DijkstraResult(distances, previous);
}

// Helper function to find minimum distance vertex
int _findMinDistance(List<int> distances, List<bool> visited) {
  int minDistance = double.maxFinite.toInt();
  int minIndex = -1;
  
  for (int v = 0; v < distances.length; v++) {
    if (!visited[v] && distances[v] < minDistance) {
      minDistance = distances[v];
      minIndex = v;
    }
  }
  
  return minIndex;
}

// Example usage
void dijkstraExample() {
  Graph graph = Graph(6);
  
  // Add edges to create a weighted graph
  graph.addUndirectedEdge(0, 1, 4);
  graph.addUndirectedEdge(0, 2, 3);
  graph.addUndirectedEdge(1, 2, 1);
  graph.addUndirectedEdge(1, 3, 2);
  graph.addUndirectedEdge(2, 3, 4);
  graph.addUndirectedEdge(3, 4, 2);
  graph.addUndirectedEdge(4, 5, 6);
  
  int source = 0;
  print('Graph with ${graph.vertices} vertices');
  print('Source vertex: $source');
  
  DijkstraResult result = dijkstra(graph, source);
  
  print('\nShortest paths from vertex $source:');
  print(result);
  
  print('Greedy Strategy (Dijkstra\'s):');
  print('1. Start with source vertex (distance = 0)');
  print('2. Always select unvisited vertex with minimum distance');
  print('3. Update distances to all neighbors');
  print('4. Mark current vertex as visited');
  print('5. Repeat until all vertices processed');
}
```

---

## 8. Load Balancing Problem

Distribute tasks among processors to minimize maximum load.

**Problem**: Assign jobs to machines to minimize maximum completion time.

**Greedy Strategy**: Always assign job to machine with current minimum load.

```dart
// Machine class to track load
class Machine {
  int id;
  int currentLoad;
  List<int> assignedJobs;
  
  Machine(this.id) : currentLoad = 0, assignedJobs = [];
  
  void assignJob(int jobTime) {
    currentLoad += jobTime;
    assignedJobs.add(jobTime);
  }
  
  @override
  String toString() => 'Machine $id: load=$currentLoad, jobs=$assignedJobs';
}

// Load Balancing Result
class LoadBalancingResult {
  List<Machine> machines;
  int makespan;
  
  LoadBalancingResult(this.machines, this.makespan);
  
  @override
  String toString() {
    StringBuffer result = StringBuffer();
    result.writeln('Load balancing result:');
    for (var machine in machines) {
      result.writeln(machine);
    }
    result.writeln('Makespan (max load): $makespan');
    return result.toString();
  }
}

// Greedy Load Balancing
LoadBalancingResult greedyLoadBalancing(List<int> jobs, int numMachines) {
  List<Machine> machines = List.generate(numMachines, (i) => Machine(i));
  
  // Assign each job to machine with minimum current load
  for (int job in jobs) {
    // Find machine with minimum load (greedy choice)
    Machine minMachine = machines.reduce((a, b) => 
      a.currentLoad < b.currentLoad ? a : b
    );
    
    minMachine.assignJob(job);
  }
  
  // Calculate makespan (maximum load)
  int makespan = machines.map((m) => m.currentLoad).reduce((a, b) => a > b ? a : b);
  
  return LoadBalancingResult(machines, makespan);
}

// Optimal load balancing using sorted jobs (better greedy)
LoadBalancingResult improvedLoadBalancing(List<int> jobs, int numMachines) {
  // Sort jobs in descending order (larger jobs first)
  List<int> sortedJobs = List.from(jobs);
  sortedJobs.sort((a, b) => b.compareTo(a));
  
  return greedyLoadBalancing(sortedJobs, numMachines);
}

// Example usage
void loadBalancingExample() {
  List<int> jobs = [7, 5, 4, 4, 3, 3, 2, 1];
  int numMachines = 3;
  
  print('Jobs to schedule: $jobs');
  print('Number of machines: $numMachines');
  
  print('\n=== SIMPLE GREEDY ===');
  LoadBalancingResult simpleResult = greedyLoadBalancing(jobs, numMachines);
  print(simpleResult);
  
  print('=== IMPROVED GREEDY (sorted jobs) ===');
  LoadBalancingResult improvedResult = improvedLoadBalancing(jobs, numMachines);
  print(improvedResult);
  
  print('Greedy Strategy:');
  print('1. Always assign job to machine with minimum current load');
  print('2. Improvement: Sort jobs in descending order first');
  print('3. This gives better approximation to optimal solution');
  
  // Calculate lower bound for comparison
  int totalWork = jobs.reduce((a, b) => a + b);
  int lowerBound = (totalWork / numMachines).ceil();
  print('\nLower bound (total work / machines): $lowerBound');
}
```

---

## 9. Interval Scheduling Maximization

Select maximum number of non-overlapping intervals.

**Problem**: Given intervals with start and end times, select maximum non-overlapping set.

**Greedy Strategy**: Sort by end time, always pick earliest ending interval.

```dart
// Interval class
class Interval {
  int start;
  int end;
  String? label;
  
  Interval(this.start, this.end, [this.label]);
  
  bool overlapsWith(Interval other) {
    return start < other.end && other.start < end;
  }
  
  @override
  String toString() => '${label ?? ""}[$start, $end]';
}

// Interval Scheduling using Greedy Algorithm
List<Interval> intervalScheduling(List<Interval> intervals) {
  if (intervals.isEmpty) return [];
  
  // Sort intervals by end time (greedy choice)
  List<Interval> sortedIntervals = List.from(intervals);
  sortedIntervals.sort((a, b) => a.end.compareTo(b.end));
  
  List<Interval> selected = [];
  selected.add(sortedIntervals[0]);
  
  int lastEndTime = sortedIntervals[0].end;
  
  for (int i = 1; i < sortedIntervals.length; i++) {
    if (sortedIntervals[i].start >= lastEndTime) {
      selected.add(sortedIntervals[i]);
      lastEndTime = sortedIntervals[i].end;
    }
  }
  
  return selected;
}

// Weighted Interval Scheduling (requires dynamic programming for optimal)
class WeightedInterval extends Interval {
  int weight;
  
  WeightedInterval(int start, int end, this.weight, [String? label]) 
    : super(start, end, label);
  
  @override
  String toString() => '${label ?? ""}[$start, $end]:$weight';
}

// Greedy approach for weighted intervals (may not be optimal)
List<WeightedInterval> greedyWeightedScheduling(List<WeightedInterval> intervals) {
  if (intervals.isEmpty) return [];
  
  // Sort by weight/duration ratio (greedy heuristic)
  List<WeightedInterval> sortedIntervals = List.from(intervals);
  sortedIntervals.sort((a, b) {
    double ratioA = a.weight / (a.end - a.start);
    double ratioB = b.weight / (b.end - b.start);
    return ratioB.compareTo(ratioA);
  });
  
  List<WeightedInterval> selected = [];
  
  for (WeightedInterval interval in sortedIntervals) {
    bool canSchedule = true;
    
    for (WeightedInterval scheduled in selected) {
      if (interval.overlapsWith(scheduled)) {
        canSchedule = false;
        break;
      }
    }
    
    if (canSchedule) {
      selected.add(interval);
    }
  }
  
  return selected;
}

// Example usage
void intervalSchedulingExample() {
  List<Interval> intervals = [
    Interval(1, 3, 'A'),
    Interval(2, 5, 'B'),
    Interval(4, 6, 'C'),
    Interval(6, 7, 'D'),
    Interval(5, 8, 'E'),
    Interval(7, 9, 'F'),
  ];
  
  print('All intervals:');
  for (var interval in intervals) {
    print(interval);
  }
  
  List<Interval> selected = intervalScheduling(intervals);
  
  print('\nSelected intervals (maximum non-overlapping):');
  for (var interval in selected) {
    print(interval);
  }
  
  print('\n=== WEIGHTED INTERVALS ===');
  List<WeightedInterval> weightedIntervals = [
    WeightedInterval(1, 3, 50, 'A'),
    WeightedInterval(2, 5, 20, 'B'),
    WeightedInterval(4, 6, 30, 'C'),
    WeightedInterval(6, 7, 40, 'D'),
    WeightedInterval(5, 8, 10, 'E'),
  ];
  
  print('Weighted intervals:');
  for (var interval in weightedIntervals) {
    print(interval);
  }
  
  List<WeightedInterval> weightedSelected = greedyWeightedScheduling(weightedIntervals);
  int totalWeight = weightedSelected.fold(0, (sum, interval) => sum + interval.weight);
  
  print('\nGreedy weighted selection:');
  for (var interval in weightedSelected) {
    print(interval);
  }
  print('Total weight: $totalWeight');
  
  print('\nNote: For weighted intervals, greedy may not be optimal!');
  print('Dynamic programming is needed for optimal weighted scheduling.');
}
```

---

## 10. Analysis and Comparison of Greedy Algorithms

```dart
// Greedy Algorithm Analysis Framework
class GreedyAnalyzer {
  static void analyzeComplexity() {
    print('=== GREEDY ALGORITHM COMPLEXITY ANALYSIS ===\n');
    
    Map<String, Map<String, String>> algorithms = {
      'Activity Selection': {
        'Time': 'O(n log n)',
        'Space': 'O(1)',
        'Optimal': 'Yes',
        'Strategy': 'Earliest finish time'
      },
      'Fractional Knapsack': {
        'Time': 'O(n log n)',
        'Space': 'O(1)',
        'Optimal': 'Yes',
        'Strategy': 'Highest value/weight ratio'
      },
      'Coin Change': {
        'Time': 'O(n)',
        'Space': 'O(1)',
        'Optimal': 'Only for canonical systems',
        'Strategy': 'Largest denomination first'
      },
      'Huffman Coding': {
        'Time': 'O(n log n)',
        'Space': 'O(n)',
        'Optimal': 'Yes',
        'Strategy': 'Merge smallest frequencies'
      },
      'Job Scheduling': {
        'Time': 'O(n log n)',
        'Space': 'O(n)',
        'Optimal': 'Yes',
        'Strategy': 'Highest profit first'
      },
      'Kruskal MST': {
        'Time': 'O(E log E)',
        'Space': 'O(V)',
        'Optimal': 'Yes',
        'Strategy': 'Smallest weight edge'
      },
      'Dijkstra': {
        'Time': 'O(V²) or O(E log V)',
        'Space': 'O(V)',
        'Optimal': 'Yes (non-negative weights)',
        'Strategy': 'Closest unvisited vertex'
      },
    };
    
    algorithms.forEach((name, props) {
      print('$name:');
      props.forEach((property, value) {
        print('  $property: $value');
      });
      print('');
    });
  }
  
  static void demonstrateGreedyFailure() {
    print('=== WHEN GREEDY FAILS ===\n');
    
    // 0/1 Knapsack example where greedy fails
    print('0/1 Knapsack Problem:');
    print('Items: [weight, value]');
    print('Item 1: [10, 60]  ratio: 6.0');
    print('Item 2: [20, 100] ratio: 5.0');
    print('Item 3: [30, 120] ratio: 4.0');
    print('Capacity: 50');
    print('');
    print('Greedy (by ratio): Takes Item 1 (weight 10, value 60)');
    print('                   Cannot fit Item 2 or 3');
    print('                   Total value: 60');
    print('');
    print('Optimal: Takes Item 2 + Item 3 (weight 50, value 220)');
    print('         Total value: 220');
    print('');
    print('Greedy fails because items cannot be fractioned!');
  }
  
  static void greedyVsDynamicProgramming() {
    print('\n=== GREEDY vs DYNAMIC PROGRAMMING ===\n');
    
    print('Greedy Algorithms:');
    print('✓ Make locally optimal choices');
    print('✓ No backtracking');
    print('✓ Usually faster (polynomial time)');
    print('✓ Less memory usage');
    print('✗ May not find global optimum');
    print('✗ Limited to problems with greedy choice property');
    
    print('\nDynamic Programming:');
    print('✓ Guarantees optimal solution');
    print('✓ Handles overlapping subproblems');
    print('✓ Works for broader class of problems');
    print('✗ Higher time complexity');
    print('✗ More memory usage');
    print('✗ Complex implementation');
    
    print('\nWhen to use Greedy:');
    print('• Problem has greedy choice property');
    print('• Optimal substructure exists');
    print('• Performance is critical');
    print('• Simple implementation desired');
  }
}

// Performance testing framework
class PerformanceTester {
  static void testActivitySelection() {
    print('\n=== PERFORMANCE TEST: Activity Selection ===');
    
    List<int> sizes = [100, 1000, 10000];
    
    for (int size in sizes) {
      List<Activity> activities = _generateRandomActivities(size);
      
      Stopwatch sw = Stopwatch()..start();
      List<Activity> result = activitySelection(activities);
      sw.stop();
      
      print('Size: $size, Selected: ${result.length}, Time: ${sw.elapsedMicroseconds} μs');
    }
  }
  
  static List<Activity> _generateRandomActivities(int count) {
    List<Activity> activities = [];
    for (int i = 0; i < count; i++) {
      int start = i * 2;
      int finish = start + 1 + (i % 3);
      activities.add(Activity(i, start, finish));
    }
    return activities;
  }
}
```

---

## Main Function - Running All Examples

```dart
void main() {
  print('=== GREEDY ALGORITHMS IN DART ===\n');
  
  print('1. Activity Selection Problem:');
  activitySelectionExample();
  
  print('\n' + '='*50 + '\n');
  print('2. Fractional Knapsack Problem:');
  fractionalKnapsackExample();
  
  print('\n' + '='*50 + '\n');
  print('3. Coin Change Problem:');
  coinChangeExample();
  
  print('\n' + '='*50 + '\n');
  print('4. Huffman Coding:');
  huffmanCodingExample();
  
  print('\n' + '='*50 + '\n');
  print('5. Job Scheduling:');
  jobSchedulingExample();
  
  print('\n' + '='*50 + '\n');
  print('6. Minimum Spanning Tree (Kruskal):');
  kruskalExample();
  
  print('\n' + '='*50 + '\n');
  print('7. Shortest Path (Dijkstra):');
  dijkstraExample();
  
  print('\n' + '='*50 + '\n');
  print('8. Load Balancing:');
  loadBalancingExample();
  
  print('\n' + '='*50 + '\n');
  print('9. Interval Scheduling:');
  intervalSchedulingExample();
  
  print('\n' + '='*50 + '\n');
  print('10. Algorithm Analysis:');
  GreedyAnalyzer.analyzeComplexity();
  GreedyAnalyzer.demonstrateGreedyFailure();
  GreedyAnalyzer.greedyVsDynamicProgramming();
  
  print('\n' + '='*50 + '\n');
  print('11. Performance Testing:');
  PerformanceTester.testActivitySelection();
}
```

---

## Key Principles of Greedy Algorithms

### 1. **Greedy Choice Property**
- At each step, make the choice that looks best at the moment
- The choice should lead to a globally optimal solution
- Once made, the choice is never reconsidered

### 2. **Optimal Substructure**
- A problem has optimal substructure if an optimal solution contains optimal solutions to subproblems
- This property allows greedy choices to be made safely

### 3. **When Greedy Works**
- **Activity Selection**: Earliest finish time maximizes remaining time
- **Fractional Knapsack**: Highest value/weight ratio maximizes value
- **Huffman Coding**: Merging smallest frequencies minimizes total cost
- **MST**: Smallest edge weight minimizes total weight

### 4. **When Greedy Fails**
- **0/1 Knapsack**: Items cannot be fractioned
- **Longest Path**: Greedy may choose wrong direction
- **Non-canonical Coin Systems**: Largest denomination may not be optimal

### 5. **Design Strategy**
1. Formulate problem as making a sequence of choices
2. Prove greedy choice property holds
3. Show optimal substructure exists
4. Implement greedy algorithm
5. Verify correctness and analyze complexity

### 6. **Advantages and Disadvantages**

**Advantages:**
- Simple to understand and implement
- Efficient (usually polynomial time)
- Low memory usage
- Often produces good approximations

**Disadvantages:**
- May not find optimal solution
- Limited applicability
- Difficult to prove correctness
- No backtracking capability

This comprehensive guide demonstrates the power and limitations of greedy algorithms, showing how local optimization can sometimes lead to global optimality!