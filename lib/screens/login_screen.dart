import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router_example/blocs/auth/auth_bloc.dart';
import 'package:go_router_example/blocs/login/login_bloc.dart';
import 'package:go_router_example/dialogs/show_auth_error.dart';
import 'package:go_router_example/screens/loading/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isInProgress) {
          LoadingScreen.instance().show(context: context, text: 'Loading...');
        } else if (state.status.isSuccess) {
          LoadingScreen.instance().hide();
          context.read<AuthBloc>().add(AuthUserChanged(state.user!));
        } else if (state.status.isFailure) {
          LoadingScreen.instance().hide();
          showAuthError(context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.username != current.username,
                builder: (context, state) {
                  return TextField(
                    controller: _usernameController,
                    onChanged: _loginBloc.onUsernameChanged,
                    decoration: InputDecoration(
                      hintText: 'Enter your username...',
                      errorText: state.username.displayError != null
                          ? 'Username cannot empty'
                          : null,
                    ),
                  );
                },
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return TextField(
                    controller: _passwordController,
                    onChanged: _loginBloc.onPasswordChanged,
                    decoration: InputDecoration(
                      hintText: 'Enter your password...',
                      errorText: state.password.displayError != null
                          ? 'password cannot empty'
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: _loginBloc.login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
