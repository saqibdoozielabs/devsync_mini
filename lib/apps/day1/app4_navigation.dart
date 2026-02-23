import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const NavigationApp());
}

class NavigationApp extends StatelessWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Async',
      theme: ThemeData(primarySwatch: Colors.orange),
      // Named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Q11: Future - represents a potential value or error
  // Future<T> completes with value T eventually
  Future<String> fetchUserData() async {
    // Q12: async marks function as asynchronous
    // Can use await inside
    
    print('📡 Fetching user data...');
    
    // Q12: await pauses execution until Future completes
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));
    
    print('✅ Data fetched!');
    return 'John Doe'; // Future completes with this value
  }

  // Q11: Future with error handling
  Future<int> fetchUserAge() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate random error
    if (DateTime.now().second % 2 == 0) {
      throw Exception('Failed to fetch age');
    }
    
    return 25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 4: Async & Navigation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Async Operations Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 30),
            
            // Q14: FutureBuilder - builds UI from Future
            const Text(
              'FutureBuilder Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            FutureBuilder<String>(
              // Q14: future - the Future to listen to
              future: fetchUserData(),
              
              // Q14: builder - called when Future state changes
              builder: (context, snapshot) {
                // Q14: snapshot contains Future state
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Future is still loading
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Loading user data...'),
                      ],
                    ),
                  );
                }
                
                if (snapshot.hasError) {
                  // Future completed with error
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                
                if (snapshot.hasData) {
                  // Future completed successfully
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'User: ${snapshot.data}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }
                
                // Initial state
                return const Text('Tap button to load');
              },
            ),
            
            const SizedBox(height: 30),
            
            // Manual async/await example
            ElevatedButton(
              onPressed: () async {
                // Q12: async callback
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                
                try {
                  // Q12: await - waits for Future to complete
                  final name = await fetchUserData();
                  final age = await fetchUserAge();
                  
                  Navigator.pop(context); // Close loading dialog
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name is $age years old'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Fetch with async/await'),
            ),
            
            const SizedBox(height: 30),
            
            // Q18: Navigation
            ElevatedButton(
              onPressed: () {
                // Q18: Navigator.push - navigate to new screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsScreen(),
                  ),
                );
              },
              child: const Text('Navigate to Details'),
            ),
            
            ElevatedButton(
              onPressed: () {
                // Q18: Navigator.pushNamed - using named routes
                Navigator.pushNamed(context, '/details');
              },
              child: const Text('Navigate (Named Route)'),
            ),
            
            const SizedBox(height: 30),
            
            // Educational notes
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎓 Async Concepts:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Future: Represents eventual value\n'
                    'async: Marks function as asynchronous\n'
                    'await: Waits for Future to complete\n'
                    'FutureBuilder: Builds UI from Future\n'
                    '\n'
                    'ConnectionState:\n'
                    '• none - not started\n'
                    '• waiting - in progress\n'
                    '• active - streaming (Stream only)\n'
                    '• done - completed\n',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Details Screen
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        // Q18: Back button automatically added
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the Details Screen',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Q18: Navigator.pop - go back
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Q18: Navigator.pop with result
                Navigator.pop(context, 'Data from Details');
              },
              child: const Text('Go Back with Result'),
            ),
          ],
        ),
      ),
    );
  }
}