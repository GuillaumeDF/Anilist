import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Informations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Informations",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  title: Text("Security"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.credit_card,
                    color: Colors.purple,
                  ),
                  title: Text("Payment"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.ad,
                    color: Colors.orange,
                  ),
                  title: Text("Ads"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.green,
                  ),
                  title: Text("Community Guidelines"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.gavel,
                    color: Colors.lightGreen,
                  ),
                  title: Text("Terms of Services"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.visibility,
                    color: Colors.lime,
                  ),
                  title: Text("Privacy Policy"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Colors.pink,
                  ),
                  title: Text("Help"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                title: Text("About"),
                trailing: Text("Version 1.0"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
