import 'package:flutter/material.dart';
import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/users_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/ui/widgets/anime_tile/anime_tile.dart';

import 'widgets/empty_favs.dart';

class FavsScreen extends StatefulWidget {
  FavsScreen({Key key}) : super(key: key);

  @override
  _FavsScreenState createState() => _FavsScreenState();
}

class _FavsScreenState extends State<FavsScreen>
    with AutomaticKeepAliveClientMixin {
  List<Favorites> _animes = [];

  @override
  void initState() {
    super.initState();
    context.read<FavsCubit>().fetchFavs(context.read<UserBloc>().state.user.id);
  }

  Widget _buildGrid() {
    return Container(
      child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          children: List.generate(_animes?.length, (index) {
            return GridTile(
                child: AnimeTile(
              title: _animes[index].title,
              score: _animes[index].score,
              malId: _animes[index].id,
              imageUrl: _animes[index].imageUrl,
            ));
          })),
    );
  }

  Widget _buildAnimes() {
    return BlocBuilder<FavsCubit, FavsState>(
      builder: (context, state) {
        if (state is FavsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FavsError) {
          return Center(child: Text("Favs failed"));
        } else if (state is FavsSuccess) {
          _animes = state.animes;
          return _animes.isEmpty ? EmptyFavs() : _buildGrid();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text("Favorite animes",
                    style: Theme.of(context).textTheme.headline5),
              ),
              _buildAnimes(),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
