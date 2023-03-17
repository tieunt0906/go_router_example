part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final StringNonEmpty username;
  final StringNonEmpty password;
  final String? user;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const StringNonEmpty.pure(),
    this.password = const StringNonEmpty.pure(),
    this.user,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    StringNonEmpty? username,
    StringNonEmpty? password,
    String? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, username, password, user];
}
