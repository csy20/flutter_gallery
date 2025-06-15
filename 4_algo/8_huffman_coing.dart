/*
 * HUFFMAN CODING ALGORITHM IN DART
 * 
 * Huffman coding is a lossless data compression algorithm that uses variable-length
 * codes for different characters. Characters that occur more frequently are assigned
 * shorter codes, while less frequent characters get longer codes.
 * 
 * Time Complexity: O(n log n) for building tree, O(m) for encoding/decoding
 * Space Complexity: O(n) where n is number of unique characters
 * 
 * Key Properties:
 * - Lossless compression
 * - Variable-length encoding
 * - Prefix-free codes (no code is prefix of another)
 * - Optimal for character-based compression
 */

import 'dart:collection';

void main() {
  print("=== HUFFMAN CODING ALGORITHM DEMONSTRATION ===\n");
  
  // Example 1: Simple text with repeated characters
  print("--- Example 1: Simple Text ---");
  HuffmanCoding huffman1 = HuffmanCoding();
  String text1 = "aaaaabbbccd";
  demonstrateCompression(huffman1, text1);
  
  print("\n" + "="*60 + "\n");
  
  // Example 2: English sentence
  print("--- Example 2: English Sentence ---");
  HuffmanCoding huffman2 = HuffmanCoding();
  String text2 = "this is an example of huffman encoding";
  demonstrateCompression(huffman2, text2);
  
  print("\n" + "="*60 + "\n");
  
  // Example 3: Edge case - single character type
  print("--- Example 3: Single Character Type ---");
  HuffmanCoding huffman3 = HuffmanCoding();
  String text3 = "aaaa";
  demonstrateCompression(huffman3, text3);
  
  print("\n" + "="*60 + "\n");
  
  // Performance comparison
  print("--- Performance Analysis ---");
  performanceAnalysis();
}

/**
 * Node class for Huffman Tree
 * Each node contains character, frequency, and left/right children
 */
class HuffmanNode {
  String? character;  // null for internal nodes
  int frequency;
  HuffmanNode? left;
  HuffmanNode? right;
  
  HuffmanNode(this.character, this.frequency, [this.left, this.right]);
  
  // Check if node is a leaf (contains actual character)
  bool get isLeaf => left == null && right == null;
  
  @override
  String toString() {
    return '${character ?? "Internal"}($frequency)';
  }
}

/**
 * Priority Queue implementation for Huffman nodes
 * Orders nodes by frequency (min-heap)
 */
class PriorityQueue {
  final List<HuffmanNode> _nodes = [];
  
  void insert(HuffmanNode node) {
    _nodes.add(node);
    // Sort by frequency (ascending order)
    _nodes.sort((a, b) => a.frequency.compareTo(b.frequency));
  }
  
  HuffmanNode extractMin() {
    if (_nodes.isEmpty) throw StateError('Queue is empty');
    return _nodes.removeAt(0);
  }
  
  bool get isEmpty => _nodes.isEmpty;
  int get length => _nodes.length;
  
  @override
  String toString() {
    return _nodes.map((node) => node.toString()).join(', ');
  }
}

/**
 * Main Huffman Coding Class
 * Handles encoding, decoding, and tree construction
 */
class HuffmanCoding {
  Map<String, int> _frequencies = {};
  HuffmanNode? _root;
  Map<String, String> _codes = {};
  
  /**
   * Step 1: Calculate character frequencies in the text
   */
  void _calculateFrequencies(String text) {
    _frequencies.clear();
    print("Calculating character frequencies...");
    
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      _frequencies[char] = (_frequencies[char] ?? 0) + 1;
    }
    
    print("Character frequencies:");
    _frequencies.forEach((char, freq) {
      String displayChar = char == ' ' ? 'SPACE' : char;
      print("  '$displayChar': $freq");
    });
  }
  
  /**
   * Step 2: Build Huffman Tree using greedy algorithm
   */
  void _buildHuffmanTree() {
    PriorityQueue pq = PriorityQueue();
    
    print("\nBuilding Huffman Tree...");
    
    // Create leaf nodes for each character
    _frequencies.forEach((char, freq) {
      pq.insert(HuffmanNode(char, freq));
    });
    
    print("Initial priority queue: $pq");
    
    // Build tree bottom-up by merging nodes
    int step = 1;
    while (pq.length > 1) {
      HuffmanNode left = pq.extractMin();
      HuffmanNode right = pq.extractMin();
      
      // Create internal node with combined frequency
      HuffmanNode merged = HuffmanNode(
        null,  // Internal nodes have no character
        left.frequency + right.frequency,
        left,
        right
      );
      
      pq.insert(merged);
      
      print("Step $step: Merge $left + $right = ${merged.frequency}");
      step++;
    }
    
    _root = pq.extractMin();
    print("Tree construction complete. Root frequency: ${_root?.frequency}");
  }
  
  /**
   * Step 3: Generate Huffman codes by traversing the tree
   * Left edge = '0', Right edge = '1'
   */
  void _generateCodes() {
    _codes.clear();
    print("\nGenerating Huffman codes...");
    
    if (_root != null) {
      if (_root!.isLeaf) {
        // Special case: only one unique character
        _codes[_root!.character!] = '0';
        print("Single character case: '${_root!.character}' -> '0'");
      } else {
        _generateCodesRecursive(_root!, '');
      }
    }
    
    print("Generated codes:");
    _codes.forEach((char, code) {
      String displayChar = char == ' ' ? 'SPACE' : char;
      print("  '$displayChar' -> '$code'");
    });
  }
  
  /**
   * Recursive helper to generate codes
   */
  void _generateCodesRecursive(HuffmanNode node, String code) {
    if (node.isLeaf) {
      _codes[node.character!] = code.isEmpty ? '0' : code;
      return;
    }
    
    if (node.left != null) {
      _generateCodesRecursive(node.left!, code + '0');
    }
    if (node.right != null) {
      _generateCodesRecursive(node.right!, code + '1');
    }
  }
  
  /**
   * Encode text using generated Huffman codes
   */
  String encode(String text) {
    print("\n=== ENCODING PROCESS ===");
    
    if (text.isEmpty) {
      print("Empty text provided");
      return '';
    }
    
    // Build the Huffman tree and generate codes
    _calculateFrequencies(text);
    _buildHuffmanTree();
    _generateCodes();
    
    // Encode the text
    StringBuffer encoded = StringBuffer();
    print("\nEncoding character by character:");
    
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      String code = _codes[char]!;
      encoded.write(code);
      
      String displayChar = char == ' ' ? 'SPACE' : char;
      print("  '$displayChar' -> '$code'");
    }
    
    String result = encoded.toString();
    print("\nEncoding Results:");
    print("Original text: \"$text\"");
    print("Encoded text:  \"$result\"");
    
    return result;
  }
  
  /**
   * Decode Huffman encoded text back to original
   */
  String decode(String encodedText) {
    print("\n=== DECODING PROCESS ===");
    
    if (_root == null) {
      throw StateError('Huffman tree not built. Encode text first.');
    }
    
    if (encodedText.isEmpty) {
      return '';
    }
    
    StringBuffer decoded = StringBuffer();
    HuffmanNode current = _root!;
    
    print("Decoding bit by bit:");
    print("Encoded: \"$encodedText\"");
    
    for (int i = 0; i < encodedText.length; i++) {
      String bit = encodedText[i];
      
      // Traverse tree based on bit value
      if (bit == '0') {
        current = current.left!;
      } else if (bit == '1') {
        current = current.right!;
      } else {
        throw ArgumentError('Invalid bit: $bit');
      }
      
      // If we reach a leaf, we found a complete character
      if (current.isLeaf) {
        decoded.write(current.character!);
        current = _root!;  // Reset to root for next character
      }
    }
    
    String result = decoded.toString();
    print("Decoded text: \"$result\"");
    
    return result;
  }
  
  /**
   * Print the structure of the Huffman tree
   */
  void printTree() {
    print("\n=== HUFFMAN TREE STRUCTURE ===");
    if (_root != null) {
      _printTreeRecursive(_root!, '', true);
    } else {
      print("Tree not built yet");
    }
  }
  
  void _printTreeRecursive(HuffmanNode node, String prefix, bool isLast) {
    String nodeDisplay = node.character != null 
        ? (node.character == ' ' ? 'SPACE' : "'${node.character}'")
        : 'Internal';
    
    print('$prefix${isLast ? '└── ' : '├── '}$nodeDisplay(${node.frequency})');
    
    List<HuffmanNode> children = [];
    if (node.left != null) children.add(node.left!);
    if (node.right != null) children.add(node.right!);
    
    for (int i = 0; i < children.length; i++) {
      bool isLastChild = i == children.length - 1;
      String newPrefix = prefix + (isLast ? '    ' : '│   ');
      _printTreeRecursive(children[i], newPrefix, isLastChild);
    }
  }
  
  /**
   * Calculate and display compression statistics
   */
  void printCompressionStats(String originalText, String encodedText) {
    print("\n=== COMPRESSION STATISTICS ===");
    
    int originalBits = originalText.length * 8;  // ASCII uses 8 bits per char
    int compressedBits = encodedText.length;
    double compressionRatio = originalBits > 0 
        ? (1 - compressedBits / originalBits) * 100 
        : 0;
    double averageBitsPerChar = originalText.length > 0 
        ? compressedBits / originalText.length 
        : 0;
    
    print("Original text length: ${originalText.length} characters");
    print("Original size (ASCII): $originalBits bits");
    print("Compressed size: $compressedBits bits");
    print("Compression ratio: ${compressionRatio.toStringAsFixed(2)}%");
    print("Average bits per character: ${averageBitsPerChar.toStringAsFixed(2)}");
    print("Space saved: ${originalBits - compressedBits} bits");
    
    if (compressionRatio > 0) {
      print("✅ Compression achieved!");
    } else {
      print("❌ No compression (or expansion occurred)");
    }
  }
  
  /**
   * Verify that encoding and decoding work correctly
   */
  bool verifyCompression(String original, String encoded) {
    String decoded = decode(encoded);
    bool isCorrect = original == decoded;
    
    print("\n=== VERIFICATION ===");
    print("Original:  \"$original\"");
    print("Decoded:   \"$decoded\"");
    print("Correct:   ${isCorrect ? '✅ YES' : '❌ NO'}");
    
    return isCorrect;
  }
}

/**
 * Demonstration helper function
 */
void demonstrateCompression(HuffmanCoding huffman, String text) {
  print("Input text: \"$text\"");
  
  // Encode
  String encoded = huffman.encode(text);
  
  // Show tree structure
  huffman.printTree();
  
  // Decode and verify
  huffman.verifyCompression(text, encoded);
  
  // Show statistics
  huffman.printCompressionStats(text, encoded);
}

/**
 * Performance analysis with different text types
 */
void performanceAnalysis() {
  List<Map<String, String>> testCases = [
    {"name": "Highly repetitive", "text": "aaaaaaaaaa"},
    {"name": "Uniform distribution", "text": "abcdefghij"},
    {"name": "Skewed distribution", "text": "aaaaabbbccd"},
    {"name": "English text", "text": "hello world"},
    {"name": "Programming text", "text": "if(x==y){return true;}"},
    {"name": "Long sentence", "text": "the quick brown fox jumps over the lazy dog"},
  ];
  
  print("Performance Analysis:");
  print("${'Type'.padRight(20)} | ${'Length'.padRight(6)} | ${'Original'.padRight(8)} | ${'Compressed'.padRight(10)} | ${'Ratio'.padRight(8)}");
  print("-" * 70);
  
  for (var testCase in testCases) {
    HuffmanCoding huffman = HuffmanCoding();
    String text = testCase["text"]!;
    String encoded = huffman.encode(text);
    
    int originalBits = text.length * 8;
    int compressedBits = encoded.length;
    double ratio = originalBits > 0 ? (1 - compressedBits / originalBits) * 100 : 0;
    
    print("${testCase['name']!.padRight(20)} | "
          "${text.length.toString().padRight(6)} | "
          "${originalBits.toString().padRight(8)} | "
          "${compressedBits.toString().padRight(10)} | "
          "${ratio.toStringAsFixed(1).padRight(8)}%");
  }
}

/**
 * ADVANTAGES OF HUFFMAN CODING:
 * 1. Optimal for character-based compression when frequencies are known
 * 2. Lossless compression - no data is lost
 * 3. Variable-length encoding reduces average code length
 * 4. Prefix-free codes ensure unique decoding
 * 5. Simple and elegant algorithm
 * 6. Forms basis for many modern compression algorithms
 * 
 * DISADVANTAGES OF HUFFMAN CODING:
 * 1. Requires two passes over data (frequency calculation + encoding)
 * 2. Need to store/transmit the Huffman tree with compressed data
 * 3. Not adaptive - tree is fixed after construction
 * 4. Poor performance on uniformly distributed data
 * 5. Character-based approach misses longer patterns
 * 
 * APPLICATIONS OF HUFFMAN CODING:
 * 1. File compression (ZIP, GZIP use variants)
 * 2. Image compression (JPEG uses Huffman for entropy coding)
 * 3. Video compression standards
 * 4. Network protocols for data transmission
 * 5. Database compression
 * 6. Fax machine compression
 * 
 * VARIANTS AND IMPROVEMENTS:
 * 1. Adaptive Huffman - updates tree dynamically
 * 2. Canonical Huffman - standardized tree representation
 * 3. Length-limited Huffman - restricts maximum code length
 * 4. Combined with other techniques (LZ77, arithmetic coding)
 */