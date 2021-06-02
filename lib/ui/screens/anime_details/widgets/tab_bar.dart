import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

class DetailsTabBar extends StatelessWidget implements PreferredSizeWidget {
  final String animeId;

  const DetailsTabBar({Key key, this.animeId}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white);

    return SizedBox(
      height: 50.0,
      child: AppBar(
        elevation: 6.0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        bottom: TabBar(
          onTap: (value) {
            if (value == 1) {
              context.read<AnimeInfosCubit>().fetchAnimeReviews(animeId);
            }
          },
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.yellow,
          tabs: [
            Tab(
              child: Text('Synopsis', style: t),
            ),
            Tab(
              child: Text('Reviews', style: t),
            ),
          ],
        ),
      ),
    );
  }
}
