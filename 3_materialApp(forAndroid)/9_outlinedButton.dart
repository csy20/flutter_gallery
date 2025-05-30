
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutlinedButton Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OutlinedButtonDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OutlinedButtonDemo extends StatefulWidget {
  const OutlinedButtonDemo({Key? key}) : super(key: key);

  @override
  State<OutlinedButtonDemo> createState() => _OutlinedButtonDemoState();
}

class _OutlinedButtonDemoState extends State<OutlinedButtonDemo> {
  bool _isLoading = false;
  String _statusMessage = 'Ready';
  String _selectedFilter = 'All';
  bool _isToggled = false;
  String _selectedOption = 'Option 1';

  void _showMessage(String message) {
    setState(() {
      _statusMessage = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _simulateAsyncOperation() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Processing...';
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _statusMessage = 'Operation completed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OutlinedButton Examples'),
        // OutlinedButton in AppBar actions
        actions: [
          OutlinedButton(
            onPressed: () {
              _showMessage('AppBar OutlinedButton pressed!');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
            ),
            child: const Text('Settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Status: $_statusMessage',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // 1. Basic OutlinedButton
            const Text(
              '1. Basic OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                _showMessage('Basic OutlinedButton pressed!');
              },
              child: const Text('Basic OutlinedButton'),
            ),
            const SizedBox(height: 20),

            // 2. Disabled OutlinedButton
            const Text(
              '2. Disabled OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: null, // null makes the button disabled
              child: const Text('Disabled OutlinedButton'),
            ),
            const SizedBox(height: 20),

            // 3. OutlinedButton with Icon
            const Text(
              '3. OutlinedButton with Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                _showMessage('Icon OutlinedButton pressed!');
              },
              icon: const Icon(Icons.download),
              label: const Text('Download'),
            ),
            const SizedBox(height: 20),

            // 4. Styled OutlinedButton
            const Text(
              '4. Styled OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                _showMessage('Styled OutlinedButton pressed!');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.purple, // Text and border color
                backgroundColor: Colors.purple.withOpacity(0.1), // Background
                side: const BorderSide(color: Colors.purple, width: 2), // Border
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Custom Styled'),
            ),
            const SizedBox(height: 20),

            // 5. Different Border Styles
            const Text(
              '5. Different Border Styles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Thick border
            OutlinedButton(
              onPressed: () => _showMessage('Thick border pressed!'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 3),
              ),
              child: const Text('Thick Border'),
            ),
            const SizedBox(height: 10),
            
            // Dashed border effect (using custom border)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: OutlinedButton(
                onPressed: () => _showMessage('Custom border pressed!'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none, // Remove default border
                  foregroundColor: Colors.orange,
                ),
                child: const Text('Custom Border'),
              ),
            ),
            const SizedBox(height: 20),

            // 6. Loading OutlinedButton
            const Text(
              '6. Loading/Async OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _isLoading ? null : _simulateAsyncOperation,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Start Process'),
            ),
            const SizedBox(height: 20),

            // 7. Different Button Sizes
            const Text(
              '7. Different OutlinedButton Sizes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Small button
            SizedBox(
              height: 32,
              child: OutlinedButton(
                onPressed: () => _showMessage('Small button pressed!'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  textStyle: const TextStyle(fontSize: 12),
                  side: const BorderSide(width: 1),
                ),
                child: const Text('Small'),
              ),
            ),
            const SizedBox(height: 10),
            
            // Medium button (default)
            OutlinedButton(
              onPressed: () => _showMessage('Medium button pressed!'),
              child: const Text('Medium (Default)'),
            ),
            const SizedBox(height: 10),
            
            // Large button
            SizedBox(
              height: 56,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showMessage('Large button pressed!'),
                style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  side: const BorderSide(width: 2),
                ),
                child: const Text('Large Full Width'),
              ),
            ),
            const SizedBox(height: 20),

            // 8. Filter Buttons Example
            const Text(
              '8. Filter Buttons with OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: ['All', 'Active', 'Completed', 'Archived'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                    _showMessage('Filter: $filter selected');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isSelected ? Colors.white : Colors.blue,
                    backgroundColor: isSelected ? Colors.blue : Colors.transparent,
                    side: BorderSide(
                      color: Colors.blue,
                      width: isSelected ? 0 : 1,
                    ),
                  ),
                  child: Text(filter),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 9. Toggle Button Example
            const Text(
              '9. Toggle OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isToggled = !_isToggled;
                });
                _showMessage(_isToggled ? 'Favorited!' : 'Unfavorited!');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: _isToggled ? Colors.red : Colors.grey,
                backgroundColor: _isToggled ? Colors.red.withOpacity(0.1) : null,
                side: BorderSide(
                  color: _isToggled ? Colors.red : Colors.grey,
                ),
              ),
              icon: Icon(_isToggled ? Icons.favorite : Icons.favorite_border),
              label: Text(_isToggled ? 'Favorited' : 'Add to Favorites'),
            ),
            const SizedBox(height: 20),

            // 10. Chip-style Buttons
            const Text(
              '10. Chip-style OutlinedButtons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Flutter', 'Dart', 'Mobile', 'Web', 'Desktop'].map((tag) {
                return OutlinedButton(
                  onPressed: () => _showMessage('Tag: $tag selected'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: const StadiumBorder(), // Pill shape
                    side: const BorderSide(color: Colors.green),
                    foregroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: Text(tag),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 11. Selection Group
            const Text(
              '11. Selection Group with OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: ['Option 1', 'Option 2', 'Option 3'].map((option) {
                final isSelected = _selectedOption == option;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedOption = option;
                      });
                      _showMessage('Selected: $option');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isSelected ? Colors.white : Colors.blue,
                      backgroundColor: isSelected ? Colors.blue : null,
                      side: const BorderSide(color: Colors.blue),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(option),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 12. Button State Management
            const Text(
              '12. OutlinedButton State Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const OutlinedButtonStateDemo(),
            const SizedBox(height: 20),

            // 13. Theme-based OutlinedButton
            const Text(
              '13. Theme-based OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal, width: 2),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              child: OutlinedButton(
                onPressed: () => _showMessage('Theme button pressed!'),
                child: const Text('Theme-based Button'),
              ),
            ),
            const SizedBox(height: 20),

            // 14. Card Actions Example
            const Text(
              '14. Card Actions with OutlinedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Card',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('This is a sample product description.'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => _showMessage('Added to wishlist'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                            side: BorderSide(color: Colors.grey[400]!),
                          ),
                          child: const Text('Wishlist'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _showMessage('Added to cart'),
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Demo widget for OutlinedButton state management
class OutlinedButtonStateDemo extends StatefulWidget {
  const OutlinedButtonStateDemo({Key? key}) : super(key: key);

  @override
  State<OutlinedButtonStateDemo> createState() => _OutlinedButtonStateDemoState();
}

class _OutlinedButtonStateDemoState extends State<OutlinedButtonStateDemo> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          onHover: (hovering) {
            setState(() {
              _isHovered = hovering;
            });
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || _isPressed) {
                  return Colors.white;
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return Colors.orange;
                }
                return Colors.blue; // Default color
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || _isPressed) {
                  return Colors.blue;
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return Colors.orange.withOpacity(0.1);
                }
                return Colors.transparent; // Default
              },
            ),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || _isPressed) {
                  return const BorderSide(color: Colors.blue, width: 2);
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return const BorderSide(color: Colors.orange, width: 2);
                }
                return const BorderSide(color: Colors.blue, width: 1);
              },
            ),
          ),
          child: Text(_isPressed ? 'Pressed!' : 'Hover/Click Me'),
        ),
        const SizedBox(height: 10),
        Text(
          'State: ${_isPressed ? "Pressed" : _isHovered ? "Hovered" : "Normal"}',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// Example of a reusable custom OutlinedButton
class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final IconData? icon;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.borderWidth,
    this.width,
    this.height,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? Theme.of(context).primaryColor,
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: borderWidth ?? 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 8),
            ],
            Text(text),
          ],
        ),
      ),
    );
  }
}