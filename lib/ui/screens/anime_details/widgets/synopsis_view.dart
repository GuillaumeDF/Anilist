import 'package:data/data_repository.dart';
import 'package:flutter/material.dart';

class SynopsisView extends StatelessWidget {
  final AnimeInfos anime;
  final _maxLines = 1500;

  const SynopsisView({Key key, this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = anime.synopsis.substring(0, anime.synopsis.indexOf('['));

    return Column(
      children: [
        SizedBox(height: 10.0),
        Text("Synopsis",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold)),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
              result.length > _maxLines
                  ? result.substring(0, _maxLines) + '...'
                  : result,
              style: Theme.of(context).textTheme.subtitle1),
        )
      ],
    );
  }
}
