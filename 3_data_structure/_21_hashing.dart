// Hashing Implementation in Dart
// Hashing is a technique to map data of arbitrary size to fixed-size values
// Hash functions convert keys into array indices for efficient data storage and retrieval

// Key Concepts:
// 1. Hash Function: Maps keys to hash values (indices)
// 2. Hash Table: Array that stores key-value pairs
// 3. Collision: When two keys hash to the same index
// 4. Load Factor: Number of entries / Table size
// 5. Collision Resolution: Techniques to handle collisions

import 'dart:math';

// Hash Table Entry for chaining collision resolution
class HashEntry<K, V> {
  K key;
  V value;
  HashEntry<K, V>? next;
  
  HashEntry(this.key, this.value, [this.next]);
  
  @override
  String toString() => '($key: $value)';
}

// Hash Table with Separate Chaining (using linked lists)
class HashTableChaining<K, V> {
  late List<HashEntry<K, V>?> table;
  int _size = 0;
  int _capacity;
  
  HashTableChaining([this._capacity = 16]) {
    table = List.filled(_capacity, null);
  }
  
  // Simple hash function for demonstration
  int _hash(K key) {
    if (key is String) {
      return _stringHash(key);
    } else if (key is int) {
      return _intHash(key);
    } else {
      return key.hashCode.abs() % _capacity;
    }
  }
  
  // String hash function (polynomial rolling hash)
  int _stringHash(String key) {
    int hash = 0;
    int prime = 31;
    
    for (int i = 0; i < key.length; i++) {
      hash = (hash * prime + key.codeUnitAt(i)) % _capacity;
    }
    
    return hash.abs();
  }
  
  // Integer hash function (multiplicative method)
  int _intHash(int key) {
    const double A = 0.6180339887; // (sqrt(5) - 1) / 2
    double temp = key * A;
    double fractional = temp - temp.floor();
    return (fractional * _capacity).floor();
  }
  
  // Insert key-value pair
  void put(K key, V value) {
    int index = _hash(key);
    HashEntry<K, V>? current = table[index];
    
    // Check if key already exists
    while (current != null) {
      if (current.key == key) {
        current.value = value; // Update existing value
        return;
      }
      current = current.next;
    }
    
    // Insert new entry at the beginning of the chain
    HashEntry<K, V> newEntry = HashEntry(key, value, table[index]);
    table[index] = newEntry;
    _size++;
    
    // Resize if load factor exceeds threshold
    if (_size > _capacity * 0.75) {
      _resize();
    }
  }
  
  // Get value by key
  V? get(K key) {
    int index = _hash(key);
    HashEntry<K, V>? current = table[index];
    
    while (current != null) {
      if (current.key == key) {
        return current.value;
      }
      current = current.next;
    }
    
    return null; // Key not found
  }
  
  // Remove key-value pair
  bool remove(K key) {
    int index = _hash(key);
    HashEntry<K, V>? current = table[index];
    HashEntry<K, V>? previous;
    
    while (current != null) {
      if (current.key == key) {
        if (previous == null) {
          table[index] = current.next;
        } else {
          previous.next = current.next;
        }
        _size--;
        return true;
      }
      previous = current;
      current = current.next;
    }
    
    return false; // Key not found
  }
  
  // Check if key exists
  bool containsKey(K key) {
    return get(key) != null;
  }
  
  // Resize hash table when load factor is high
  void _resize() {
    List<HashEntry<K, V>?> oldTable = table;
    _capacity *= 2;
    table = List.filled(_capacity, null);
    _size = 0;
    
    // Rehash all existing entries
    for (HashEntry<K, V>? entry in oldTable) {
      while (entry != null) {
        put(entry.key, entry.value);
        entry = entry.next;
      }
    }
  }
  
  // Get all keys
  List<K> get keys {
    List<K> result = [];
    for (HashEntry<K, V>? entry in table) {
      while (entry != null) {
        result.add(entry.key);
        entry = entry.next;
      }
    }
    return result;
  }
  
  // Get all values
  List<V> get values {
    List<V> result = [];
    for (HashEntry<K, V>? entry in table) {
      while (entry != null) {
        result.add(entry.value);
        entry = entry.next;
      }
    }
    return result;
  }
  
  // Get current size
  int get size => _size;
  
  // Check if empty
  bool get isEmpty => _size == 0;
  
  // Get load factor
  double get loadFactor => _size / _capacity;
  
  // Display hash table structure
  void display() {
    print('Hash Table (Capacity: $_capacity, Size: $_size, Load Factor: ${loadFactor.toStringAsFixed(2)}):');
    for (int i = 0; i < _capacity; i++) {
      String chain = '';
      HashEntry<K, V>? current = table[i];
      
      while (current != null) {
        chain += current.toString();
        if (current.next != null) chain += ' -> ';
        current = current.next;
      }
      
      if (chain.isNotEmpty) {
        print('[$i]: $chain');
      }
    }
  }
}

// Hash Table with Linear Probing (Open Addressing)
class HashTableLinearProbing<K, V> {
  late List<K?> keys;
  late List<V?> values;
  late List<bool> deleted; // Track deleted entries
  int _size = 0;
  int _capacity;
  
  HashTableLinearProbing([this._capacity = 16]) {
    keys = List.filled(_capacity, null);
    values = List.filled(_capacity, null);
    deleted = List.filled(_capacity, false);
  }
  
  // Hash function
  int _hash(K key) {
    if (key is String) {
      return _stringHash(key);
    } else if (key is int) {
      return key.abs() % _capacity;
    } else {
      return key.hashCode.abs() % _capacity;
    }
  }
  
  int _stringHash(String key) {
    int hash = 0;
    for (int i = 0; i < key.length; i++) {
      hash = (hash * 31 + key.codeUnitAt(i)) % _capacity;
    }
    return hash.abs();
  }
  
  // Insert key-value pair with linear probing
  void put(K key, V value) {
    if (_size >= _capacity * 0.75) {
      _resize();
    }
    
    int index = _hash(key);
    
    // Linear probing to find empty slot or existing key
    while (keys[index] != null && !deleted[index]) {
      if (keys[index] == key) {
        values[index] = value; // Update existing value
        return;
      }
      index = (index + 1) % _capacity;
    }
    
    // Insert at found position
    if (keys[index] == null || deleted[index]) {
      if (deleted[index]) deleted[index] = false;
      if (keys[index] == null) _size++;
      keys[index] = key;
      values[index] = value;
    }
  }
  
  // Get value by key
  V? get(K key) {
    int index = _hash(key);
    
    while (keys[index] != null) {
      if (keys[index] == key && !deleted[index]) {
        return values[index];
      }
      index = (index + 1) % _capacity;
    }
    
    return null;
  }
  
  // Remove key-value pair
  bool remove(K key) {
    int index = _hash(key);
    
    while (keys[index] != null) {
      if (keys[index] == key && !deleted[index]) {
        deleted[index] = true;
        _size--;
        return true;
      }
      index = (index + 1) % _capacity;
    }
    
    return false;
  }
  
  // Resize and rehash
  void _resize() {
    List<K?> oldKeys = keys;
    List<V?> oldValues = values;
    List<bool> oldDeleted = deleted;
    
    _capacity *= 2;
    keys = List.filled(_capacity, null);
    values = List.filled(_capacity, null);
    deleted = List.filled(_capacity, false);
    _size = 0;
    
    // Rehash all existing entries
    for (int i = 0; i < oldKeys.length; i++) {
      if (oldKeys[i] != null && !oldDeleted[i]) {
        put(oldKeys[i]!, oldValues[i]!);
      }
    }
  }
  
  int get size => _size;
  bool get isEmpty => _size == 0;
  double get loadFactor => _size / _capacity;
  
  void display() {
    print('Hash Table with Linear Probing (Capacity: $_capacity, Size: $_size):');
    for (int i = 0; i < _capacity; i++) {
      if (keys[i] != null && !deleted[i]) {
        print('[$i]: ${keys[i]} -> ${values[i]}');
      } else if (deleted[i]) {
        print('[$i]: [DELETED]');
      }
    }
  }
}

// Hash Function Examples and Analysis
class HashFunctions {
  // Division Method
  static int divisionMethod(int key, int tableSize) {
    return key % tableSize;
  }
  
  // Multiplication Method
  static int multiplicationMethod(int key, int tableSize) {
    const double A = 0.6180339887; // (sqrt(5) - 1) / 2
    double temp = key * A;
    double fractional = temp - temp.floor();
    return (fractional * tableSize).floor();
  }
  
  // Mid-square Method
  static int midSquareMethod(int key, int tableSize) {
    int squared = key * key;
    String squaredStr = squared.toString();
    int length = squaredStr.length;
    
    if (length < 2) return squared % tableSize;
    
    int start = length ~/ 4;
    int end = start + (length ~/ 2);
    String middle = squaredStr.substring(start, min(end, length));
    
    return int.parse(middle) % tableSize;
  }
  
  // Folding Method
  static int foldingMethod(int key, int tableSize) {
    String keyStr = key.toString();
    int sum = 0;
    
    // Split into 2-digit parts and sum
    for (int i = 0; i < keyStr.length; i += 2) {
      String part = keyStr.substring(i, min(i + 2, keyStr.length));
      sum += int.parse(part);
    }
    
    return sum % tableSize;
  }
}

// Hash Table Performance Analysis
class HashTableAnalysis {
  static void analyzeHashFunction(String name, int Function(int, int) hashFunc, 
                                 List<int> keys, int tableSize) {
    print('\n=== $name Analysis ===');
    
    List<int> bucketCounts = List.filled(tableSize, 0);
    Map<int, List<int>> distribution = {};
    
    // Calculate hash values and distribution
    for (int key in keys) {
      int hash = hashFunc(key, tableSize);
      bucketCounts[hash]++;
      
      if (!distribution.containsKey(hash)) {
        distribution[hash] = [];
      }
      distribution[hash]!.add(key);
    }
    
    // Calculate statistics
    int collisions = bucketCounts.where((count) => count > 1).length;
    int emptyBuckets = bucketCounts.where((count) => count == 0).length;
    double loadFactor = keys.length / tableSize;
    
    // Calculate clustering
    int maxCluster = bucketCounts.reduce(max);
    double avgCluster = bucketCounts.where((c) => c > 0).isEmpty ? 0 :
        bucketCounts.where((c) => c > 0).reduce((a, b) => a + b) / 
        bucketCounts.where((c) => c > 0).length;
    
    print('Load Factor: ${loadFactor.toStringAsFixed(2)}');
    print('Collisions: $collisions/${tableSize} buckets');
    print('Empty Buckets: $emptyBuckets');
    print('Max Cluster Size: $maxCluster');
    print('Average Cluster Size: ${avgCluster.toStringAsFixed(2)}');
    
    // Show distribution for small table sizes
    if (tableSize <= 20) {
      print('Distribution:');
      for (int i = 0; i < tableSize; i++) {
        if (bucketCounts[i] > 0) {
          print('  Bucket $i: ${distribution[i]} (${bucketCounts[i]} items)');
        }
      }
    }
  }
}

// Demonstration and Examples
void main() {
  print('=== Hashing Concepts in Dart ===\n');
  
  print('1. Hash Function Examples:');
  List<int> testKeys = [123, 456, 789, 234, 567, 890, 345, 678];
  int tableSize = 11;
  
  HashTableAnalysis.analyzeHashFunction(
    'Division Method', HashFunctions.divisionMethod, testKeys, tableSize);
  
  HashTableAnalysis.analyzeHashFunction(
    'Multiplication Method', HashFunctions.multiplicationMethod, testKeys, tableSize);
  
  HashTableAnalysis.analyzeHashFunction(
    'Mid-Square Method', HashFunctions.midSquareMethod, testKeys, tableSize);
  
  print('\n' + '='*60);
  
  print('\n2. Hash Table with Separate Chaining:');
  var chainTable = HashTableChaining<String, int>();
  
  // Insert some data
  Map<String, int> data = {
    'apple': 5,
    'banana': 3,
    'orange': 8,
    'grape': 2,
    'kiwi': 6,
    'mango': 4,
  };
  
  print('Inserting data...');
  data.forEach((key, value) {
    chainTable.put(key, value);
    print('Inserted: $key -> $value');
  });
  
  print('\nHash table structure:');
  chainTable.display();
  
  print('\nSearch operations:');
  for (String key in ['apple', 'banana', 'cherry']) {
    int? value = chainTable.get(key);
    print('$key: ${value ?? 'Not found'}');
  }
  
  print('\n' + '='*60);
  
  print('\n3. Hash Table with Linear Probing:');
  var probingTable = HashTableLinearProbing<String, int>();
  
  print('Inserting same data...');
  data.forEach((key, value) {
    probingTable.put(key, value);
  });
  
  print('\nHash table structure:');
  probingTable.display();
  
  print('\nRemoving "banana"...');
  probingTable.remove('banana');
  probingTable.display();
  
  print('\n' + '='*60);
  
  print('\n4. Collision Resolution Comparison:');
  print('''
  Separate Chaining:
  ✓ Simple implementation
  ✓ No clustering issues
  ✓ Easy deletion
  ✗ Extra memory for pointers
  ✗ Cache performance issues
  
  Linear Probing (Open Addressing):
  ✓ Better cache performance
  ✓ Less memory overhead
  ✗ Clustering issues
  ✗ Complex deletion
  ✗ Performance degrades with high load factor
  
  Other Collision Resolution Methods:
  • Quadratic Probing: i² step size
  • Double Hashing: Second hash function for step size
  • Robin Hood Hashing: Minimize variance in probe distances
  ''');
  
  print('\n5. Hash Function Properties:');
  print('''
  Good Hash Function Characteristics:
  1. Uniform Distribution: Spreads keys evenly
  2. Fast Computation: O(1) time complexity
  3. Deterministic: Same input → same output
  4. Avalanche Effect: Small input change → large output change
  5. Low Collision Rate: Minimizes hash collisions
  
  Common Hash Functions:
  • Division Method: h(k) = k mod m
  • Multiplication Method: h(k) = ⌊m(kA mod 1)⌋
  • Universal Hashing: Randomly chosen from family
  • Cryptographic Hashes: SHA, MD5 (for security)
  ''');
  
  print('\n6. Applications of Hashing:');
  print('''
  • Hash Tables/Maps: Fast key-value storage
  • Sets: Unique element storage
  • Caches: Fast data retrieval
  • Database Indexing: Quick record lookup
  • Password Storage: Secure authentication
  • Checksums: Data integrity verification
  • Bloom Filters: Probabilistic membership testing
  • Load Balancing: Consistent hashing
  • Cryptography: Digital signatures, certificates
  ''');
  
  print('\n7. Time Complexities:');
  print('''
  Average Case:
  • Insert: O(1)
  • Search: O(1)
  • Delete: O(1)
  
  Worst Case (all keys hash to same bucket):
  • Insert: O(n)
  • Search: O(n)
  • Delete: O(n)
  
  Space Complexity: O(n)
  ''');
  
  print('\n8. Dart Built-in Hash Support:');
  print('''
  Dart provides built-in hash support:
  • Map<K, V>: Hash table implementation
  • Set<T>: Hash set implementation
  • hashCode property: Every object has hash code
  • HashMap, HashSet: Explicit hash-based collections
  
  Example:
  Map<String, int> map = HashMap();
  Set<String> set = HashSet();
  ''');
}
