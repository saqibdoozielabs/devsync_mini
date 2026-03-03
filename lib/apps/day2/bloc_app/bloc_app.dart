import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/auth_bloc.dart';
import 'auth/auth_event.dart';
import 'auth/auth_state.dart';
import 'auth/auth_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BlocApp());
}

class BlocApp extends StatelessWidget {
  const BlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Q30: BlocProvider - provides BLoC to widget tree
    // All descendants can access this BLoC
    return BlocProvider(
      // Q30: create - creates the BLoC instance
      create: (context) => AuthBloc(
        repository: AuthRepository(),
      )..add(const AuthCheckRequested()), // Check auth on startup
      
      child: MaterialApp(
        title: 'BLoC Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        
        // Q29: BlocBuilder at root to switch screens based on state
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // Show loading while checking auth
            if (state is AuthLoading || state is AuthInitial) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            // Show home if authenticated
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            
            // Show login for all other states
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}