import 'package:admin_pannel/bloc/authentication/authentication_bloc.dart';
import 'package:admin_pannel/bloc/user_data/user_data_bloc.dart';
import 'package:admin_pannel/pages/detail_user/detail_user_page.dart';
import 'package:admin_pannel/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_repository.dart';

class PanelPage extends StatelessWidget {
  final UsersRepository usersRepository;

  const PanelPage({@required this.usersRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDataBloc>(
      create: (context) =>
          UserDataBloc(usersRepository)..add(PanelPageStarted()),
      child: PanelPageView(),
    );
  }
}

class PanelPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Console Admin"),
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(LoggedOut())),
            ),
            ListUsersView(),
          ],
        ),
      ),
    );
  }
}

class ListUsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
      if (state is UsersLoaded) {
        return Expanded(
          child: ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailUser(user: state.users[index]),
                    ),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      leading: Icon(
                        Icons.account_box_rounded,
                        color: Colors.white,
                      ),
                      title: Text(
                          state.users[index].name != null
                              ? state.users[index].name
                              : "No name",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                          state.users[index].email != null
                              ? state.users[index].email
                              : "No email",
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(Icons.chevron_right, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else
        return Container();
    });
  }
}
