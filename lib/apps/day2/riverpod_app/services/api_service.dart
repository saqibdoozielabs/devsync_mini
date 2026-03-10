// Q34: Provider for service (dependency injection)
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Q36: Service for API calls
/// Riverpod can inject this as dependency
class ApiService {
  // Simulate fetching user
  Future<User> fetchUser(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate occasional error
    if (DateTime.now().second % 3 == 0) {
      throw Exception('Network error');
    }
    
    return User(
      id: userId,
      name: 'John Doe',
      email: 'john@example.com',
    );
  }
  
  // Simulate fetching posts
  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      Post(id: '1', title: 'First Post', body: 'This is the first post'),
      Post(id: '2', title: 'Second Post', body: 'This is the second post'),
      Post(id: '3', title: 'Third Post', body: 'This is the third post'),
    ];
  }
  
  // Simulate stream of messages
  Stream<String> messagesStream() {
    return Stream.periodic(
      const Duration(seconds: 2),
      (count) => 'Message ${count + 1} at ${DateTime.now().second}s',
    ).take(10); // Only 10 messages
  }
}

class User {
  final String id;
  final String name;
  final String email;
  
  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

class Post {
  final String id;
  final String title;
  final String body;
  
  Post({
    required this.id,
    required this.title,
    required this.body,
  });
}


final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});