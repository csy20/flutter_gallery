
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElevatedButton Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ElevatedButtonDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ElevatedButtonDemo extends StatefulWidget {
  const ElevatedButtonDemo({Key? key}) : super(key: key);

  @override
  State<ElevatedButtonDemo> createState() => _ElevatedButtonDemoState();
}

class _ElevatedButtonDemoState extends State<ElevatedButtonDemo> {
  bool _isLoading = false;
  String _statusMessage = 'Ready';

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

    // Simulate a network request or async operation
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
        title: const Text('ElevatedButton Examples'),
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

            // 1. Basic ElevatedButton
            const Text(
              '1. Basic ElevatedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showMessage('Basic button pressed!');
              },
              child: const Text('Basic ElevatedButton'),
            ),
            const SizedBox(height: 20),

            // 2. Disabled ElevatedButton
            const Text(
              '2. Disabled ElevatedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: null, // null makes the button disabled
              child: const Text('Disabled Button'),
            ),
            const SizedBox(height: 20),

            // 3. ElevatedButton with Icon
            const Text(
              '3. ElevatedButton with Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _showMessage('Icon button pressed!');
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Message'),
            ),
            const SizedBox(height: 20),

            // 4. Styled ElevatedButton
            const Text(
              '4. Styled ElevatedButton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showMessage('Styled button pressed!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Background color
                foregroundColor: Colors.white, // Text color
                elevation: 8, // Shadow elevation
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Custom Styled Button'),
            ),
            const SizedBox(height: 20),

            // 5. Loading Button
            const Text(
              '5. Loading/Async Button',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _simulateAsyncOperation,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Start Async Operation'),
            ),
            const SizedBox(height: 20),

            // 6. Different Button Sizes
            const Text(
              '6. Different Button Sizes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Small button
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () => _showMessage('Small button pressed!'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text('Small'),
              ),
            ),
            const SizedBox(height: 10),
            
            // Medium button (default)
            ElevatedButton(
              onPressed: () => _showMessage('Medium button pressed!'),
              child: const Text('Medium (Default)'),
            ),
            const SizedBox(height: 10),
            
            // Large button
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showMessage('Large button pressed!'),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Large Full Width'),
              ),
            ),
            const SizedBox(height: 20),

            // 7. Button with Gradient Background
            const Text(
              '7. Gradient Background Button',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: () => _showMessage('Gradient button pressed!'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Gradient Button',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 8. Outlined Style Button
            const Text(
              '8. Custom Outlined Style',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showMessage('Outlined style pressed!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                elevation: 0,
                side: const BorderSide(color: Colors.blue, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Outlined Style'),
            ),
            const SizedBox(height: 20),

            // 9. Button with Custom Splash Effect
            const Text(
              '9. Custom Splash Effect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showMessage('Custom splash pressed!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                splashFactory: InkRipple.splashFactory,
                overlayColor: Colors.yellow.withOpacity(0.3),
              ),
              child: const Text('Custom Splash'),
            ),
            const SizedBox(height: 20),

            // 10. Button States Demo
            const Text(
              '10. Button State Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ButtonStateDemo(),
            const SizedBox(height: 20),

            // 11. Theme-based Button
            const Text(
              '11. Theme-based Button',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () => _showMessage('Theme button pressed!'),
                child: const Text('Theme-based Button'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Demo widget for button state management
class ButtonStateDemo extends StatefulWidget {
  const ButtonStateDemo({Key? key}) : super(key: key);

  @override
  State<ButtonStateDemo> createState() => _ButtonStateDemoState();
}

class _ButtonStateDemoState extends State<ButtonStateDemo> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
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
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || _isPressed) {
                  return Colors.red;
                } else if (states.contains(MaterialState.hovered) || _isHovered) {
                  return Colors.orange;
                }
                return Colors.blue; // Default color
              },
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
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

// Example of a reusable custom ElevatedButton
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
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