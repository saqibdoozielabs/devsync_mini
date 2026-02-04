import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const CounterScreen(),
    );
  }
}

/// Q6-Q7: StatefulWidget - widget with mutable state
/// Has 2 classes: StatefulWidget + State
class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  // Q7: createState() called when widget first inserted into tree
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

/// Q7: State object - mutable state for StatefulWidget
/// Lifecycle: initState → build → dispose
class _CounterScreenState extends State<CounterScreen> {
  // Q6: Mutable state variable
  int _counter = 0;
  String _lifecycleLog = '';

  // Q7: initState() - called once when State object created
  // Good place for initialization (controllers, listeners, etc.)
  @override
  void initState() {
    super.initState();
    _lifecycleLog = 'initState called';
    print('📱 initState: Counter initialized');
  }

  // Q7: didUpdateWidget() - called when parent rebuilds this widget
  @override
  void didUpdateWidget(CounterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('📱 didUpdateWidget: Widget updated');
  }

  // Q7: dispose() - called when State object removed from tree
  // Clean up resources here (controllers, streams, listeners)
  @override
  void dispose() {
    print('📱 dispose: Counter disposed');
    super.dispose();
  }

  // Q6: setState() - tells Flutter to rebuild this widget
  // CRITICAL: Only call setState() when state actually changes!
  void _incrementCounter() {
    setState(() {
      // Q6: This code runs inside setState
      _counter++;
      _lifecycleLog = 'setState called - counter: $_counter';
    });
    
    print('📱 setState: Counter = $_counter');
    print('📱 build() will be called next');
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _lifecycleLog = 'setState called - counter: $_counter';
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _lifecycleLog = 'Counter reset';
    });
  }

  // Q7: build() - called every time setState() is called
  // MUST be fast! No heavy computation here
  @override
  Widget build(BuildContext context) {
    print('📱 build: Rebuilding UI with counter = $_counter');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 2: Counter (StatefulWidget)'),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Q8: Widget tree - logical structure
            // This Text widget is in widget tree
            const Text(
              'Counter Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Q6: This Text rebuilds when setState called
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Lifecycle log
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lifecycleLog,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement button
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.remove),
                ),
                
                const SizedBox(width: 20),
                
                // Reset button
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: const Text('Reset'),
                ),
                
                const SizedBox(width: 20),
                
                // Increment button
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Educational notes
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                children: [
                  Text(
                    '🎓 Learning Points:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• setState() triggers rebuild\n'
                    '• Only UI dependent on state rebuilds\n'
                    '• Check console for lifecycle logs\n'
                    '• Try hot reload - state persists!',
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