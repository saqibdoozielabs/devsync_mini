import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/counter_provider.dart';
import 'providers/user_provider.dart';
import 'providers/messages_provider.dart';

void main() {
  // Q33: ProviderScope - required at root
  // Stores all provider states
  runApp(
    const ProviderScope(
      child: RiverpodApp(),
    ),
  );
}

class RiverpodApp extends StatelessWidget {
  const RiverpodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const RiverpodHomeScreen(),
    );
  }
}

// Q33: ConsumerWidget - can access providers
class RiverpodHomeScreen extends ConsumerWidget {
  const RiverpodHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Q39: ref.watch - listen to provider, rebuilds when changes
    final counter = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 3: Riverpod'),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Simple Counter Section
            const Text(
              'Simple Counter (StateProvider)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${counter}',
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          // Q39: ref.read - access provider without listening
                          // Use for callbacks
                          onPressed: () {
                            ref.read(counterProvider.notifier).state--;
                          },
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state = 0;
                          },
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state++;
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Complex Counter Section
            const Text(
              'Complex Counter (StateNotifierProvider)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            const ComplexCounterSection(),
            
            const SizedBox(height: 20),
            
            // User Section (FutureProvider)
            const Text(
              'User Data (FutureProvider)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            const UserSection(),
            
            const SizedBox(height: 20),
            
            // Messages Section (StreamProvider)
            const Text(
              'Messages (StreamProvider)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            const MessagesSection(),
            
            const SizedBox(height: 20),
            
            // Educational Notes
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎓 Riverpod:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• StateProvider: Simple values\n'
                    '• StateNotifierProvider: Complex logic\n'
                    '• FutureProvider: Async data\n'
                    '• StreamProvider: Real-time data\n'
                    '• ref.watch: Listen & rebuild\n'
                    '• ref.read: Access without rebuild',
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

// Q35: Complex counter with StateNotifierProvider
class ComplexCounterSection extends ConsumerWidget {
  const ComplexCounterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterNotifierProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 48,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).reset();
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Q36 & Q38: FutureProvider with AsyncValue
class UserSection extends ConsumerWidget {
  const UserSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Q36: ref.watch on FutureProvider returns AsyncValue
    final userAsync = ref.watch(userProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: userAsync.when(
          // Q38: AsyncValue.when - pattern matching
          
          // Loading state
          loading: () => const Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Loading user...'),
              ],
            ),
          ),
          
          // Error state
          error: (error, stack) => Column(
            children: [
              const Icon(Icons.error, color: Colors.red, size: 40),
              const SizedBox(height: 10),
              Text(
                'Error: ${error.toString()}',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Q36: Refresh provider
                  ref.invalidate(userProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
          
          // Data state
          data: (user) => Column(
            children: [
              const Icon(Icons.person, size: 60, color: Colors.purple),
              const SizedBox(height: 10),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(userProvider);
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Q37 & Q38: StreamProvider with AsyncValue
class MessagesSection extends ConsumerWidget {
  const MessagesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Q37: ref.watch on StreamProvider returns AsyncValue
    final messagesAsync = ref.watch(messagesProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Real-time Messages:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Q38: AsyncValue.when for Stream
            messagesAsync.when(
              loading: () => const CircularProgressIndicator(),
              
              error: (error, stack) => Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
              
              data: (message) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '📨 $message',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}