
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextButton Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TextButtonDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TextButtonDemo extends StatefulWidget {
  const TextButtonDemo({Key? key}) : super(key: key);

  @override
  State<TextButtonDemo> createState() => _TextButtonDemoState();
}

class _TextButtonDemoState extends State<TextButtonDemo> {
  bool _isLoading = false;
  String _statusMessage = 'Ready';
  int _counter = 0;

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
      _statusMessage = 'Loading...';
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
        title: const Text('TextButton Examples'),
        // TextButtons are commonly used in AppBar actions
        actions: [
          TextButton(
            onPressed: () {
              _showMessage('AppBar TextButton pressed!');
            },
            child: const Text(
              'Action',
              style: TextStyle(color: Colors.white),
            ),
          ),
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

            // 1. Basic TextButton
            const Text(
              '1. Basic TextButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _showMessage('Basic TextButton pressed!');
              },
              child: const Text('Basic TextButton'),
            ),
            const SizedBox(height: 20),

            // 2. Disabled TextButton
            const Text(
              '2. Disabled TextButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: null, // null makes the button disabled
              child: const Text('Disabled TextButton'),
            ),
            const SizedBox(height: 20),

            // 3. TextButton with Icon
            const Text(
              '3. TextButton with Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                _showMessage('Icon TextButton pressed!');
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Like'),
            ),
            const SizedBox(height: 20),

            // 4. Styled TextButton
            const Text(
              '4. Styled TextButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _showMessage('Styled TextButton pressed!');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple, // Text color
                backgroundColor: Colors.purple.withOpacity(0.1), // Background
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

            // 5. TextButton with Border
            const Text(
              '5. TextButton with Border',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _showMessage('Bordered TextButton pressed!');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue, width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Bordered TextButton'),
            ),
            const SizedBox(height: 20),

            // 6. Loading TextButton
            const Text(
              '6. Loading/Async TextButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _isLoading ? null : _simulateAsyncOperation,
              child: _isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Start Operation'),
            ),
            const SizedBox(height: 20),

            // 7. TextButton Sizes
            const Text(
              '7. Different TextButton Sizes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Small TextButton
            TextButton(
              onPressed: () => _showMessage('Small TextButton pressed!'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Small'),
            ),
            
            // Medium TextButton (default)
            TextButton(
              onPressed: () => _showMessage('Medium TextButton pressed!'),
              child: const Text('Medium (Default)'),
            ),
            
            // Large TextButton
            TextButton(
              onPressed: () => _showMessage('Large TextButton pressed!'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Large'),
            ),
            const SizedBox(height: 20),

            // 8. Counter Example
            const Text(
              '8. Interactive Counter with TextButtons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  child: const Text('-'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_counter',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 9. Dialog Example
            const Text(
              '9. Dialog with TextButtons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _showConfirmDialog(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
              child: const Text('Show Dialog'),
            ),
            const SizedBox(height: 20),

            // 10. Button State Management
            const Text(
              '10. TextButton State Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const TextButtonStateDemo(),
            const SizedBox(height: 20),

            // 11. Theme-based TextButton
            const Text(
              '11. Theme-based TextButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    padding: const EdgeInsets.all(16),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () => _showMessage('Theme TextButton pressed!'),
                child: const Text('Theme-based TextButton'),
              ),
            ),
            const SizedBox(height: 20),

            // 12. Navigation Example
            const Text(
              '12. Navigation with TextButtons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondScreen(),
                      ),
                    );
                  },
                  child: const Text('Go to Next'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 13. Overflow Menu Example
            const Text(
              '13. Overflow Menu with TextButtons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const OverflowMenuDemo(),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Action'),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showMessage('Action cancelled');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showMessage('Action confirmed');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Demo widget for TextButton state management
class TextButtonStateDemo extends StatefulWidget {
  const TextButtonStateDemo({Key? key}) : super(key: key);

  @override
  State<TextButtonStateDemo> createState() => _TextButtonStateDemoState();
}

class _TextButtonStateDemoState extends State<TextButtonStateDemo> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
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
                  return Colors.red;
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return Colors.orange;
                }
                return Colors.blue; // Default color
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || _isPressed) {
                  return Colors.red.withOpacity(0.1);
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return Colors.orange.withOpacity(0.1);
                }
                return Colors.transparent; // Default
              },
            ),
          ),
          child: Text(_isPressed ? 'Pressed!' : 'Click Me'),
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

// Example of overflow menu with TextButtons
class OverflowMenuDemo extends StatefulWidget {
  const OverflowMenuDemo({Key? key}) : super(key: key);

  @override
  State<OverflowMenuDemo> createState() => _OverflowMenuDemoState();
}

class _OverflowMenuDemoState extends State<OverflowMenuDemo> {
  String _selectedOption = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Selected: $_selectedOption'),
        const SizedBox(height: 10),
        PopupMenuButton<String>(
          onSelected: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Option 1',
              child: Text('Option 1'),
            ),
            const PopupMenuItem(
              value: 'Option 2',
              child: Text('Option 2'),
            ),
            const PopupMenuItem(
              value: 'Option 3',
              child: Text('Option 3'),
            ),
          ],
          child: TextButton(
            onPressed: null, // PopupMenuButton handles the press
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Option'),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Second screen for navigation example
class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        // TextButton in AppBar leading
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the second screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of a reusable custom TextButton
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final IconData? icon;

  const CustomTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? Theme.of(context).primaryColor,
        backgroundColor: backgroundColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: TextStyle(
          fontSize: fontSize ?? 14,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize ?? 14),
            const SizedBox(width: 8),
          ],
          Text(text),
        ],
      ),
    );
  }
}