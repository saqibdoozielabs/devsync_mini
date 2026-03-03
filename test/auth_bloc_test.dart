import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Import your auth files
// import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_bloc.dart';
// import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_event.dart';
// import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_state.dart';
// import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_repository.dart';

/// Q31: Testing BLoC with bloc_test package
/// 
/// Run tests with: flutter test
void main() {
  group('AuthBloc', () {
    // late AuthRepository mockRepository;
    // late AuthBloc authBloc;

    // setUp(() {
    //   mockRepository = MockAuthRepository();
    //   authBloc = AuthBloc(repository: mockRepository);
    // });

    // tearDown(() {
    //   authBloc.close();
    // });

    // Q31: Test initial state
    test('initial state is AuthInitial', () {
      // expect(authBloc.state, const AuthInitial());
    });

    // Q31: Test login success
    // blocTest<AuthBloc, AuthState>(
    //   'emits [AuthLoading, AuthAuthenticated] when login succeeds',
    //   build: () => authBloc,
    //   act: (bloc) => bloc.add(
    //     const LoginRequested(
    //       email: 'test@test.com',
    //       password: 'password123',
    //     ),
    //   ),
    //   expect: () => [
    //     const AuthLoading(),
    //     isA<AuthAuthenticated>(),
    //   ],
    // );

    // Q31: Test login failure
    // blocTest<AuthBloc, AuthState>(
    //   'emits [AuthLoading, AuthError, AuthUnauthenticated] when login fails',
    //   build: () {
    //     when(() => mockRepository.login(any(), any()))
    //         .thenThrow(Exception('Invalid credentials'));
    //     return authBloc;
    //   },
    //   act: (bloc) => bloc.add(
    //     const LoginRequested(
    //       email: 'test@test.com',
    //       password: 'wrong',
    //     ),
    //   ),
    //   expect: () => [
    //     const AuthLoading(),
    //     isA<AuthError>(),
    //     const AuthUnauthenticated(),
    //   ],
    // );
  });
}

// Mock repository for testing
// class MockAuthRepository extends Mock implements AuthRepository {}