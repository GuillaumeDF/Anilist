import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart' as constants;

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
        onTap: (value) {
          String type =
              value == 0 ? 'tv' : constants.tabTitles[value].toLowerCase();
          context.read<TopCubit>().fetchTopAnimes(type, 1);
        },
        tabs: <Widget>[
          Tab(
            child: Text(constants.tabTitles[0], style: t),
          ),
          Tab(
            child: Text(constants.tabTitles[1], style: t),
          ),
          Tab(
            child: Text(constants.tabTitles[2], style: t),
          ),
        ],
      ),
    );
  }
}
