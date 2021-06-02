import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';
import 'package:ani_list/ui/widgets/auth_button.dart';
import 'package:ani_list/ui/widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    confirmController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration textFieldDecoration(String hintText) => InputDecoration(
        labelText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          print('Sign Up Failed');
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(homeRoute);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100.0,
                      child: Image.asset(
                        "assets/images/login_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    TextField(
                      controller: emailController,
                      style: textTheme.subtitle1,
                      decoration: textFieldDecoration('Email'),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: textTheme.subtitle1,
                      decoration: textFieldDecoration('Password'),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: confirmController,
                      obscureText: true,
                      style: textTheme.subtitle1,
                      decoration: textFieldDecoration('Confirm password'),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    AuthButton(
                        text: 'Register',
                        onPressed: () => context.read<RegisterCubit>().register(
                            emailController.text,
                            passwordController.text,
                            confirmController.text)),
                    SizedBox(height: 15.0),
                    AuthButton(
                        text: 'Cancel',
                        onPressed: () =>
                            Navigator.of(context).pushNamed(loginRoute)),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SocialButton(
                            path: "assets/images/facebook.png", onTap: null),
                        SocialButton(
                            path: "assets/images/google.png", onTap: null)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
