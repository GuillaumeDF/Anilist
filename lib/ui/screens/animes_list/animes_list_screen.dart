import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/users_repository.dart';
import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

import 'widgets/animes_list_card.dart';
import 'widgets/custom_tab_bar.dart';

class AnimesListScreen extends StatefulWidget {
  AnimesListScreen({Key key}) : super(key: key);

  @override
  _AnimesListScreenState createState() => _AnimesListScreenState();
}

class _AnimesListScreenState extends State<AnimesListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<AnimesListCubit>()
        .fetchList(context.read<UserBloc>().state.user.id);
  }

  Widget _buildAnimes(List<AnimesList> list) {
    return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => Divider(height: 0.0),
        itemBuilder: (context, index) {
          return AnimesListCard(list[index]);
        });
  }

  List<AnimesList> _buildFromStatus(List<AnimesList> list, bool isWatching) {
    List<AnimesList> orderedList = [];
    list.forEach((element) {
      if (element.status == "watching" && isWatching) {
        orderedList.add(element);
      } else if (element.status == "plan" && !isWatching) {
        orderedList.add(element);
      }
    });
    return orderedList;
  }

  Widget _buildList(bool isWatching) {
    return BlocBuilder<AnimesListCubit, AnimesListState>(
      builder: (context, state) {
        if (state is AnimesListLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AnimesListError) {
          return Center(child: Text("AnimeList failed"));
        } else if (state is AnimesListSuccess) {
          return _buildAnimes(_buildFromStatus(state.animes, isWatching));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: CustomTabBar(),
        body: TabBarView(
          children: [
            _buildList(true),
            _buildList(false),
          ],
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
