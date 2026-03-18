import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coding Challenges Day 2',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coding Challenges Day 2'),
        ),
        body: const Center(
          // child: ChangeNotifierProvider(
          //   create: (context) => CounterModel(),
          //   child: const Challenge1(),
          // ),
          // child: BlocProvider(
          //   create: (context) => AuthBloc(),
          //   child: const Challenge2(),
          // ),
          child: ProviderScope(
            child: Challenge3(),
          ),
        ),
      ),
    );
  }
}

// Challenge 1: Create a Counter with Provider

// class CounterModel extends ChangeNotifier {
//   int _counter = 0;

//   int get counter => _counter;

//   void increment() {
//     _counter++;
//     notifyListeners();
//   }

//   void decrement() {
//     if (_counter > 0) {
//       _counter--;
//       notifyListeners();
//     }
//   }

//   void reset() {
//     _counter = 0;
//     notifyListeners();
//   }
// }

// class Challenge1 extends StatelessWidget {
//   const Challenge1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Counter"),
//         Consumer<CounterModel>(
//           builder: (ctx, counterModel, child) {
//             return Text('${counterModel.counter}');
//           }
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: context.read<CounterModel>().increment,
//               child: const Text("+"),
//             ),
//             ElevatedButton(
//               onPressed: context.read<CounterModel>().reset,
//               child: const Text("Reset"),
//             ),
//             ElevatedButton(
//               onPressed: context.read<CounterModel>().decrement,
//               child: const Text("-"),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// Challenge 1: Create a Counter with Provider


// Challenge 2: Create Auth BLoC

// Event
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

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
// Event

// State
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}
class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
// State

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      if (event.password == "test123") {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError('$e'));
    }
  }
}
// Bloc

class Challenge2 extends StatelessWidget {
  const Challenge2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        }

        if (state is AuthError) {
          return const Text("Invalid email or password");
        }

        if (state is AuthAuthenticated) {
          return const Text("Success");
        }

        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                    LoginRequested(
                      email: _emailController.text, 
                      password: _passwordController.text
                    ),
                  );
                }
              }, 
              child: const Text('Login'),
            ),
          ],
        ),
        
      ),
    );
  }
}

// Challenge 2: Create Auth BLoC


// Challenge 3: Create User Provider with Riverpod

class User {
  final String name;
  final String age;

  const User({
    required this.name,
    required this.age,
  });
}

final userProvider = FutureProvider<User>((ref) async {
  await Future.delayed(const Duration(seconds: 2));

  return const User(name: "Saqib", age: "age");
});

class Challenge3 extends ConsumerWidget {
  const Challenge3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text("$error"), 
      data: (data) {
        return Text(data.name);
      }, 
    );
  }
}

// Challenge 3: Create User Provider with Riverpod
