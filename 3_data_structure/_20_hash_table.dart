// Hash Table (Hash Map) Implementation in Dart
// A hash table is a data structure that implements an associative array
// It uses a hash function to compute an index into an array of buckets or slots

// Key Concepts:
// 1. Hash Function: Maps keys to array indices
// 2. Collision Handling: What to do when multiple keys hash to same index
// 3. Load Factor: Ratio of filled slots to total slots
// 4. Dynamic Resizing: Expanding the table when load factor gets too high

// Entry class for key-value pairs
class HashEntry<K, V> {
  K key;
  V value;
  HashEntry<K, V>? next; // For chaining collision resolution
  
  HashEntry(this.key, this.value, [this.next]);
  
  @override
  String toString() => '($key: $value)';
}

// Hash Table implementation using separate chaining
class HashTable<K, V> {
  static const int _initialCapacity = 16;
  static const double _loadFactorThreshold = 0.75;
  
  List<HashEntry<K, V>?> _buckets;
  int _size = 0;
  int _capacity;
  
  HashTable([int capacity = _initialCapacity]) 
      : _capacity = capacity,
        _buckets = List<HashEntry<K, V>?>.filled(capacity, null);
  
  // Hash function - converts key to array index
  int _hash(K key) {
    if (key == null) return 0;
    
    // Simple hash function using key's hashCode
    int hash = key.hashCode;
    // Ensure positive value and fit within capacity
    return hash.abs() % _capacity;
  }
  
  // Advanced hash function (for demonstration)
  int _advancedHash(K key) {
    if (key == null) return 0;
    
    int hash = key.hashCode;
    // Apply secondary hash to reduce clustering
    hash ^= (hash >> 20) ^ (hash >> 12);
    hash ^= (hash >> 7) ^ (hash >> 4);
    return hash.abs() % _capacity;
  }
  
  // Calculate current load factor
  double get loadFactor => _size / _capacity;
  
  // Get the number of elements
  int get size => _size;
  
  // Check if hash table is empty
  bool get isEmpty => _size == 0;
  
  // Get all keys
  List<K> get keys {
    List<K> keyList = [];
    for (var bucket in _buckets) {
      var current = bucket;
      while (current != null) {
        keyList.add(current.key);
        current = current.next;
      }
    }
    return keyList;
  }
  
  // Get all values
  List<V> get values {
    List<V> valueList = [];
    for (var bucket in _buckets) {
      var current = bucket;
      while (current != null) {
        valueList.add(current.value);
        current = current.next;
      }
    }
    return valueList;
  }
  
  // Insert or update a key-value pair
  void put(K key, V value) {
    // Check if we need to resize
    if (loadFactor >= _loadFactorThreshold) {
      _resize();
    }
    
    int index = _hash(key);
    
    // If bucket is empty, create new entry
    if (_buckets[index] == null) {
      _buckets[index] = HashEntry<K, V>(key, value);
      _size++;
      return;
    }
    
    // Handle collision using chaining
    var current = _buckets[index];
    while (current != null) {
      // If key already exists, update value
      if (current.key == key) {
        current.value = value;
        return;
      }
      
      // If we reach the end of chain, add new entry
      if (current.next == null) {
        current.next = HashEntry<K, V>(key, value);
        _size++;
        return;
      }
      
      current = current.next;
    }
  }
  
  // Get value by key
  V? get(K key) {
    int index = _hash(key);
    var current = _buckets[index];
    
    while (current != null) {
      if (current.key == key) {
        return current.value;
      }
      current = current.next;
    }
    
    return null; // Key not found
  }
  
  // Remove a key-value pair
  bool remove(K key) {
    int index = _hash(key);
    var current = _buckets[index];
    
    // If bucket is empty
    if (current == null) return false;
    
    // If first entry matches
    if (current.key == key) {
      _buckets[index] = current.next;
      _size--;
      return true;
    }
    
    // Search through chain
    while (current.next != null) {
      if (current.next!.key == key) {
        current.next = current.next!.next;
        _size--;
        return true;
      }
      current = current.next!;
    }
    
    return false; // Key not found
  }
  
  // Check if key exists
  bool containsKey(K key) {
    return get(key) != null;
  }
  
  // Check if value exists
  bool containsValue(V value) {
    for (var bucket in _buckets) {
      var current = bucket;
      while (current != null) {
        if (current.value == value) {
          return true;
        }
        current = current.next;
      }
    }
    return false;
  }
  
  // Clear all entries
  void clear() {
    _buckets = List<HashEntry<K, V>?>.filled(_capacity, null);
    _size = 0;
  }
  
  // Resize the hash table when load factor is too high
  void _resize() {
    var oldBuckets = _buckets;
    _capacity *= 2;
    _buckets = List<HashEntry<K, V>?>.filled(_capacity, null);
    int oldSize = _size;
    _size = 0;
    
    print('Resizing hash table from ${_capacity ~/ 2} to $_capacity buckets');
    
    // Rehash all existing entries
    for (var bucket in oldBuckets) {
      var current = bucket;
      while (current != null) {
        put(current.key, current.value);
        current = current.next;
      }
    }
    
    print('Rehashed $oldSize entries');
  }
  
  // Display hash table structure
  void display() {
    print('\nHash Table Structure (Capacity: $_capacity, Size: $_size, Load Factor: ${loadFactor.toStringAsFixed(2)}):');
    for (int i = 0; i < _capacity; i++) {
      if (_buckets[i] != null) {
        String chain = '';
        var current = _buckets[i];
        while (current != null) {
          chain += current.toString();
          if (current.next != null) chain += ' -> ';
          current = current.next;
        }
        print('Bucket $i: $chain');
      }
    }
  }
  
  // Get statistics about the hash table
  Map<String, dynamic> getStatistics() {
    int usedBuckets = 0;
    int maxChainLength = 0;
    int totalChainLength = 0;
    List<int> chainLengths = [];
    
    for (var bucket in _buckets) {
      if (bucket != null) {
        usedBuckets++;
        int chainLength = 0;
        var current = bucket;
        while (current != null) {
          chainLength++;
          current = current.next;
        }
        chainLengths.add(chainLength);
        maxChainLength = chainLength > maxChainLength ? chainLength : maxChainLength;
        totalChainLength += chainLength;
      }
    }
    
    double avgChainLength = usedBuckets > 0 ? totalChainLength / usedBuckets : 0;
    
    return {
      'capacity': _capacity,
      'size': _size,
      'usedBuckets': usedBuckets,
      'loadFactor': loadFactor,
      'maxChainLength': maxChainLength,
      'avgChainLength': avgChainLength,
      'chainLengths': chainLengths,
    };
  }
}

// Alternative implementation using open addressing (linear probing)
class HashTableOpenAddressing<K, V> {
  static const int _initialCapacity = 16;
  static const double _loadFactorThreshold = 0.5; // Lower for open addressing
  
  List<K?> _keys;
  List<V?> _values;
  List<bool> _deleted; // To mark deleted entries
  int _size = 0;
  int _capacity;
  
  HashTableOpenAddressing([int capacity = _initialCapacity])
      : _capacity = capacity,
        _keys = List<K?>.filled(capacity, null),
        _values = List<V?>.filled(capacity, null),
        _deleted = List<bool>.filled(capacity, false);
  
  int _hash(K key) {
    return key.hashCode.abs() % _capacity;
  }
  
  double get loadFactor => _size / _capacity;
  int get size => _size;
  bool get isEmpty => _size == 0;
  
  // Linear probing to find next available slot
  int _probe(K key, bool forInsertion) {
    int index = _hash(key);
    
    while (_keys[index] != null) {
      if (_keys[index] == key && !_deleted[index]) {
        return index;
      }
      
      if (forInsertion && (_keys[index] == null || _deleted[index])) {
        return index;
      }
      
      index = (index + 1) % _capacity; // Linear probing
    }
    
    return index;
  }
  
  void put(K key, V value) {
    if (loadFactor >= _loadFactorThreshold) {
      _resize();
    }
    
    int index = _probe(key, true);
    
    if (_keys[index] == null || _deleted[index]) {
      _keys[index] = key;
      _values[index] = value;
      _deleted[index] = false;
      _size++;
    } else {
      // Update existing key
      _values[index] = value;
    }
  }
  
  V? get(K key) {
    int index = _probe(key, false);
    
    if (_keys[index] == key && !_deleted[index]) {
      return _values[index];
    }
    
    return null;
  }
  
  bool remove(K key) {
    int index = _probe(key, false);
    
    if (_keys[index] == key && !_deleted[index]) {
      _deleted[index] = true;
      _size--;
      return true;
    }
    
    return false;
  }
  
  void _resize() {
    var oldKeys = _keys;
    var oldValues = _values;
    var oldDeleted = _deleted;
    
    _capacity *= 2;
    _keys = List<K?>.filled(_capacity, null);
    _values = List<V?>.filled(_capacity, null);
    _deleted = List<bool>.filled(_capacity, false);
    int oldSize = _size;
    _size = 0;
    
    for (int i = 0; i < oldKeys.length; i++) {
      if (oldKeys[i] != null && !oldDeleted[i]) {
        put(oldKeys[i]!, oldValues[i]!);
      }
    }
  }
  
  void display() {
    print('\nOpen Addressing Hash Table:');
    for (int i = 0; i < _capacity; i++) {
      if (_keys[i] != null && !_deleted[i]) {
        print('Index $i: ${_keys[i]} -> ${_values[i]}');
      } else if (_deleted[i]) {
        print('Index $i: [DELETED]');
      }
    }
  }
}

// Demonstration and Examples
void main() {
  print('=== Hash Table (Hash Map) Implementation in Dart ===\n');
  
  print('1. Hash Table Concepts:');
  print('''
  Hash Table Key Concepts:
  • Maps keys to values using a hash function
  • Average O(1) time complexity for insert, search, delete
  • Hash function converts key to array index
  • Collision handling when multiple keys hash to same index
  • Load factor = number of entries / table size
  • Dynamic resizing to maintain performance
  
  Collision Resolution Methods:
  1. Separate Chaining: Use linked lists at each bucket
  2. Open Addressing: Find another empty slot
     - Linear Probing: Check next slot sequentially
     - Quadratic Probing: Check slots at quadratic intervals
     - Double Hashing: Use second hash function
  ''');
  
  print('\n2. Separate Chaining Example:');
  var hashTable = HashTable<String, int>();
  
  // Insert some key-value pairs
  List<String> names = ['Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Frank', 'Grace'];
  List<int> ages = [25, 30, 35, 28, 32, 27, 29];
  
  print('Inserting key-value pairs:');
  for (int i = 0; i < names.length; i++) {
    hashTable.put(names[i], ages[i]);
    print('Put(${names[i]}, ${ages[i]})');
  }
  
  hashTable.display();
  
  print('\n3. Hash Table Operations:');
  
  // Search operations
  print('\nSearch Operations:');
  List<String> searchKeys = ['Alice', 'Bob', 'Unknown'];
  for (String key in searchKeys) {
    var value = hashTable.get(key);
    print('Get($key): ${value ?? 'Not found'}');
  }
  
  // Check existence
  print('\nExistence Checks:');
  print('Contains key "Charlie": ${hashTable.containsKey("Charlie")}');
  print('Contains value 30: ${hashTable.containsValue(30)}');
  
  // Update value
  print('\nUpdating value:');
  hashTable.put('Alice', 26);
  print('Updated Alice\'s age to: ${hashTable.get('Alice')}');
  
  // Remove entry
  print('\nRemoving entry:');
  bool removed = hashTable.remove('David');
  print('Removed David: $removed');
  print('Size after removal: ${hashTable.size}');
  
  print('\n4. Hash Table Statistics:');
  var stats = hashTable.getStatistics();
  print('Capacity: ${stats['capacity']}');
  print('Size: ${stats['size']}');
  print('Used Buckets: ${stats['usedBuckets']}');
  print('Load Factor: ${stats['loadFactor'].toStringAsFixed(3)}');
  print('Max Chain Length: ${stats['maxChainLength']}');
  print('Average Chain Length: ${stats['avgChainLength'].toStringAsFixed(2)}');
  
  print('\n5. Triggering Resize:');
  print('Adding more entries to trigger resize...');
  
  // Add more entries to trigger resize
  List<String> moreNames = ['Henry', 'Ivy', 'Jack', 'Kate', 'Liam', 'Mia'];
  for (int i = 0; i < moreNames.length; i++) {
    hashTable.put(moreNames[i], 20 + i);
  }
  
  hashTable.display();
  
  print('\n' + '='*60);
  
  print('\n6. Open Addressing Example:');
  var openHashTable = HashTableOpenAddressing<String, int>();
  
  print('Inserting into open addressing hash table:');
  for (int i = 0; i < names.length; i++) {
    openHashTable.put(names[i], ages[i]);
  }
  
  openHashTable.display();
  
  print('\nLoad factor: ${openHashTable.loadFactor.toStringAsFixed(3)}');
  
  print('\n' + '='*60);
  
  print('\n7. Hash Function Analysis:');
  print('''
  Good Hash Function Properties:
  • Uniform distribution: Keys spread evenly across buckets
  • Deterministic: Same key always produces same hash
  • Fast computation: O(1) time complexity
  • Avalanche effect: Small key changes cause large hash changes
  
  Common Hash Functions:
  • Division method: h(k) = k mod m
  • Multiplication method: h(k) = ⌊m(kA mod 1)⌋
  • Universal hashing: Random hash function selection
  ''');
  
  // Demonstrate hash distribution
  print('\nHash Distribution Example:');
  var testTable = HashTable<int, String>();
  List<int> testKeys = [1, 11, 21, 31, 41, 51]; // Keys that might collide
  
  for (int key in testKeys) {
    int hash = key.hashCode.abs() % 16; // Assuming capacity 16
    print('Key $key hashes to bucket $hash');
    testTable.put(key, 'Value$key');
  }
  
  print('\n8. Performance Comparison:');
  print('''
  Hash Table vs Other Data Structures:
  
  Operation    | Hash Table | Array | Linked List | BST (balanced)
  -------------|------------|-------|-------------|---------------
  Search       | O(1) avg   | O(n)  | O(n)        | O(log n)
  Insert       | O(1) avg   | O(n)  | O(1)        | O(log n)
  Delete       | O(1) avg   | O(n)  | O(n)        | O(log n)
  Space        | O(n)       | O(n)  | O(n)        | O(n)
  
  Hash Table Applications:
  • Database indexing
  • Caching systems
  • Symbol tables in compilers
  • Associative arrays/dictionaries
  • Sets implementation
  • Password storage (with cryptographic hash)
  • Blockchain (Merkle trees)
  ''');
  
  print('\n9. Dart Built-in Hash Structures:');
  print('''
  Dart provides built-in hash-based collections:
  
  Map<K, V>: Hash table implementation
  - HashMap<K, V>: Unordered map
  - LinkedHashMap<K, V>: Insertion-order map
  
  Set<T>: Hash set implementation
  - HashSet<T>: Unordered set
  - LinkedHashSet<T>: Insertion-order set
  
  Example usage:
  var map = <String, int>{'Alice': 25, 'Bob': 30};
  var set = <String>{'Apple', 'Banana', 'Cherry'};
  ''');
  
  // Dart built-in example
  print('\nDart Built-in Map Example:');
  Map<String, int> dartMap = {'Alice': 25, 'Bob': 30, 'Charlie': 35};
  print('Dart Map: $dartMap');
  print('Get Alice: ${dartMap['Alice']}');
  dartMap['David'] = 28;
  print('After adding David: $dartMap');
}
