import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router_example/utils/pref_helper.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PrefHelper prefHelper;

  AuthBloc({
    required this.prefHelper,
  }) : super(const AuthState.unknown()) {
    on<AuthStarted>((event, emit) async {
      emit(const AuthState.unknown());

      await Future.delayed(const Duration(milliseconds: 1500));
      final user = await prefHelper.getValue(Preferences.token);

      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
    on<AuthUserChanged>((event, emit) {
      emit(AuthState.authenticated(event.user));
    });
    on<AuthLogoutRequested>((event, emit) async {
      await prefHelper.remove(Preferences.token);
      emit(const AuthState.unauthenticated());
    });
  }

  void logout() {
    add(AuthLogoutRequested());
  }
}
