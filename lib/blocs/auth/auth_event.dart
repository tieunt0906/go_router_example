part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final String user;

  AuthUserChanged(this.user);
}

class AuthLogoutRequested extends AuthEvent {}
