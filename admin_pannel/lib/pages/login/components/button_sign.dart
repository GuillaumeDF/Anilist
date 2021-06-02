import 'package:admin_pannel/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

abstract class ButtonSign extends StatelessWidget {
  final VoidCallback _onPressed;

  const ButtonSign([this._onPressed]);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Container(
                  width: 300,
                  height: 45,
                  margin: EdgeInsets.only(top: 34),
                  child: TextButton(
                    key: Key("sign_in_flatButton"),
                    onPressed: state.status.isValidated ? _onPressed : null,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "Connect Admin",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
        });
  }
}

class ButtonSignIn extends ButtonSign {
  const ButtonSignIn(VoidCallback _onPressed) : super(_onPressed);
}
