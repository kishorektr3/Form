import 'package:bloc/bloc.dart';
import 'package:adminbloccif/bloc/auth_event.dart';
import 'package:adminbloccif/bloc/auth_state.dart';
import 'auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.login(event.email, event.password);
      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Handle logout if necessary
  }
}
