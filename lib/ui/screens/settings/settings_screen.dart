import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ani_list/ui/screens/settings/widgets/informations.dart';
import 'package:ani_list/ui/screens/settings/widgets/notification_settings.dart';

import 'widgets/general_settings.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _buildAppBar() => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text('Settings',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GeneralSettings(),
              NotificationSettings(),
              Informations(),
            ],
          ),
        ),
      ),
    );
  }
}
