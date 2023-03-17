part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isUnknown => this == AuthStatus.unknown;
}

@immutable
class AuthState extends Equatable {
  final AuthStatus status;
  final String? user;

  const AuthState._({
    required this.status,
    this.user,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated(String user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
