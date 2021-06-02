import 'package:admin_pannel/bloc/user_edit/user_edit_bloc.dart';
import 'package:admin_pannel/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_repository.dart';

abstract class DetaitUserTextField extends StatelessWidget {
  final String _title;

  const DetaitUserTextField([this._title]);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: ListTile(
        title: Text(_title, style: TextStyle(color: Colors.white)),
        trailing: BlocBuilder<UserEditBloc, UserEditState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => (state is NewValueTextField)
                ? Container(
                    width: 300,
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: state.value,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<UserEditBloc>(context)
                              .add(SetTextValue(value));
                        }),
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}

class TextFieldBio extends StatelessWidget {
  final User user;

  TextFieldBio({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserEditBloc(user: user)..add(InitiatField("bio")),
        child: TextFieldBioView());
  }
}

class TextFieldBioView extends DetaitUserTextField {
  const TextFieldBioView() : super("Bio");
}

class TextFieldEmail extends StatelessWidget {
  final User user;

  TextFieldEmail({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserEditBloc(user: user)..add(InitiatField("email")),
        child: TextFieldEmailView());
  }
}

class TextFieldEmailView extends DetaitUserTextField {
  const TextFieldEmailView() : super("Email");
}

class TextFieldName extends StatelessWidget {
  final User user;

  TextFieldName({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserEditBloc(user: user)..add(InitiatField("name")),
        child: TextFieldNameView());
  }
}

class TextFieldNameView extends DetaitUserTextField {
  const TextFieldNameView() : super("Name");
}

class TextFieldPhoto extends StatelessWidget {
  final User user;

  TextFieldPhoto({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserEditBloc(user: user)..add(InitiatField("photo")),
        child: TextFieldPhotoView());
  }
}

class TextFieldPhotoView extends DetaitUserTextField {
  const TextFieldPhotoView() : super("Photo");
}

class DeleteUser extends StatelessWidget {
  final UsersRepository usersRepository = UsersRepository();
  final User user;

  DeleteUser({this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: CustomTheme.loginGradientStart,
              title: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'This user will be permanently deleted.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    usersRepository.deleteUser(user);
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            "Delete User",
            style: TextStyle(color: Colors.red),
          ),
          leading: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          //trailing: Text(''),
        ),
      ),
    );
  }
}
