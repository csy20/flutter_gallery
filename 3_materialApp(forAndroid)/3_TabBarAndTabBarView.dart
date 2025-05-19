import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TabBar & TabBarView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TabBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({Key? key}) : super(key: key);

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> with TickerProviderStateMixin {
  // TabController is required to coordinate TabBar and TabBarView
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    // Initialize TabController with length equal to number of tabs
    _tabController = TabController(length: 4, vsync: this);
    
    // Optional: Listen for tab changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // This is called when the tab selection changes
        print('Tab ${_tabController.index} is selected');
      }
    });
  }
  
  @override
  void dispose() {
    // Important: Dispose of the TabController when done
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar & TabBarView Example'),
        // Place TabBar in the AppBar's bottom property for top navigation
        bottom: TabBar(
          // Connect TabBar to the controller
          controller: _tabController,
          // Make tabs take the whole width
          isScrollable: false,
          // Tab indicator customization
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          // Tab styling
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          // The tabs with icons and text
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      // TabBarView shows content for each tab
      body: TabBarView(
        // Connect TabBarView to the same controller
        controller: _tabController,
        // Children widgets correspond to tabs in the TabBar
        children: [
          // Content for Home tab
          const HomeTabContent(),
          // Content for Search tab
          const SearchTabContent(),
          // Content for Favorites tab
          const FavoritesTabContent(),
          // Content for Settings tab
          const SettingsTabContent(),
        ],
      ),
    );
  }
}

// Content widgets for each tab
class HomeTabContent extends StatelessWidget {
  const HomeTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            'Home Tab Content',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'This tab demonstrates the Home section of the application. '
              'Each tab content can be any widget or combination of widgets.',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class SearchTabContent extends StatelessWidget {
  const SearchTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 100, color: Colors.green),
          const SizedBox(height: 20),
          Text(
            'Search Tab Content',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          // Example search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesTabContent extends StatelessWidget {
  const FavoritesTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example list for favorites tab
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text('Favorite Item ${index + 1}'),
          subtitle: Text('Description for item ${index + 1}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped on favorite ${index + 1}')),
            );
          },
        );
      },
    );
  }
}

class SettingsTabContent extends StatelessWidget {
  const SettingsTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example settings list
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Account Settings'),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Privacy'),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text('Appearance'),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Help & Support'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

// Example of a stand-alone TabBar (not in AppBar)
class StandaloneTabBarExample extends StatefulWidget {
  const StandaloneTabBarExample({Key? key}) : super(key: key);

  @override
  State<StandaloneTabBarExample> createState() => _StandaloneTabBarExampleState();
}

class _StandaloneTabBarExampleState extends State<StandaloneTabBarExample> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Standalone TabBar')),
      body: Column(
        children: [
          // TabBar can also be placed directly in the widget tree
          TabBar(
            controller: _controller,
            labelColor: Colors.blue, // For text in selected tab
            unselectedLabelColor: Colors.grey, // For text in unselected tabs
            tabs: const [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
          // Expanded makes the TabBarView fill the remaining space
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: const [
                Center(child: Text('Content for Tab 1')),
                Center(child: Text('Content for Tab 2')),
                Center(child: Text('Content for Tab 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}