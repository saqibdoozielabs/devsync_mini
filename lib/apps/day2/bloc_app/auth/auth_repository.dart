import 'auth_state.dart';

/// Q28: Repository - handles data operations
/// BLoC calls repository methods, doesn't handle data directly
class AuthRepository {
  // Simulate database/API delay
  Future<void> _delay() => Future.delayed(const Duration(seconds: 2));
  
  /// Simulate login
  Future<User> login(String email, String password) async {
    await _delay();
    
    // Simulate validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }
    
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    
    // Simulate wrong credentials
    if (password != 'password123') {
      throw Exception('Invalid email or password');
    }
    
    // Return user
    return User(
      id: '123',
      email: email,
      name: email.split('@')[0],
    );
  }
  
  /// Simulate register
  Future<User> register(String email, String password, String name) async {
    await _delay();
    
    // Simulate validation
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('All fields are required');
    }
    
    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }
    
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    
    // Return new user
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
    );
  }
  
  /// Simulate logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  
  /// Check if user is logged in
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In real app, check local storage/secure storage
    return null;
  }
}