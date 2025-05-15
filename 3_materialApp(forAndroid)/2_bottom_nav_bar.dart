
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BottomNavBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavBarExample extends StatefulWidget {
  const BottomNavBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavBarExample> createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  // Current selected index for the bottom navigation bar
  int _selectedIndex = 0;
  
  // List of pages to display when tab is selected
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];
  
  // Called when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
      ),
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed for more than 3 items
        currentIndex: _selectedIndex, // Highlight the current tab
        onTap: _onItemTapped, // Handle tab selection
        selectedItemColor: Colors.blue, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        // The items in the bottom navigation bar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Example screen widgets for each tab
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Home Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Search Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Notifications Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Profile Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}