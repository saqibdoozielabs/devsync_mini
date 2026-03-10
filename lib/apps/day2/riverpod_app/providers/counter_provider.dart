import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Q33: Riverpod provider - simplest form
/// StateProvider for simple state (int, bool, String)
final counterProvider = StateProvider<int>((ref) {
  // Initial value
  return 0;
});

/// Q35: StateNotifierProvider for complex state
/// Use when you need custom methods
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0); // Initial value = 0
  
  void increment() {
    state = state + 1;
    print('Counter incremented to: $state');
  }
  
  void decrement() {
    if (state > 0) {
      state = state - 1;
    }
  }
  
  void reset() {
    state = 0;
  }
}

// Q35: StateNotifierProvider exposes the notifier
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);