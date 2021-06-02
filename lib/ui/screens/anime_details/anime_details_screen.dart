import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:users/models/user.dart';
import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

import 'widgets/status_dialog.dart';
import 'widgets/tab_bar.dart';
import 'widgets/infos_card.dart';
import 'widgets/reviews_view.dart';
import 'widgets/synopsis_view.dart';

class AnimeDetailsScreen extends StatefulWidget {
  AnimeDetailsScreen({Key key}) : super(key: key);

  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  AnimeInfos anime;

  @override
  void initState() {
    super.initState();
    anime = context.read<AnimeInfosCubit>().state.animeInfos;
  }

  Widget _buildListIcon(User user) {
    return BlocBuilder<AnimesListCubit, AnimesListState>(
      builder: (context, state) {
        if (state is AnimesListLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AnimesListError) {
          print("Error in AnimesListCubit");
        }
        return StatusDialog(anime: anime);
      },
    );
  }

  Widget _buildAppBar(textTheme, user) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text(anime.title,
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          _buildListIcon(user),
        ],
      );

  Widget _buildImage() => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final User user = context.select((UserBloc bloc) => bloc.state.user);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(textTheme, user),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage(),
              SizedBox(height: 10.0),
              InfosCard(anime),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: DetailsTabBar(animeId: anime.malId.toString()),
              ),
              Container(
                height: 1150.0,
                child: TabBarView(children: [
                  SynopsisView(anime: anime),
                  ReviewsView(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
