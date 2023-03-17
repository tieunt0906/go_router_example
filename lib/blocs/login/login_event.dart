part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UsernameChanged extends LoginEvent {
  final String username;

  UsernameChanged(this.username);
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
}

class LoginRequested extends LoginEvent {}
