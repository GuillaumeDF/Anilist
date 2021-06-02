import 'package:admin_pannel/bloc/authentication/authentication_bloc.dart';
import 'package:admin_pannel/bloc/login/login_cubit.dart';
import 'package:admin_pannel/models/authentication/authentication_repository.dart';
import 'package:admin_pannel/pages/login/components/button_sign.dart';
import 'package:admin_pannel/pages/login/components/textfield_email.dart';
import 'package:admin_pannel/pages/login/components/textfield_password.dart';
import 'package:flutter/material.dart';
import 'package:admin_pannel/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(
              RepositoryProvider.of<AuthenticationRepository>(context),
            ),
        child: LoginPageView());
  }
}

class LoginPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) _showSnackBarFailure(context);
            if (state.status.isSubmissionSuccess) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              return Navigator.pop(context);
            }
          },
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.7],
                  colors: <Color>[
                    CustomTheme.loginGradientStart,
                    CustomTheme.loginGradientEnd
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: (MediaQuery.of(context).size.width / 3),
                      child: Column(
                        children: [
                          TextFieldEmail(),
                          TextFieldPassword(),
                          ButtonSignIn(() =>
                              BlocProvider.of<LoginCubit>(context)
                                  .logInWithCredentials()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showSnackBarFailure(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Login Failure'), Icon(Icons.error)],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
