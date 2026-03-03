import 'package:equatable/equatable.dart';

/// User model
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  
  const User({
    required this.id,
    required this.email,
    required this.name,
  });
  
  @override
  List<Object?> get props => [id, email, name];
}

/// Q28: States - Output from BLoC
/// States represent different UI states
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state (during login/register)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated
class AuthAuthenticated extends AuthState {
  final User user;
  
  const AuthAuthenticated(this.user);
  
  @override
  List<Object?> get props => [user];
}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Error state
class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object?> get props => [message];
}