import 'package:flutter/foundation.dart';

/// Q22: ChangeNotifier - notifies listeners when data changes
/// Base class for Provider state management
class CounterModel extends ChangeNotifier {
  // Private state
  int _counter = 0;
  
  // Q21: Getter - exposes state (read-only)
  int get counter => _counter;
  
  // Q22: Method that modifies state and notifies listeners
  void increment() {
    _counter++;
    
    // Q22: notifyListeners() - tells all listeners to rebuild
    // This is the key to Provider pattern
    notifyListeners();
    
    print('Counter incremented to: $_counter');
  }
  
  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }
  
  void reset() {
    _counter = 0;
    notifyListeners();
  }
}