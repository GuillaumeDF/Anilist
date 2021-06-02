import 'package:admin_pannel/pages/detail_user/components/detail_user_card.dart';
import 'package:admin_pannel/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:users/users_repository.dart';

class DetailUser extends StatelessWidget {
  final User user;
  const DetailUser({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name != null ? user.name : "No name"),
        backgroundColor: CustomTheme.loginGradientStart,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomTheme.loginGradientStart,
              CustomTheme.loginGradientEnd
            ],
          ),
        ),
        child: ListView(
            padding: const EdgeInsets.only(left: 50, right: 50),
            children: <Widget>[
              TextFieldBio(user: user),
              TextFieldEmail(user: user),
              TextFieldName(user: user),
              TextFieldPhoto(user: user),
              DeleteUser(user: user),
            ]),
      ),
    );
  }
}
