import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:beta_project/features/authentication/cubit/auth_cubit.dart'; // Updated import
import 'package:beta_project/features/authentication/cubit/auth_state.dart'; // Updated import
import 'package:beta_project/data/auth_repository.dart';

// Mock AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthCubit authCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    // Prevent checkAuthStatus from completing and emitting states by default
    when(() => mockAuthRepository.getCurrentUser()).thenAnswer((_) => Completer<String?>().future);
    authCubit = AuthCubit(mockAuthRepository); // Pass mockAuthRepository to AuthCubit
  });

  tearDown(() {
    authCubit.close();
  });

  group('AuthCubit TDD', () {
    test('initial state is AuthInitial', () {
      expect(authCubit.state, AuthInitial());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when login is successful',
      build: () {
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => true);
        return authCubit;
      },
      act: (cubit) => cubit.login('test@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        const AuthAuthenticated('test@example.com'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] when login fails',
      build: () {
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => false);
        return authCubit;
      },
      act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
      expect: () => [
        AuthLoading(),
        const AuthError('Invalid credentials.'), // Updated error message
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when register is successful',
      build: () {
        when(() => mockAuthRepository.register(any(), any()))
            .thenAnswer((_) async => true);
        return authCubit;
      },
      act: (cubit) => cubit.register('newuser@example.com', 'password'),
      expect: () => [
        AuthLoading(),
        const AuthAuthenticated('newuser@example.com'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] when logout is called',
      build: () {
        when(() => mockAuthRepository.logout()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        AuthLoading(), // Logout also emits loading state first
        AuthUnauthenticated(),
      ],
    );
  });
}
