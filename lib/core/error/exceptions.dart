/// Q48: Exceptions that get converted to Failures
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache error']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);
}