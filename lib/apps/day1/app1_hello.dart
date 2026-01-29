import 'package:flutter/material.dart';

/// Q1: This demonstrates what Flutter is - a UI framework
/// runApp() is the entry point that inflates the widget tree
void main() {
  runApp(HelloWorldApp());
}

/// Q5: StatelessWidget - UI that doesn't change
/// Used when widget doesn't need to maintain state
class HelloWorldApp extends StatelessWidget {
  // Q4: Key - unique identifier for widgets
  // Optional but important for performance
  const HelloWorldApp({Key? key}) : super(key: key);

  /// Q3: BuildContext - handle to location of widget in tree
  /// Provides access to theme, media query, navigation, etc.
  @override
  Widget build(BuildContext context) {
    // Q1: MaterialApp provides Material Design framework
    return MaterialApp(
      title: 'Hello World',
      
      // Q3: Theme accessed via BuildContext
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HelloScreen(),
    );
  }
}

/// Separate screen widget following best practices
class HelloScreen extends StatelessWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Q3: context provides access to MediaQuery
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      // AppBar at top
      appBar: AppBar(
        title: const Text('App 1: Hello World'),
        elevation: 2,
      ),
      
      // Main content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Q4: Without key, Flutter might reuse widget incorrectly
            const Text(
              'Hello, Flutter!',
              key: ValueKey('hello_text'),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Q3: Using context to access theme
            Text(
              'Screen size: ${size.width.toInt()} x ${size.height.toInt()}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            
            const SizedBox(height: 40),
            
            // Q2: Hot Reload Demo Button
            ElevatedButton(
              onPressed: () {
                // Q3: Context used for SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Button pressed! Try hot reload (Ctrl+S)'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Test Hot Reload'),
            ),
            
            const SizedBox(height: 20),
            
            // Q9-Q10 Preview: const vs final
            const Text(
              'const: Compile-time constant',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}