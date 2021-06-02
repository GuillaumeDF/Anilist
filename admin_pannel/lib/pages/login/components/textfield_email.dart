import 'package:admin_pannel/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                BlocProvider.of<LoginCubit>(context).emailChanged(email),
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
              labelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.always,
            autocorrect: false,
          );
        });
  }
}
