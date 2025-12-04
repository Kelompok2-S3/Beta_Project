import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:beta_project/data/auth_repository.dart'; // Assuming this path is correct

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      final success = await _authRepository.login(email, password);
      if (success) {
        final username = await _authRepository.getUsername(email);
        emit(AuthAuthenticated(email, username));
      } else {
        emit(const AuthError('Invalid credentials.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      final success = await _authRepository.register(email, password);
      if (success) {
        final username = await _authRepository.getUsername(email);
        emit(AuthAuthenticated(email, username));
      } else {
        emit(const AuthError('Registration failed. User might already exist.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
