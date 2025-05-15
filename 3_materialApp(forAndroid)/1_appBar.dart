
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is the AppBar
      appBar: AppBar(
        // Title of the AppBar
        title: const Text('AppBar Example'),
        
        // Leading widget - appears at the start of the AppBar
        // Usually used for navigation or a menu button
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu button pressed')),
            );
          },
        ),
        
        // Actions - appear at the end of the AppBar
        // Usually used for action buttons
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search button pressed')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More button pressed')),
              );
            },
          ),
        ],
        
        // Background color of the AppBar
        backgroundColor: Colors.blue,
        
        // Elevation - shadow effect below the AppBar
        elevation: 8.0,
        
        // Center title - centers the title in the AppBar
        centerTitle: true,
        
        // Bottom widget - appears below the AppBar
        // Usually used for tabs
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.blue.shade700,
            height: 48.0,
            alignment: Alignment.center,
            child: const Text(
              'Custom bottom widget',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: const Text(
          'This is a basic example of an AppBar in Flutter',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}