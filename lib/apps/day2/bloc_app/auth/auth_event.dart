import 'package:equatable/equatable.dart';

/// Q28: Events - Input to BLoC
/// Events represent user actions or system events
/// Use Equatable for easy comparison in tests
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object?> get props => [];
}

/// User wants to login
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  const LoginRequested({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}

/// User wants to register
class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  
  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
  });
  
  @override
  List<Object?> get props => [email, password, name];
}

/// User wants to logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Check if user is already logged in (on app start)
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}