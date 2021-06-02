import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    return AppBar(
      bottom: TabBar(
        physics: NeverScrollableScrollPhysics(),
        indicatorColor: Colors.yellow,
        tabs: <Widget>[
          Tab(
            child: Text("Watching", style: t),
          ),
          Tab(
            child: Text("Plan to watch", style: t),
          ),
        ],
      ),
    );
  }
}
