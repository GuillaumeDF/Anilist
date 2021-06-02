import 'package:admin_pannel/bloc/simple_bloc_observer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:admin_pannel/pages/panel/panel_page.dart';
import 'package:admin_pannel/pages/splash/splash_page.dart';

import 'package:users/users_repository.dart';
import 'package:admin_pannel/pages/login/login_page.dart';
import 'package:admin_pannel/bloc/authentication/authentication_bloc.dart';
import 'package:admin_pannel/models/authentication/authentication_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(authenticationRepository: AuthenticationRepository()));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const MyApp({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
            authenticationRepository: authenticationRepository)
          ..add(AppStarted()),
        child: MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  final UsersRepository usersRepository = UsersRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated)
            return PanelPage(usersRepository: usersRepository);
          if (state is Unauthenticated) return LoginPage();
          return SplashPage();
        },
      ),
    );
  }
}
