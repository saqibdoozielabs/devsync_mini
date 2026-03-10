import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

/// Q37: StreamProvider - for real-time data
/// Automatically converts Stream to AsyncValue
final messagesProvider = StreamProvider<String>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.messagesStream();
});