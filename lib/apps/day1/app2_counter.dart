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

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  String _lifecycleLog = '';

  @override
  void initState() {
    super.initState();
    _lifecycleLog = 'initState called';
    print('📱 initState: Counter initialized');
  }

  @override
  void didUpdateWidget(CounterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('📱 didUpdateWidget: Widget updated');
  }

  @override
  void dispose() {
    print('📱 dispose: Counter disposed');
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 2: Counter (StatefulWidget)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 40),
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
          ],
        ),
      ),
    );
  }
}
