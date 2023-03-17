import 'package:flutter/material.dart';
import 'package:go_router_example/router.dart';
import 'package:go_router_example/simple_bloc_observer.dart';
import 'package:go_router_example/utils/pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final PrefHelper prefHelper = PrefHelper(sharedPreferences);

  Bloc.observer = SimpleBlocObserver();

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(prefHelper: prefHelper)..add(AuthStarted()),
      child: MyApp(
        prefHelper: prefHelper,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final PrefHelper prefHelper;

  const MyApp({
    super.key,
    required this.prefHelper,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: AppRouter(
        authBloc: context.read<AuthBloc>(),
        prefHelper: prefHelper,
      ).router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
