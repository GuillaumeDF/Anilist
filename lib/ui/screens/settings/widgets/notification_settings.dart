import 'package:flutter/material.dart';

class NotificationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Notifications",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.pause,
                  color: Colors.amber,
                ),
                title: Text('Pause All'),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                title: Text("Likes"),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.green,
                ),
                title: Text("Follow"),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color: Colors.grey,
                ),
                title: Text("Messages"),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
