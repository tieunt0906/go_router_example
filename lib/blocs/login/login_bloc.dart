import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:go_router_example/utils/pref_helper.dart';
import 'package:go_router_example/utils/validation.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PrefHelper _prefHelper;

  LoginBloc(this._prefHelper) : super(const LoginState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginRequested>(_onLoginRequested);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        username: StringNonEmpty.dirty(value: event.username),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: StringNonEmpty.dirty(value: event.password),
    ));
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    final username = StringNonEmpty.dirty(value: state.username.value);
    final password = StringNonEmpty.dirty(value: state.password.value);

    emit(state.copyWith(
      username: username,
      password: password,
    ));

    final isValid = Formz.validate([username, password]);
    if (!isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    await Future.delayed(const Duration(seconds: 1));
    const user = 'tieunt';

    if (username.value == user && password.value == '1234') {
      await _prefHelper.setValue(Preferences.token, user);
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        user: user,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void onUsernameChanged(String value) {
    add(UsernameChanged(value));
  }

  void onPasswordChanged(String value) {
    add(PasswordChanged(value));
  }

  void login() {
    add(LoginRequested());
  }
}
