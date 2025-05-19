import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Setting initial route 
      initialRoute: '/',
      // Defining named routes for the application
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      // onGenerateRoute handles routes that aren't defined in the routes table
      onGenerateRoute: (settings) {
        // Handle dynamic routes like '/product/123'
        if (settings.name?.startsWith('/product/') ?? false) {
          // Extract the product ID from the route
          final productId = settings.name!.split('/')[2];
          return MaterialPageRoute(
            builder: (context) => ProductScreen(productId: productId),
          );
        }
        // Return null to allow the onUnknownRoute handler to take over
        return null;
      },
      // Fallback for undefined routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// Home screen - the starting point of our app
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator Demo Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic navigation - push a new route
            ElevatedButton(
              child: const Text('Go to Details (Push)'),
              onPressed: () {
                // Method 1: Push a route directly using MaterialPageRoute
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Named route navigation
            ElevatedButton(
              child: const Text('Go to Details (Named Route)'),
              onPressed: () {
                // Method 2: Navigate using a named route
                Navigator.pushNamed(context, '/details');
              },
            ),
            const SizedBox(height: 20),
            // Navigate with replacement (replaces current route)
            ElevatedButton(
              child: const Text('Go to Settings (Replace)'),
              onPressed: () {
                // Method 3: Replace the current route
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
            const SizedBox(height: 20),
            // Navigate and remove routes until a condition is met
            ElevatedButton(
              child: const Text('Go to Details & Clear History'),
              onPressed: () {
                // Method 4: Push and remove routes until a condition is met
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/details',
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
            ),
            const SizedBox(height: 20),
            // Navigate with arguments
            ElevatedButton(
              child: const Text('Pass Data to Details'),
              onPressed: () {
                // Method 5: Push route with arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(
                      message: 'Data from Home Screen!',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Navigate to a dynamic route
            ElevatedButton(
              child: const Text('Go to Product 123'),
              onPressed: () {
                // Method 6: Push to a dynamically generated route
                Navigator.pushNamed(context, '/product/123');
              },
            ),
            const SizedBox(height: 20),
            // Navigate to a non-existent route to demonstrate error handling
            ElevatedButton(
              child: const Text('Go to Non-existent Route'),
              onPressed: () {
                // This will trigger the onUnknownRoute handler
                Navigator.pushNamed(context, '/non-existent');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Detail screen - demonstrates basic navigation and returning data
class DetailScreen extends StatelessWidget {
  // Optional parameter to demonstrate passing data between routes
  final String? message;

  const DetailScreen({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message ?? 'Detail Screen',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go Back'),
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Return Data to Previous Screen'),
              onPressed: () {
                // Return data to the calling screen
                Navigator.pop(context, 'Data from Detail Screen!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Settings screen - demonstrates replacement navigation
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
        // If we navigated here with replacement, there's no back button
        // We can add one manually
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Go back to home by pushing a new instance (since we replaced)
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go to Home'),
              onPressed: () {
                // Clear navigation stack and go to home
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Product screen - demonstrates dynamic routes
class ProductScreen extends StatelessWidget {
  final String productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $productId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product Details for ID: $productId',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Not Found screen - demonstrates handling unknown routes
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go Home'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Example of a more complex navigation setup using nested navigators
class NestedNavigationExample extends StatelessWidget {
  const NestedNavigationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            // Sidebar navigation (could be a drawer as well)
            Container(
              width: 200,
              color: Colors.grey[200],
              child: Navigator(
                // This is a nested navigator with its own navigation stack
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  Widget page;
                  switch (settings.name) {
                    case '/':
                      page = const SidebarHomePage();
                      break;
                    case '/category':
                      page = const SidebarCategoryPage();
                      break;
                    default:
                      page = const SidebarHomePage();
                  }
                  return MaterialPageRoute(builder: (_) => page);
                },
              ),
            ),
            // Main content area with its own navigator
            const Expanded(
              child: MainContentNavigator(),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder widgets for nested navigation example
class SidebarHomePage extends StatelessWidget {
  const SidebarHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          title: const Text('Categories'),
          onTap: () {
            Navigator.pushNamed(context, '/category');
          },
        ),
      ],
    );
  }
}

class SidebarCategoryPage extends StatelessWidget {
  const SidebarCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Back'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const ListTile(title: Text('Category 1')),
        const ListTile(title: Text('Category 2')),
        const ListTile(title: Text('Category 3')),
      ],
    );
  }
}

class MainContentNavigator extends StatelessWidget {
  const MainContentNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const MainContentHomePage();
            break;
          case '/details':
            page = const MainContentDetailsPage();
            break;
          default:
            page = const MainContentHomePage();
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

class MainContentHomePage extends StatelessWidget {
  const MainContentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Content')),
      body: Center(
        child: ElevatedButton(
          child: const Text('View Details'),
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
        ),
      ),
    );
  }
}

class MainContentDetailsPage extends StatelessWidget {
  const MainContentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Detail Content'),
            ElevatedButton(
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}