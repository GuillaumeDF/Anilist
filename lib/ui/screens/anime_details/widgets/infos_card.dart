import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/constants/constants.dart' as constants;

class InfosCard extends StatelessWidget {
  final AnimeInfos _anime;

  InfosCard(this._anime);
  @override
  Widget build(BuildContext context) {
    Widget _buildScore(String title, String data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('$title ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold)),
              Icon(FontAwesomeIcons.trophy, color: Colors.amber, size: 15.0),
            ],
          ),
          Text(data,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      );
    }

    Widget _buildStatus() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
              '${_anime.episodes == null ? '0' : _anime.episodes.toString()} episodes',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
          Text(_anime.status.toUpperCase(),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: constants.status[_anime.status]))
        ],
      );
    }

    Widget _buildInfos() {
      final DateFormat formatter = DateFormat('yMMM');
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.tv, color: Colors.cyan, size: 15.0),
              SizedBox(width: 10),
              Text(_anime.type,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Text(formatter.format(_anime.aired.from),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      );
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: <Color>[Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.cyan, offset: Offset(1.0, 1.0))
            ]),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScore("Score", _anime.score.toString()),
            VerticalDivider(),
            _buildStatus(),
            VerticalDivider(),
            _buildInfos(),
          ],
        )),
      ),
    );
  }
}
