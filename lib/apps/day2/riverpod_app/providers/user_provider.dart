import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

/// Q36: FutureProvider - for async data
/// Automatically handles loading, data, error states
final userProvider = FutureProvider<User>((ref) async {
  // Q34: ref.watch - depend on another provider
  final apiService = ref.watch(apiServiceProvider);
  
  // Fetch user
  return await apiService.fetchUser('123');
});

/// Q36: FutureProvider with parameter
/// Use .family for parameterized providers
final userByIdProvider = FutureProvider.family<User, String>((ref, userId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchUser(userId);
});

/// Q36: Posts provider
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchPosts();
});