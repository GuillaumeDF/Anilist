import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/ui/widgets/anime_tile/anime_tile_text.dart';
import 'package:data/data_repository.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';
import 'package:users/users_repository.dart';

class AnimeTile extends StatefulWidget {
  final String title;
  final String score;
  final String malId;
  final String imageUrl;

  AnimeTile(
      {@required this.title,
      @required this.score,
      @required this.malId,
      @required this.imageUrl});

  @override
  _AnimeTileState createState() => _AnimeTileState();
}

class _AnimeTileState extends State<AnimeTile> {
  String id;
  AnimeInfos anime;
  bool _isFav = false;
  bool _isVisible = false;
  String _animationName = "none";
  FavsCubit _favsCubit;

  @override
  void initState() {
    super.initState();
    _favsCubit = BlocProvider.of<FavsCubit>(context);
    id = context.read<UserBloc>().state.user.id;
    _isFav = _favsCubit.isFav(widget.malId);
  }

  _handleTap() async {
    await context.read<AnimeInfosCubit>().fetchAnimeInfos(widget.malId);
    Navigator.of(context).pushNamed(detailsRoute);
  }

  _handleDoubleTap(User user, FlareControls controls) async {
    await context.read<AnimeInfosCubit>().fetchAnimeInfos(widget.malId);
    anime = context.read<AnimeInfosCubit>().state.animeInfos;
    _isFav
        ? _favsCubit.removeFav(user, widget)
        : _favsCubit.addFav(user, widget);
    setState(() => _isVisible = true);
    controls.play(_isFav ? _animationName = "Unlike" : _animationName = "Like");
    _isFav = !_isFav;
  }

  Widget build(BuildContext context) {
    final User user = context.select((UserBloc bloc) => bloc.state.user);
    final FlareControls controls = FlareControls();

    return GestureDetector(
      onTap: () => _handleTap(),
      onDoubleTap: () => _handleDoubleTap(user, controls),
      child: BlocBuilder<FavsCubit, FavsState>(builder: (context, state) {
        if (state is FavsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UpdateFavFailure) {
          return Center(
              child: Icon(
            Icons.not_interested,
            color: Colors.red,
          ));
        }
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(right: 5),
          child: Stack(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                widget.imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Wrap(children: [AnimeTileText(widget: widget)]),
            Visibility(
              visible: _isVisible,
              child: FlareActor(
                "assets/animations/Fav.flr",
                animation: _animationName,
                controller: controls,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                callback: (str) => setState(() => _isVisible = false),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
