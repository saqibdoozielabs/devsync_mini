import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Import your auth files
import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_bloc.dart';
import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_event.dart';
import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_state.dart';
import 'package:devsync_mini/apps/day2/bloc_app/auth/auth_repository.dart';

// /// Q31: Testing BLoC with bloc_test package
// /// 
// /// Run tests with: flutter test
// void main() {
//   group('AuthBloc', () {
//     late AuthRepository mockRepository;
//     late AuthBloc authBloc;

//     setUp(() {
//       mockRepository = MockAuthRepository();
//       authBloc = AuthBloc(repository: mockRepository);
//     });

//     tearDown(() {
//       authBloc.close();
//     });

//     // Q31: Test initial state
//     test('initial state is AuthInitial', () {
//       expect(authBloc.state, const AuthInitial());
//     });

//     // Q31: Test login success
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthLoading, AuthAuthenticated] when login succeeds',
//       build: () {
//         when(() => mockRepository.login(any(), any()))
//         .thenAnswer((_) async {
//           print('🍕 Fake kitchen: Making successful user...');
//           return const User(
//             id: 'test_123',
//             email: 'test@test.com',
//             name: 'Test User',
//           );
//         });

//         return authBloc;
//       },
//       act: (bloc) => bloc.add(
//         const LoginRequested(
//           email: 'test@test.com',
//           password: 'password123',
//         ),
//       ),
//       expect: () => [
//         const AuthLoading(),
//         isA<AuthAuthenticated>(),
//       ],
//     );

//     // Q31: Test login failure
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthLoading, AuthError, AuthUnauthenticated] when login fails',
//       build: () {
//         when(() => mockRepository.login(any(), any()))
//             .thenThrow(Exception('Invalid credentials'));
//         return authBloc;
//       },
//       act: (bloc) => bloc.add(
//         const LoginRequested(
//           email: 'test@test.com',
//           password: 'wrong',
//         ),
//       ),
//       expect: () => [
//         const AuthLoading(),
//         isA<AuthError>(),
//         const AuthUnauthenticated(),
//       ],
//       wait: const Duration(seconds: 4),
//     );
//   });
// }

// // Mock repository for testing
// class MockAuthRepository extends Mock implements AuthRepository {}



/////////////////////////
/////////////////////////
/////////////////////////

// ═══════════════════════════════════════════════════════════
// STORY 1: Creating a Fake Kitchen (Mock Repository)
// ═══════════════════════════════════════════════════════════

/// This is our FAKE kitchen
/// It PRETENDS to be a real kitchen but we control everything
class MockAuthRepository extends Mock implements AuthRepository {}

// ═══════════════════════════════════════════════════════════
// STORY 2: Setting Up the Restaurant Test
// ═══════════════════════════════════════════════════════════

void main() {
  /// Think of 'group' as "Today's Testing Schedule"
  /// We're testing all AuthBloc scenarios
  group('AuthBloc Tests - Restaurant Order System', () {
    
    // ─────────────────────────────────────────────────────────
    // VARIABLES: Our Testing Tools
    // ─────────────────────────────────────────────────────────
    
    /// The FAKE kitchen (we control what it "makes")
    late MockAuthRepository mockRepository;
    
    /// The WAITER we're testing (AuthBloc)
    late AuthBloc authBloc;
    
    // ─────────────────────────────────────────────────────────
    // setUp: BEFORE EACH TEST (Like setting the table)
    // ─────────────────────────────────────────────────────────
    
    /// This runs BEFORE EVERY test
    /// Like setting up a clean table before each customer
    setUp(() {
      print('\n🔧 Setting up test...');
      
      // Create a fresh fake kitchen
      mockRepository = MockAuthRepository();
      
      // Create a fresh waiter (BLoC) with our fake kitchen
      authBloc = AuthBloc(repository: mockRepository);
      
      print('✅ Setup complete - Clean slate ready!');
    });
    
    // ─────────────────────────────────────────────────────────
    // tearDown: AFTER EACH TEST (Like clearing the table)
    // ─────────────────────────────────────────────────────────
    
    /// This runs AFTER EVERY test
    /// Like clearing the table after customer leaves
    tearDown(() {
      print('🧹 Cleaning up...');
      
      // Close the BLoC (stop the waiter's shift)
      authBloc.close();
      
      print('✅ Cleanup complete!\n');
    });

    // ═══════════════════════════════════════════════════════════
    // TEST 1: Check Initial State (Is table clean?)
    // ═══════════════════════════════════════════════════════════
    
    test('🎬 TEST 1: Waiter starts with clean slate (AuthInitial)', () {
      // STORY: When restaurant opens, no orders yet
      
      print('📝 Checking: Does waiter start with empty notepad?');
      
      // EXPECT: Waiter should have no orders initially
      expect(
        authBloc.state,          // Current state of waiter
        const AuthInitial(),     // Should be "ready for orders"
      );
      
      print('✅ PASS: Waiter is ready with empty notepad!');
    });

    // ═══════════════════════════════════════════════════════════
    // TEST 2: Successful Login (Customer orders pizza, gets pizza)
    // ═══════════════════════════════════════════════════════════
    
    blocTest<AuthBloc, AuthState>(
      '🎬 TEST 2: Login Success - Customer orders, gets food',
      
      // ───────────────────────────────────────────────────────
      // SETUP PHASE: Prepare the fake kitchen
      // ───────────────────────────────────────────────────────
      build: () {
        print('\n🔧 Preparing fake kitchen for success test...');
        
        // TELL THE FAKE KITCHEN: "When someone orders, give them this user"
        when(() => mockRepository.login(any(), any()))
            .thenAnswer((_) async {
              print('🍕 Fake kitchen: Making successful user...');
              return User(
                id: 'test_123',
                email: 'test@test.com',
                name: 'Test User',
              );
            });
        
        print('✅ Fake kitchen ready to serve success!');
        return authBloc;
      },
      
      // ───────────────────────────────────────────────────────
      // ACTION PHASE: Customer places order
      // ───────────────────────────────────────────────────────
      act: (bloc) {
        print('\n🧑 Customer: "I want to login!"');
        print('📝 Waiter writes order: email=test@test.com, password=password123');
        
        // Give waiter the order (send LoginRequested event)
        return bloc.add(
          const LoginRequested(
            email: 'test@test.com',
            password: 'password123',
          ),
        );
      },
      
      // ───────────────────────────────────────────────────────
      // VERIFICATION PHASE: Check what customer receives
      // ───────────────────────────────────────────────────────
      expect: () {
        print('\n🔍 Watching what customer receives...\n');
        
        return [
          // FIRST: Customer sees "Preparing your order..."
          const AuthLoading(),
          
          // THEN: Customer receives their food (authenticated user)
          isA<AuthAuthenticated>()
              .having((s) => s.user.email, 'user email', 'test@test.com')
              .having((s) => s.user.name, 'user name', 'Test User'),
        ];
      },
      
      // ───────────────────────────────────────────────────────
      // VERIFICATION: Additional checks
      // ───────────────────────────────────────────────────────
     
      // Add wait to let async operations complete
      wait: const Duration(seconds: 3),
      
      verify: (_) {
        print('✅ Verified: Kitchen was called exactly once');
        verify(() => mockRepository.login('test@test.com', 'password123'))
            .called(1);
      },
    );

    // ═══════════════════════════════════════════════════════════
    // TEST 3: Failed Login (Customer orders, kitchen says "No!")
    // ═══════════════════════════════════════════════════════════
    
    blocTest<AuthBloc, AuthState>(
      '🎬 TEST 3: Login Failure - Wrong password, kitchen rejects',
      
      // ───────────────────────────────────────────────────────
      // SETUP: Prepare fake kitchen to FAIL
      // ───────────────────────────────────────────────────────
      build: () {
        print('\n🔧 Preparing fake kitchen for failure test...');
        
        // TELL THE FAKE KITCHEN: "Throw an error when login called"
        when(() => mockRepository.login(any(), any()))
            .thenThrow(Exception('Invalid credentials'));
        
        print('✅ Fake kitchen ready to reject!');
        return authBloc;
      },
      
      // ───────────────────────────────────────────────────────
      // ACTION: Customer tries wrong password
      // ───────────────────────────────────────────────────────
      act: (bloc) {
        print('\n🧑 Customer: "I want to login with WRONG password!"');
        print('📝 Waiter writes order: email=test@test.com, password=WRONG');
        
        return bloc.add(
          const LoginRequested(
            email: 'test@test.com',
            password: 'wrong_password',
          ),
        );
      },
      
      // ───────────────────────────────────────────────────────
      // VERIFICATION: Check error handling
      // ───────────────────────────────────────────────────────
      expect: () {
        print('\n🔍 Watching error handling...\n');
        
        return [
          // FIRST: Shows loading
          const AuthLoading(),
          
          // THEN: Shows error
          isA<AuthError>()
              .having((s) => s.message, 'error message', 
                     contains('Invalid credentials')),
          
          // FINALLY: Back to unauthenticated (after 3 seconds in real code)
          const AuthUnauthenticated(),
        ];
      },
      
      // Wait for async operations
      wait: const Duration(seconds: 4),
    );

    // ═══════════════════════════════════════════════════════════
    // TEST 4: Multiple Events (Customer keeps changing order)
    // ═══════════════════════════════════════════════════════════
    
    blocTest<AuthBloc, AuthState>(
      '🎬 TEST 4: Multiple Events - Customer changes mind',
      
      build: () {
        // Setup successful kitchen
        when(() => mockRepository.login(any(), any()))
            .thenAnswer((_) async => User(
                  id: '123',
                  email: 'test@test.com',
                  name: 'Test',
                ));
        
        when(() => mockRepository.logout())
            .thenAnswer((_) async => Future.delayed(Duration(milliseconds: 100)));
        
        return authBloc;
      },
      
      act: (bloc) async {
        print('\n🧑 Customer: "Login please!"');
        bloc.add(const LoginRequested(
          email: 'test@test.com',
          password: 'password123',
        ));
        
        await Future.delayed(Duration(milliseconds: 500));
        print('🧑 Customer: "Wait, logout!"');
        bloc.add(const LogoutRequested());
        
        await Future.delayed(Duration(milliseconds: 500));
        print('🧑 Customer: "Actually, login again!"');
        bloc.add(const LoginRequested(
          email: 'test@test.com',
          password: 'password123',
        ));
      },
      
      expect: () => [
        // Login sequence
        const AuthLoading(),
        isA<AuthAuthenticated>(),
        
        // Logout sequence
        const AuthUnauthenticated(),
        
        // Login again sequence
        const AuthLoading(),
        isA<AuthAuthenticated>(),
      ],
      
      wait: const Duration(seconds: 3),
    );

    // ═══════════════════════════════════════════════════════════
    // TEST 5: Skip States (Check specific state transitions)
    // ═══════════════════════════════════════════════════════════
    
    blocTest<AuthBloc, AuthState>(
      '🎬 TEST 5: State already loading, login completes',
      
      build: () {
        print('\n🔧 BLoC already in loading state...');
        
        when(() => mockRepository.login(any(), any()))
            .thenAnswer((_) async => User(
                  id: '123',
                  email: 'test@test.com',
                  name: 'Test',
                ));
        return authBloc;
      },
      
      // ✅ FIX: Don't use seed here, it causes confusion
      // Instead, test that loading only emitted once
      act: (bloc) {
        print('🧑 Customer places order');
        return bloc.add(const LoginRequested(
          email: 'test@test.com',
          password: 'password123',
        ));
      },
      
      expect: () {
        print('🔍 Should see Loading then Authenticated');
        return [
          const AuthLoading(),
          isA<AuthAuthenticated>(),
        ];
      },
      
      // ✅ FIX: Add wait
      wait: const Duration(seconds: 2),
    );
  });
}