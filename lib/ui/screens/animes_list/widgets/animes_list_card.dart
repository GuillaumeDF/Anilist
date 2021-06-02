import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/users_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';

class AnimesListCard extends StatelessWidget {
  final AnimesList _anime;

  AnimesListCard(this._anime);
  Widget _buildImage(String url) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<AnimeInfosCubit>().fetchAnimeInfos(_anime.id);
        Navigator.of(context).pushNamed(detailsRoute);
      },
      child: Container(
        height: 150,
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImage(_anime.imageUrl),
            Text(
              _anime.title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('${_anime.watched}/${_anime.episodes}',
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        )),
      ),
    );
  }
}
