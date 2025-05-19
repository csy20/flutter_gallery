import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DrawerExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DrawerExample extends StatefulWidget {
  const DrawerExample({Key? key}) : super(key: key);

  @override
  State<DrawerExample> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample> {
  // Track the currently selected navigation item
  int _selectedIndex = 0;
  
  // List of page titles that correspond to drawer items
  final List<String> _pageTitles = [
    'Home',
    'Profile',
    'Settings',
    'Help & Feedback',
    'About',
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Close the drawer after selection
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
      ),
      // The drawer widget - creates a side panel that slides in from the left
      drawer: Drawer(
        child: Column(
          children: [
            // DrawerHeader - usually contains user info or app branding
            UserAccountsDrawerHeader(
              accountName: const Text('John Doe'),
              accountEmail: const Text('john.doe@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/46.jpg',
                ),
              ),
              otherAccountsPictures: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Switching Account')),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/46.jpg',
                    ),
                  ),
                ),
              ],
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1557682250-33bd709cbe85?q=80&w=1000',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.6),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            // Drawer items - each item in the navigation menu
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    selected: _selectedIndex == 0,
                    onTap: () => _onDrawerItemTapped(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    selected: _selectedIndex == 1,
                    onTap: () => _onDrawerItemTapped(1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    selected: _selectedIndex == 2,
                    onTap: () => _onDrawerItemTapped(2),
                  ),
                  const Divider(), // A visual separator
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help & Feedback'),
                    selected: _selectedIndex == 3,
                    onTap: () => _onDrawerItemTapped(3),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    selected: _selectedIndex == 4,
                    onTap: () => _onDrawerItemTapped(4),
                  ),
                ],
              ),
            ),
            // Bottom drawer section - often used for logout or app version
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: const Text(
                'App Version 1.0.0',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      // Main content area that changes based on drawer selection
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForIndex(_selectedIndex),
              size:
                  100.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              '${_pageTitles[_selectedIndex]} Page',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'This is the content for the ${_pageTitles[_selectedIndex].toLowerCase()} section',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      // An action button that opens the drawer programmatically
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can also open the drawer programmatically using a GlobalKey
          Scaffold.of(context).openDrawer();
        },
        tooltip: 'Open Drawer',
        child: const Icon(Icons.menu),
      ),
    );
  }

  // Helper method to get the appropriate icon for each selected index
  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.settings;
      case 3:
        return Icons.help;
      case 4:
        return Icons.info;
      default:
        return Icons.error;
    }
  }
}

// Example of creating an EndDrawer (appears from the right side)
class EndDrawerExample extends StatelessWidget {
  const EndDrawerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('End Drawer Example'),
        // AppBar automatically adds endDrawer button if it exists
      ),
      // Normal drawer from the left
      drawer: const Drawer(
        child: Center(
          child: Text('Main Drawer'),
        ),
      ),
      // End drawer from the right 
      endDrawer: Drawer(
        width: 250, // Custom width
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'End Drawer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Notifications'),
              leading: const Icon(Icons.notifications),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              leading: const Icon(Icons.message),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Swipe from right edge or tap the icon in AppBar'),
      ),
    );
  }
}