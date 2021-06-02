import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';

class AnimeCard extends StatefulWidget {
  final List<Anime> animes;
  AnimeCard({Key key, this.animes}) : super(key: key);

  @override
  _AnimeCardState createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.animes.length,
        itemBuilder: (context, idx) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: InkWell(
              onTap: () async {
                await context
                    .read<AnimeInfosCubit>()
                    .fetchAnimeInfos(widget.animes[idx].malId.toString());
                Navigator.of(context).pushNamed(detailsRoute);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: Image.network(
                      widget.animes[idx].imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.animes[idx].title,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
