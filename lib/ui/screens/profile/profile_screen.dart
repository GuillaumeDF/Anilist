import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/constants/constants.dart';

import 'widgets/avatar.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buildAppBar(textTheme) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(),
        centerTitle: true,
        title: Text('Profile',
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.cog, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, settingsRoute)),
        ],
      );

  Widget _buildBottomBar() => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.redAccent,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () =>
                  Navigator.of(context).pushNamed(profileEditRoute),
              child: Text(
                'EDIT',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((UserBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: _buildAppBar(textTheme),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Avatar(url: user?.photo),
              ),
              SizedBox(height: 20.0),
              Text(user?.name ?? '',
                  style: textTheme.headline5
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Text(user?.email ?? '', style: textTheme.headline6),
              SizedBox(height: 20.0),
              Text(user?.bio ?? '', style: textTheme.headline6),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
