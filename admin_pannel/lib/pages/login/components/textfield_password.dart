import 'package:admin_pannel/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                BlocProvider.of<LoginCubit>(context).passwordChanged(password),
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid ? 'invalid password' : null,
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            obscureText: true,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
          );
        });
  }
}
