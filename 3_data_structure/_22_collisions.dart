// Hash Table Collisions - Comprehensive Guide in Dart
// Collisions occur when two different keys hash to the same index
// This is inevitable due to the pigeonhole principle

// Key Entry class for storing key-value pairs
class KeyValuePair<K, V> {
  K key;
  V value;
  KeyValuePair<K, V>? next; // For chaining
  bool isDeleted; // For open addressing with lazy deletion
  
  KeyValuePair(this.key, this.value, {this.next, this.isDeleted = false});
  
  @override
  String toString() => '($key: $value)';
}

// Hash Table with Separate Chaining (Collision Resolution)
class HashTableChaining<K, V> {
  List<KeyValuePair<K, V>?> _buckets;
  int _size;
  int _capacity;
  
  HashTableChaining([int capacity = 10]) 
      : _capacity = capacity, 
        _size = 0,
        _buckets = List.filled(capacity, null);
  
  // Hash function (simple modulo)
  int _hash(K key) {
    return key.hashCode % _capacity;
  }
  
  // Insert key-value pair
  void put(K key, V value) {
    int index = _hash(key);
    
    // If bucket is empty, create new entry
    if (_buckets[index] == null) {
      _buckets[index] = KeyValuePair<K, V>(key, value);
      _size++;
      return;
    }
    
    // Traverse the chain to find key or end of chain
    KeyValuePair<K, V>? current = _buckets[index];
    while (current != null) {
      if (current.key == key) {
        // Update existing key
        current.value = value;
        return;
      }
      if (current.next == null) break;
      current = current.next;
    }
    
    // Add new entry at end of chain (collision handled)
    current!.next = KeyValuePair<K, V>(key, value);
    _size++;
  }
  
  // Get value by key
  V? get(K key) {
    int index = _hash(key);
    KeyValuePair<K, V>? current = _buckets[index];
    
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
    KeyValuePair<K, V>? current = _buckets[index];
    
    // If first node is the target
    if (current != null && current.key == key) {
      _buckets[index] = current.next;
      _size--;
      return true;
    }
    
    // Search in the chain
    while (current?.next != null) {
      if (current!.next!.key == key) {
        current.next = current.next!.next;
        _size--;
        return true;
      }
      current = current.next;
    }
    return false;
  }
  
  // Display hash table structure
  void display() {
    print('\n=== Hash Table with Chaining ===');
    for (int i = 0; i < _capacity; i++) {
      print('Bucket $i: ', newline: false);
      KeyValuePair<K, V>? current = _buckets[i];
      
      if (current == null) {
        print('empty');
      } else {
        List<String> chain = [];
        while (current != null) {
          chain.add(current.toString());
          current = current.next;
        }
        print('${chain.join(' -> ')}');
      }
    }
    print('Size: $_size, Capacity: $_capacity');
    print('Load Factor: ${(_size / _capacity).toStringAsFixed(2)}');
  }
  
  // Get collision statistics
  Map<String, dynamic> getCollisionStats() {
    int emptyBuckets = 0;
    int maxChainLength = 0;
    int totalChainLength = 0;
    int bucketsWithCollisions = 0;
    
    for (int i = 0; i < _capacity; i++) {
      int chainLength = 0;
      KeyValuePair<K, V>? current = _buckets[i];
      
      while (current != null) {
        chainLength++;
        current = current.next;
      }
      
      if (chainLength == 0) {
        emptyBuckets++;
      } else if (chainLength > 1) {
        bucketsWithCollisions++;
      }
      
      maxChainLength = chainLength > maxChainLength ? chainLength : maxChainLength;
      totalChainLength += chainLength;
    }
    
    return {
      'emptyBuckets': emptyBuckets,
      'bucketsWithCollisions': bucketsWithCollisions,
      'maxChainLength': maxChainLength,
      'averageChainLength': totalChainLength / (_capacity - emptyBuckets),
      'loadFactor': _size / _capacity,
    };
  }
}

// Hash Table with Linear Probing (Open Addressing)
class HashTableLinearProbing<K, V> {
  List<KeyValuePair<K, V>?> _buckets;
  int _size;
  int _capacity;
  
  HashTableLinearProbing([int capacity = 10])
      : _capacity = capacity,
        _size = 0,
        _buckets = List.filled(capacity, null);
  
  int _hash(K key) {
    return key.hashCode % _capacity;
  }
  
  // Linear probing to find next available slot
  int _probe(K key, [bool forInsertion = false]) {
    int index = _hash(key);
    int originalIndex = index;
    
    while (_buckets[index] != null) {
      // Found existing key
      if (_buckets[index]!.key == key && !_buckets[index]!.isDeleted) {
        return index;
      }
      
      // For insertion, can use deleted slots
      if (forInsertion && _buckets[index]!.isDeleted) {
        return index;
      }
      
      // Move to next slot (linear probing)
      index = (index + 1) % _capacity;
      
      // Table is full or we've circled back
      if (index == originalIndex) {
        return -1;
      }
    }
    
    return index; // Found empty slot
  }
  
  void put(K key, V value) {
    if (_size >= _capacity * 0.7) { // Resize when load factor > 0.7
      _resize();
    }
    
    int index = _probe(key, true);
    if (index == -1) {
      throw Exception('Hash table is full');
    }
    
    if (_buckets[index] == null || _buckets[index]!.isDeleted) {
      _buckets[index] = KeyValuePair<K, V>(key, value);
      _size++;
    } else {
      // Update existing key
      _buckets[index]!.value = value;
    }
  }
  
  V? get(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      return _buckets[index]!.value;
    }
    return null;
  }
  
  bool remove(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      _buckets[index]!.isDeleted = true; // Lazy deletion
      _size--;
      return true;
    }
    return false;
  }
  
  void _resize() {
    List<KeyValuePair<K, V>?> oldBuckets = _buckets;
    int oldCapacity = _capacity;
    
    _capacity *= 2;
    _buckets = List.filled(_capacity, null);
    _size = 0;
    
    // Rehash all elements
    for (int i = 0; i < oldCapacity; i++) {
      if (oldBuckets[i] != null && !oldBuckets[i]!.isDeleted) {
        put(oldBuckets[i]!.key, oldBuckets[i]!.value);
      }
    }
  }
  
  void display() {
    print('\n=== Hash Table with Linear Probing ===');
    for (int i = 0; i < _capacity; i++) {
      String status = 'empty';
      if (_buckets[i] != null) {
        if (_buckets[i]!.isDeleted) {
          status = 'deleted (${_buckets[i]})';
        } else {
          status = _buckets[i].toString();
        }
      }
      print('Slot $i: $status');
    }
    print('Size: $_size, Capacity: $_capacity');
    print('Load Factor: ${(_size / _capacity).toStringAsFixed(2)}');
  }
  
  Map<String, dynamic> getProbingStats() {
    int emptySlots = 0;
    int deletedSlots = 0;
    int occupiedSlots = 0;
    
    for (int i = 0; i < _capacity; i++) {
      if (_buckets[i] == null) {
        emptySlots++;
      } else if (_buckets[i]!.isDeleted) {
        deletedSlots++;
      } else {
        occupiedSlots++;
      }
    }
    
    return {
      'emptySlots': emptySlots,
      'deletedSlots': deletedSlots,
      'occupiedSlots': occupiedSlots,
      'loadFactor': _size / _capacity,
    };
  }
}

// Hash Table with Quadratic Probing
class HashTableQuadraticProbing<K, V> {
  List<KeyValuePair<K, V>?> _buckets;
  int _size;
  int _capacity;
  
  HashTableQuadraticProbing([int capacity = 11]) // Prime number for better distribution
      : _capacity = capacity,
        _size = 0,
        _buckets = List.filled(capacity, null);
  
  int _hash(K key) {
    return key.hashCode % _capacity;
  }
  
  // Quadratic probing: h(k) + i^2
  int _probe(K key, [bool forInsertion = false]) {
    int index = _hash(key);
    int i = 0;
    
    while (i < _capacity) {
      int probedIndex = (index + i * i) % _capacity;
      
      if (_buckets[probedIndex] == null) {
        return probedIndex; // Empty slot found
      }
      
      if (_buckets[probedIndex]!.key == key && !_buckets[probedIndex]!.isDeleted) {
        return probedIndex; // Key found
      }
      
      if (forInsertion && _buckets[probedIndex]!.isDeleted) {
        return probedIndex; // Deleted slot can be reused
      }
      
      i++;
    }
    
    return -1; // No slot found
  }
  
  void put(K key, V value) {
    if (_size >= _capacity * 0.5) { // Lower load factor for quadratic probing
      _resize();
    }
    
    int index = _probe(key, true);
    if (index == -1) {
      throw Exception('Hash table is full');
    }
    
    if (_buckets[index] == null || _buckets[index]!.isDeleted) {
      _buckets[index] = KeyValuePair<K, V>(key, value);
      _size++;
    } else {
      _buckets[index]!.value = value;
    }
  }
  
  V? get(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      return _buckets[index]!.value;
    }
    return null;
  }
  
  bool remove(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      _buckets[index]!.isDeleted = true;
      _size--;
      return true;
    }
    return false;
  }
  
  void _resize() {
    List<KeyValuePair<K, V>?> oldBuckets = _buckets;
    int oldCapacity = _capacity;
    
    _capacity = _getNextPrime(_capacity * 2);
    _buckets = List.filled(_capacity, null);
    _size = 0;
    
    for (int i = 0; i < oldCapacity; i++) {
      if (oldBuckets[i] != null && !oldBuckets[i]!.isDeleted) {
        put(oldBuckets[i]!.key, oldBuckets[i]!.value);
      }
    }
  }
  
  int _getNextPrime(int n) {
    while (!_isPrime(n)) {
      n++;
    }
    return n;
  }
  
  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }
  
  void display() {
    print('\n=== Hash Table with Quadratic Probing ===');
    for (int i = 0; i < _capacity; i++) {
      String status = 'empty';
      if (_buckets[i] != null) {
        if (_buckets[i]!.isDeleted) {
          status = 'deleted (${_buckets[i]})';
        } else {
          status = _buckets[i].toString();
        }
      }
      print('Slot $i: $status');
    }
    print('Size: $_size, Capacity: $_capacity');
    print('Load Factor: ${(_size / _capacity).toStringAsFixed(2)}');
  }
}

// Double Hashing Implementation
class HashTableDoubleHashing<K, V> {
  List<KeyValuePair<K, V>?> _buckets;
  int _size;
  int _capacity;
  
  HashTableDoubleHashing([int capacity = 11])
      : _capacity = capacity,
        _size = 0,
        _buckets = List.filled(capacity, null);
  
  int _hash1(K key) {
    return key.hashCode % _capacity;
  }
  
  // Second hash function (should never return 0)
  int _hash2(K key) {
    return 7 - (key.hashCode % 7); // Using prime number 7
  }
  
  // Double hashing: h1(k) + i * h2(k)
  int _probe(K key, [bool forInsertion = false]) {
    int h1 = _hash1(key);
    int h2 = _hash2(key);
    int i = 0;
    
    while (i < _capacity) {
      int index = (h1 + i * h2) % _capacity;
      
      if (_buckets[index] == null) {
        return index;
      }
      
      if (_buckets[index]!.key == key && !_buckets[index]!.isDeleted) {
        return index;
      }
      
      if (forInsertion && _buckets[index]!.isDeleted) {
        return index;
      }
      
      i++;
    }
    
    return -1;
  }
  
  void put(K key, V value) {
    if (_size >= _capacity * 0.7) {
      _resize();
    }
    
    int index = _probe(key, true);
    if (index == -1) {
      throw Exception('Hash table is full');
    }
    
    if (_buckets[index] == null || _buckets[index]!.isDeleted) {
      _buckets[index] = KeyValuePair<K, V>(key, value);
      _size++;
    } else {
      _buckets[index]!.value = value;
    }
  }
  
  V? get(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      return _buckets[index]!.value;
    }
    return null;
  }
  
  bool remove(K key) {
    int index = _probe(key);
    if (index != -1 && _buckets[index] != null && !_buckets[index]!.isDeleted) {
      _buckets[index]!.isDeleted = true;
      _size--;
      return true;
    }
    return false;
  }
  
  void _resize() {
    List<KeyValuePair<K, V>?> oldBuckets = _buckets;
    int oldCapacity = _capacity;
    
    _capacity = _getNextPrime(_capacity * 2);
    _buckets = List.filled(_capacity, null);
    _size = 0;
    
    for (int i = 0; i < oldCapacity; i++) {
      if (oldBuckets[i] != null && !oldBuckets[i]!.isDeleted) {
        put(oldBuckets[i]!.key, oldBuckets[i]!.value);
      }
    }
  }
  
  int _getNextPrime(int n) {
    while (!_isPrime(n)) {
      n++;
    }
    return n;
  }
  
  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }
  
  void display() {
    print('\n=== Hash Table with Double Hashing ===');
    for (int i = 0; i < _capacity; i++) {
      String status = 'empty';
      if (_buckets[i] != null) {
        if (_buckets[i]!.isDeleted) {
          status = 'deleted (${_buckets[i]})';
        } else {
          status = _buckets[i].toString();
        }
      }
      print('Slot $i: $status');
    }
    print('Size: $_size, Capacity: $_capacity');
    print('Load Factor: ${(_size / _capacity).toStringAsFixed(2)}');
  }
}

// Demonstration and Examples
void main() {
  print('=== Hash Table Collisions in Dart ===\n');
  
  print('''
COLLISION CONCEPTS:
• Collision: When two different keys hash to the same index
• Inevitable due to pigeonhole principle (more keys than slots)
• Load Factor: number of elements / table size
• Good hash functions minimize but don't eliminate collisions

COLLISION RESOLUTION METHODS:
1. Separate Chaining (Closed Addressing)
2. Open Addressing:
   - Linear Probing
   - Quadratic Probing  
   - Double Hashing
  ''');
  
  // Example keys that will cause collisions
  List<String> keys = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
  List<int> values = [1, 2, 3, 4, 5];
  
  print('\n1. SEPARATE CHAINING EXAMPLE:');
  print('=' * 40);
  
  var chainTable = HashTableChaining<String, int>(5);
  
  for (int i = 0; i < keys.length; i++) {
    print('Inserting ${keys[i]} -> ${values[i]}');
    chainTable.put(keys[i], values[i]);
  }
  
  chainTable.display();
  print('\nCollision Stats: ${chainTable.getCollisionStats()}');
  
  print('\nSearching for "banana": ${chainTable.get("banana")}');
  print('Searching for "grape": ${chainTable.get("grape")}');
  
  print('\n2. LINEAR PROBING EXAMPLE:');
  print('=' * 40);
  
  var linearTable = HashTableLinearProbing<String, int>(7);
  
  for (int i = 0; i < keys.length; i++) {
    print('Inserting ${keys[i]} -> ${values[i]}');
    linearTable.put(keys[i], values[i]);
  }
  
  linearTable.display();
  print('\nProbing Stats: ${linearTable.getProbingStats()}');
  
  print('\nRemoving "banana"...');
  linearTable.remove("banana");
  linearTable.display();
  
  print('\n3. QUADRATIC PROBING EXAMPLE:');
  print('=' * 40);
  
  var quadraticTable = HashTableQuadraticProbing<String, int>(7);
  
  for (int i = 0; i < keys.length; i++) {
    print('Inserting ${keys[i]} -> ${values[i]}');
    quadraticTable.put(keys[i], values[i]);
  }
  
  quadraticTable.display();
  
  print('\n4. DOUBLE HASHING EXAMPLE:');
  print('=' * 40);
  
  var doubleHashTable = HashTableDoubleHashing<String, int>(7);
  
  for (int i = 0; i < keys.length; i++) {
    print('Inserting ${keys[i]} -> ${values[i]}');
    doubleHashTable.put(keys[i], values[i]);
  }
  
  doubleHashTable.display();
  
  print('\n5. COLLISION COMPARISON:');
  print('=' * 40);
  print('''
Separate Chaining:
✓ Simple implementation
✓ No clustering issues
✓ Can exceed load factor of 1
✗ Extra memory for pointers
✗ Cache performance may suffer

Linear Probing:
✓ Good cache performance
✓ Memory efficient
✗ Primary clustering
✗ Performance degrades with high load factor

Quadratic Probing:
✓ Reduces primary clustering
✓ Better than linear probing
✗ Secondary clustering
✗ May not find empty slot even if available

Double Hashing:
✓ Excellent collision distribution
✓ Minimizes clustering
✓ Good performance
✗ More complex implementation
✗ Two hash function computations

PERFORMANCE COMPARISON:
Operation    | Chaining | Linear | Quadratic | Double
-------------|----------|---------|-----------|--------
Search       | O(1+α)   | O(1+α²) | O(1+α²)   | O(1+α²)
Insert       | O(1)     | O(1+α²) | O(1+α²)   | O(1+α²)
Delete       | O(1+α)   | O(1+α²) | O(1+α²)   | O(1+α²)

Where α = load factor (n/m)
  ''');
  
  print('\n6. BEST PRACTICES:');
  print('=' * 40);
  print('''
• Keep load factor < 0.75 for open addressing
• Use prime table sizes for better distribution
• Choose good hash functions (uniform distribution)
• Consider chaining for high load factors
• Use lazy deletion for open addressing
• Resize table when load factor exceeds threshold
• Test collision resolution with your data patterns
  ''');
}
