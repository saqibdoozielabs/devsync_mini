import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'auth_repository.dart';

/// Q28: BLoC - Business Logic Component
/// Transforms Events into States
/// All business logic lives here, NOT in UI
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  
  // Q26: BLoC constructor
  // Initial state is AuthInitial
  AuthBloc({required this.repository}) : super(const AuthInitial()) {
    // Q28: Register event handlers
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }
  
  /// Q28: Handle login event
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Q28: emit() outputs new state
    
    // Step 1: Emit loading state
    emit(const AuthLoading());
    
    print('🔐 Login attempt: ${event.email}');
    
    try {
      // Step 2: Call repository
      final user = await repository.login(event.email, event.password);
      
      print('✅ Login successful: ${user.name}');
      
      // Step 3: Emit success state
      emit(AuthAuthenticated(user));
      
    } catch (e) {
      print('❌ Login failed: $e');
      
      // Step 4: Emit error state
      emit(AuthError(e.toString()));
      
      // After 3 seconds, go back to unauthenticated
      await Future.delayed(const Duration(seconds: 3));
      emit(const AuthUnauthenticated());
    }
  }
  
  /// Handle register event
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    print('📝 Register attempt: ${event.email}');
    
    try {
      final user = await repository.register(
        event.email,
        event.password,
        event.name,
      );
      
      print('✅ Registration successful: ${user.name}');
      
      emit(AuthAuthenticated(user));
      
    } catch (e) {
      print('❌ Registration failed: $e');
      
      emit(AuthError(e.toString()));
      
      await Future.delayed(const Duration(seconds: 3));
      emit(const AuthUnauthenticated());
    }
  }
  
  /// Handle logout event
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('👋 Logout requested');
    
    await repository.logout();
    
    emit(const AuthUnauthenticated());
    
    print('✅ Logged out');
  }
  
  /// Check auth status on app start
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final user = await repository.getCurrentUser();
    
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
}