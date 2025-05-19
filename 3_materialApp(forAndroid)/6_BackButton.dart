import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Back Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Button Demo'),
        // No back button on first screen
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StandardBackButtonScreen(),
                  ),
                );
              },
              child: const Text('Default AppBar Back Button'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomBackButtonScreen(),
                  ),
                );
              },
              child: const Text('Custom Back Button'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BackButtonWidgetScreen(),
                  ),
                );
              },
              child: const Text('Back Button Widget'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomBackHandlingScreen(),
                  ),
                );
              },
              child: const Text('Custom Back Handling'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SystemBackButtonScreen(),
                  ),
                );
              },
              child: const Text('System Back Button'),
            ),
          ],
        ),
      ),
    );
  }
}

// 1. Default AppBar Back Button
class StandardBackButtonScreen extends StatelessWidget {
  const StandardBackButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Back Button'),
        // The back button is automatically included in the AppBar
        // when there is a previous route in the navigation stack
      ),
      body: const Center(
        child: Text(
          'The AppBar automatically includes a back button when this screen is pushed onto the navigation stack.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// 2. Custom Back Button in AppBar
class CustomBackButtonScreen extends StatelessWidget {
  const CustomBackButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom AppBar Back Button'),
        // Hide the automatic back button
        automaticallyImplyLeading: false,
        // Add custom leading widget (back button)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Custom icon
          onPressed: () {
            // Custom action when back button is pressed
            print('Custom back button pressed');
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text(
          'This screen has a custom back button in the AppBar with an iOS-style arrow and custom handling.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// 3. BackButton Widget Demo
class BackButtonWidgetScreen extends StatelessWidget {
  const BackButtonWidgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackButton Widget'),
        // Hide the automatic back button
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Flutter provides built-in BackButton widget',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            // Default BackButton widget
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Default BackButton:'),
                SizedBox(width: 10),
                BackButton(),
              ],
            ),
            const SizedBox(height: 20),
            // Customized BackButton widget
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Customized BackButton:'),
                const SizedBox(width: 10),
                BackButton(
                  color: Colors.red, // Customize color
                  onPressed: () {
                    // Custom action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Custom back action!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            // CloseButton is similar to BackButton but with X icon
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Built-in CloseButton:'),
                SizedBox(width: 10),
                CloseButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Custom Back Button with Custom Handling
class CustomBackHandlingScreen extends StatefulWidget {
  const CustomBackHandlingScreen({Key? key}) : super(key: key);

  @override
  State<CustomBackHandlingScreen> createState() => _CustomBackHandlingScreenState();
}

class _CustomBackHandlingScreenState extends State<CustomBackHandlingScreen> {
  bool _hasUnsavedChanges = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // WillPopScope catches the system or app back button presses
      onWillPop: () async {
        if (_hasUnsavedChanges) {
          // Show confirmation dialog if there are unsaved changes
          final shouldPop = await _showConfirmationDialog(context);
          return shouldPop ?? false;
        }
        // Allow back navigation without confirmation
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Back Handling'),
          // Override the default back button behavior
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (_hasUnsavedChanges) {
                final shouldPop = await _showConfirmationDialog(context);
                if (shouldPop == true) {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                }
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This screen asks for confirmation before going back when there are "unsaved changes"',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unsaved Changes:'),
                  Switch(
                    value: _hasUnsavedChanges,
                    onChanged: (value) {
                      setState(() {
                        _hasUnsavedChanges = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Try using the back button now',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved changes. Are you sure you want to leave this screen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Don't leave the screen
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Leave the screen
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }
}

// 5. System Back Button
class SystemBackButtonScreen extends StatelessWidget {
  const SystemBackButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Back Button'),
        // Hide the automatic back button
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Custom handling of Android system back button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Press the Android back button or use the custom exit button below',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Custom Exit'),
              onPressed: () {
                // For Android, you can use SystemNavigator.pop() to exit the app
                // This is the same as pressing the system back button on the home screen
                SystemNavigator.pop();
                
                // Note: On iOS, apps should not provide explicit "exit" buttons
                // as it goes against platform guidelines
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 6. Back Button with Navigation Animation
class CustomBackAnimationScreen extends StatelessWidget {
  const CustomBackAnimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Animation'),
        // Custom back button with custom transition
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Custom page transition on back
            Navigator.of(context).pop();
            
            // For more complex animations, you would use custom page routes:
            // Navigator.of(context).push(
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) => YourPage(),
            //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //       return FadeTransition(opacity: animation, child: child);
            //     },
            //   ),
            // );
          },
        ),
      ),
      body: const Center(
        child: Text('Screen with custom back animation'),
      ),
    );
  }
}